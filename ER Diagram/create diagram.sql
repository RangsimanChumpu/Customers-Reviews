Table customers {
  customer_id int [primary key]
  name varchar 
  contact_info varchar
}

Table products {
  product_id int [primary key]
  product_name varchar
}

Table reviews {
  review_id int [primary key]
  customer_id int
  product_id int
  rating int
  review_text varchar
  date datetime
}

// one - namy relationship
ref a_relationship {
  customers.customer_id < reviews.customer_id
}

// one - namy relationship
ref a_relationship {
  products.product_id < reviews.product_id
}
