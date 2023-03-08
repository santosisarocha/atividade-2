create database empresa_x;
use empresa_x;

create table personal_data (
employee_id INT not null AUTO_INCREMENT,
name varchar(50) not null,
birthday date not null,
genero enum ( 'F', 'M' ) NOT NULL,
cpf bigint(14) not null,
primary key (employee_id)
);

CREATE TABLE history (
  employee_id INT not null,
  start_date DATE NOT NULL,
  end_date DATE,
  job_title VARCHAR(50) NOT NULL,
  department_id INT NOT NULL,
  PRIMARY KEY (employee_id),
  FOREIGN KEY (employee_id) REFERENCES personal_data (employee_id)
  );
  
  create table salaries (
   employee_id INT not null,
   start_date DATE NOT NULL,
   end_date DATE,
   salarie int not null,
   PRIMARY KEY (employee_id),
   FOREIGN KEY (employee_id) REFERENCES personal_data (employee_id)
  );
  
  CREATE TABLE departments (
  department_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  manager_id INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE,
  FOREIGN KEY (manager_id) REFERENCES personal_data (employee_id)
);

CREATE TABLE department_manager (
  department_id INT NOT NULL,
  manager_id INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE,
  PRIMARY KEY (department_id, start_date),
  FOREIGN KEY (department_id) REFERENCES departments (department_id),
  FOREIGN KEY (manager_id) REFERENCES personal_data (employee_id)
);

INSERT INTO personal_data (name, birthday, genero, cpf)
VALUES ('João Silva', '1980-02-15', 'M', 12345678901),
('Maria Santos', '1992-05-08', 'F', 23456789012),
('Pedro Almeida', '1985-11-23', 'M', 34567890123),
('Ana Souza', '1998-08-06', 'F', 45678901234),
('Lucas Oliveira', '1979-04-12', 'M', 56789012345);

INSERT INTO history (employee_id, start_date, end_date, job_title, department_id)
 VALUES (1, '2000-01-01', '2005-12-31', 'Programmer', 1),
 (2, '2006-01-01', NULL, 'Manager', 2),
 (3, '2015-02-01', '2019-12-31', 'Accountant', 3),
 (4, '2020-01-01', NULL, 'Supervisor', 4);

INSERT INTO salaries (employee_id, start_date, end_date, salarie) 
VALUES (1, '2000-01-01', '2005-12-31', 4000),
  (2, '2006-01-01', '2010-12-31', 6000), 
  (3, '2011-01-01', NULL, 8000),
  (4, '2015-02-01', '2017-12-31', 3500);

INSERT INTO departments (department_id, name, manager_id, start_date, end_date)
VALUES (1, 'IT', 1, '2000-01-01', NULL), 
  (2, 'Management', 1, '2006-01-01', NULL), 
  (3, 'Finanças', 2, '2015-02-01', '2021-06-30'), 
  (4, 'Operações', 4, '2020-01-01', NULL);

INSERT INTO department_manager (department_id, manager_id, start_date, end_date)
VALUES (1, 1, '2000-01-01', NULL),
(2, 1, '2006-01-01', NULL),
(3, 2, '2015-02-01', '2021-06-30'),
(3, 4, '2021-07-01', NULL),
(4, 4, '2020-01-01', NULL);

select * from history h  
join personal_data pd on pd.employee_id = h.employee_id;

select * from salaries s  
join personal_data pd on pd.employee_id = s.employee_id;

SELECT * FROM departments de
JOIN personal_data pd ON pd.employee_id = de.manager_id;

SELECT * FROM department_manager dm
JOIN departments de ON de.department_id = dm.department_id
JOIN personal_data pd ON pd.employee_id = dm.manager_id;

SELECT * FROM salaries
WHERE salarie > 5000;

SELECT personal_data.name, salaries.salarie
FROM salaries
JOIN personal_data ON salaries.employee_id = personal_data.employee_id
WHERE salaries.salarie = (SELECT MAX(salarie) FROM salaries);

SELECT p.name, h.job_title
FROM personal_data p
INNER JOIN history h ON p.employee_id = h.employee_id
INNER JOIN departments d ON h.department_id = d.department_id
WHERE d.manager_id = 1;

SELECT job_title 
FROM history 
WHERE employee_id = 1
LIMIT 0, 1000;

SELECT pd.name AS manager_name
FROM department_manager dm
JOIN personal_data pd ON dm.manager_id = pd.employee_id
WHERE dm.department_id = 3;


