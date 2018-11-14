use lego;


create or replace view info_parts as
  select * 
  from parts
  left join part_categories using (part_category_id);

select * from info_parts limit 1;


create or replace view info_inv_sets as
  select *
  from inventory_sets 
  inner join sets using (set_id);

select * from info_inv_sets where inventory_id = 71;


create or replace view info_sets_parts as
  select *
  from sets 
  left join inventories using (set_id)
  left join inventory_parts using (inventory_id)
  left join colors using (color_id)
  left join parts using (part_id);

select * from info_sets_parts where set_id = '8755-1';
