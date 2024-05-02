#Import Library
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

#Create table customers
customers <- tribble(
  ~customer_id, ~name, ~contact_info,
  1, 'John Doe', 'john.doe@example.com',
  2,  'Alice Smith', 'alice.smith@example.com',
  3, 'Bob Johnson', 'bob.johnson@example.com',
  4, 'Emma Davis', 'emma.davis@example.com',
  5, 'Michael Brown', 'michael.brown@example.com',
  6, 'Sarah Wilson', 'sarah.wilson@example.com',
  7, 'David Lee', 'david.lee@example.com',
  8, 'Emily White', 'emily.white@example.com',
  9, 'Daniel Miller', 'daniel.miller@example.com',
  10, 'Olivia Taylor', 'olivia.taylor@example.com'
)

#Create products table
products <- tribble(
  ~product_id, ~product_name,
  1, 'Product A',
  2, 'Product B',
  3, 'Product C'
)

#create Reviews table
reviews <- tribble(
  ~customer_id, ~product_id, ~rating, ~review_text, ~date, 
  1, 1, 5, 'Excellent product!', '2024-03-01',
  2, 1, 4, 'Good product, but could be improved.', '2024-03-02',
  1, 2, 3, 'Not satisfied with the quality.', '2024-03-03',
  3, 3, 5, 'Amazing experience with Product C.', '2024-03-04',
  2, 2, 2, 'Very disappointed with Product B.', '2024-03-05',
  1, 3, 4, 'Impressed with Product C features.', '2024-03-06',
  4, 1, 5, 'Great service and fast delivery.', '2024-03-07',
  5, 2, 4, 'Decent product for the price.', '2024-03-08',
  6, 3, 2, 'Not recommended, poor quality.', '2024-03-09',
  7, 1, 3, 'Average product, nothing special.', '2024-03-10',
  8, 2, 4, 'Satisfied with the purchase.', '2024-03-11',
  9, 3, 5, 'Best product I have ever bought!', '2024-03-12',
  10, 1, 2, 'Terrible experience, never buying again.', '2024-03-13',
  1, 2, 4, 'Improved quality compared to previous purchases.', '2024-03-14',
  2, 3, 3, 'Product meets expectations, nothing extraordinary.', '2024-03-15',
  3, 1, 5, 'Highly recommend, great value for money.', '2024-03-16',
  4, 2, 1, 'Worst purchase ever, complete waste of money.', '2024-03-17',
  5, 3, 4, 'Good product with fast shipping.', '2024-03-18',
  6, 1, 2, 'Disappointed, did not live up to the hype.', '2024-03-19',
  7, 2, 5, 'Exceeded expectations, fantastic product!', '2024-03-20',
  8, 3, 3, 'Average quality, but the price is reasonable.', '2024-03-21',
  9, 1, 4, 'Impressive features, would recommend.', '2024-03-22',
  10, 2, 1, 'Regret buying, poor quality and bad customer service.', '2024-03-23',
  1, 3, 5, 'Absolutely love it, worth every penny!', '2024-03-24',
  2, 1, 3, 'Okay product, but there are better alternatives.', '2024-03-25'
)

# bring those table to our database
dbWriteTable(con, "customers", customers)
dbWriteTable(con, "products", products)
dbWriteTable(con, "reviews", reviews)
