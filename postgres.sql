create table tenant
(
	tenant_id int primary key,
  	description text
);

create table tenant_tag
(
	tenant_id int primary key,
  	name varchar(255),
  	description text
);

create table if not exists account
(
  id serial primary key,
  tenant_id int,
  trx_id int,
  entity_id int,
  version int,
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

create table if not exists alias
(
  id serial not null primary key,
  account_id int,
  entity_id int,
  
  unique(account_id, entity_id),
  constraint account_alias_fk
  	foreign key (account_id)
  		references account (id)
);

create table if not exists alias__name
(
  id int primary key,
  name varchar(255),
  
  constraint alias_name_fk
  	foreign key (id)
  		references alias (id)
);


insert into account (tenant_id, trx_id, entity_id, version) values (1, 1, 1, 1);

insert into account__username (id, username)
select 
	id as "id",
    'john.doe' as "username"
from account
where tenant_id = 1
	and trx_id = 1;
    
insert into account__email (id, email)
select 
	id,
    'john.doe@nowhere.com'
from account
where tenant_id = 1
	and trx_id = 1;
    
insert into alias (account_id, entity_id)
select 
	id,
    10
from account
where tenant_id = 1
	and trx_id = 1;

with alias_cte as (
  select
      AL.id
  from account AC
      inner join alias AL
          on AC.id = AL.account_id
  where AC.tenant_id = 1
      and AC.trx_id = 1
      and AL.entity_id = 10),
insert_name_cte as (
  insert into alias__name (id, name)
  select
      id,
      'john.wick'
  from alias_cte)
select * from alias_cte;
    
select *
from account AC
	left join account__username AC_USE
    	on AC.id = AC_USE.id
    left join account__email AC_EMA
    	on AC.id = AC_EMA.id;
        
select *
from account AC
	inner join alias AL
    	on AC.id = AL.account_id
    inner join alias__name AL_NAM
    	on AL.id = AL_NAM.id
where AC.tenant_id = 1
	and AC.trx_id = 1
    and AL.entity_id = 10;


