
/*Commands*/
CREATE TABLE creates -- a new table.
INSERT INTO adds a new row to a table.
SELECT queries data from a table.
UPDATE edits a row in a table.
ALTER TABLE changes an existing table.
DELETE FROM deletes rows from a table.

SELECT is the clause you use every time you want to query information from a database.
WHERE is a popular command that lets you filter the results of the query based on conditions that you specify.
LIKE and BETWEEN are special operators that can be used in a WHERE clause
AND and OR are special operators that you can use with WHERE to filter the query on two or more conditions.
ORDER BY lets you sort the results of the query in either ascending or descending order.
LIMIT lets you specify the maximum number of rows that the query will return. This is especially important in large tables that have thousands or even millions of rows.

GROUP BY is a clause used with aggregate functions to combine data from one or more columns.
SUM() takes the column name as an argument and returns the sum of all the values in that column.
MAX() takes the column name as an argument and returns the largest value in that column.
MIN() takes the column name as an argument and returns the smallest value in that column.
AVG() takes a column name as an argument and returns the average value for that column.
ROUND() takes two arguments, a column name and the number of decimal places to round the values in that column.

INNER JOIN will combine rows from different tables if the join condition is true.
LEFT OUTER JOIN will return every row in the left table, and if the join condition is not met, NULL values are used to fill in the columns from the right table.
AS is a keyword in SQL that allows you to rename a column or table in the result set using an alias.

