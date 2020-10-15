USE sakila;
-- Instructions
-- 1   Rank films by length.
select title, length, rank() over (order by length DESC) from film; 
select title, length, dense_rank() over (order by length DESC) from film; 
-- 2   Rank films by length within the rating category.
select rating, title, length, rank() over (partition by rating order by length ASC)  
from film;
-- order by rating DESC, length; 
-- 3    Rank languages by the number of films (as original language).
select title, original_language_id, rank() over(partition by title)  
from film;

select title, language_id, rank() over(partition by title)  
from film;

-- 4    Rank categories by the number of films.
select rating, count(title) AS 'number_of_movies', rank() over(partition by rating order by count(title)) as ranking_1
from film
group by rating
order by number_of_movies;

select * from film_category;
select * from category;
select * from film;
select cat.name, count(cat.name) AS 'number_of_movies' from film as f
inner join film_category as f_cat on f_cat.film_id = f.film_id
inner join category as cat on cat.category_id = f_cat.category_id
group by cat.name
order by number_of_movies DESC;

-- 5    Which actor has appeared in the most films?
-- maybe we can do this only with film_actor table?
select f_a.actor_id, a.first_name,a.last_name, count(f_a.film_id) AS number_of_movies from film_actor as f_a
inner join actor as a ON f_a.actor_id = a.actor_id
group by actor_id
order by number_of_movies DESC;
-- 6    Most active customer.
-- we need to join rental and customer
select c.customer_id, c. first_name, c.last_name, count(r.inventory_id) AS 'count_of_rentals' from rental as r
INNER join customer as c ON c.customer_id = r.customer_id 
group by c.customer_id
ORDER BY count_of_rentals DESC;
-- 7    Most rented film.
-- Join from inventory and rental
select f.title, count(r.inventory_id) AS 'count_of_rentals' from rental as r
INNER join inventory as i ON i.inventory_id = r.inventory_id 
INNER join film as f ON f.film_id = i.film_id
group by title
ORDER BY count_of_rentals DESC;


