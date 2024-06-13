SELECT * FROM dummy.authors;

SELECT * FROM dummy.authors;


-- 1) sellect all authors-- 
select * from authors;


-- 2) select all post
select * from posts;

-- 3)  SELECT FIRST NAME OF ALL AUTHORS
	select first_name from authors;
    
--     4) SELECT TITLE OF ALL POST
		SELECT title FROM posts;
-- 5) select author born after 1980
SELECT * FROM authors WHERE birthdate > '1980-01-01';

-- 6) select posts from 2023
SELECT * FROM posts WHERE date > '2023-01-01';

-- 7) count the number authors
SELECT COUNT(*) FROM authors;

-- 8) count the number of posts
select count(*) from posts;

-- 9) find any author by email
SELECT * FROM authors WHERE email LIKE '%jschmidt@example.org%';

-- 10) find post by any specific author
SELECT *
FROM posts
JOIN authors ON id = id
WHERE first_name = 'AuthorFirstName' AND last_name = 'AuthorLastName';


-- 11) join authors and posts
SELECT *, posts.title,posts.id,posts.content 
FROM authors 
LEFT JOIN posts ON authors.id = posts.author_id;

SELECT authors.*, posts.title, posts.content
FROM authors
INNER JOIN posts ON authors.id = posts.author_id;


-- 12) select authors who have written posts
SELECT DISTINCT author_id,posts.id
FROM posts;

-- 13) Count post by each author
select count(*) from authors;

SELECT author_id, first_name, COUNT(*) AS post_count
FROM posts
GROUP BY author_id, author_name;

-- 14) count post by each author
SELECT authors.id, authors.first_name, authors.last_name, COUNT(posts.id) AS post_count
FROM authors
LEFT JOIN posts ON authors.id = posts.author_id
GROUP BY authors.id, authors.first_name, authors.last_name;

-- 14) select most recent post by each author
SELECT authors.id AS author_id, authors.first_name, authors.last_name, posts.title, posts.content, posts.date AS post_date
FROM authors
JOIN (
    SELECT author_id, MAX(date) AS max_date
    FROM posts
    GROUP BY author_id
) AS recent_posts
ON authors.id = recent_posts.author_id
JOIN posts 
ON recent_posts.author_id = posts.author_id
AND recent_posts.max_date = posts.date;


-- 15) find author with no posts
SELECT * FROM authors
LEFT JOIN posts ON authors.id = posts.author_id
WHERE posts.author_id IS NULL;

-- 16) select post containing a specific keyword in the title
SELECT * FROM posts WHERE title LIKE '%nemo.%';

-- 17) Update Authors email address
UPDATE authors 
SET email = 'swap@gmail.com' 
WHERE id=5;

-- 19) find author added in last 30 days 
SELECT * FROM authors WHERE added >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY);

-- 20) select post orderd by date
SELECT *FROM posts ORDER BY date;

-- 21)select the average number of posts per months
-- SELECT AVG(posts) AS avg_posts_per_month
-- FROM (
--     SELECT COUNT(*) AS posts, 
--            DATE_FORMAT(date, '%Y-%m') AS year_month
--     FROM posts
--     GROUP BY DATE_FORMAT(date, '%Y-%m')
-- ) AS monthly_posts;

-- 	22) find the author with most post
SELECT author_id, COUNT(*) AS num_posts FROM posts
GROUP BY author_id ORDER BY num_posts DESC
LIMIT 1;

-- 23) find post by authors with more than 5 posts
SELECT * FROM posts
JOIN (
    SELECT author_id
    FROM posts
    GROUP BY author_id
    HAVING COUNT(*) > 5
) AS authors_with_more_than_5_posts
ON posts.author_id = authors_with_more_than_5_posts.author_id;

-- 24)find authors who have wriiten post in the last 7 days
SELECT DISTINCT *
FROM authors
JOIN posts ON authors.id = posts.author_id
WHERE posts.date >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY);


-- 25) Select authors with email from a specific domain
SELECT * FROM authors WHERE email LIKE '%.com%';


-- 26) create veiw of authors and their post count
 SELECT authors.id,authors.first_name,
       COUNT(posts.id) AS post_count