/************/
CREATE TABLE IF NOT EXISTS category (
	id INT NOT NULL,
	name VARCHAR(255) NULL,
	PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
/************/
CREATE TABLE IF NOT EXISTS category_has_good (
	category_id INT NOT NULL, good_id INT NOT NULL,
	PRIMARY KEY (category_id, good_id),
	INDEX fk_category_has_good_good_idx (good_id ASC),
	INDEX fk_category_has_good_category_idx (category_id ASC),
	CONSTRAINT fk_category_has_good_category
		FOREIGN KEY (category_id) REFERENCES category (id)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_category_has_good_good1 
		FOREIGN KEY (good_id) REFERENCES good (id)
		ON DELETE NO ACTION ON UPDATE NO ACTION);
/************/

ALTER TABLE sale
	DROP COLUMN dt_created,
	DROP FOREIGN KEY fk_order_status1,

	ADD COLUMN dt_created ts_modified TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	ADD COLUMN sale_status VARCHAR(45) NOT NULL DEFAULT 'new'
		CHECK (VALUE IN ('new', 'process', 'assembly', 'ready', 'delivering', 'issued', 'rejected'))

	;
/************/
ALTER TABLE client
ADD COLUMN source_id int null,
add CONSTRAINT fk_source_id FOREIGN KEY (source_id) REFERENCES source(id);

/************/


/*CODECADEMY begin*/

CREATE TABLE celebs (
	id INTEGER, 
	name TEXT, 
	age INTEGER
	);

INSERT INTO celebs (id, name, age) VALUES (1, 'Justin Bieber', 21);/*запись в БД*/

SELECT * FROM celebs /*взять все из таблицы*/

INSERT INTO celebs (id, name, age) VALUES (2, 'Beyonce Knowles', 33); 
INSERT INTO celebs (id, name, age) VALUES (3, 'Jeremy Lin', 26); 
INSERT INTO celebs (id, name, age) VALUES (4, 'Taylor Swift', 26);

UPDATE celebs
SET age = 22
WHERE id = 1;

ALTER TABLE celebs ADD COLUMN /*Add a new column to the table. In the code editor type*/
twitter_handle TEXT;

UPDATE celebs
SET twitter_handle = '@taylorswift13'
WHERE id = 4;

DELETE FROM celebs WHERE 
twitter_handle IS NULL;

SELECT * FROM celebs;

/************/

SELECT name, imdb_rating FROM movies;

SELECT DISTINCT genre FROM movies; /*SELECT DISTINCT is used to return unique values in the result set*/

SELECT * FROM movies WHERE imdb_rating > 8;

SELECT * FROM movies WHERE name LIKE 'Se_en'; /* LIKE is a special operator used with the WHERE clause to search for a specific pattern in a column.*/

SELECT * FROM movies WHERE name LIKE 'a%'; /* % is a wildcard character that matches zero or more missing letters in the pattern.*/

SELECT * FROM movies WHERE name LIKE '%man%';

SELECT * FROM movies WHERE name BETWEEN 'A' AND 'J';

SELECT * FROM movies WHERE year BETWEEN 1990 AND 2000;

SELECT * FROM movies WHERE year BETWEEN 1990 AND 2000 AND genre = 'comedy';

SELECT * FROM movies WHERE genre = 'comedy' OR year < 1980;

SELECT * FROM movies ORDER BY imdb_rating DESC; /* sort the results in descending order (high to low or Z-A) */

SELECT * FROM movies ORDER BY imdb_rating ASC LIMIT 3; /*  sort the results in ascending order (low to high or A-Z) */

/************/

SELECT * FROM fake_apps;

SELECT COUNT (*) FROM fake_apps; /* Count how many apps are in the database. */

SELECT COUNT(*) FROM fake_apps WHERE price = 0;

SELECT price, COUNT(*) FROM fake_apps GROUP BY price; /* GROUP BY is a clause in SQL that is only used with aggregate functions */

SELECT price, COUNT(*) FROM fake_apps WHERE downloads > 20000 GROUP BY price;

SELECT SUM(downloads) FROM fake_apps; /* SUM() is a function that takes the name of a column as an argument and returns the sum of all the values in that column */

SELECT category, SUM(downloads) FROM fake_apps GROUP BY category; /* sum of downloads of each category*/

SELECT MAX(downloads) FROM fake_apps;

SELECT name, category, MAX(downloads) FROM fake_apps GROUP BY category;

SELECT price, ROUND(AVG(downloads), 2) FROM fake_apps GROUP BY price; /* округляет */

/************/

CREATE TABLE artists(id INTEGER PRIMARY KEY, name TEXT);
SELECT * FROM albums JOIN artists ON albums.artist_id = artists.id; /* select all from two tables (insert into first table value of second table where albums.artist_id = artists.id */
SELECT * FROM albums LEFT JOIN artists ON albums.artist_id = artists.id; /* select all even if artists.id = null */

/************/

/*CODECADEMY end*/
/************//************//************/



/*Examples*/

/************//************//************/

SELECT maker FROM Product WHERE type = 'Printer' GROUP BY maker

SELECT maker FROM Product WHERE model IN (SELECT model FROM Printer) GROUP BY maker /* model contained in the two tables */

SELECT 
albums.name AS 'Album', 
albums.year, 
artists.name AS 
'Artist'
FROM
albums
JOIN artists ON albums.artist_id = artists.id
WHERE
albums.year > 1980;



/************//************//************/




/************//************//************/
CREATE DATABASE db_name;/*создаем базу данных*/
SHOW DATABASES;/*показать все базы*/
USE db_name;/*выбрать базу данных для работы*/
CREATE TABLE table_name (
	id_author int(6) NOT NULL auto_increment,
	name text,
	time datetime default NULL,
	themes int(10) default NULL,
	PRIMARY KEY (id_author)
) TYPE=MyISAM;

SHOW TABLES;
DESCRIBE tаble_name;/*структура созданных таблиц*/
ALTER TABLE table_name alter_spec/*изменяет ст-ру таблицы*/
ALTER TABLE forums ADD test int(10) AFTER name;/*add столбец*/
ALTER TABLE forums CHANGE test new_test text;/*rename столбец*/
ALTER TABLE forums DROP new_test;/*delete столбец*/

DROP TABLE table_name или [ ,table_name,...];/*del 1 или несколько таблиц*/
DROP DATABASE database_name;

INSERT INTO authors VALUES (1, 'Maks', '123', ' maks@mail.ru ', 
	' www.softtime.ru ', '', 'программист', '', '', '', 0, 0);

DELETE FROM authors; /*del все из столбца autor*/
DELETE FROM authors WHERE id_author = 1;/*del значение из столбца autor*/

/*удаляются все авторы с паролем '123' и первичный ключ которых превышает 10*/
DELETE FROM authors WHERE passw = '123' AND id_author > 10;

SELECT column,.../*можно выбрать одну или несколько колонок, или все '*' */
[FROM table WHERE definition]

/*сортирует строки запросов по столбцу col_name в прямом (ASC) или обр. порядке (DESC).*/
[ORDER BY col_name [ASC | DESC], ...]

/*сообщает MySQL об выводе только rows запросов начиная с позиции offset.*/
[LIMIT [offset], rows]

SELECT * FROM forums;/*выбрать все из таблицы forums*/
SELECT id_forum, name FROM forums;/*выбрать не все столбцы таблицы, а лишь часть*/
SELECT * FROM forums LIMIT 3;/*ограничения количества строк, возвращенных командой SELECT*/
SELECT * FROM forums LIMIT 1,3; /*выбор строк со второй по третью*/
SELECT * FROM forums WHERE id_forum > 2;/*выберем записи, у которых значение id_forum больше 2*/
SELECT * FROM forums WHERE id_forum > 2 ORDER BY pos;/*сортировка по значениям столбца pos, а не по id*/

UPDATE table/*обновляет столбцы таблицы table*/
/*указывается, какие именно столбцы следует модифицировать и какие величины должны быть в них установлены*/
SET col_name1=expr1 [, col_name2=expr2 ...]
[WHERE definition]/*какие строки подлежат обновлению*/
[LIMIT rows]/*ограничить число обновляемых строк*/

UPDATE forums SET name='PHP', hide=1 WHERE id_forum=2;

SHOW FIELDS FROM authors;/*вывести список всех столбцов выбранной таблицы*/
SHOW INDEX FROM authors;/*отобразить информацию обо всех индексах конкретной таблицы*/

/************************************/





/*Выборка из нескольких источников*/
/*
Выведите все позиций списка товаров принадлежащие какой-либо категории с названиями товаров и названиями категорий. Список должен быть отсортирован по названию товара, названию категории. Для соединения таблиц необходимо использовать оператор INNER JOIN.
Ожидаемый формат результата:
+-------------+----------------+
| good_name   | category_name  |
+-------------+----------------+
| good 1      | category 1     |
| good 1      | category 2     |
| good 2      | category 3     |
| good 2      | category 4     |
| good 3      | category 7     |
*/
select good.name as good_name, c.name as category_name
from good
inner join category_has_good as chg 
on good.id = chg.good_id
inner join category as c 
on c.id = chg.category_id
order by 1,2
;

/*
Выведите список клиентов (имя, фамилия) и количество заказов данных клиентов, имеющих статус "new".
Ожидаемый формат результата:
№+------------+------------+----------------------+
| first_name | last_name  | new_sale_num         |
+------------+------------+----------------------+
| Ivan       | Ivanov     |                   10 |
| Petr       | Petrov     |                    7 |
| Semen      | Sidorov    |                    7 |
| Frank      | Sinatra    |                    2 |
| Ella       | Fitzgerald |                    1 |
*/
SELECT client.first_name, client.last_name, count(status.name) as new_sale_num FROM sale 
INNER JOIN client 
ON client.id = sale.client_id
INNER JOIN status 
ON status.id = sale.status_id 
WHERE status.name = 'new'
GROUP BY first_name, last_name
;

/*
Выведите список товаров с названиями товаров и названиями категорий, в том числе товаров, не принадлежащих ни одной из категорий.
Ожидаемый формат результата:
+-------------+----------------+
| good_name   | category_name  |
+-------------+----------------+
| good 1      | category 1     |
| good 1      | category 2     |
| good 2      | category 3     |
| good 2      | category 4     |
| good 3      | category 7     |
*/
select good.name, category.name 
from good 
left join category_has_good
on good.id = category_has_good.good_id 
left join category
on category.id = category_has_good.category_id 
order by good.name
;

/*
Выведите список товаров с названиями категорий, в том числе товаров, не принадлежащих ни к одной из категорий, в том числе категорий не содержащих ни одного товара.
Ожидаемый формат результата:
+-------------+----------------+
| good_name   | category_name  |
+-------------+----------------+
| good 1      | category 1     |
| good 1      | category 2     |
| good 2      | category 3     |
| good 2      | category 4     |
| good 3      | category 7     |
*/
SELECT g.name AS good_name, c.name AS category_name FROM good AS g
LEFT JOIN category_has_good AS chg
ON g.id = chg.good_id
LEFT JOIN category AS c
ON chg.category_id = c.id
UNION
SELECT g.name AS good_name, c.name AS category_name FROM good AS g
LEFT JOIN category_has_good AS chg
ON g.id = chg.good_id
RIGHT JOIN category AS c
ON chg.category_id = c.id
;

/*
Выведите список всех источников клиентов и суммарный объем заказов по каждому источнику. Результат должен включать также записи для источников, по которым не было заказов.
Ожидаемый формат результата:
+-------------+----------------+
| source_name | sale_sum       |
+-------------+----------------+
| source 1    | 111.00         |
| source 2    | 222.00         |
| source 3    | 333.00         |
*/
SELECT s.name AS source_name, sum(sale.sale_sum) AS sale_sum 
FROM source AS s
LEFT JOIN client AS c
ON c.source_id = s.id
LEFT JOIN sale
ON sale.client_id = c.id
GROUP BY source_name    
;

/*
Выведите названия товаров, которые относятся к категории 'Cakes' или фигурируют в заказах текущий статус которых 'delivering'. Результат не должен содержать одинаковых записей. В запросе необходимо использовать оператор UNION для объединения выборок по разным условиям.
Ожидаемый формат результата:
+-------------+
| good_name   |
+-------------+
| good 1      |
| good 2      |
| good 3      |
*/
SELECT g.name AS good_name FROM good AS g
JOIN category_has_good AS chg
ON chg.good_id = g.id
JOIN category as c
ON c.id = chg.category_id
WHERE c.name = 'Cakes'
UNION 
SELECT g.name AS good_name FROM good AS g
JOIN sale_has_good AS shg 
ON shg.good_id = g.id
JOIN sale AS s
ON s.id = shg.sale_id
JOIN status AS st
ON st.id = s.status_id
WHERE st.name = 'delivering'


/*
Выведите список всех категорий продуктов и количество продаж товаров, относящихся к данной категории. Под количеством продаж товаров подразумевается суммарное количество единиц товара данной категории, фигурирующих в заказах с любым статусом.
Ожидаемый формат результата:
+---------------------+----------+
| name                | sale_num |
+---------------------+----------+
| category 1          |       11 |
| category 2          |       25 |
| category 3          |       13 |
*/
select c.name, count(s.number) from category as c
left join category_has_good as chg
on chg.category_id = c.id
left join good as g
on chg.good_id = g.id
left join sale_has_good as shg
on g.id = shg.good_id
left join sale as s
on shg.sale_id = s.id
group by c.name
;

/*
Выведите список источников, из которых не было клиентов, либо клиенты пришедшие из которых не совершали заказов или отказывались от заказов. Под клиентами, которые отказывались от заказов, необходимо понимать клиентов, у которых есть заказы, которые на момент выполнения запроса находятся в состоянии 'rejected'. В запросе необходимо использовать оператор UNION для объединения выборок по разным условиям.
Ожидаемый формат результата:
+-------------+
| source_name |
+-------------+
| source 1    |
| source 2    |
| source 3    |
*/
select s.name from source as s
where not exists (select * from client as c
	where s.id = c.source_id)
union
select s.name from source as s
join client as c 
on c.source_id = s.id
join sale
on sale.client_id = c.id
right join status
on status.id = sale.status_id
where status.name = 'rejected' 
or status.name is null
;



explain
select good.name as good_name, c.name as category_name
from good
inner join category_has_good as chg
inner join category as c on c.id = chg.category_id and chg.good_id = good.id
order by 1,2;
/************************************/


/* SENTENCES */
/************************************/
/*
texts
+--------+-----------------------+
| id     |       text            |
+--------+-----------------------+
| 1      | Hello my name is Dima |
| 2      | Hello my name is Vasya|
| 3      | Hello my name is Kolya|


words
+--------+---------+
| id     |  text   |
+--------+---------+
| 1      | Hello   |
| 2      | my name |
| 3      | name is |

*/

SELECT text FROM texts, words WHERE LOWER(texts.text) LIKE LOWER(CONCAT('%', words.word, '%')) AND words.id = 2

SELECT * FROM texts, words WHERE LOWER(REPLACE(texts.text, 'm', '')) LIKE LOWER('%dia%') AND words.id = 9/*gsub*/




INSERT INTO texts (id, text) VALUES (9, 'My jora dim');

Update texts
SET text = 'My jora dim')
where id = 9;

/************************************/
