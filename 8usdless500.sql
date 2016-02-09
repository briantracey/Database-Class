--select ordnum, totalusd 
--from orders

--select name, city
--from agents
--where name = 'Smith'


--select pid, name, priceusd
--from products
--where quantity > 208000

--select name, city
--from customers
--where city = 'Dallas'

--select name
--from agents 
--where city <> 'New York' and city <> 'Tokyo'


--select * 
--from products
--where (city <> 'Dallas'
--and city <> 'Duluth'and priceusd >= 1);

--select *
--from orders
--where mon = 'jan' or mon = 'mar'

select *
from orders
where mon = 'feb' AND totalusd < 500;

