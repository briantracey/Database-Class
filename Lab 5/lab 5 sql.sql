--lab 5 
--use joins not subqueries
--Brian Tracey

--1 Cities of agents booking an order from customer whose id is c002
Select city
From agents,
	orders
where agents.aid = orders.aid
	and orders.cid = 'c002'
	;

--2 ids of products ordered through any agent who makes atleast one order for a customer in dallas. 
--sort by pid high to low 
Select products.pid
from products,
	orders,
	customers
Where products.pid = orders.pid
	AND customers.cid = orders.cid
	and customers.city = 'Dallas'
	Group BY products.pid
	order by pid ASC 
	;

--3 names of customers who have never place an order
--use a subquery

select name 
from customers
where cid not in (select cid 
		from orders
		)
		;
--4 names of customers who have never placed an order 
--use an outer join

select name
from customers
	Full outer join orders on customers.cid = orders.cid
	where orders.cid is null 
	;
--cant accept the !=  because it has to join the tables thus add "where is null"


--5 show the names of customers who placed at least one order through an agent in their own city, with names
Select customers.name 
from customers,
	orders,
	agents
where customers.city = agents.city	
	and orders.cid = customers.cid
	and agents.aid = orders.aid
	group by customers.name
	;


	---following joins didnt work wasted my time and headaches doing them (ignore for future reference) 
	--inner join agents on agents.city = customers.city
	--inner join orders on orders.aid = agents.aid
	--where agents.city = customers.city 
	--and orders.aid = agents.aid

--6 names of customers and agents living in same city, with name of city
select customers.name, agents.name, agents.city
from customers,
	agents
where customers.city = agents.city 
;

--7 name and city of customers who live in the city that makes the fewest differnt kindas of products
select customers.name, products.city
from customers,
	products
where customers.city = products.city 
and  products.city in (select city 
				from products
				group by products.city
				order by count(products.city) 
				limit 1
				)
group by customers.name, products.city
order by customers.name, products.city
				;

