-- CREATE DB
Create database emp_stg
USE emp_stg
go

-- CREATE STAGING TABLE

drop table emp_record_stg
create table emp_record_stg
( emp_id varchar(10) NOT NULL,
  emp_dob date NOT NULL,
  emp_dept_id integer,
  emp_name varchar(250),
  emp_dept Varchar(250),
  emp_joining_date date,
  emp_email varchar(250) NOT NULL)
  
  
 -- CREATE MAIN TABLE
 
 drop table emp_record_main
Create table emp_record_main
(
	emp_sk bigint NOT NULL,
	emp_id varchar(10) NOT NULL,
	emp_name varchar(250) NOT NULL,
	emp_dob date NOT NULL,
	emp_dept_id int,
	emp_dept varchar(250),
	emp_joining_date date,
	emp_email varchar(250),
	prev_emp_dept_id int,
	prev_emp_dept varchar(250),
	record_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP, -- For both insert and update
    PRIMARY KEY (emp_sk)
);

---select * from emp_record_stg
---select * from emp_record_main


-- Select* from emp_record_stg
-- INSERT CURRENT DATA INTO STAGING TABLE

delete from emp_record_stg
insert into emp_record_stg values ('P101','1975-02-09','10','Otu','HR','2022-05-14','otu@xyzcompany.com');
insert into emp_record_stg values ('P102','1989-06-13','20','Moses','FINANCE','2022-03-24','moses@xyzcompany.com');
insert into emp_record_stg values ('P103','1994-08-18','30','jerry','MANUFACTURING','2022-02-10','jerry@xyzcompany.com');
insert into emp_record_stg values ('P104','1995-11-22','40','Jermain','IT','2022-05-14','jermain@xyzcompany.com');
insert into emp_record_stg values ('P105','2000-12-26','50','Prince','SALES','2022-05-14','prince@xyzcompany.com');

-- Select* from emp_record_stg

-- UPDATE statement
UPDATE main
SET 
    prev_emp_dept_id = main.emp_dept_id,
    emp_dept_id = stg.emp_dept_id,
    prev_emp_dept = main.emp_dept,
    emp_dept = stg.emp_dept
FROM emp_record_main main
INNER JOIN emp_record_stg stg ON main.emp_id = stg.emp_id;

-- INSERT statement
INSERT INTO emp_record_main (
    emp_sk, 
    emp_id, 
    emp_name, 
    emp_dob, 
    emp_dept_id, 
    prev_emp_dept_id, 
    emp_dept, 
    prev_emp_dept, 
    emp_joining_date, 
    emp_email
)
SELECT 
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS emp_sk, -- Generate emp_sk using ROW_NUMBER
    stg.emp_id, 
    stg.emp_name, 
    stg.emp_dob, 
    stg.emp_dept_id, 
    stg.emp_dept_id, 
    stg.emp_dept, 
    stg.emp_dept, 
    stg.emp_joining_date, 
    stg.emp_email
FROM 
    emp_record_stg stg 
LEFT JOIN 
    emp_record_main main ON stg.emp_id = main.emp_id
WHERE 
    main.emp_id IS NULL;

select*from emp_record_main



--- NEW UPDATE; Moses changes dept to sales and Prince changes dept to Finance

delete from emp_record_stg
insert into emp_record_stg values ('P101','1975-02-09','10','Otu','HR','2022-05-14','otu@xyzcompany.com');
insert into emp_record_stg values ('P102','1989-06-13','50','Moses','SALES','2022-03-24','moses@xyzcompany.com');
insert into emp_record_stg values ('P103','1994-08-18','30','jerry','MANUFACTURING','2022-02-10','jerry@xyzcompany.com');
insert into emp_record_stg values ('P104','1995-11-22','40','Jermain','IT','2022-05-14','jermain@xyzcompany.com');
insert into emp_record_stg values ('P105','2000-12-26','20','Prince','FINANCE','2022-05-14','prince@xyzcompany.com');
select * from emp_record_stg


-- UPDATE statement
UPDATE main
SET 
    prev_emp_dept_id = main.emp_dept_id,
    emp_dept_id = stg.emp_dept_id,
    prev_emp_dept = main.emp_dept,
    emp_dept = stg.emp_dept
FROM emp_record_main main
INNER JOIN emp_record_stg stg ON main.emp_id = stg.emp_id;

-- INSERT statement
INSERT INTO emp_record_main (
    emp_sk, 
    emp_id, 
    emp_name, 
    emp_dob, 
    emp_dept_id, 
    prev_emp_dept_id, 
    emp_dept, 
    prev_emp_dept, 
    emp_joining_date, 
    emp_email
)
SELECT 
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS emp_sk, -- Generate emp_sk using ROW_NUMBER
    stg.emp_id, 
    stg.emp_name, 
    stg.emp_dob, 
    stg.emp_dept_id, 
    stg.emp_dept_id, 
    stg.emp_dept, 
    stg.emp_dept, 
    stg.emp_joining_date, 
    stg.emp_email
FROM 
    emp_record_stg stg 
LEFT JOIN 
    emp_record_main main ON stg.emp_id = main.emp_id
WHERE 
    main.emp_id IS NULL;

select*from emp_record_main

