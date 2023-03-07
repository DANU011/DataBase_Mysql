use db2020;
-- 트래젝션 p104

commit; # 하나의 단위 작업이 끝남.
rollback; # 하나의 단위 작업이 끝남. 되돌리기

select @@autocommit; # 상태확인 1 자동 0 수동 기본세팅 1
set autocommit=0; # 수동커밋
select @@autocommit;

create table book1 (select * from book);
create table book2 (select * from book);

delete from book1;
select @@autocommit; # 1 자동상태 < 프로그램 재실행
rollback; # 자동 커밋되서 안먹힘

set autocommit=0;
select @@autocommit; # 0 수동상태
delete from book2;
rollback; # 수동 커밋이라 커밋되지 않아서 먹힘.

delete from book2;
commit;
rollback; # commit 해서 안먹힘

set autocommit=1;

create table book1 (select * from book);
create table book2 (select * from book);

start transaction;
delete from book1;
delete from book2;
rollback; # > 하나의 트랜젝션 종료 ( 문제가 있으면 rollback, 없으면 commit 으로 종료 )


#=======구역이 나뉨=======#
start transaction;
savepoint A;
delete from book1;
savepoint B;
rollback to savepoint B;
commit; # > book1은 사라져있고 book2는 살아있음.


use db0307;


create table account(
accNum char(10) primary key,
amount int not null default 0);


insert into account values('a',450000);
insert into account values('b',90000);


select * from db0307.account;


# a계좌에서 4만원을 빼서 b계좌로 넣는다.
update account 
set amount=amount -40000
where accNum='a';
update account
set amount=amount+40000
where accNum='b'; 


select * from db0307.account;


#인출-송금을 하나의 트랜잭션으로 묶음.
start transaction;
update account 
set amount=amount -40000
where accNum='a';
update account
set amount=amount+40000
where accNum='b'; 
commit;


#트리거로 작성 가능. (+예외처리)
delimiter // 
create trigger account_beforupdate
before update on account for each row
begin
if(new.amount<0) then 
signal sqlstate '45000';
end if;
end;
// delimiter ;


delimiter // 
CREATE procedure account_transaction (
in sender char(15),
in recipe char(15),
in _amount int) 
BEGIN 
declare exit handler for sqlexception rollback;
start transaction;
update account
set amount = amount-_amount 
where accNum=sender;
update account 
set aomount = amount+_amount
where accNum=recip;
commit;
END; 
// delimiter ;









