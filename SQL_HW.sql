use sakila;
--- Question 1a
select first_name, last_name from actor;

--- Question 1b
SELECT Concat(first_name ,last_name) AS 
`Actor Name` FROM actor;

--- Question 2a

select actor_id, first_name, last_name
from actor
where  first_name like 'JOE%';

--- Question 2b
select actor_id, first_name, last_name
from actor
where  last_name like '%GEN%';

--- Question 2c
select actor_id, first_name, last_name
from actor
where  last_name like '%LI%'
order by last_name, first_name DESC;

--- Question 2d
select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

--- Question 3

alter table actor
add middle_name varchar(125)
after first_name;

alter table actor
modify column middle_name blob;

alter table actor
drop column middle_name;

--- Question 4a
select last_name, COUNT(*) 
from actor
group by last_name
order by last_name ASC;

--- Question 4b
select last_name, COUNT(*) 
from actor
group by last_name
having count(*) > 2;

--- Question 4c

update actor 
set first_name= 'HARPO'
where first_name='GROUCHO' AND last_name='WILLIAMS';

--- Question 4d

update actor 
set first_name= 'GROUCHO'
where first_name='HARPO' AND last_name='WILLIAMS';

--- Question 5a

describe sakila.address;

--- Question 6a
select * from staff;
select * from address;

select staff.first_name, staff.last_name, address.address
from staff
staff left join address on staff.address_id = address.address_id;

--- Question 6b
select * from payment;

select staff.first_name, staff.last_name, SUM(payment.amount) as 'August Total $' 
from staff left join payment on staff.staff_id = payment.staff_id
where payment_date like '2005-08%'
group by staff.first_name, staff.last_name;

--- Question 6c
select * from film;
select * from film_actor;

select film.title, count(film_actor.actor_id) as '# of Actors'
from film  inner join film_actor on film.film_id = film_actor.film_id
group by film.title;

--- Question 6d
select * from inventory;

select film.title, count(inventory.film_id) as '# of Copies'
from film  inner join inventory on film.film_id = inventory.film_id
where title like 'Hunchback Impossible';

--- Question 6e
select * from customer;
select * from payment;

select customer.first_name, customer.last_name, sum(payment.amount) AS 'Total Payment'
from customer  inner join payment on customer.customer_id = payment.customer_id
GROUP BY customer.first_name, customer.last_name
ORDER BY customer.last_name ASC;

--- Question 7a

select title
from film
where (title like 'K%' or title like 'Q%') 
and language_id=(select language_id from language where name='English');

--- Question 7b

select first_name, last_name
from actor
where actor_id
	in(select actor_id from film_actor where film_id 
		in(select film_id from film where title='ALONE TRIP'));
        
--- Question 7c

select first_name, last_name, email 
from customer
join address on(customer.address_id = address.address_id)
join city on(address.city_id=city.city_id)
join country on(city.country_id=country.country_id)
where country like 'Canada';

--- Question 7d
select * from film_category;
select * from category;

select title from film 
join film_category on (film.film_id=film_category.film_id)
join category on (film_category.category_id=category.category_id)
where name like 'Family';

--- Question 7e
select * from rental;
select * from film;

select title, count(film.film_id) as 'Rented Movies'
from film
join inventory on(film.film_id = inventory.film_id)
join rental on(inventory.inventory_id = rental.inventory_id)
group by title
order by 'Rented Movies' ASC;

--- Question 7h
select * from category;
select * from film_category;
select * from inventory;
select * from payment;
select * from rental;

select category.name AS 'Top $ Five', sum(payment.amount) as 'Gross' 
from category 
join film_category on(category.category_id = film_category.category_id)
join inventory on(film_category.film_id = inventory.film_id)
join rental on(inventory.inventory_id = rental.inventory_id)
join payment on(rental.rental_id = payment.rental_id)
group by category.name 
order by Gross DESC 
LIMIT 5;

--- Question 8a

create view  Gross_Five  as
select 'Top $ Five', 'Gross'
from category;

--- Question 8b

select * from Gross_Five;

--- Question 8c

Drop view Gross_Five;