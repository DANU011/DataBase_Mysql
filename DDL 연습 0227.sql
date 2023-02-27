alter table orders drop primary key;

show index from orders;

ALTER TABLE orders ADD PRIMARY KEY(orderid);

show index from orders;