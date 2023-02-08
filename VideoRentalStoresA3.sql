/********************************************************************************/
/*		COMP53 Section 101														*/																
/*		Assignment 3 - Create a database for video rental stores 				*/
/*		Date:  6/04/2022														*/							
/*		Name:  Phuong Uyen Dang													*/
/********************************************************************************/
USE sakila;

-- 1.	 Display the number of films (2)
SELECT COUNT(*) AS 'NumberFilms'
FROM film;

-- 2.	Display the number of customers who are not active (3)
SELECT COUNT(active) AS 'Number of Non-Active Customers'
FROM customer
WHERE active = 0;


-- 3.	Display the number of customers per store (4)
SELECT store_id, COUNT(customer_id) AS 'Numbers of Customers Per Store'
FROM customer
GROUP BY store_id; 

-- 4.	Using payment table, produce this output: (7)
SELECT COUNT(payment_id) AS 'numberPayments',
	   MIN(amount) AS 'lowest_payment',
       MAX(amount) AS 'highest_payment',
       AVG(amount) AS 'avg_payment',
       SUM(amount) AS 'total_of_all_payment'
FROM payment;

-- 5.	Display all film titles and descriptions only for descriptions that have both the words ‘dog’ and ‘squirrel’ in it. 
--      Sort alphabetically by title. 6 rows returned. (6)
SELECT title, description
FROM film
WHERE description LIKE '%dog%' AND description LIKE '%squirrel%'
ORDER BY title;

-- 6.	 a) display the average film length (2)
SELECT ROUND(AVG(length),1) AS 'avgFilmLength'
FROM film;

        -- b)  Display films with a length longer than the average length. Sort by length, highest to lowest. (6)
SELECT film_id, title, length
FROM film
HAVING length > 
		(SELECT ROUND(AVG(length),0)
         FROM film)
ORDER BY length DESC;

-- 7.	Display the total rental amounts by customer for payment dates in July 2005 only. 
		-- Then display only results that total more than $50. Sort by customer ID. Use payment table - 179 rows returned (10)
SELECT customer_id, SUM(amount) AS total_rental_amount_for_July
FROM payment
WHERE DATE(payment_date) BETWEEN '2005-07-01' AND '2005-07-31'
GROUP BY customer_id
HAVING total_rental_amount_for_July > 50
ORDER BY customer_id;


-- 8.	Display rental ID, last name, first name for customers that are not active.  Use rental and customer tables -not all rows are showing here. (6)
SELECT rental_id, last_name, first_name
FROM  customer c
	JOIN rental r
    ON c.customer_id = r.customer_id
WHERE r.customer_id IS NULL;

-- 9.	Code an INSERT statement to add a category of ‘Zombie Programmers’ to category table. Use a column list using the name column only. (4)

INSERT INTO category(name) VALUES
('Zombie Programmers');

-- 10.	Code a DELETE statement to delete the row you added in question 10. (3)
DELETE FROM category
 WHERE name = 'Zombie Programmers';

-- 11.	Code an UPDATE statement to modify the customers table.  Change email address to the word ‘reset’ for non-active customers only. (4)
CREATE TABLE customer_backup AS
SELECT *
FROM customer; 

UPDATE customer_backup
SET email = 'reset'
WHERE active = 0;
 

-- 12.	Write the statement to create an index for the email column in the customers table using a standard index name. (4)
CREATE INDEX customer_email_ix 
ON customer (email);

-- 13.	Display the indexes for the customers table. (2)
SHOW index FROM customer;