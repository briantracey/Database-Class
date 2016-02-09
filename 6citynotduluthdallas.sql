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
--where city <> 'New York' or city <> 'Tokyo'


select * 
from products
where (city <> 'Dallas'
and city <> 'Duluth'and priceusd >= 1);