FROM authors
LEFT JOIN posts ON authors.id = posts.author_id
GROUP BY authors.id, authors.first_name;

-- 27) select post with content longer than 1000 charectors
SELECT *FROM posts WHERE LENGTH(content) > 190;


-- -- 28) Find the Oldest  by each author
-- SELECT author_id, MIN(date) AS oldest
-- FROM posts
-- GROUP BY author_id;


-- SELECT * 
-- FROM authors
-- JOIN (
--     SELECT author_id, 
--            MIN(date) AS oldest_post_date
--     FROM posts
--     GROUP BY author_id
-- ) AS oldest_posts
-- ON authors.id = oldest_posts.author_id
-- JOIN posts
-- ON oldest_posts.author_id = posts.author_id
-- AND oldest_posts.oldest_post_date = posts.date;

-- 29) Update all post to have a default description
   UPDATE posts
SET description = 'Default  description'where description='';

-- 30) Delete author with no post
-- DELETE authors
-- FROM authors
-- LEFT JOIN posts ON authors.id = posts.author_id
-- WHERE posts.id IS NULL;

-- 31) select authors and their posts orderd by authors last name
SELECT authors.last_name,posts.title,posts.content
FROM authors
LEFT JOIN posts ON authors.id = posts.author_id ORDER BY authors.last_name;

-- 32) find post published on weekend
SELECT * FROM posts WHERE dayofweek(DATE)IN(1,7);

-- 33) CALCULATE AGE OF EACH AUTHORS
SELECT * ,TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) AS age
FROM authors;

-- 34) FIND POST WRITTEN BY AUTHORS BORN BEFORE 1970
SELECT *FROM posts
JOIN authors ON posts.author_id = authors.id
WHERE YEAR(authors.birthdate) < 1980;

-- 35) SELECT POSTS WITH TITLE LONGER THAN 50 CHARECTERES
SELECT * FROM posts WHERE char_length(title) > 50;

-- 38) find the longest post content
	SELECT MAX(LENGTH(content)) AS longest FROM posts;
    
-- 39) SELECT AUTHORS WHO HAVE NOT WRITTEN POSTS IN THE LAST YEAR
SELECT *FROM authors WHERE id NOT IN (
    SELECT author_id
    FROM posts
    WHERE date >= DATE_SUB(NOW(), INTERVAL 2023  YEAR)
);
-- 40) FIND THE AUTHORS AND NUMBER OF POSTS THEY WROTE LAST MONTHS
SELECT authors.*, COUNT(posts.id) AS NoOfposts
FROM authors
LEFT JOIN posts ON authors.id = posts.author_id
WHERE posts.date >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
GROUP BY authors.id, authors.first_name;

-- 41) FIND THE POST WRITTEN BY AUTHORS WITH 'SMITH 'ON THEIR NAME
SELECT *FROM posts
JOIN authors ON posts.author_id = authors.id
WHERE authors.first_name Like '%Torey';

-- 42)FIND THE AUTHORS WHO HAVE WRITTEN MORE THAN 10 POSTS
SELECT authors.*, COUNT(posts.id) AS num_posts
FROM authors
JOIN posts ON authors.id = posts.author_id
GROUP BY authors.id
HAVING num_posts > 10;

-- 43) SELECT THE TOP 5 MOST RECENTS POSTS 
SELECT *FROM posts ORDER BY date DESC
LIMIT 5;

-- 44) UPDATE DESCRIPTION OF POSTS WRITTEN BEFORE 2020
UPDATE posts
SET description = 'New Description'
WHERE date < '2020-01-01';

-- 45)CREATE FUNCTION TO CALCULATE THE TOTAL NUMBER OF POSTS

-- 46) FIND AUTHOS WHO JOINED AFTER WRITTING THEIR FIRST POST

SELECT authors.*,MIN(posts.date) AS first_post_date
FROM authors
JOIN posts ON authors.id = posts.author_id
GROUP BY authors.id
HAVING authors.added > MIN(posts.date);



-- 47)CREATE VIEW SHOWING AUTHORS AND THEIR LASTEST POST 
CREATE VIEW latest_posts_by_authors AS
SELECT authors.id AS author_id,authors.first_name,posts.id AS post_id,posts.title,posts.content,posts.date
FROM 
    authors
