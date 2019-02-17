```sql
with payload as (
	select * 
	from json_to_recordset('[
		{
			"id": 1,
			"key": "value1"
		},
		{
			"id": 2,
			"key": "value2"
		}
	]') as
	x(
		"id" int,
		"key" text
	)
)
select *
from payload;


with sample_data
(
	firstname,
	lastname
) 
as 
( 
	values
	(
		text 'john',
		text 'doe'
	)
)
select *
from sample_data;

-- see: https://www.reddit.com/r/PostgreSQL/comments/2u6ah3/how_to_use_json_to_recordset_on_json_stored_in_a/
with data(obj) as (
	values (
		json '[
			{
				"id": 1,
				"key": "value1"
			},
			{
				"id": 2,
				"key": "value2"
			}
		]'
	)
),
payload as (
	select
		x.id,
		x.key
	from
		data d
		cross join lateral 
		json_to_recordset(d.obj) as x
		(
			"id" int,
			"key" text
		)
)
select *  
from payload
```
