create table customers (
customer_id integer primary key,
first_name varchar (20),
last_name varchar (20),
date_of_birth date,
gender varchar (20),
contact_number integer,
email varchar (50),
address varchar (100),
aadhar_number integer,
pan_number varchar (20)
);

create table agents (
agent_id integer primary key,
first_name varchar (20),
last_name varchar (20),
contact_number integer,
email varchar (50),
comission_rate numeric(10,2)
);

CREATE TABLE policies (
policy_id INTEGER PRIMARY KEY,
policy_type VARCHAR(20),
coverage_amount INTEGER,
premium_amount INTEGER,
start_date DATE,
end_date DATE,
customer_id INTEGER,
agent_id INTEGER,
approved_by VARCHAR(50),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);

create table claims (
claim_id integer primary key,
claim_date date,
amount_claimed integer,
policy_id integer,
status varchar (50),
foreign key (policy_id) references policies (policy_id),
approved_by varchar (50)
);

create table payments (
payment_uuid varchar (100) primary key,
payment_date date,
policy_id integer,
payment_method varchar (20),
foreign key (policy_id) references policies (policy_id)
);


--Query 1
select
c.first_name,
p.customer_id,
count (p.policy_id)
from customers c
join policies p on p.customer_id = c.customer_id
group by p.customer_id, c.first_name;

--Query 2
select
sum(premium_amount)
from policies;

--Query 3
select
c.first_name,
p.customer_id,
sum (p.premium_amount) as total_premium_amount
from customers c
join policies p on p.customer_id = c.customer_id
group by p.customer_id, c.first_name;

--Query 4
Select
a.first_name,
a.last_name,
count(p.policy_id) AS total_policies_sold
from agents a
left join policies p on a.agent_id = p.agent_id
group by a.agent_id, a.first_name, a.last_name;

--Query 5
select 
p.policy_id,
sum(c.amount_claimed) as total_claim_amount
from policies p
left join claims c on p.policy_id = c.policy_id
group by p.policy_id;

--query 6
select
policy_id,
status
from claims
where status = 'Approved';

--query 7
select 
p.policy_id,
sum(c.amount_claimed) as total_payment_received
from policies p
left join claims c on p.policy_id = c.policy_id
group by p.policy_id;

--query 8
select 
c.customer_id,
c.first_name,
c.last_name,
p.policy_id
from customers c
left join policies p on c.customer_id = p.customer_id;

--query 9
select
policy_type,
avg(premium_amount) as avg_premium
from policies
group by policy_type;

--query 10
select 
a.first_name,
sum(p.premium_amount * a.comission_rate / 100) AS total_commission
from agents a
left join policies p on a.agent_id = p.agent_id
group by a.agent_id;

select * from customers;
select * from agents;
select * from policies;
select * from claims;
select * from payments;
