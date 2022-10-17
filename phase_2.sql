drop table if exists store cascade;
drop table if exists product cascade;
drop table if exists users cascade;
drop table if exists customer cascade;
drop table if exists manager cascade;
drop table if exists warehouse cascade;
drop table if exists supplies cascade;
drop table if exists orders cascade;
drop table if exists requests cascade;
drop table if exists updates cascade;  
 

create table store(	storeID integer not null unique,
			manager_ID integer not null,
			name char(30) not null,
			latitude decimal(8,6) not null,
			longitude decimal(9,6) not null,
			date_established date,
			Primary Key(storeID, manager_ID),
			Foreign Key(manager_ID) references manager(user_ID));

create table product(	p_name char(30) not null,
			storeID integer,
			number_units integer not null,
			ppu integer not null,
			description char(100),
			image_url char(30),
			Primary Key(storeID),
			Foreign Key(storeID) references store(storeID));

create table users(	user_ID integer not null unique,
			password char(11) not null,
			name char(50) not null,
			email char(50),
			Primary key(user_ID));

create table customer(	user_ID integer not null unique,
			credit_score integer,
			latitude decimal(8,6) not null,
			longitude decimal(9,6) not null,
			Primary Key(user_ID), 
			Foreign Key(user_ID) references users(user_ID));

create table manager(	user_ID integer not null unique,
			degree char(20),
			salary integer not null,
			Primary Key(user_ID),
			Foreign Key(user_ID) references users(user_ID));

create table warehouse(	warehouseID integer not null unique primary key,
			area integer,
			latitude decimal(8,6) not null,
			longitude decimal(9,6) not null);

create table supplies(	warehouseID integer not null,
			storeID integer not null,
			Primary Key(warehouseID, storeID),
			Foreign Key(warehouseID) references warehouse(warehouseID),
			Foreign Key(storeID) references product(storeID));

create table orders(	units_ordered integer,
			order_date date,
			user_ID integer not null,
			storeID integer not null,
			Primary Key(user_ID, storeID),
			Foreign Key(user_ID) references customer(user_ID));

create table requests(	user_ID integer not null,
			storeID integer not null,
			p_name char(30) not null,
			units_requested integer,
			Primary Key(user_ID, p_name),
			Foreign Key(user_ID) references manager(user_ID),
			Foreign Key(p_name) references product(p_name));

create table updates(	managerID integer not null,	
			p_name char(30) not null,
			Primary Key(managerID, p_name),
			Foreign Key(managerID) references manager(user_ID),
			Foreign Key(p_name) references product(p_name));
			
