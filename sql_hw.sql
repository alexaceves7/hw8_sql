use sakila;

-- 1a
SELECT first_name, last_name
FROM actor;

-- 1b
SELECT Concat(first_name, ' ' ,last_name) as actor_name
FROM actor;

-- 2a
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

-- 2b
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%gen%';

-- 2c
SELECT last_name, first_name
FROM actor
WHERE last_name LIKE '%li%'
ORDER BY last_name;

-- 2d

SELECT country_id, country
FROM country
WHERE country in
	(SELECT country
    FROM country
    WHERE country = 'Afghanistan' or country = 'Bangladesh' or country ='China');

-- 3a
ALTER TABLE actor
ADD COLUMN description BLOB;
SELECT*FROM actor;

-- 3b
ALTER TABLE actor
DROP COLUMN description;
SELECT*FROM actor;

-- 4a
SELECT last_name, Count(*)
FROM actor
GROUP BY last_name;

-- 4b
SELECT last_name, Count(*)
FROM actor
GROUP BY last_name
HAVING Count(*)>=2;

-- 4c
UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO";

-- 4d
UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO";

-- 5a
SHOW COLUMNS FROM address;

-- 6a
SELECT s.first_name, s.last_name, a.address
FROM staff AS s
JOIN address as a
ON s.address_id = a.address_id;

-- 6b
SELECT s.first_name, s.last_name, sum(p.amount) as total_amount
FROM staff AS s
JOIN payment as p
ON s.staff_id = p.staff_id
GROUP BY s.staff_id;

-- 6c
SELECT f.title, COUNT(DISTINCT fa.actor_id) AS number_of_actors
FROM film AS f
INNER JOIN film_actor AS fa
ON f.film_id = fa.film_id
GROUP BY f.film_id;

-- 6d
SELECT 
    COUNT(i.film_id) AS copies_exist
FROM
    inventory AS i
WHERE
    film_id IN (SELECT 
            f.film_id
        FROM
            film AS f
        WHERE
            f.title = 'Hunchback Impossible');
            
-- 6e
SELECT c.last_name, c.first_name, SUM(p.amount) AS total_spent
FROM customer AS c
JOIN payment AS p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name;

-- 7a
SELECT 
    title, language_id
FROM
    film
WHERE
    (title LIKE 'K%' OR title LIKE 'Q%')
        AND language_id IN (SELECT 
            language_id
        FROM
            language
        WHERE
            name = 'English');
            
-- 7b
SELECT 
    first_name, last_name
FROM
    actor
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            film_actor
        WHERE
            film_id IN (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'Alone Trip'));

-- 7c

SELECT 
    c.last_name,
    c.first_name,
    c.email,
    a.city_id,
    ci.country_id,
    co.country
FROM
    customer AS c
        JOIN
    address AS a ON c.address_id = a.address_id
        JOIN
    city AS ci ON a.city_id = ci.city_id
        JOIN
    country AS co ON ci.country_id = co.country_id
WHERE
    co.country = 'Canada'
ORDER BY c.last_name;

-- 7d
SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film_category
        WHERE
            category_id IN (SELECT 
                    category_id
                FROM
                    category
                WHERE
                    name = 'Family'));
                    
-- 7e
SELECT 
    f.title,
    f.film_id,
    COUNT(DISTINCT r.inventory_id) AS total_rentals
FROM
    film AS f
        JOIN
    inventory AS i ON f.film_id = i.film_id
        JOIN
    rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY total_rentals DESC;

-- 7f
SELECT 
    s.store_id, SUM(p.amount) AS total_business
FROM
    store AS s
        JOIN
    staff AS st ON s.store_id = st.store_id
        JOIN
    payment AS p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

-- 7g
SELECT 
    s.store_id, c.city, co.country
FROM
    store AS s
        JOIN
    address AS a ON s.address_id = a.address_id
        JOIN
    city AS c ON a.city_id = c.city_id
        JOIN
    country AS co ON c.country_id = co.country_id;

-- 7h
SELECT 
    c.name, SUM(p.amount) AS gross_revenue
FROM
    category AS c
        JOIN
    film_category AS fc ON c.category_id = fc.category_id
        JOIN
    inventory AS i ON fc.film_id = i.film_id
        JOIN
    rental AS r ON i.inventory_id = r.inventory_id
        JOIN
    payment AS p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 8a
CREATE VIEW top_five_genres AS
SELECT 
    c.name, SUM(p.amount) AS gross_revenue
FROM
    category AS c
        JOIN
    film_category AS fc ON c.category_id = fc.category_id
        JOIN
    inventory AS i ON fc.film_id = i.film_id
        JOIN
    rental AS r ON i.inventory_id = r.inventory_id
        JOIN
    payment AS p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 8b
SELECT * FROM top_five_genres;

-- 8c
DROP VIEW top_five_genres;




