-- ILIKE - case-insensitive search */
SELECT title from orders WHERE title ILIKE '%батарея%' LIMIT 10
--------------------

-- LIKE
SELECT * FROM movies WHERE name LIKE 'Se_en'; -- LIKE is a special operator used with the WHERE clause to search for a specific pattern in a column.
                     WHERE name LIKE 'a%';    -- % is a wildcard character that matches zero or more missing letters in the pattern.*/
                     WHERE name LIKE '%man%';
                     WHERE name LIKE '%m.n%';
                     WHERE name LIKE '%m_n%';
                     WHERE name BETWEEN 'A' AND 'J';
                     WHERE year BETWEEN 1990 AND 2000 AND genre = 'comedy';
                     WHERE genre = 'comedy' OR year < 1980;
--------------------

-- CRUD
CREATE TABLE creates            -- a new table.
INSERT INTO adds                -- a new row to a table
ALTER TABLE changes             -- an existing table
DELETE FROM deletes             -- rows from a table
UPDATE edits SET a = 'a'        -- a row in a table
DESCRIBE tаble_name;            -- структура созданных таблиц*/
--------------------

GROUP BY is a clause used with aggregate functions to combine data from one or more columns.
SUM()   -- takes the column name as an argument and returns the sum of all the values in that column.
MAX()   -- takes the column name as an argument and returns the largest value in that column.
MIN()   -- takes the column name as an argument and returns the smallest value in that column.
AVG()   -- takes a column name as an argument and returns the average value for that column.
ROUND() -- takes two arguments, a column name and the number of decimal places to round the values in that column.

INNER JOIN      -- will combine rows from different tables if the join condition is true.
LEFT OUTER JOIN -- will return every row in the left table, and if the join condition is not met, NULL values are used to fill in the columns from the right table.
AS is           -- add alias
--------------------

--------------------
SELECT text FROM texts, words
WHERE LOWER(texts.text) LIKE LOWER(CONCAT('%', words.word, '%'))
--------------------

-- REPLACE
SELECT * FROM texts, words
WHERE LOWER(REPLACE(texts.text, 'm', '')) LIKE LOWER('%dia%')

SELECT * FROM y
ORDER BY REGEXP_REPLACE(number, '(^\\d{8})\\d{1}(\\d+$)', '\\1\\2')
--------------------

-- JSONB
SELECT * FROM y
WHERE (data ->> 'city' LIKE 'KRASNOGORSK')
WHERE (data #> '{state_history, -1}' -> 'changed_at')             -- select changed_at field from json from last element of array
WHERE (data #> '{state_history, 0}' ->> 'from_state' = 'pending') -- select from first element of array
--------------------

-- COPY
COPY aircraft FROM '/home/xxx.txt'
COPY aircraft TO '/home/xxx.txt' WITH (FORMAT csv)
--------------------

-- CONFLICT
INSERT INTO test (some_key) VALUES ('a')
ON CONFLICT DO NOTHING;
--------------------

-- USING (for joins instead of ON)
SELECT * FROM COUNTRIES JOIN CITIES
USING (COUNTRY)
--------------------

-- EXAMPLES
CREATE TABLE IF NOT EXISTS category (
	id INT NOT NULL,
	name VARCHAR(255) NULL,
	PRIMARY KEY (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
--------------------
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
--------------------
ALTER TABLE sale
	DROP COLUMN dt_created,
	DROP FOREIGN KEY fk_order_status1,
	ADD COLUMN dt_created ts_modified TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	ADD COLUMN sale_status VARCHAR(45) NOT NULL DEFAULT 'new'
		CHECK (VALUE IN ('new', 'process', 'assembly', 'ready', 'delivering', 'issued', 'rejected'));
--------------------
ALTER TABLE client
ADD COLUMN source_id int null,
ADD CONSTRAINT fk_source_id FOREIGN KEY (source_id) REFERENCES source(id);
--------------------


CREATE TABLE artists(id INTEGER PRIMARY KEY, name TEXT);
SELECT * FROM albums JOIN artists ON albums.artist_id = artists.id;      -- select all from two tables (insert into first table value of second table where albums.artist_id = artists.id */
SELECT * FROM albums LEFT JOIN artists ON albums.artist_id = artists.id; -- select all even if artists.id = null */

--------------------
/*Выборка из нескольких источников*/
/*
Выведите все позиций списка товаров принадлежащие какой-либо категории с
названиями товаров и названиями категорий. Список должен быть отсортирован по
названию товара, названию категории. Для соединения таблиц необходимо
использовать оператор INNER JOIN.
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
SELECT client.first_name, client.last_name,
       COUNT(status.name) AS new_sale_num FROM sale
INNER JOIN client 
ON client.id = sale.client_id
INNER JOIN status 
ON status.id = sale.status_id 
WHERE status.name = 'new'
GROUP BY first_name, last_name
;

/*
Выведите список товаров с названиями товаров и названиями категорий, в том числе
товаров, не принадлежащих ни одной из категорий.
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
Выведите список товаров с названиями категорий, в том числе товаров, не
принадлежащих ни к одной из категорий, в том числе категорий не содержащих ни
одного товара.
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
Выведите список всех источников клиентов и суммарный объем заказов по каждому
источнику. Результат должен включать также записи для источников, по которым не
было заказов.
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
Выведите названия товаров, которые относятся к категории 'Cakes' или фигурируют
в заказах текущий статус которых 'delivering'. Результат не должен содержать
одинаковых записей. В запросе необходимо использовать оператор UNION для
объединения выборок по разным условиям.

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
Выведите список всех категорий продуктов и количество продаж товаров,
относящихся к данной категории. Под количеством продаж товаров подразумевается
суммарное количество единиц товара данной категории, фигурирующих в заказах с
любым статусом.

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
Выведите список источников, из которых не было клиентов, либо клиенты пришедшие
из которых не совершали заказов или отказывались от заказов. Под клиентами,
которые отказывались от заказов, необходимо понимать клиентов, у которых есть
заказы, которые на момент выполнения запроса находятся в состоянии 'rejected'.
В запросе необходимо использовать оператор UNION для объединения выборок по разным
условиям.

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
