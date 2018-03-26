use lego;


create or replace table part_categories(
  part_category_id tinyint unsigned not null primary key,
  part_category_name char(50) not null
);

load data local infile 
  '/home/ralf/Programming/sql/lego/part_categories.csv' 
  into table part_categories
  columns
    terminated by ','
    optionally enclosed by '"'
  ignore 1 lines;

select * from part_categories limit 10;


create or replace table themes(
  theme_id smallint unsigned not null primary key,
  theme_name char(50) not null,
  parent_id smallint unsigned not null
);

load data local infile 
  '/home/ralf/Programming/sql/lego/themes.csv' 
  into table themes
  columns
    terminated by ','
    optionally enclosed by '"'
  ignore 1 lines;

select * from themes limit 10;


create or replace table parts(
  part_id char(16) not null primary key,
  part_name tinytext not null,
  part_category_id tinyint unsigned not null
);

load data local infile 
  '/home/ralf/Programming/sql/lego/parts.csv' 
  into table parts
  columns
    terminated by ','
    optionally enclosed by '"'
  ignore 1 lines;

select * from parts limit 10;


create or replace table sets(
  set_id char(16) not null primary key,
  set_name tinytext not null,
  year smallint unsigned not null,
  theme_id smallint unsigned not null,
  num_parts smallint unsigned not null
);

load data local infile 
  '/home/ralf/Programming/sql/lego/sets.csv' 
  into table sets
  columns
    terminated by ','
    optionally enclosed by '"'
  ignore 1 lines;

select * from sets limit 10;


create or replace table inventories(
  inventory_id smallint unsigned not null primary key,
  version tinyint not null,
  set_id char(16) not null
);

load data local infile 
  '/home/ralf/Programming/sql/lego/inventories.csv' 
  into table inventories
  columns
    terminated by ','
    optionally enclosed by '"'
  ignore 1 lines;

select * from inventories limit 10;


create or replace table inventory_sets(
  inventory_id smallint unsigned not null,
  set_id char(16) not null,
  quantity tinyint unsigned not null,
  primary key (inventory_id, set_id)
);

load data local infile 
  '/home/ralf/Programming/sql/lego/inventory_sets.csv' 
  into table inventory_sets
  columns
    terminated by ','
    optionally enclosed by '"'
  ignore 1 lines;

select * from inventory_sets limit 10;


create or replace table inventory_parts(
  inventory_id smallint unsigned not null,
  part_id char(16) not null,
  color_id smallint unsigned not null,
  quantity smallint unsigned not null,
  is_spare enum('t', 'f') not null
);

load data local infile 
  '/home/ralf/Programming/sql/lego/inventory_parts.csv' 
  into table inventory_parts
  columns
    terminated by ','
    optionally enclosed by '"'
  ignore 1 lines;

select * from inventory_parts limit 10;


create or replace table colors(
  color_id mediumint not null primary key,
  color_name char(32) not null,
  rgb char(6) not null,
  is_trans enum('t', 'f') not null
);

load data local infile 
  '/home/ralf/Programming/sql/lego/colors.csv' 
  into table colors
  columns
    terminated by ','
    optionally enclosed by '"'
  ignore 1 lines;

select * from colors limit 10;
