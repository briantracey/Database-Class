--Lab 4
--Brian Tracey

-- 1 Cities of Agents booking an order for a customer whose cid is ''
select city 
from agents
where aid in (select aid 
	from orders 
	where cid = ('c002')
	);
		

--2 ids of products ordered through any agent who has one order from dallas, sorted by pid High to Low
select pid
from orders 
where cid in (select cid 
		from customers
		where city = 'Dallas')
		order by pid ASC
		;
		
--3 ids and names of customers who did not place an order through agent 01 
select cid, name
from customers
where cid not in (select cid 
		from orders
		where aid ='a01')
		;
	--all customers appear including ones who have orders with agent 01 and another agent
	--....dont want to leave out orders 

--4 ids of customers who orders product 01 and 07
select cid
from customers 
where cid in (select cid from orders where pid ='p01' 
and cid in (select cid from orders where pid ='p07'))

;


--5 ids of products not order by any customers who placed any order through agent a07 in pid order from hi to low
select pid
from orders
where aid in (select aid
	from orders
	where aid = 'a07')
;
-- theres no agent 07

--6 name discounts and city for all customers who place orders through agents in london or NY
select name, discount, city
from customers 
where cid in (select cid from orders
	where aid in
	 (select aid 
	 from agents 
	 where city in ('London','New York')
	 )
	 ); 

--7 customers who have same discount in dallas or london
--question doesnt even make sense.... not one similar discount or any in London
select cid,name
from customers 
where discount in (select discount from customers where city in ('Dallas', 'London'));

--8 check constraints 
-- According to W3 Schools, check contraints limit the value range that can be placed on a column. 
--When creating a table, one would add a constraint at the bottom to prevent poor information in the database.
--The advantage of check constraints is that they give database more structure. They also provide data integrity and consistency by only allowing certain data to be admitted into the database.
--A good example of a check constraint would be adding "CONSTRAINT quantity > 0."
--A database should not allow negative numbers inside quantity, because once you sell out of a certain product, you hit 0 and is impossible to go under. Backorders would have to be its own column. 
--a bad example of a check contraint would be putting a limit on the price of products. CONSTRAINT totalUSD<100 would be poor because your limiting the amount you can sell your products for. Inflation and competition could increase the price and the limit would prevent this. 
