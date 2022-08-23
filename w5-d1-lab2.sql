use sakila;

-- Drop column picture from staff.
alter table staff
drop column picture;



-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from customer where first_name = "Tammy";

insert into staff
values (3, "Tammy", "Sanders", "4", "Tammy.Sanders@sakilastaff.com", 2, 1, "Tammy", "1234", "2022-08-23 22:28:15");



-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the
-- rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need 
-- to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well.
-- To get that you can use the following query:
insert into rental
values	(16050, 
		"2022-08-23 22:28:15",
		(select inventory_id from sakila.inventory where film_id = (select film_id from sakila.film where title = 'Academy Dinosaur') and inventory_id = 6),
        (select customer_id from sakila.customer where first_name = 'CHARLOTTE' and last_name = 'HUNTER'),
        NULL,
        1,
        "2022-08-23 22:28:15");

select * 
from rental 
order by rental_id desc 
limit 1;
		-- Use similar method to get inventory_id, film_id, and staff_id.
        -- NESTED ARGUMENTS:
		-- for the rental_id : select max(rental_id)+1 from rental; -- IT'S NOT WORKING! Apparently you cannot use cyclic arguments that refer to the same table you are inserting values.
		-- rental_date : current date
		-- for the inventory_id : select inventory_id from sakila.inventory where film_id = (select film_id from sakila.film where title = 'Academy Dinosaur') and inventory_id = 4;
		-- for the customer_id : select customer_id from sakila.customer where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
		-- return_date : null
		-- staff_id : 1
		-- last_update : current date



-- Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
	-- Check if there are any non-active users
select *
from customer 
where active = 0;


	-- Create a table backup table as suggested
    -- Insert the non active users in the table backup table
create table customer_backup
as select *
from customer
where active = 0;

	
	-- Delete the non active users from the table customer
delete
from customer
where active = 0;