JOIN 
    posts ON authors.id = posts.author_id
WHERE posts.date = ( SELECT MAX(date) FROM posts 
        WHERE posts.author_id = authors.id);
  
--   48) SELCET AUTHORS WHO HAVE THE SAME FIRST AND LAST NAME
SELECT *
FROM authors
WHERE first_name=last_name;


-- 49) FIND THE TOTAL NUMBER POSTS WRITTEN ON EACH DAY
SELECT DATE(date) AS post_day, COUNT(*) AS NO_posts
FROM posts
GROUP BY post_day
ORDER BY post_day;

-- 50)UPDATE AUTHORS BIRTHDATE
-- 51) FIND POST WRITTEN BY AUTHOR WHO HAVE 'JOHN 'IN THE FIST NAME
SELECT *FROM posts
JOIN authors ON posts.author_id = authors.id
WHERE authors.first_name Like '%Chanel';
  

-- 52) UPDATE EMAIL DOMAIN OF ALL AUTHORS
UPDATE authors
SET email = CONCAT(
    SUBSTRING_INDEX(email, '@', 1), '@newdomain.com'
);


-- 53) find shortest post content
SELECT * FROM posts ORDER BY LENGTH(content) ASC LIMIT 1;

-- 54) create index on the posts title
CREATE INDEX title_index ON posts(title);

-- 55) select authors who have not been updated recently
SELECT *
FROM authors
WHERE added < DATE_SUB(NOW(), INTERVAL 1 MONTH);

-- 56) find the post written in last 30 days
SELECT *
FROM posts
WHERE date >= DATE_SUB(NOW(), INTERVAL 30 DAY);

select * from authors;
select * from posts;



-- 57) create a view showing posts and their authors email
CREATE VIEW AuthorsWithEmails AS
SELECT a.*, p.title AS post_title
FROM authors a
LEFT JOIN posts p ON a.id = p.author_id;

-- 58) find the posts that were updated after being created **
SELECT p.*
FROM posts p
JOIN post_updates pu ON p.post_id = pu.post_id
WHERE pu.update_timestamp > p.created_at;

-- 59) select authors and their posts including those with no post
SELECT a.*, p.*
FROM authors a
LEFT JOIN posts p ON a.id = p.author_id;

-- 60) update all authors to have default birthdate if null
UPDATE authors
SET birthdate = 'DEFAULT_DATE'
WHERE birthdate IS NULL;

-- 61)select authors with the most post in the current year
SELECT a.*, COUNT(p.id) AS num_posts
FROM authors a
LEFT JOIN posts p ON a.id = p.author_id
WHERE YEAR(p.date) = YEAR(CURDATE())
GROUP BY a.id
ORDER BY num_posts DESC
LIMIT 1;

-- 62) find post by authors with 'jschmidt@example.org'email
SELECT p.*
FROM posts p
JOIN authors a ON p.author_id = a.id
WHERE a.email = 'jschmidt@example.org';

-- 64) find posts written on same day by different authors 
SELECT DISTINCT p1.*
FROM posts p1
JOIN posts p2 ON p1.date = p2.date AND p1.author_id <> p2.author_id;

-- 65) update titles of posts to be uppercase
UPDATE posts
SET title = UPPER(title);

-- 66)create fuction to return number of authors
-- 67) find the longest time span between posts by the same authors
SELECT MAX(TIMESTAMPDIFF(SECOND, p1.date, p2.date)) AS longest_time_span
FROM posts p1
JOIN posts p2 ON p1.author_id = p2.author_id
WHERE p1.id <> p2.id;

-- 68)select authors and their post filter by post content
SELECT a.*, p.*
FROM authors a
JOIN posts p ON a.id = p.author_id
WHERE p.content LIKE '%filter_criteria%';

-- 69)create trigger to log author delcetion 
-- 70) find the post written by authors who have never written before
SELECT p.*
FROM posts p
WHERE p.author_id IN (
    SELECT a.id
    FROM authors a
    LEFT JOIN posts p ON a.id = p.author_id
    WHERE p.id IS NULL
);

-- 71)find the posts with exactly 100 charectors on the title
SELECT *
FROM posts
WHERE LENGTH(title) = 100;

