```bash
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

with accounts as (
	select * 
	from dbo.account
	where identity = '02628dd0-78f8-4036-b051-820f4ff99e89'
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
		array_to_json(array_agg(row_to_json(related_accounts))) as tokens
	from related_accounts
),
payload as (
	select
		identity,
		( select tokens from tokens ),
		username
	from dbo.account as account
)
select row_to_json(payload) from payload```
