create table if not exists tenant 
(
  tenant_id int,
  name varchar(255)
);

insert into tenant values (1, 'prod');
insert into tenant values (2, 'test');

create table if not exists customer_trx_type
(
  customer_trx_type_id int,
  type varchar(255)

);

insert into customer_trx_type values (1, 'customer created')
on conflict
do nothing;

insert into customer_trx_type values (2, 'email changed')
on conflict
do nothing;

create table if not exists customer_trx
(
  customer_trx_id int not null,
  customer_trx_type_id int not null
);

create table if not exists customer
(
  customer_id int,
  customer_trx_id int,
  version int
);

create table if not exists customer__tenant
(
  customer_trx_id int,
  tenant_id int
);

create table if not exists customer__username
(
  customer_trx_id int,
  username varchar(255)
);

create table if not exists customer__email
(
  customer_trx_id int,
  email varchar(255)
);

insert into customer_trx values ( 1, 1 );
insert into customer__username values (1, 'john.doe');
insert into customer__email values (1, 'john.doe@nowhere.com');
insert into customer__tenant values (1, 1);
insert into customer values ( 100, 1, 1 );

insert into customer_trx values (2, 2);
insert into customer__email values (2, 'john001@gmail.com');
insert into customer values (100, 2, 2);

create or replace view customer_history_view as
select
	CU.customer_id as customer_id,
    CU.version as version,
    TT.type as trx_type,
    TE.name as tenant,
	username,
    email
from customer CU
	INNER JOIN customer_trx CT
    	ON CU.customer_trx_id = CT.customer_trx_id
    INNER JOIN customer_trx_type TT
    	ON TT.customer_trx_type_id = CT.customer_trx_type_id
    LEFT JOIN customer__tenant CU_TEN
    	ON CU.customer_trx_id = CU_TEN.customer_trx_id
    LEFT JOIN tenant TE
    	ON CU_TEN.tenant_id = TE.tenant_id
   	LEFT JOIN customer__username CU_USE
    	ON CT.customer_trx_id = CU_USE.customer_trx_id
    LEFT JOIN customer__email CU_EMA
    	ON CT.customer_trx_id = CU_EMA.customer_trx_id;
