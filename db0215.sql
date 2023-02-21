create table members (
memid varchar(10) not null,
memname varchar(20) not null,
passwd varchar(128),
passwdmdt datetime,
jumin varchar(64),
addr varchar(100),
birthday date,
jobcd char(1),
mileage decimal(7,0) unsigned default 0,
stat enum('Y','N') default 'Y',
enterdtm datetime default CURRENT_TIMESTAMP(),
leavedtm datetime, 
primary key(memid)
);

create table goodsinfo (
goodscd char(5) not null,
goodsname varchar(20) not null,
unitcd char(2),
unitprice decimal(5,0),
stat enum('Y','N') default 'Y',
insdtm datetime default CURRENT_TIMESTAMP(),
moddtm datetime,
primary key(goodscd)
);

create table order_h (
orderno char(9) not null,
orddt date not null,
memid varchar(10) not null,
ordamt decimal(7,0) unsigned not null default 0,
cancelyn enum('Y','N') default 'N',
canceldtm datetime,
insdtm datetime default CURRENT_TIMESTAMP(),
moddtm datetime,
primary key(orderno)
);

create table order_d(
orderno char(9) not null,
goodscd char(5) not null,
unitcd char(2), 
unitprice decimal(5,0) unsigned not null default 0,
qty decimal(3,0) not null default 0,
amt decimal(7,0) not null default 0,
insdtm datetime default CURRENT_TIMESTAMP(),
moddtm datetime,
primary key(orderno,goodscd)
);
