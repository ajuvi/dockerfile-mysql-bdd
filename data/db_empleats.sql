create database if not exists db_empleats 
character set utf8mb4 
collate utf8mb4_unicode_ci;

use db_empleats;

set foreign_key_checks = 0;

drop table if exists job_grades;
drop table if exists job_history;
drop table if exists departments;
drop table if exists employees;
drop table if exists jobs;
drop table if exists locations;
drop table if exists countries;
drop table if exists regions;

create table regions(
    region_id integer,
    region_name varchar(25),
    constraint pk_regions primary key (region_id));

create table countries(
    country_id char(2),
    country_name varchar(40),
    region_id integer,
    primary key (country_id),
    foreign key(region_id) references regions(region_id));              

create table locations (
     location_id int(4),
     street_address varchar(40),
     postal_code varchar(12),
     city varchar(30) not null,
     state_province varchar(25),
     country_id char(2),
     primary key(location_id),
     foreign key(country_id) references countries(country_id)); 

create table departments(
   department_id int(4),
   department_name varchar(30) not null,
   manager_id int(6),
   location_id int(4),
   primary key(department_id),
   foreign key(location_id) references locations(location_id));

create table jobs(
   job_id varchar(10),
   job_title varchar(35) not null,
   min_salary int(6),
   max_salary int(6),
   primary key(job_id));

create table employees(
    employee_id int(6),
    first_name varchar(20),
    last_name varchar(25) not null,
    email varchar(25) not null,
    phone_number varchar(20),
    hire_date date not null,
    job_id varchar(10) not null,
    salary decimal(8,2),
    commission_pct decimal(2,2),
    manager_id int(6),
    department_id int(4),
    primary key(employee_id),
    foreign key(job_id) references jobs(job_id),
    foreign key(manager_id) references employees(employee_id),
    foreign key(department_id) references departments(department_id),
    constraint emp_email_uk unique(email));

alter table departments add constraint fk_departments_employees
   foreign key(manager_id) references employees(employee_id);

create table job_history(
  employee_id int(6),
  start_date date not null,
  end_date date not null,
  job_id varchar(10) not null,
  department_id int(4),
  primary key(employee_id, job_id),
  foreign key(employee_id) references employees(employee_id),
  foreign key(job_id) references jobs(job_id),
  foreign key(department_id) references departments(department_id));

create table job_grades(
     grade_level varchar(3),
     lowest_sal integer,
     highest_sal integer,
     primary key(grade_level));

insert into regions values (1, 'Europe');
insert into regions values (2, 'Americas');
insert into regions values (3, 'Asia');
insert into regions values (4, 'Middle East and Africa');

insert into countries values('CA', 'Canada', 2);
insert into countries values('DE', 'Germany', 1);
insert into countries values('UK', 'United Kingdom', 1);
insert into countries values('US', 'United States of America', 2);

