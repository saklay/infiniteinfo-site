#!/bin/sh

nsql -U infinite -P bg3ntl <<- EOF


create table directory (
    area_code text,
    email text,
    extension text,
    first_name text not null,
    home_phone text,
    id integer,
    last_name text not null,
    location text,
    mobile_phone text,
    phone_number text,
    title text
);

-- Meta data for table "directory":


insert into ns2_columns
    values ('directory', 'area_code', 'order', '6');

insert into ns2_columns
    values ('directory', 'email', 'order', '4');
insert into ns2_columns
    values ('directory', 'email', 'displayas', 'mailto');

insert into ns2_columns
    values ('directory', 'extension', 'order', '8');

insert into ns2_columns
    values ('directory', 'first_name', 'order', '3');
insert into ns2_columns
    values ('directory', 'first_name', 'not_null', '1');

insert into ns2_columns
    values ('directory', 'home_phone', 'order', '9');

insert into ns2_columns
    values ('directory', 'id', 'order', '1');
insert into ns2_columns
    values ('directory', 'id', 'htmltag_type', 'autoincr');

insert into ns2_columns
    values ('directory', 'last_name', 'order', '2');
insert into ns2_columns
    values ('directory', 'last_name', 'not_null', '1');

insert into ns2_columns
    values ('directory', 'location', 'order', '11');

insert into ns2_columns
    values ('directory', 'mobile_phone', 'order', '10');

insert into ns2_columns
    values ('directory', 'phone_number', 'order', '7');

insert into ns2_columns
    values ('directory', 'title', 'order', '5');

EOF
