CREATE TYPE account_status AS ENUM ();
ALTER TYPE account_status ADD VALUE IF NOT EXISTS 'created';
ALTER TYPE account_status ADD VALUE IF NOT EXISTS 'deleted';

CREATE TYPE account_action AS ENUM ();
ALTER TYPE account_action ADD VALUE IF NOT EXISTS 'ACCOUNT_CREATED';
ALTER TYPE account_action ADD VALUE IF NOT EXISTS 'ACCOUNT_DELETED';

create table if not exists account
(
  id int primary key,
  tenant_id int,
  account_id int,
  version int,
  action account_action,
  username text,
  email text,
  status account_status,
  balance int,
  unique(tenant_id, account_id, version)
);

create or replace function if_then(p boolean, q boolean)
	returns boolean as
'
begin
	return not(p) or q;
end;
' language plpgsql;
create or replace function P(username text)
	returns boolean as 
'
begin
	return username is not null
    	and username <> '''';
end;
' language plpgsql;

alter table account
add constraint username_check
check (
  if_then(P(username), balance > 0 and balance is not null)
);

create table if not exists profile
(
  id int,
  firstname text,
  lastname text
);

create table if not exists account__email
(
  tenant_id int,
  account_id int,
  email text
);

create unique index concurrently index_unique_email_per_tenant
	on account__email (tenant_id, account_id, email);
    
create unique index concurrently index_unique_email_per_account_in_tenant
	on account__email (tenant_id, email);
    
ALTER TABLE account__email
ADD CONSTRAINT rule_unique_email_per_tenant
UNIQUE USING INDEX index_unique_email_per_tenant;

ALTER TABLE account__email
ADD CONSTRAINT rule_unique_email_per_account_in_tenant
UNIQUE USING INDEX index_unique_email_per_account_in_tenant;

create or replace function verify_account_email()
	RETURNS trigger as
'
begin
	insert into account__email values ( 
    	NEW."tenant_id", 
        NEW."account_id", 
        NEW."email" 
    )
    on conflict on constraint rule_unique_email_per_tenant
    do nothing;
    
    return new;
end;
' language plpgsql;

create trigger account_email_verification
	AFTER INSERT
	ON account
    FOR EACH ROW
    EXECUTE PROCEDURE verify_account_email();
    

create or replace function update_account(payload json)
	returns void as
'
begin
	insert into account values 
    (
    	(payload->>''id'')::int,
        (payload->>''tenant_id'')::int,
        (payload->>''account_id'')::int,
        (payload->>''version'')::int,
        (payload->>''action'')::account_action,
        (payload->>''username'')::text,
        (payload->>''email'')::text,
        (payload->>''status'')::account_status,
        (payload->>''balance'')::int
    );
    
    insert into profile
    select 
    	(payload->>''id'')::int,
        firstname,
        lastname
    from json_to_recordset((payload->''profile'')::text::json)
    as x("firstname" text, "lastname" text);
end;
' language plpgsql;


select update_account($${
	"id": 1,
    "tenant_id": 1,
    "account_id": 1,
    "version": 1,
    "action": "ACCOUNT_CREATED",
    "username": "john.doe",
    "email": "john.doe@nowhere.com",
    "status": "created",
    "profile": [
    	{
      		"firstname": "John",
      		"lastname": "Doe"
      	},
      	{
      		"firstname": "Jane",
      		"lastname": "Doe"
      	}
   	],
    "balance": 10
}$$::json);

select update_account($${
	"id": 2,
    "tenant_id": 1,
    "account_id": 2,
    "version": 1,
    "action": "ACCOUNT_CREATED",
    "username": "",
    "email": "jane@nowhere.com",
    "status": "created"
}$$::json);


WITH __account__id AS
	(
      SELECT id
      FROM account
      WHERE tenant_id = 1
      	AND account_id = 1
      ORDER BY version DESC
      LIMIT 1
    )
, __json_profile as
	(
    	SELECT json_agg(profile) as profile
      	from profile 
      		natural join __account__id
    )
, __account as
	(
      select *
      from account
      	natural join __json_profile
      	natural join __account__id
    )
, __json_account as
	(
      select json_agg(__account)
      from __account
    )
select *
from __json_account;

WITH __profile as 
	(
      select $$[
        {
          "id": 1,
          "firstname": "john",
          "lastname": "doe"
        },
        {
          "id": 1,
          "lastname": "jane",
          "lastname": "doe"
        }
      ]$$::json
    )
select * 
from jsonb_to_recordset(null) as 
	x(
      "id" int,
      "firstname" text,
      "lastname" text
    );

select * from account__email;

select * from profile;
