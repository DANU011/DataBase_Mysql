use db2020;

/*(1) InsertBook() 프로시저를 수정하여 고객을 새로 등록하는 InsertCustomer() 프로시저를 작성하시오.*/ 
drop procedure if exists InsertCustomer;
delimiter //
CREATE PROCEDURE InsertCustomer(
 IN mycustid INTEGER,
 IN myname VARCHAR(40),
 IN myaddress VARCHAR(50),
 IN myphone VARCHAR(20))
BEGIN
 INSERT INTO Customer(custid, name, address, phone)
 VALUES(mycustid, myname, myaddress, myphone);
END;
//
delimiter ;

/* 프로시저 InsertCustomer을 테스트하는 부분 */
CALL InsertCustomer(6,'김아무개', '서울시 종로구', '123-4567-8912');
SELECT * FROM Customer;

/*(2) BookInsertOrUpdate() 프로시저를 수정하여 삽입 작업을 수행하는 프로시저를 작성하시오. 
삽입하려는 도서와 동일한 도서가 있으면 삽입하려는 도서의 가격이 높을 때만 새로운 값으로 변경한다. */

SELECT * FROM Book;

drop procedure if exists BookInsertOrUpdate;
delimiter //
CREATE PROCEDURE BookInsertOrUpdate(
 myBookID INTEGER,
 myBookName VARCHAR(40),
 myPublisher VARCHAR(40),
 myPrice INT)
BEGIN
 DECLARE mycount INTEGER;
 SELECT count(*) INTO mycount FROM Book
 WHERE bookname LIKE myBookName;
 IF mycount!=0 THEN
 SET SQL_SAFE_UPDATES=0; /* DELETE, UPDATE 연산에 필요한 설정 문 */
 UPDATE Book SET price = myPrice
 WHERE price < myPrice; -- update 조건만 바꿔주면 해결 elseif 보다 간단함.
 ELSE
 INSERT INTO Book(bookid, bookname, publisher, price)
 VALUES(myBookID, myBookName, myPublisher, myPrice);
 END IF;
END;
//
delimiter ; 

-- BookInsertOrUpdate 프로시저를 실행하여 테스트하는 부분
CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 25000);
SELECT * FROM Book; -- 15번 투플 삽입 결과 확인
-- BookInsertOrUpdate 프로시저를 실행하여 테스트하는 부분
CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 30000);
SELECT * FROM Book; -- 15번 투플 가격 상승 변경 확인
CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 20000);
SELECT * FROM Book; -- 15번 투플 가격 하락 변경 되지 않는것 확인


/*(3) 출판사가 '이상미디어'인 도서의 이름과 가격을 보여주는 프로시저를 작성하시오. 커서 사용*/
drop procedure if exists db2020.cursor_pro3;

delimiter $$
create procedure cusor_pro3()
begin
	declare myname varchar(40);
    declare myprice int;
    declare endOfRow boolean default false;
    declare bookCursor cursor for select bookname, price from book where publisher='이상미디어';
    DECLARE CONTINUE handler FOR NOT FOUND SET endOfRow=TRUE; 
    open bookCursor;
    cursor_loop: LOOP 
		FETCH bookCursor into myname, myprice;
		IF endOfRow THEN LEAVE cursor_loop; 
		END IF; 
		select myname, myprice;
	end loop cursor_loop;
    close bookCursor;
    end $$
    delimiter ;
    
    call cusor_pro3();

/* (4) 출판사별로 출판사 이름과 도서의 판매 총액을 보이시오(판매 총액은 Orders 테이블에 있다). */

drop procedure if exists pro4;
delimiter $$
create procedure pro4()
begin
select book.publisher, sum(orders.saleprice) 
from book join orders on book.bookid = orders.bookid
group by book.publisher;
end; 
$$
delimiter ;
    
call pro4();


/*(5) 출판사별로 도서의 평균가보다 비싼 도서의 이름을 보이시오
(예를 들어 A 출판사 도서의 평균가가 20,000원이라면 A 출판사 도서 중 20,000원 이상인 도서를 보이면 된다). */

drop procedure if exists pro5;
delimiter $$
create procedure pro5()
begin
	select b1.bookname from book1 b1
	where (select avg(b2.price) from book1 b2 where b2.publisher = b1.publisher) < b1.price;
end $$
delimiter ;
    
call pro5();
    


/* (6) 고객별로 도서를 몇 권 구입했는지와 총 구매액을 보이시오. */
drop procedure if exists pro6;
delimiter $$
create procedure pro6()
begin
select customer.name, sum(orders.saleprice) 
from customer join orders on customer.custid=orders.custid
group by customer.name;
end; 
$$
delimiter ;
    
call pro6();




/* (7) 주문이 있는 고객의 이름과 주문 총액을 출력하고, 주문이 없는 고객은 이름만 출력하는 프로시저를 작성하시오. */



/* (9) 고객의 주소를 이용하여 국내에 거주하면 '국내거주', 해외에 거주하면 '국외거주'를 반환하는 함수 Domestic()
을 작성하시오. Domestic()을 호출하여 고객의 이름과 국내/국외 거주 여부를 출력하는 SQL 문도 작성하시오. */

/* (10) (9)번에서 작성한 Domestic()을 호출하여 국내거주 고객의 판매 총액과 국외거주 고객의 판매총액을 출력하는
SQL 문을 작성하시오. */