insert into locations values(1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');
insert into locations values(1500, '2001 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US');
insert into locations values(1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');
insert into locations values(1800, '460 Bloor St. W.', 'ON M5S 1X8', 'Toronto', 'Ontario', 'CA');
insert into locations values(2500, 'Magdalen Centre, The Ofxord Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK');

insert into jobs values('AD_PRES', 'President', 20000, 40000);
insert into jobs values('AD_VP', 'Administration Vice President', 15000, 30000);
insert into jobs values('AD_ASST', 'Administration Assistant', 3000, 6000);
insert into jobs values('AC_MGR', 'Accounting Manager', 8200, 16000);
insert into jobs values('AC_ACCOUNT', 'Public Accountant', 4200, 9000);
insert into jobs values('SA_MAN', 'Sales Manager', 10000, 20000);
insert into jobs values('SA_REP', 'Sales Representative', 6000, 12000);
insert into jobs values('ST_MAN', 'Stock Manager', 5500, 8500);
insert into jobs values('ST_CLERK', 'Stock Clerk', 2000, 5000);
insert into jobs values('IT_PROG', 'Programmer', 4000, 10000);
insert into jobs values('MK_MAN', 'Marketing Manager', 9000, 15000);
insert into jobs values('MK_REP', 'Marketing Representative', 4000, 9000);

insert into departments values (10, 'Administration', 200, 1700);
insert into departments values (20, 'Marketing', 201, 1800);
insert into departments values (50, 'Shipping', 124, 1500);
insert into departments values (60, 'IT', 103, 1400);
insert into departments values (80, 'Sales', 149, 2500);
insert into departments values (90, 'Executive', 100, 1700);
insert into departments values (110, 'Accounting', 205, 1700);
insert into departments values (190, 'Contracting', null, 1700);

insert into employees values (100, 'Steven', 'King', 'SKING', '515.123.4567', '1987-06-17', 'AD_PRES', 24000, null, null, 90);
insert into employees values (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1989-09-21', 'AD_VP', 17000, null, 100, 90); 
insert into employees values (102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '1993-01-13', 'AD_VP', 17000, null, 100, 90); 
insert into employees values (103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '1990-01-03', 'IT_PROG', 9000, null, 102, 60); 
insert into employees values (104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '1991-05-21', 'IT_PROG', 6000, null, 103, 60); 
insert into employees values (107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '1999-02-07', 'IT_PROG', 4200, null, 103, 60); 
insert into employees values (124, 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234', '1999-11-19', 'ST_MAN', 5800, null, 100, 50); 
insert into employees values (141, 'Trenna', 'Rajs', 'TRAJS', '650.121.8009', '1995-10-17', 'ST_CLERK', 3500, null, 124, 50); 
insert into employees values (142, 'Curtis', 'Davies', 'CDAVIES', '650.121.2994', '1997-01-29', 'ST_CLERK', 3100, null, 124, 50); 
insert into employees values (143, 'Randall', 'Matos', 'RMATOS', '650.121.2874', '1998-03-15', 'ST_CLERK', 2600, null, 124, 50); 
insert into employees values (144, 'Peter', 'Vargas', 'PVARGAS', '650.121.2004', '1998-07-09', 'ST_CLERK', 2500, null, 124, 50); 
insert into employees values (149, 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', '2000-01-29', 'SA_MAN', 10500, .2, 100, 80); 
insert into employees values (174, 'Ellen', 'Abel', 'EABEL', '011.44.1644.429267', '1996-05-11', 'SA_REP', 11000, .3, 149, 80); 
insert into employees values (176, 'Jonathan', 'Taylor', 'JTAYLOR', '011.44.1644.429265', '1998-03-24', 'SA_REP', 8600, .2, 149, 80); 
insert into employees values (178, 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263', '1999-05-24', 'SA_REP', 7000, .15, 149, null); 
insert into employees values (200, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', '1987-09-17', 'AD_ASST', 4400, null, 101, 10); 
insert into employees values (201, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', '1996-02-17', 'MK_MAN', 13000, null, 100, 20); 
insert into employees values (202, 'Pat', 'Fay', 'PFAY', '603.123.6666', '1997-08-17', 'MK_REP', 6000, null, 201, 20); 
insert into employees values (205, 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', '1994-06-07', 'AC_MGR', 12000, null, 101, 110); 
insert into employees values (206, 'William', 'Gietz', 'WGIETZ', '515.123.8181', '1994-06-07', 'AC_ACCOUNT', 8300, null, 205, 110);  

insert into job_history values(102, '1993-01-13', '1998-07-24', 'IT_PROG', 60);
insert into job_history values(101, '1989-09-21', '1993-10-27', 'AC_ACCOUNT', 110);
insert into job_history values(101, '1993-10-28', '1997-03-15', 'AC_MGR', 110);
insert into job_history values(201, '1996-02-17', '1999-12-19', 'MK_REP', 20);
insert into job_history values(144, '1998-03-24', '1999-12-31', 'ST_CLERK', 50);
insert into job_history values(142, '1999-01-01', '1999-12-31', 'ST_CLERK', 50);
insert into job_history values(200, '1987-09-17', '1993-06-17', 'AD_ASST', 90);
insert into job_history values(176, '1998-03-24', '1998-12-31', 'SA_REP', 80);
insert into job_history values(176, '1999-01-01', '1999-12-31', 'SA_MAN', 80);
insert into job_history values(200, '1994-07-01', '1998-12-31', 'AC_ACCOUNT', 90);

insert into job_grades values('A', 1000, 2999);
insert into job_grades values('B', 3000, 5999);
insert into job_grades values('C', 6000, 9999);
insert into job_grades values('D', 10000, 14999);
insert into job_grades values('E', 15000, 24999);
insert into job_grades values('F', 25000, 40000);

set foreign_key_checks = 1;