-- 72) update the content of all post to inclide timestamp
UPDATE posts
SET content = CONCAT(content, ' ', NOW());

-- 73)create view showing authors and their post dates
CREATE VIEW AuthorsPostDates AS
SELECT a.id, a.first_name AS author_name, p.date
FROM authors a
JOIN posts p ON a.id = p.author_id;

-- 74) find authors who have change their email more than once
SELECT *, COUNT(email) AS email_changes
FROM authors
GROUP BY id
HAVING COUNT(email) > 1;

-- 75) create function to calculate the average post length 
-- 76) select top 3 authors by number of posts
SELECT a.id, COUNT(p.id) AS num_posts
FROM authors a
LEFT JOIN posts p ON a.id = p.author_id
GROUP BY a.id
ORDER BY num_posts DESC
LIMIT 3;

-- 77) find posts written by authors with same birthdate
SELECT p.*
FROM posts p
JOIN authors a1 ON p.author_id = a1.id
JOIN authors a2 ON a1.birthdate = a2.birthdate AND a1.id <> a2.id;

-- 78) Update the last names of all  authors to lowercase
UPDATE authors
SET last_name = LOWER(last_name);

-- 79) create a stored procedure to updated an authors details
-- 80)find the posts with the most comments 
-- 81) select authors with email that start with 'a' 
SELECT *
FROM authors
WHERE email LIKE 'a%';
-- 82) update all posts to have default content if null
UPDATE posts
SET content = 'DEFAULT_CONTENT'
WHERE content IS NULL;

-- 83) find posts written by authors with birthdate in january
SELECT p.*
FROM posts p
JOIN authors a ON p.author_id = a.id
WHERE MONTH(a.birthdate) = 1;

-- 84) create a function to retirn number of posts by any authors
-- 85) find the latest post by each authors in the current year
SELECT author_id, MAX(date) AS latest_post_date
FROM posts
WHERE YEAR(date) = YEAR(CURDATE())
GROUP BY author_id;

-- 86) select authors and total length of their posts
    SELECT a.id, a.first_name AS author_name, SUM(CHAR_LENGTH(p.content)) AS total_length_of_posts
FROM authors a
JOIN posts p ON a.id = p.author_id
GROUP BY a.id, a.first_name;

-- 87)create trigger to log post updates
-- 88) find posts with titles that include numbers
SELECT *
FROM posts
WHERE title LIKE '%[0-9]%';
-- 89) update the first names of all authors to be title case
UPDATE authors
SET first_name = CONCAT(UCASE(SUBSTRING(first_name, 1, 1)), LCASE(SUBSTRING(first_name, 2)));

-- 90) create a strored procedure to add new post
-- CREATE PROCEDURE AddNewPost(
--     IN author_id INT,
--     IN title VARCHAR(255),
--     IN content TEXT,
--     IN post_date DATETIME
-- )
-- BEGIN
--     INSERT INTO posts (author_id, title, content, post_date)
--     VALUES (1, "swap", "hello swap", "2024-01-01");
--     END ;
    
--     91) find posts written by authors who joined last year
    SELECT p.*
    FROM posts p
    JOIN authors a ON p.author_id = a.id
    WHERE YEAR(date) = YEAR(CURDATE()) - 1;
    
--     92) select authors who have never updated their profile
--     93) find longest title among all posts
        SELECT MAX(LENGTH(title)) AS longest_title
        FROM posts;
            
    --       --   94) update the birthdate of authors to include the time zone
--                     ALTER TABLE authors
--                     MODIFY COLUMN birthdate TIMESTAMP  TIME ZONE;

-- 95) create a view showing number of posts per months
CREATE VIEW PostsPerMonth AS
SELECT DATE_FORMAT(date, '%Y-%m') AS month_year,
       COUNT(*) AS num_posts
FROM posts
GROUP BY DATE_FORMAT(date, '%Y-%m');

-- 96) find the posts with duplicate titles
SELECT title, COUNT(*) AS num_duplicates
FROM posts
GROUP BY title
HAVING COUNT(*) > 1;

-- 97) select authors and their posts ,excluding drafts
SELECT a.*, p.*
FROM authors a
JOIN posts p ON a.id = p.author_id
WHERE p.content <> 'draft';
-- 98) create function to return the oldest post by any author

