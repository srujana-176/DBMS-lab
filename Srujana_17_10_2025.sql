
show databases;
create database BANK1;
use BANK1;
create table branch (branch_name varchar(30) primary key, branch_city varchar(30), 
assets decimal(10,2));

create table bankaccount(accno int primary key, branch_name varchar(30), 
balance decimal(10,2), 
foreign key(branch_name) references branch(branch_name));

create table bankcustomer(customer_name varchar(30) primary key,
customer_street varchar(30), customer_city varchar(30));

create table depositor(customer_name varchar(30), accno int,
primary key(customer_name, accno),
foreign key(customer_name) references bankcustomer(customer_name),
foreign key(accno) references bankaccount(accno));

create table loan(loan_number int primary key,
branch_name varchar (30), amount decimal(15,2),
foreign key(branch_name) references branch(branch_name));

INSERT INTO Branch (branch_name, branch_city, assets) VALUES
('SBI_Chamrajpet', 'Bangalore', 50000),
('SBI_ResidencyRoad', 'Bangalore', 10000),
('SBI_ShivajiRoad', 'Bombay', 20000),
('SBI_ParlimentRoad', 'Delhi', 20000),
('SBI_Jantarmantar', 'Delhi', 20000);

INSERT INTO BankAccount (accno, branch_name, balance) VALUES
(1, 'SBI_Chamrajpet', 2000),
(2, 'SBI_ResidencyRoad', 5000),
(3, 'SBI_ShivajiRoad', 6000),
(4, 'SBI_ParlimentRoad', 8000),
(5, 'SBI_Jantarmantar', 8000),
(6, 'SBI_ShivajiRoad', 4000),
(7, 'SBI_ResidencyRoad', 5000),
(8, 'SBI_ParlimentRoad', 3000),
(9, 'SBI_ResidencyRoad', 5000),
(10, 'SBI_ResidencyRoad', 5000),
(11, 'SBI_Jantarmantar', 2000);

INSERT INTO BankCustomer (customer_name, customer_street, customer_city) VALUES
('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Bannergatta_Road', 'Bangalore'),
('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikhil', 'Akbar_Road', 'Delhi'),
('Ravi', 'Prithviraj_Road', 'Delhi');

INSERT INTO Depositor (customer_name, accno) VALUES
('Avinash', 1),
('Dinesh', 2),
('Nikhil', 4),
('Ravi', 5),
('Avinash', 8),
('Nikhil', 9),
('Dinesh', 10),
('Nikhil', 11);

INSERT INTO Loan (loan_number, branch_name, amount) VALUES
(1, 'SBI_Chamrajpet', 1000),
(2, 'SBI_ResidencyRoad', 2000),
(3, 'SBI_ShivajiRoad', 3000),
(4, 'SBI_ParlimentRoad', 4000),
(5, 'SBI_Jantarmantar', 5000);

select branch_name, assets as assets_in_lakhs
from branch;

select  d.customer_name
from bankaccount b, depositor d
where b.accno=d.accno
group by d.customer_name
having count(*)>1;

create view loans_at_branch
as select branch_name, SUM(amount) 
from loan
group by branch_name;

select*from loans_at_branch