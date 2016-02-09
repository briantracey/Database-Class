--1 List the order number and total $ of all orders
select ordnum, totalusd 
from orders;

--2 List the name and city of agents named Smith
select name, city
from agents
where name = 'Smith';

--3 List the id, name and priceUSD of products with qty > 208000
select pid, name, priceusd
from products
where quantity > 208000;

--4 List the names and cities of customers in Dallas
select name, city
from customers
where city = 'Dallas';

--5 list the names and agents not in NY and not in Tokyo
select name
from agents 
where city <> 'New York' and city <> 'Tokyo';

--6 List all the data for products not in Dallas or Duluth that cost more than us $1
select * 
from products
where (city <> 'Dallas' and city <> 'Duluth' and priceUSD >=1);

--7 List all data for orders in Jan or Mar
select *
from orders
where mon = 'jan' or mon = 'mar';

--8 List all data for orders in Feb less than $500
select *
from orders
where mon = 'feb' AND totalusd < 500;

--List all orders from customer C005
select ordnum
from orders 
where cid = 'C005';



