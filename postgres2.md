```sql
drop table if exists public.account;

create table if not exists public.account (
	id uuid primary key,
	username varchar(36) not null,
	email varchar(36) not null
);

drop table if exists id_for_name;

create temporary table if not exists id_for_name
(
	var_name varchar(36),
	id uuid
);

insert into id_for_name values
(
	'account1',
	uuid_generate_v4()
),
(
	'account2',
	uuid_generate_v4()
);


insert into public.account
select
	id,
	'john.doe',
	'john.doe@gmail'
from id_for_name
where var_name = 'account1';

insert into public.account
select
	id,
	'jane.doe',
	'jane.doe@gmail'
from id_for_name
where var_name = 'account2';

select * from public.account;

with account_payload as (
	select *
	from public.account
)
select jsonb_pretty(array_to_json(array_agg(to_jsonb(account_payload)))::jsonb) 
from account_payload;

```