-- 99) find post written in the first week of each month
SELECT *
FROM posts
WHERE WEEK(date) = 1 AND YEAR(date) = YEAR(date);

-- 100) update all posts to include an authors full name in the description
UPDATE posts p
JOIN authors a ON p.author_id = a.id
SET p.description = CONCAT(p.description, ' - ', a.first_name, ' ', a.last_name);











-- 1) find posts with  a specific keyword in the title
SELECT * FROM posts WHERE title LIKE '%Quasi%'; 

-- 2) Count the number of authors
SELECT COUNT(*) FROM authors;

-- 3) Counts the number of posts
SELECT COUNT(*) FROM posts;

--  4) Find the earliest post date
SELECT MIN(date) FROM posts;

-- 5) Find the most recent post date
SELECT MAX(date) FROM posts;

-- 6) Select posts with content length greater than 500 
SELECT * FROM posts WHERE length(content)>500;

-- 7) SELECT authors added in the last 30 days
SELECT * FROM authors WHERE added >= DATE_SUB(CURDATE(),INTERVAL 30 DAY);

-- 8)Find the avarage content length of posts
SELECT AVG(LENGTH(content)) FROM posts;

-- 9)Find the longest post title
SELECT * FROM posts ORDER BY LENGTH(title) DESC LIMIT 1;

-- 10) SELECT the title and description of all posts
SELECT title,description FROM posts;

-- 11)SELECT the number of posts by each author
SELECT author_id, COUNT(*) FROM posts GROUP BY author_id;

-- 12)Select authors who have written more than 5 posts
SELECT author_id FROM posts GROUP BY author_id HAVING COUNT(*)> 5;

-- 13)Find the most common author first name
SELECT first_name, COUNT(*) FROM authors GROUP BY first_name ORDER BY COUNT(*) DESC LIMIT 1;

-- 14)find posts with a specific keyword in the content
SELECT * FROM posts WHERE content LIKE '%Vel%';

-- 15) SELECT authors born before 1970
SELECT * FROM authors WHERE birthdat < '1970-01-01';

-- 16)Selcet the last 5 posts by date 
SELECT * FROM posts ORDER BY date DESC LIMIT 5;

-- 17) Find the most recent author added
SELECT * FROM authors ORDER BY added DESC LIMIT 1;

-- 18)Select posts written in 2023
SELECT * FROM posts WHERE YEAR(date)=2023;

-- 19) Select authors with email ending in 'example.com'
SELECT * FROM authors WHERE email LIKE '%glen57@example.com';

-- 20)Count post by month
SELECT MONTH(date), COUNT(*) FROM posts GROUP BY MONTH(date);

-- 21)Select authors with no posts
SELECT * FROM authors WHERE id NOT IN (SELECT DISTINCT author_id FROM posts);

-- 22)Select posts longer than 1000 characters
SELECT * FROM posts WHERE LENGTH(content) >1000;

-- 23)Select posts with unique titles
SELECT DISTINCT title FROM posts;

-- 24)Select authors and their total number of posts
SELECT authors.id, authors.first_name, authors.last_name, COUNT(posts.id) as 
total_posts FROM authors LEFT JOIN posts ON authors.id =posts.author_id GROUP BY
authors.id;

-- 25) Find posts written by authors with the last name 'Smith'
SELECT posts.* FROM posts JOIN authors ON posts.author_id=authors.id
WHERE authors.last_name='Smith';

-- 26)Select authors born in specific year
SELECT * FROM authors WHERE YEAR(birthdate)=1990;

-- 27) Select posts grouped by author and order by post count 
SELECT author_id, COUNT(*) as post_count FROM posts GROUP BY author_id
ORDER BY post_count DESC;

-- 28)Select authors and the length of their shortest post
SELECT authors.id,authors.first_name,authors.last_name,
MIN(LENGTH(posts.content)) as shortest_post_length FROM authors JOIN posts ON 
authors.id=posts.author_id GROUP BY authors.id;

-- 29) find the total length of posts  by each author
SELECT author_id,
sum(length(content))
from posts GROUP BY author_id;

