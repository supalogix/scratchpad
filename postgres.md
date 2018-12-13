```sql
create schema if not exists dbo;

create table if not exists dbo.account
(
	identity uuid primary key,
	username varchar(256) unique
);

create table if not exists dbo.token
(
	identity uuid primary key,
	hmac varchar(256)
);

create table if not exists dbo.account_belongsTo_token_has
(
	account_identity uuid,
	token_identity uuid primary key
);

create or replace function dbo.create_account
(
	event json
)
returns void as
$$
	insert into dbo.account
	(
		identity,
		username
	)
	values 
	(
		(event->>'identity')::text::uuid,
		(event->>'username')::text
	)
	on conflict do nothing;	
$$ language sql;

select dbo.create_account($${
	"identity": "02628dd0-78f8-4036-b051-820f4ff99e89",
	"username": "jnaciona"
}$$);
/*
insert into dbo.account
(
	identity,
	username
)
values 
(
	'02628dd0-78f8-4036-b051-820f4ff99e89',
	'jnaciona'
)
on conflict do nothing;
*/

insert into dbo.token
(
	identity,
	hmac
)
values
(
	'77f8526c-4500-4df5-b9cb-4179182b80bc',
	'hmac1'
),
(
	'93dd60fa-0964-4356-b523-e440adb4c961',
	'hmac2'
),
(
	'83dd60fa-0964-4356-b523-e440adb4c961',
	'hmac3'
)
on conflict do nothing;

insert into dbo.account_belongsto_token_has
(
	account_identity,
	token_identity
)
values
(
	'02628dd0-78f8-4036-b051-820f4ff99e89',
	'77f8526c-4500-4df5-b9cb-4179182b80bc'
),
(
	'02628dd0-78f8-4036-b051-820f4ff99e89',
	'93dd60fa-0964-4356-b523-e440adb4c961'
),
(
	'02628dd0-78f8-4036-b051-820f4ff99e89',
	'83dd60fa-0964-4356-b523-e440adb4c961'
)
on conflict do nothing;

create or replace function get_accounts(id uuid)
returns json as
$$
with accounts as (
	select 
		identity
	from dbo.account
	where identity = id
),
related_accounts as (
	select *
	from dbo.account_belongsto_token_has
	where account_identity in 
	(
		select identity 
		from accounts
	)
),
tokens as (
	select 
		array_to_json(array_agg(to_jsonb(related_accounts))) as tokens
	from related_accounts
),
account_payload as (
	select
		identity,
		( select tokens from tokens ),
		username
	from dbo.account as account
)
select array_to_json(array_agg(to_jsonb(account_payload))) 
from account_payload
$$ language sql;

select * 
from get_accounts('02628dd0-78f8-4036-b051-820f4ff99e89')
```

```sql
create or replace function dbo.handle_create_product
(
	event json
)
returns void as
$$
	insert into dbo.lpr_product
	(
		pr_uid_product_uuid,
		pr_nam_product_name,
		pr_nam_changedAt,
		pr_dsc_product_description,
		pr_dsc_changedAt,
		pr_rep_product_retailPrice,
		pr_rep_changedAt
	)
	select
		(event->'data'->>'identity')::text::uuid,
		
		(event->'data'->>'name')::text,
		(event->'creationDate')::text::timestamp,
		
		(event->'data'->>'description')::text,
		(event->'creationDate')::text::timestamp,
		
		(event->'data'->>'retailPrice')::int,
		(event->'creationDate')::text::timestamp
	where not exists (
		select 1
		from dbo.lpr_product
		where pr_uid_product_uuid = (event->'data'->>'identity')::text
	)
	on conflict do nothing;
$$ language sql;

create or replace function dbo.handle_change_product
(
	event json
)
returns void as
$$
	insert into dbo.lpr_product
	(
		PR_Id,
		PR_NAM_Product_Name,
		PR_NAM_changedAt,
		PR_DSC_Product_Description,
		PR_DSC_ChangedAt,
		PR_REP_Product_RetailPrice,
		PR_REP_ChangedAt
	)
	select 
		pr_id,
		(event->'data'->>'name')::text,
		(event->'creationDate')::text::timestamp,
		
		(event->'data'->>'description')::text,
		(event->'creationDate')::text::timestamp,
		
		(event->'data'->>'retailPrice')::int,
		(event->'creationDate')::text::timestamp
	from dbo.lpr_product 
	where pr_uid_product_uuid = (event->'data'->>'identity')
	on conflict do nothing;
$$ language sql;

select dbo.handle_create_product($${
	"aggregateId": "",
	"eventType": "",
	"eventId": "",
	"nextEventId": "",
	"lastEventId": "",
	"creationDate": "2018-12-11",
	"data": {
		"identity": "02628dd0-78f8-4036-b051-820f4ff99e87",
		"name": "product",
		"description": "this is another description",
		"retailPrice": "1234"
	}
}$$);

select dbo.handle_change_product($${
	"aggregateId": "",
	"eventType": "",
	"eventId": "",
	"nextEventId": "",
	"lastEventId": "",
	"creationDate": "2018-12-21",
	"data": {
		"identity": "02628dd0-78f8-4036-b051-820f4ff99e88",
		"name": "product",
		"description": "another description 12345",
		"retailPrice": "1"
	}
}$$);

select * from dbo.lpr_product;
select pr_id from dbo.lpr_product where pr_uid_product_uuid = '02628dd0-78f8-4036-b051-820f4ff99e88'

insert into dbo.lpr_product
	(
		pr_id,
		pr_nam_product_name,
		pr_nam_changedAt,
		pr_dsc_product_description,
		pr_dsc_changedAt,
		pr_rep_product_retailPrice,
		pr_rep_changedAt
	)
select 
	pr_id,
	'product name new 1234',
	'2018-12-15',
	'some new description 1234',
	'2018-12-15',
	2,
	'2018-12-15'
from dbo.lpr_product 
where pr_uid_product_uuid = '02628dd0-78f8-4036-b051-820f4ff99e88'
on conflict do nothing;

select 
	*
from dbo.dpr_product('2000-10-10', '2019-01-01')
where pr_id = 3
order by pr_dsc_changedat

select 
	inspectedtimepoint,
--	pr_uid_product_uuid,
	pr_nam_product_name,
	pr_dsc_product_description,
	pr_rep_product_retailPrice
from dbo.dpr_product('2000-10-10', '2019-01-01')
where pr_id = 3
group by
	inspectedtimepoint,
--	pr_uid_product_uuid,
	pr_nam_product_name,
	pr_dsc_product_description,
	pr_rep_product_retailPrice
order by inspectedtimepoint
```