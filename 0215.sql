create table persons(
id int not null,
lastname varchar(255) not null,
firstname varchar(255),
age int,
primary key(id)
);

insert into persons values(1,'Hansen','ola',30);
insert into persons values(2,'Svendson','Tove',23);
insert into persons values(3,'Pettersen','Kari',20);

CREATE TABLE Orders (
    orderid int NOT NULL,
    orderNumber int NOT NULL,
    id int,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES Persons(id)
);

insert into Orders values(1,77895,4);/*기본키에 없는 도메인이라 들어가지 않음*/
insert into Orders values(2,44678,3);
insert into Orders values(3,22456,2);
insert into Orders values(4,24562,1);



