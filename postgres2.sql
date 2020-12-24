create table if not exists account
(
  id serial not null primary key,
  tenant_id uuid,
  trx_id uuid,
  entity_id uuid,
  version int,
  creation_date date,
  
  unique(tenant_id, trx_id),
  unique(tenant_id, entity_id, version)
);

create table if not exists account__username
(
  id int primary key,
  username varchar(255)
);

create table if not exists account__email
(
  id int primary key,
  email varchar(255)
);


with payload as (
  select *
  from json_to_recordset($$[
    {
    	"tenant_id": "02628dd0-78f8-4036-b051-820f4ff99e89",
    	"trx_id": "71a99dfe-be44-4c2d-8604-6b433322188e",
    	"entity_id": "c4a48539-eed0-4888-822f-30b546c827bc",
    	"version": 1,
    	"creation_date": "2020-01-01T00:00:00",
    	"username": "john.doe"
    },
    {
    	"tenant_id": "02628dd0-78f8-4036-b051-820f4ff99e89",
    	"trx_id": "2e5abe63-e568-471a-a611-8f5f92b7fd72",
    	"entity_id": "c4a48539-eed0-4888-822f-30b546c827bc",
    	"version": 2,
    	"creation_date": "2020-01-01T00:00:00",
    	"username": "john.doe",
    	"email": "john.doe@nowhere.com"
    }
  ]$$) as x(
    tenant_id uuid,
    trx_id uuid,
    entity_id uuid,
    version int,
    creation_date date,
    username text,
    email text
  )
),
insert_account as (
  insert into account
  (
    tenant_id,
    trx_id,
    entity_id,
    version,
    creation_date
  )
  select 
    tenant_id,
    trx_id,
    entity_id,
    version,
    creation_date
  from payload
  returning 
    id,
    tenant_id,
    trx_id,
    entity_id,
    version,
    creation_date
),
insert_account__username as (
  insert into account__username (id, username)
  select id, username
  from insert_account AC
  	inner join payload P
  		on AC.tenant_id = P.tenant_id
  		and AC.trx_id = P.trx_id
),
insert_account__email as (
  insert into account__email (id, email)
  select id, email
  from insert_account AC
  	inner join payload P
  		on AC.tenant_id = P.tenant_id
  		and AC.trx_id = P.trx_id
  where email is not null
)
select * from insert_account;

                        
                        
select
	AC.id,
    AC.tenant_id,
    AC.trx_id,
    AC.entity_id,
    AC.version,
    AC.creation_date,
    AC_USE.username,
    AC_EMA.email
from account AC
	left join account__username AC_USE
    	on AC.id = AC_USE.id
    left join account__email AC_EMA
    	on AC.id = AC_EMA.id;

