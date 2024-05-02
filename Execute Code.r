library(RPostgreSQL)
library(tidyverse)

#Connect
con <- dbConnect(
  PostgreSQL(),
  host = "arjuna.db.elephantsql.com",
  dbname = "wniurgay",
  user = "wniurgay",
  password = "AS_6VlL0EUL2rDTkBf9Psjmj4m0Rh2Y0",
  port = 5432
)
con

dbListTables(con)
dbListFields(con, "customers")
dbListFields(con, "products")
dbListFields(con, "reviews")

#หาค่าเฉลี่ย rating ของสินค้าเเต่ละรายการ
dbGetQuery(con, 
"select 
  pr.product_id AS product_id, 
  pr.product_name AS product_name, 
  AVG(re.rating) AS average_rating 
 from products AS pr
 INNER JOIN reviews AS re
  ON pr.product_id = re.product_id
 GROUP BY 1,2"
)

#ดึงข้อมูลลูกค้าที่ให้ Rating มากกว่า 4
dbGetQuery(con, 
"select 
  cu.name, 
  cu.contact_info 
 FROM customers AS cu
 INNER JOIN reviews AS re
  ON cu.customer_id = re.customer_id
 WHERE rating > 4
 ORDER BY rating DESC"
)

#นับจำนวนครั้งลูกค้าเเต่ละคนเข้ามาเขียนรีวิว
dbGetQuery(con, 
"select 
  cu.name AS name, 
  COUNT(re.customer_id) AS count_review
 from customers AS cu
 INNER JOIN reviews AS re
  ON cu.customer_id = re.customer_id
 GROUP BY 1
 ORDER BY count_review DESC"
)

#สินค้าที่ได้เรตติ้ง >= 3.5 เป็นสินค้าชนิดใดบ้าง
dbGetQuery(con, 
"SELECT
  pr.product_id AS product_id,
  pr.product_name AS product_name,
  AVG(re.rating) AS average_rating
 FROM products AS pr
 INNER JOIN reviews AS re
  ON pr.product_id = re.product_id
 GROUP BY 1,2
 HAVING AVG(re.rating) >= 3.5"
)

#นับจำนวนข้อความที่เป็นรีวิวด้านลบจะมีคำว่า "disappointed"
dbGetQuery(con,
"SELECT
  COUNT(review_text) AS count_review
 FROM reviews
 WHERE review_text LIKE '%disappointed%'
 GROUP BY review_text"
)

#ลูกค้าคนไหนบ้างที่เคยเขียนข้อความรีวิวในด้านบวกให้คะเเนนเรตติ้งสูง >= 4
dbGetQuery(con,
"SELECT
  cu.customer_id AS customer_id,
  cu.name AS name
 FROM customers AS cu
 INNER JOIN reviews AS re
  ON cu.customer_id = re.customer_id
 WHERE review_text LIKE '%excellent%' OR review_text LIKE '%impressive%' OR 
  review_text LIKE '%recommend%' and rating >= 4"           
)
