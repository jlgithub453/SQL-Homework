
Use sakila;
SELECT first_name, last_name FROM actor;
ALTER TABLE actor
ADD COLUMN Actor_Name VARCHAR(100) AFTER last_name;
UPDATE actor SET Actor_Name = concat(first_name, ' ', last_name);
SELECT * FROM actor;

SELECT Actor_Name,UPPER(Actor_Name) 
FROM actor;


SELECT actor_id, first_name, last_name FROM actor 
WHERE first_name="Joe";

SELECT * FROM actor
WHERE last_name LIKE '%GEN%';

SELECT * FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

SELECT * FROM country;

SELECT country_id, country 
FROM country
WHERE country in ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE actor
ADD COLUMN description BLOB AFTER Actor_Name;

ALTER TABLE actor
  DROP COLUMN description;
  
SELECT last_name, COUNT(last_name) AS 'Number of Actors'
FROM actor
GROUP BY last_name;

SELECT last_name, COUNT(last_name) AS 'Number of Actors'
FROM actor
GROUP BY last_name
HAVING COUNT(last_name)>=2;

UPDATE actor SET Actor_Name='HARPO WILLIAMS' WHERE Actor_Name='GROUCHO WILLIAMS';

UPDATE actor SET first_name='GROUCHO' WHERE first_name='HARPO';

SHOW CREATE TABLE address;

SELECT * FROM staff;

SELECT * FROM address;

SELECT s.first_name, s.last_name, a.address
FROM staff s
INNER JOIN address a
ON s.address_id=a.address_id;

SELECT * FROM payment;

SELECT s.first_name, s.last_name, SUM(amount) as 'total amount'
FROM staff s
INNER JOIN payment p ON
s.staff_id=p.staff_id
WHERE p.payment_date like '2005-08%'
GROUP BY p.staff_id;

SELECT * FROM film;
SELECT * FROM film_actor;

SELECT f.title, SUM(actor_id) as 'number of actors'
FROM film as f
INNER JOIN film_actor as fa ON
f.film_id=fa.film_id
GROUP BY fa.film_id;

SELECT * FROM inventory;

SELECT f.title, sum(inventory_id) as 'number of copies'
FROM film f
INNER JOIN inventory i ON
f.film_id=i.film_id
WHERE f.title='Hunchback Impossible';

SELECT * FROM payment;

SELECT c.first_name, c.last_name, SUM(amount) AS 'total amount paid'
FROM customer c
INNER JOIN payment p ON
c.customer_id=p.customer_id
GROUP BY p.customer_id
ORDER BY c.last_name;

SELECT * FROM film;
SELECT * FROM language;

SELECT f.title FROM
film f WHERE (f.language_id in 
(SELECT l.language_id FROM language l WHERE name='English'))
AND (f.title LIKE 'K%' AND f.title LIKE 'Q%');

SELECT * FROM film_actor;
SELECT * FROM actor;

SELECT first_name, last_name FROM
actor WHERE actor_id in 
(SELECT actor_id FROM film_actor WHERE
film_id in
(SELECT film_id FROM film WHERE title='Alone Trip'));

SELECT * FROM customer;
SELECT * FROM address;
SELECT * FROM country;
SELECT * FROM city;

SELECT c.first_name, c.last_name, c.email FROM
customer c INNER JOIN address a
ON c.address_id=a.address_id
INNER JOIN city on
a.city_id=city.city_id INNER JOIN
country on
city.country_id=country.country_id
WHERE country.country='CANADA';

SELECT * FROM film_category;
SELECT * FROM category;

SELECT f.title FROM film f WHERE
f.film_id in (SELECT fc.film_id from film_category fc WHERE fc.category_id in
(SELECT c.category_id FROM category c WHERE c.name='Family'));

SELECT * FROM rental;
SELECT * FROM inventory;

SELECT f.title, SUM(i.film_id) as 'number of rentals'
FROM film f INNER JOIN inventory i ON
f.film_id=i.film_id INNER JOIN rental r ON
i.inventory_id=r.inventory_id
GROUP BY i.film_id
ORDER BY SUM(i.film_id) DESC;

SELECT * FROM store;
SELECT * FROM payment;
SELECT * FROM staff;

SELECT s.store_id, SUM(p.amount) as 'businees brought in'
FROM store s INNER JOIN payment p on
s.manager_staff_id=p.staff_id
GROUP BY s.store_id;

SELECT s.store_id, city.city, country.country FROM
store s INNER JOIN address a on
s.address_id=a.address_id INNER JOIN city ON
a.city_id=city.city_id INNER JOIN country ON
city.country_id=country.country_id;


SELECT ca.name, SUM(p.amount) AS 'Gross Revenue'
FROM category ca INNER JOIN film_category fc on
ca.category_id=fc.category_id INNER JOIN inventory i on
fc.film_id=i.film_id INNER JOIN rental r on
i.inventory_id=r.inventory_id INNER JOIN payment p on
r.rental_id=p.rental_id 
GROUP BY ca.name
ORDER BY SUM(p.amount) DESC LIMIT 5;

CREATE VIEW sakila.gross_revenue AS 
SELECT ca.name, SUM(p.amount) AS 'Gross Revenue'
FROM category ca INNER JOIN film_category fc on
ca.category_id=fc.category_id INNER JOIN inventory i on
fc.film_id=i.film_id INNER JOIN rental r on
i.inventory_id=r.inventory_id INNER JOIN payment p on
r.rental_id=p.rental_id 
GROUP BY ca.name
ORDER BY SUM(p.amount) DESC LIMIT 5;

SHOW CREATE VIEW sakila.gross_revenue;

DROP VIEW IF EXISTS sakila.gross_revenue;