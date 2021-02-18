/*Day26_Lab2 SQL Iterations
In this lab, we will continue working on the Sakila database of movie rentals.

Instructions
Write queries to answer the following questions:

1. Write a query to find what is the total business done by each store.*/
USE SAKILA;

SELECT sum(p.amount), s.store_id from payment as p
join staff as s
on p.staff_id = s.staff_id
join store as st
on st.store_id = s.store_id
Group by S.store_id;

#######
#2 Convert the previous query into a stored procedure.

drop procedure if exists store_amount_pro;

delimiter //
create procedure store_amount_pro ()

begin 
SELECT sum(p.amount), s.store_id from payment as p
join staff as s
on p.staff_id = s.staff_id
join store as st
on st.store_id = s.store_id
Group by S.store_id;
end;
//
delimiter ;

call store_amount_pro();

#######
/*3. Convert the previous query into a stored procedure that takes the input for store_id 
and displays the total sales for that store.*/

drop procedure if exists store_amount_pro;

delimiter //
create procedure store_amount_pro (in paramINstore int)

begin 
SELECT sum(p.amount), s.store_id from payment as p
join staff as s
on p.staff_id = s.staff_id
join store as st
on st.store_id = s.store_id
Group by S.store_id
having store_id = paramINstore;
end;
//
delimiter ;

call store_amount_pro(2);

#######
#4. Update the previous query. Declare a variable total_sales_value of float type, that will store the 
#returned result (of the total sales amount for the store). Call the stored procedure and print the results.

DROP PROCEDURE IF EXISTS store_procedure;
delimiter //
CREATE PROCEDURE store_procedure (in param1 int)
BEGIN
  DECLARE total_sales_value float default 0.0; -- Declaring variables
SELECT SUM(p.amount) into total_sales_value
FROM payment p
JOIN staff s
ON p.staff_id = s.staff_id
JOIN store st
ON s.store_id = st.store_id
GROUP BY st.store_id
HAVING st.store_id = param1;
SELECT total_sales_value;
SET total_sales_value = 0.0;
END;
// delimiter ;

CALL store_procedure (2);


 ####### 
/*5. In the previous query, add another variable flag. If the total sales value for the store is over 30.000,
then label it as green_flag, otherwise label is as red_flag. Update the stored procedure that takes an input
as the store_id and returns total sales value for that store and flag value.*/

drop procedure if exists total_business4;

delimiter //
create procedure total_business4 (in param1 int)

begin 
declare total_sales_value float default 0.0;   

SELECT sum(p.amount) into total_sales_value
from payment as  p
join staff as st on p.staff_id = st.staff_id
join store as s on st.store_id = s.store_id
where s.store_id= param1 
group by s.store_id;

select total_sales_value, 
case 
when total_sales_value > 30000 then 'green_flag'
else 'red_flag' END 
as flag;

end;
//
delimiter ;

call total_business4(2);
