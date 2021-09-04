-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/p1Cx20
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "salaries" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "employees" ALTER COLUMN birth_date TYPE DATE
using to_date(birth_date, 'MM/DD/YYYY');
ALTER TABLE employees ALTER COLUMN hire_date TYPE DATE
using to_date(hire_date, 'MM/DD/YYYY');

SELECT "employees"."emp_no","employees"."last_name","employees"."first_name","employees"."sex", "salaries"."salary"
FROM "employees"
JOIN "salaries"
ON "employees"."emp_no" = "salaries"."emp_no";

SELECT "employees"."first_name", "employees"."last_name", "employees"."hire_date"
FROM "employees"
Where EXTRACT(Year FROM hire_date)= 1986;

SELECT "departments"."dept_no", "departments"."dept_name", "employees"."emp_no", "employees"."last_name", "employees"."first_name"
FROM "departments"
LEFT JOIN "dept_manager" 
ON "departments"."dept_no" = "dept_manager"."dept_no"
LEFT JOIN "employees"
ON "dept_manager"."emp_no" = "employees"."emp_no";


SELECT "departments"."dept_no", "departments"."dept_name", "employees"."emp_no", "employees"."last_name", "employees"."first_name"
FROM "employees"
LEFT JOIN "dept_emp" 
ON "dept_emp"."emp_no" = "employees"."emp_no"
LEFT JOIN "departments"
ON "dept_emp"."dept_no" = "departments"."dept_no";


SELECT "employees"."first_name", "employees"."last_name", "employees"."sex"
FROM "employees"
WHERE "first_name" = 'Hercules'
AND "last_name"
LIKE 'B%'

SELECT "departments"."dept_no", "departments"."dept_name", "employees"."emp_no", "employees"."last_name", "employees"."first_name"
FROM "employees"
LEFT JOIN "dept_emp" 
ON "dept_emp"."emp_no" = "employees"."emp_no"
LEFT JOIN "departments"
ON "dept_emp"."dept_no" = "departments"."dept_no"
WHERE "departments"."dept_no" = 'd007';

SELECT "departments"."dept_no", "departments"."dept_name", "employees"."emp_no", "employees"."last_name", "employees"."first_name"
FROM "employees"
LEFT JOIN "dept_emp" 
ON "dept_emp"."emp_no" = "employees"."emp_no"
LEFT JOIN "departments"
ON "dept_emp"."dept_no" = "departments"."dept_no"
WHERE "departments"."dept_no" = 'd007'
OR "departments"."dept_no" = 'd005';


SELECT last_name,
COUNT ("employees"."last_name")
FROM "employees"
GROUP BY "employees"."last_name"
ORDER BY COUNT ("employees"."last_name") DESC