-- 30)select authors and their average post length
select authors.*,
avg(length(posts.content))as avgPostLength
from authors
JOIN posts on authors.id=posts.author_id
Group by authors.id;

-- 31) select author with more than one post titlt containnig the same word
select authors.* from authors
join posts on authors.id=posts.author_id
group by authors.id Having count(DISTINCT posts.title)>1;

-- 32)find posts by authors with a first name Starting with 'A'
select posts.* from posts
join authors on posts.author_id=authors.id
where authors.first_name Like 'A%';

-- 33)find posts by authors with a first name ending with 'A'
select posts.* from posts
join authors on posts.author_id=authors.id
where authors.first_name Like '%A';

-- 34)find authors with no posts in the last year
select * from authors where id NOT IN (SELECT DISTINCT id
from posts where date>=date_sub(CURDATE(),interval 1 year));

-- 35)select posts and their authors orderd by post date
select posts.*,authors.first_name,authors.last_name
from posts
join authors
on posts.author_id=authors.id
order by posts.date DESC;

-- 36)find authors with more than one email address
select email,count(*)from authors GROUP BY email having count(*)>1;

-- 37) update the title of specific post
update posts set title ='Update title' where id =1;

-- 39)Delete specific post
delete from posts WHERE id =10;

-- 40) find authors who joined in specific month and year
select * from authors
where month(added)=6 and year(added)=2024;

-- 41) select total number of posts written by all authors
select count(*) from posts;

-- 42) select authors with most recent post
select authors.first_name,authors.last_name,posts.title,posts.date
from authors 
JOIN posts on authors.id=posts.author_id
order by posts.date
desc limit 1;

-- 43) find average age of authors
select avg(year(curdate())-year(birthdate))
as avgDate
from authors;

-- 44)select authors who have updated their profile
select * from authors
where  added=current_timestamp();

-- 45) find the shortest post by content length
select * from posts ORDER BY length(content) asc limit 1;

-- 46) find the total length of all posts  by each authors
select authors.*,
sum(length(posts.content))
as TotalLength
from authors 
JOIN posts on authors.id=posts.author_id
group by authors.id;

-- 47)select authors with the same first and last name
select * from authors WHERE first_name=last_name;

-- 48)find the second most recent post
select * from posts order by date DESC limit 1 offset 1;

-- 49) find authors born in same months
select * from authors 
WHERE month(birthdate)=month(curdate());

-- 50) find authors with email domains not ending 'com'
select * from authors 
WHERE email not like "%@%.com";

-- 51)select posts with titles longer than their content
select * from posts WHERE length(title)> length(content);

-- 52) find authors who have written posts on the same day
select authors.*,posts.date
from authors
JOIN posts on authors.id=posts.author_id
group by authors.id,posts.date
having count(posts.date)>1;

-- 53)select post with no description
select * from posts WHERE description="";

-- 54) find the average length of posts  with title containing 'data'
select avg(length(content))
from posts WHERE title like "%data%";

-- 55)select authors who joined more than 5 year ago
select * from authors WHERE added <date_sub(curdate(),interval 5 year);

-- 56)find post by author who born after 1990
select posts.* from posts
JOIN authors on
posts.author_id=authors.id
where authors.birthdate > 1990-01-01;

-- 57)select authors with a specific email domain
SELECT * FROM authors WHERE email LIKE '%@specificdomain.com';

-- 58)count the number of posts  by authors born in the 1990s
	select count(*)from posts
    where author_id in (SELECT id from authors
    WHERE birthdate between '1990-01-01'and '1999-12-12');
    
--     59) select psots with a sppecific word in th description
	select * from posts where description like "%word%";
    
--     60) find the author with the longest name
	select * from authors order by length(first_name)+length(last_name)desc limit 1;
    
    
--     61)select post by authos who have written exactly 3 post
select * from posts 
WHERE author_id in (SELECT author_id from posts
group by author_id having count(*)=3);
 
--  62) SELECT POSTS AND THEIR AUTHORS FOR POSTS LONGER THAN 10000 CHARACTERS
    SELECT posts.*,
    authors.first_name,authors.last_name
    from posts
    join authors on posts.author_id=authors.id
    where length(posts.content)>1000;
    
    



