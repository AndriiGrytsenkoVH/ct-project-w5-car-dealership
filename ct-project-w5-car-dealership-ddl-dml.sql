-------------------------------------------------------------------------------------
-- DDl
-------------------------------------------------------------------------------------

create table customer(
	customer_id serial primary key,
	name varchar,
	email varchar,
	phone varchar
);

create table sales_person(
	sales_person_id serial primary key,
	name varchar,
	salary int
);

create table invoice(
	invoice_id serial primary key,
	sales_person_id int not null,
	foreign key(sales_person_id) references sales_person(sales_person_id),
	price int not null
);

create table car(
	car_serial_number serial primary key,
	customer_id int not null,
	foreign key(customer_id) references customer(customer_id),
	invoice_id int,
	foreign key(invoice_id) references invoice(invoice_id),
	used bool default false,
	car_make varchar,
	car_model varchar,
	car_color varchar,
	car_miles numeric(6,2)
);

create table mechanic(
	mechanic_id serial primary key,
	name varchar,
	salary int
);

create table service_ticket(
	service_ticket_id serial primary key,
	car_serial_number int not null,
	foreign key(car_serial_number) references car(car_serial_number),
	description text,
	price int not null
);

create table mechanic_ticket(
	mechanic_id int not null,
	foreign key(mechanic_id) references mechanic(mechanic_id),
	service_ticket_id int not null,
	foreign key(service_ticket_id) references service_ticket(service_ticket_id)
);

-------------------------------------------------------------------------------------
-- DML
-------------------------------------------------------------------------------------

create or replace procedure hire_mechanic(
	new_name varchar,
	new_salary int
)
language plpgsql
as $$
begin 
	insert into mechanic(
		name,
		salary
	) values (
		new_name,
		new_salary
	);
end;
$$;

call hire_mechanic('Ryan Gosling',20000000);
call hire_mechanic('Tony Stark',50000000);

select * from mechanic;

-------------------------------------------------------------

create or replace procedure hire_sales(
	new_name varchar,
	new_salary int
)
language plpgsql
as $$
begin 
	insert into sales_person (
		name,
		salary
	) values (
		new_name,
		new_salary
	);
end;
$$;

call hire_sales('Sidorovich',1);
call hire_sales('Daniel LaRusso',20000000);

select * from sales_person;

-------------------------------------------------------------

create or replace procedure new_customer(
	new_name varchar,
	new_email varchar,
	new_phone varchar
)
language plpgsql
as $$
begin 
	insert into customer(
		name,
		email,
		phone
	) values (
		new_name,
		new_email,
		new_phone
	);
end;
$$;

call new_customer('Tweedle Dee','td@mail','999-999-9999');
call new_customer('Tweedle Dum','td1@mail','888-888-8888');

select * from customer;

-------------------------------------------------------------

create or replace procedure new_ivoice(
	new_sales_person_id int,
	new_price int
)
language plpgsql
as $$
begin 
	insert into invoice(
		sales_person_id,
		price 
	) values (
		new_sales_person_id,
		new_price
	);
end;
$$;

call new_ivoice(1,3000);
call new_ivoice(1,6000);

select * from invoice;

-------------------------------------------------------------

create or replace procedure new_car(
	new_car_serial_number int,
	new_car_customer int,
	new_car_invoice int,
	new_used bool,
	new_car_make varchar,
	new_car_model varchar,
	new_color varchar,
	new_miles numeric(6,2)
)
language plpgsql
as $$
begin 
	insert into car(
		car_serial_number,
		customer_id,
		invoice_id,
		used,
		car_make,
		car_model,
		car_color,
		car_miles 
	) values (
		new_car_serial_number,
		new_car_customer,
		new_car_invoice,
		new_used,
		new_car_make,
		new_car_model,
		new_color,
		new_miles
	);
end;
$$;

call new_car(
	1,
	1,
	1,
	false,
	'x',
	'x',
	'x',
	0
);
call new_car(
	2,
	2,
	null,
	true,
	'x',
	'x',
	'x',
	9001
);

select * from car;

-------------------------------------------------------------

create or replace procedure new_service_ticket(
	new_car_serial_number int,
	new_description text,
	new_price int
)
language plpgsql
as $$
begin 
	insert into service_ticket (
		car_serial_number,
		description,
		price 
	) values (
		new_car_serial_number,
		new_description,
		new_price
	);
end;
$$;

call new_service_ticket(1,'wheel replacement',20000);
call new_service_ticket(2,'broken mirror',5000);

select * from service_ticket;

-------------------------------------------------------------

create or replace procedure new_team_member(
	new_mechanic int,
	new_service_ticket int
)
language plpgsql
as $$
begin 
	insert into mechanic_ticket  (
		mechanic_id,
		service_ticket_id
	) values (
		new_mechanic,
	new_service_ticket
	);
end;
$$;

call new_team_member(1,1);
call new_team_member(2,2);

select * from mechanic_ticket;
