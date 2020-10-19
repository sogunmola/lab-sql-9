USE sakila;

SELECT customer_id, sum(amount) as Ttl_Amount FROM payment
GROUP BY customer_id;

SELECT (film_category.category_id) FROM customer
INNER JOIN rental ON rental.customer_id = customer.customer_id
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
INNER JOIN film_category ON film_category.film_id = inventory.film_id
GROUP BY film_category.category_id
ORDER BY customer.customer_id asc;

/*SELECT customer.customer_id, count(film_category.category_id) AS Cat_Count FROM customer
INNER JOIN rental ON rental.customer_id = customer.customer_id
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
INNER JOIN film_category ON film_category.film_id = inventory.film_id
GROUP BY film_category.category_id
ORDER BY customer.customer_id asc;
*/


-- USE RENTAL AS COUNT FOR CATEGORY ANALYSIS
SELECT customer.customer_id, category.name, count(rental.rental_id) AS Top_Rental FROM rental
INNER JOIN customer ON customer.customer_id = rental.customer_id
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
INNER JOIN film_category ON film_category.film_id = inventory.film_id
INNER JOIN category ON category.category_id = film_category.film_id
GROUP BY customer.customer_id
HAVING customer_id = 25
ORDER BY Top_Rental desc;


SELECT rental.customer_id, category.name, COUNT(rental.rental_id) AS rental_amount FROM rental
INNER JOIN customer ON customer.customer_id = rental.customer_id
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
INNER JOIN film_category ON film_category.film_id = inventory.film_id
INNER JOIN category ON category.category_id = film_category.category_id
GROUP BY rental.customer_id
ORDER BY 2 ASC, 3 DESC;

SELECT rental.customer_id, category.name, COUNT(rental.rental_id) AS rental_amount FROM rental
INNER JOIN customer ON customer.customer_id = rental.customer_id
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
INNER JOIN film_category ON film_category.film_id = inventory.film_id
INNER JOIN category ON category.category_id = film_category.category_id
GROUP BY rental.customer_id
HAVING rental.customer_id = 526;

SELECT * FROM rental
WHERE rental.customer_id = 148;

-- Category frequency query
SELECT rental.customer_id, category.name ,COUNT(*) AS Freq 
FROM rental
INNER JOIN customer ON customer.customer_id = rental.customer_id
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
INNER JOIN film_category ON film_category.film_id = inventory.film_id
INNER JOIN category ON category.category_id = film_category.category_id
GROUP BY rental.customer_id, category.name
ORDER BY COUNT(category.name) desc;

-- Rental dates query (last month)
SELECT rental.customer_id, rental_date, COUNT(*) AS last_month_rentals FROM rental
GROUP BY rental.customer_id
HAVING rental_date BETWEEN 20050515 AND 20050530;

-- Current Month rentals query
SELECT rental.customer_id, rental_date,
CASE 
	WHEN rental_date BETWEEN 20050615 AND 20050630 THEN 1
    ELSE 0
END AS current_month_active
FROM rental
GROUP BY rental.customer_id;

SELECT rental.customer_id, rental_date,
CASE
	WHEN rental_date BETWEEN 20050515 AND 20050530 THEN COUNT(*)
    ELSE 0
END AS last_month_rentals
FROM rental
GROUP BY rental.customer_id;