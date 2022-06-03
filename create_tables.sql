drop database lego;
create database lego;

use lego;

create or replace table part_categories(
  id tinyint unsigned not null primary key,
  name char(50) not null
);

load data local infile 
  'csvs\\part_categories.csv' 
  into table part_categories
  columns
    terminated by ','
    optionally enclosed by '"'
  ignore 1 lines;

select * from part_categories limit 10;


create or replace table parts(
  id char(16) not null primary key,
  name tinytext not null,
  category_id tinyint unsigned not null references part_categories(id)
);

load data local infile 
  'csvs\\parts.csv' 
  into table parts
  columns
    terminated by ','
    optionally enclosed by '"'
  ignore 1 lines;

select * from parts limit 10;


create or replace table themes(
  id smallint unsigned not null primary key,
  name char(50) not null,
  parent_id smallint unsigned not null
);

load data local infile 
  'csvs\\themes.csv' 
  into table themes
  columns
    terminated by ','
    optionally enclosed by '"'
  ignore 1 lines;

select * from themes limit 10;


create or replace table sets(
  id char(16) not null primary key,
  name tinytext not null,
  year smallint unsigned not null,
  theme_id smallint unsigned not null references themes(id),
  num_parts smallint unsigned not null
);

load data local infile 
  'csvs\\sets.csv' 
  into table sets
  columns
    terminated by ','
    optionally enclosed by '"'
  ignore 1 lines;

select * from sets limit 10;


create or replace table inventories(
  id smallint unsigned not null primary key,
  version_nr tinyint not null,
  set_id char(16) not null references sets(id)
);

load data local infile 
  'csvs\\inventories.csv' 
  into table inventories
  columns
    terminated by ','
    optionally enclosed by '"'
  ignore 1 lines;

select * from inventories limit 10;


create or replace table inventory_sets(
  inventory_id smallint unsigned not null references inventories(id),
  set_id char(16) not null references sets(id),
  quantity tinyint unsigned not null,
  primary key (inventory_id, set_id)
);

load data local infile 
  'csvs\\inventory_sets.csv' 
  into table inventory_sets
  columns
    terminated by ','
    optionally enclosed by '"'
  ignore 1 lines;

select * from inventory_sets limit 10;


create or replace table colors(
  id smallint not null primary key,
  name char(32) not null,
  rgb char(6) not null,
  is_trans enum('t', 'f') not null
);

load data local infile 
  'csvs\\colors.csv' 
  into table colors
  columns
    terminated by ','
    optionally enclosed by '"'
  ignore 1 lines;

select * from colors limit 10;


create or replace table inventory_parts(
  inventory_id smallint unsigned not null references inventories(id),
  part_id char(16) not null references parts(id),
  color_id smallint not null references colors(id),
  quantity smallint unsigned not null,
  is_spare enum('t', 'f') not null,
  primary key (inventory_id, part_id, color_id)
);

load data local infile 
  'csvs\\inventory_parts.csv' 
  into table inventory_parts
  columns
    terminated by ','
    optionally enclosed by '"'
  ignore 1 lines;

select * from inventory_parts limit 10;
