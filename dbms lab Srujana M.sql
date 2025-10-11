use mysql
show databases;
create database bmsce;
use bmsce;
create table person(driver_id varchar(30),
name varchar(30),
address varchar(30),
primary key(driver_id));

create table car(reg_no varchar(10), model varchar(10), year int, primary key(reg_no));
desc car;

create table accident(report_num int, accident_date date, location varchar(20), primary key(report_num));
desc accident;

create table owns(driver_id varchar(10),reg_no varchar(10),primary key(driver_id, reg_no),
foreign key(driver_id) references person(driver_id),
foreign key(reg_no) references car(reg_no));

desc owns;
create table participated(driver_id varchar(10), reg_no varchar(10),
report_num int, damage_amount int,
primary key(driver_id, reg_no, report_num),

foreign key(driver_id) references person(driver_id),
foreign key(reg_no) references car(reg_no),
foreign key(report_num) references accident(report_num));

insert into person
values
("A01","Richard","Srinivas nagar"),
("A02","Pradeep","Rajaji nagar"),
("A03","Smith","Ashok nagar"),
("A04","Venu","NR Colony"),
("A05","John","Hanumanth nagar");

insert into car
values
("KA052250","Indica","1990"),
("KA031181","Lancer","1957"),
("KA095477","Toyota","1998"),
("KA053408","Honda","2008"),
("KA041702","Audi","2005");

insert into accident
values 
(11, "2003-01-01","Mysore Road"),
(12,"2004-02-02","South end Circle"),
(13,"2003-01-21","Bull temple Road"),
(14,"2008-02-17","Mysore Road"),
(15,"2004-03-05","Kanakpura Road");

insert into owns 
values 
("A01","KA052250");
insert into owns 
values ("A02","KA053408");
insert into owns 
values("A03","KA095477");
insert into owns 
values("A04","KA031181");
insert into owns 
values("A05","KA041702");

select*from owns;


insert into participated values("A01","KA052250",11,10000);
insert into participated values("A02","KA053408",12,50000);
insert into participated values("A03","KA095477",13,25000);
insert into participated values("A04","KA031181",14,3000);
insert into participated values("A05","KA041702",15,5000);

select*from participated

select accident_date, location
from accident;

select p.name
from person p, participated pd
where p.driver_id=pd.driver_id and pd.damage_amount>=25000;

select p.name, c.model
from person p, car c,owns o
where p.driver_id=o.driver_id and c.reg_no=o.reg_no;

select p.name, a.location, a.accident_date, pd.damage_amount
from person p,participated pd, accident a
where p.driver_id=pd.driver_id and a.report_num=pd.report_num;

select p.name
from person p, participated pd
where p.driver_id=pd.driver_id
group by pd.driver_id
having count(*)>1

select o.reg_no
from owns o
where o.reg_no not in(select pd.reg_no
                     from participated pd)
select *
from accident
where accident_date>=all(select accident_date
                        from accident);


select p.name,avg(pd.damage_amount) as Avg_damage_amount
from person p,participated pd
where p.driver_id=pd.driver_id
group by pd.driver_id;

update participated
set damage_amount=25000
where driver_id="A03"

SELECT driver_id, damage_amount
from particicipated
where damage_amount>=all(select pd.damage_amount
                          from participated pd);

select model
from car c,participated pd
where c.reg_no=pd.reg_no
group by pd.reg_no
having sum(pd.damage_amount)>20000;

CREATE VIEW summary_accidents AS
SELECT
    a.report_num AS Acc_ReportNum,a.location as Acc_location,
    a.accident_date AS Acc_Date,
    COUNT(p.driver_id) AS NumberOfParticipants,
    SUM(p.damage_amount) AS TotalDamage
FROM accident AS a
JOIN participated AS p ON a.report_num = p.report_num
GROUP BY a.report_num;
select*from summary_accidents;

