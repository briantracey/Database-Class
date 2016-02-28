--lab 6 painful queries 
--Brian Tracey
--March 1st 2016

--1 name and city of customers who live in any city that makes the most different kinds of products 

select customers.name, products.city, --count(products.city)
 from customers,
 	products
 where customers.city = products.city 
 and  products.city in (select city 
 				from products
 				group by products.city
 				order by count(products.city) DESC
 				limit 2
 				
 				)
 group by customers.name, products.city
 order by customers.name, products.city
 				;
--initially showed count(product.city) to see which city has to most different products.
--ordered by DESC to have the largest number at top
--limit to 2 because there are two cities with the most 
--newark does not appaear because there are no customers from newark (typical)

--2 names of products whose price USD is strictly above the average priceUSD in reverse alphabetical order?

select products.name
from products
where priceUSD > (select avg(priceUSD)
			from products)
			group by products.name
			order by products.name Desc 
			;

-- 3 customer name, pid ordered, and total for all orders, sorted high to low 

select customers.name, orders.pid, orders.totalUSD
from customers,
	orders
where customers.cid = orders.cid 
group by orders.totalUSD, customers.name, orders.pid
order by orders.totalUSD DESC

--dont like this question? look for one customer name, with each pid and sum of totalUSD


--4 customers name in alph orer and total order 

select customers.name, sum(orders.totalUSD)
from customers,
	orders
where customers.cid = orders.cid
	
group by customers.name
order by customers.name ASC
;
--output is customers name in Alphabetical order with the totalUSD theyve order.

--5 display the names of all customers who bought products from agents in tokyo and names of products their orders and names of agents 

select customers.name, products.name, agents.name 
from customers,
	products,
	orders,
	agents

where orders.pid = products.pid
	and orders.aid = agents.aid 
	and customers.cid = orders.cid 
	and agents.city = 'Tokyo'
	;

--6 accuracy of $ collumn in Orders table

Select orders
from orders,
	products,
	customers 
where  orders.pid = products.pid 
	and orders.cid = customers.cid
	and orders.qty * products.priceUSD * ((100-customers.discount)/100) != orders.totalUSD
;

--caught up on discount..... 100 - discount will negate any multiply by 0 error. Then divide by 100 to put numberic into %
	
-- 7 When joining to tables, one might use an outer join. However, in SQL one has to specify whether it is a right or left outer join.
--When writing a querie, the table that is first written will be on the "left" and the table following on the "right."
--So in a left outer join, the table that is written first will look for the foreign key on the second table. 
--If there is no match in the second table, the value will be return as "null." 
--If you replaced "left" with "right" in the same querie, the database will show a table with the same results except show all the values in the second table.
--If the second table does not have a match with the first table, the value will appear as null. 
--For example.. if the table "NBA_Teams" looked like:
-- CITY   TEAM
-- NY     Knicks 
-- BKN    Nets
--and another table "NBA_Players:"
--TEAM       LNAME
--Knicks     Anthony
--Celtics    Thomas
-- with the querie: SELECT * FROM NBA_Teams left outer join NBA_Players WHERE NBA_Players.TEAM = NBA_Teams.Teams
-- would produce the output: 
-- CITY     TEAM      TEAM        LNAME
--NY       Knicks    Knicks     Anthony
--BKN	   Nets       NULL      NULL
-- if i switched left into right so ( 	 SELECT * FROM NBA_Teams right outer join NBA_Players WHERE NBA_Players.TEAM = NBA_Teams.Teams)
-- CITY     TEAM      TEAM        LNAME
--NY       Knicks    Knicks     Anthony
--NULL      NULL     Celtics    Thomas
--Virtually you can use the right or left depending on which table you looking for the null values since it can be easily switched. 