create table account
(
  id int,
  username text,
  email text
);

create table role
(
  id int,
  name text
);

create table account_role
(
  account_id int,
  role_id int
);

insert into account values (1,'john.doe', 'john.doe@nowhere.com');
insert into role values (1, 'role1');
insert into role values (2, 'role2');
insert into account_role values (1, 1);
insert into account_role values (1, 2);

with account_roles as (
	select 
  		r.id,
  		r.name
  	from role r
  		inner join account_role ar
  			on r.id = ar.role_id
 	where ar.account_id = 1
), 
account_roles_agg as (
  	select 
		array_to_json(array_agg(account_roles)) as roles 
	from account_roles),
payload as (
  select json_build_object(
  	'id', id,
    'username', username,
  	'email', email,
    'roles', roles
  )
  from account
  	cross join account_roles_agg
  where id = 1
)
select * from payload ;
                      
select json_build_object(
  'id', ac.id,
  'username', username,
  'email', email,
  'roles', coalesce(roles.roles, '[]'::json)
) 
from account ac 
   	left join lateral (
      select
          array_to_json(array_agg(json_build_object(
              'id', r.id,
              'name', r.name
          ))) as roles
      from role r
          inner join account_role ar
              on r.id = ar.role_id
      where ar.account_id = ac.id
) roles on true
