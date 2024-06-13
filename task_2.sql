create database supertwentydaytwo;
use supertwentydaytwo;
create TABLE authors(id int PRIMARY key AUTO_INCREMENT,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100),
birthdate DATE);

INSERT into authors(first_name,last_name,email,birthdate)VALUES
("Amit","Sharma","amit@gmail.com","1982-07-12"),
("Priya ","Patel","priya@gmail.com","1991-04-25"),
("Rajesh","Singh","rajesh@gmail.com","1988-11-30"),
("Neha ","Gupta","neha@gmail.com","1995-09-18"),
("Swap","Kshirsagar","swap@gmail.com","2001-01-31");


SELECT * from authors;


CREATE TABLE posts(id int PRIMARY key AUTO_INCREMENT,
author_id INT,
title varchar(100),
description TEXT,
content TEXT,
date DATE,
FOREIGN KEY (author_id)REFERENCES authors(id));

INSERT INTO posts (author_id,title,description,content,date)
VALUES(1,"first post","Description of first post","Content of first Post","2024-06-1"),
(2,"second post","Description of second post","Content of second Post","2024-06-5"),
(3,"third post","Description of third post","Content of third Post","2024-06-10"),
(4,"fourth post","Description of fourth post","Content of fourth Post","2024-06-15"),
(5,"fifth post","Description of fifth post","Content of fifth Post","2024-06-20");

SELECT * from authors;
select * from posts;
