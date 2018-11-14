/*
create or replace procedure list_collection(
  in in_inventory_id smallint unsigned
)
(
  select 1 as quantity, set_name, num_parts
  from sets
  inner join inventories using (set_id)
  where inventory_id = in_inventory_id 
)
union
(
  select quantity, set_name, num_parts
  from sets
  inner join inventory_sets using (set_id)
  where inventory_id = in_inventory_id 
)
;
  
call list_collection(39);

with 
year_themes as (
  select
    theme_id,
    theme_name,
    year,
    sum(num_parts) as sum_parts
  from 
    sets
    left join themes using (theme_id)
  where
    year between 2011 and 2015
  group by
    theme_id, year
)
select * 
from 
  year_themes
where
  sum_parts > (
    select 
      0.02 * sum(sum_parts)
    from 
      year_themes
    where
      year = 2015
  )
 and
   year = 2015
order by sum_parts desc;


with recursive fibb as (
  select
    1 as fibb_no,
    1 as current,
    1 as next
  union all
  select
    fibb_no + 1,
    next,
    current + next
  from fibb
  where fibb_no < 20
)
select fibb_no, current as value from fibb;
*/

with recursive hierarchy as (
  select * from themes 
  where theme_id = 565
  union all
  select themes.* from themes, hierarchy
  where themes.theme_id = hierarchy.parent_id
) 
select * from hierarchy;
