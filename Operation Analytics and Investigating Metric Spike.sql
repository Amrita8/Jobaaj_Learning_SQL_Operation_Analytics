create database job_db;
use job_db;
create table job_data
(
ds date,
job_id int,
actor_id int,
event varchar(20),
language varchar(20),
time_spent time,
org varchar(10)
);
insert into job_data (ds, job_id, actor_id, event, language, time_spent, org)
values
('2020-11-30', '21', '1001', 'skip', 'English', '15', 'A'),
('2020-11-30', '22', '1006', 'transfer', 'Arabic', '25', 'B'),
('2020-11-29', '23', '1003', 'decision', 'Persian', '20', 'C'),
('2020-11-28', '23', '1005', 'transfer', 'Persian', '22', 'D'),
('2020-11-28', '25', '1002', 'decision', 'Hindi', '11',	'B'),
('2020-11-27', '11', '1007', 'decision', 'French', '104', 'D'),
('2020-11-26', '23', '1004', 'skip', 'Persian', '56', 'A'),
('2020-11-25', '20', '1003', 'transfer', 'Italian', '45', 'C');

select * from job_data;

select count(distinct job_id)/(30*24)
as per_hour_jobs
from job_data;

select ds, tot_events, avg(tot_events) over(order by ds rows between 6 preceding and current row) as 7_days_rolling_average
from (select ds, count(distinct event) as tot_events from job_data group by ds order by ds)sub;

select language, count(language) as tot_language,
count(*)*100/sum(count(*)) over() as percentage from job_data group by language order by language;

select *, count(*) as duplicate from job_data group by actor_id having count(*)>1;

create database project_3;
use project_3;

#Table-1 users
create table users (
user_id int,
created_at varchar(100),
company_id int,
language varchar(50),
activated_at varchar(100),
state varchar(50));

select * from users;

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv"
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

alter table users add column temp_created_at datetime;

UPDATE users SET temp_created_at = str_to_date(created_at, '%d-%m-%Y %H:%i');

ALTER TABLE USERS DROP COLUMN created_at;

ALTER TABLE USERS CHANGE COLUMN temp_created_at created_at DATETIME;

select * from users;

#Table-2 events

create table events (
user_id int,
occured_at varchar(100),
event_type varchar(50),
event_name varchar(100),
location varchar(50),
device varchar(50),
user_type int);

select * from events;

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv"
INTO TABLE events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

alter table events add column temp_occured_at datetime;

UPDATE events SET temp_occured_at = str_to_date(created_at, '%d-%m-%Y %H:%i');

ALTER TABLE events DROP COLUMN occured_at;

ALTER TABLE events CHANGE COLUMN created_at occured_at DATETIME;

select * from events;

#Table-3 email_events

create table email_events (
user_id int,
occured_at varchar(100),
action varchar(50),
user_type int);

select * from email_events;

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv"
INTO TABLE email_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

alter table email_events add column temp_occured_at datetime;

UPDATE email_events SET temp_occured_at = str_to_date(occured_at, '%d-%m-%Y %H:%i');

ALTER TABLE email_events DROP COLUMN occured_at;

ALTER TABLE email_events CHANGE COLUMN temp_occured_at occured_at DATETIME;

select * from users;
select * from events;
select * from email_events;

select extract(week from occured_at) as week_number,
count(distinct user_id) as active_user
from events
where event_type='engagement'
group by week_number
order by week_number;

select year, week_num, num_users, sum(num_users)
over (order by year, week_num) as cum_users
from (
select extract(year from created_at) as year, extract(week from created_at) as week_num, count(distinct user_id) as num_users
from users
group by year, week_num
order by year, week_num)sub;

with cte as (select extract(year from occured_at) as year, extract(week from occured_at) as week,
device, count(distinct user_id) as usercnt 
from events where event_type = 'engagement'
group by year, week, device
order by year, week)
select year, week, device, usercnt
from cte;

with cte1 as (select distinct user_id, Extract(week from occured_at) as signup_week from events 
where event_type = 'signup_flow' and event_name = 'complete_signup' and extract(week from occured_at) = 18),
cte2 as (select distinct user_id, Extract(week from occured_at) as engagement_week from events 
where event_type = 'engagement')
select count(user_id) total_engaged_users, sum(case when retention_week > 0 then 1 else 0 end) as retained_users 
from (select a.user_id, a.signup_week, b.engagement_week, b.engagement_week-a.signup_week as retention_week
from cte1 a LEFT JOIN cte2 b on a.user_id = b.user_id
order by a.user_id)sub;


select 
100 * sum(case when email_cat = 'email_open' then 1 else 0 end)/sum(case when email_cat = 'email_sent' then 1 else 0 end) as email_open_rate,
100 * sum(case when email_cat = 'email_clicked' then 1 else 0 end)/sum(case when email_cat = 'email_sent' then 1 else 0 end) as email_click_rate
from (select *, case when action in ('sent_weekly_digest', 'sent_reengagement_email')then 'email_sent'
when action in ('email_open')then 'email_open'
when action in ('email_clickthrough')then 'email_clicked'
end as email_cat
from email_events)sub
