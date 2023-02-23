-- Question 1
DELIMITER //
CREATE PROCEDURE first_name_email_last (OUT param1 FLOAT)
BEGIN
SELECT 
    first_name
    , last_name
    , email
FROM
    customer
        JOIN
    rental ON customer.customer_id = rental.customer_id
        JOIN
    inventory ON rental.inventory_id = inventory.inventory_id
        JOIN
    film ON film.film_id = inventory.film_id
        JOIN
    film_category ON film_category.film_id = film.film_id
        JOIN
    category ON category.category_id = film_category.category_id
WHERE
    category.name = 'Action'
GROUP BY first_name , last_name , email;
END;
//
DELIMITER ;
CALL first_name_email_last(@x);

-- Question 2
DELIMITER //
CREATE PROCEDURE name_procedure (IN param1 CHAR(15), OUT param2 FLOAT)
BEGIN
SELECT 
    first_name
    , last_name
    , email
FROM
    customer
        JOIN
    rental ON customer.customer_id = rental.customer_id
        JOIN
    inventory ON rental.inventory_id = inventory.inventory_id
        JOIN
    film ON film.film_id = inventory.film_id
        JOIN
    film_category ON film_category.film_id = film.film_id
        JOIN
    category ON category.category_id = film_category.category_id
WHERE
    category.name COLLATE utf8mb4_general_ci = param1
GROUP BY first_name , last_name , email;
END;
//
DELIMITER ;
CALL name_procedure("Action",@y);

-- Question 3
DELIMITER //
CREATE PROCEDURE movies_rent( IN param3 INTEGER)
BEGIN 
SELECT 
    c.name AS category_name
    , COUNT(t.title) AS number_of_movies
FROM
    film t
        JOIN
    film_category f ON t.film_id = f.film_id
        JOIN
    category c ON f.category_id = c.category_id
GROUP BY c.name
HAVING number_of_movies > param3
ORDER BY number_of_movies;
END;
//
DELIMITER ;
CALL movies_rent(50);