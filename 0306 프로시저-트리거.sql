delimiter // 
CREATE PROCEDURE 새학과(
in my학과번호 char(2), 
in my학과명 VARCHAR(20), 
in my전화번호 VARCHAR(20)) 
BEGIN 
INSERT INTO 학과(학과번호 , 학과명 , 전화번호) 
VALUES(my학과번호, my학과명, my전화번호); 
END; 
// delimiter ;

delimiter //
CREATE PROCEDURE 학과_입력_수정(
in my학과번호 char(2), 
in my학과명 VARCHAR(20), 
in my전화번호 VARCHAR(20)) 
BEGIN declare cnt int;
SELECT count(*) into cnt from 학과 where 학과번호 = my학과번호;  
IF (cnt=0) THEN 
INSERT INTO 학과(학과번호 , 학과명 , 전화번호) VALUES(my학과번호, my학과명, my전화번호);
else update 학과 SET 학과명 = my학과명 , 전화번호=my전화번호 where 학과번호=my학과번호;
END IF;
END
// delimiter ;

-- CALL 새학과('08', '컴퓨터보안학과’, ‘022-200-7000');
call db0221.새학과('08', '컴퓨터보안학과', '022-200-7000');

call db0221.학과_입력_수정('08', '컴퓨터보안학과', '022-200-7123');

call db0221.학과_입력_수정('09', '컴퓨터빅데이터학과', '022-201-7123');

call db0221.학과_입력_수정('06', '사물인터넷학과', '022-211-7123');

delimiter // 
CREATE PROCEDURE 통계(
out 교수수  INTEGER,
out 학생수  INTEGER,
out 과목수  INTEGER /*out 출력 매개변수 넣을게 아니라 불러옴으로*/
) 
BEGIN 
select count(이름) into 교수수 from 교수;
select count(이름) into 학생수 from 학생;
select count(과목명) into 과목수 from 과목;
END; 
// delimiter ;

call 통계(@교수수,@학생수,@과목수);
select @교수수 as 교수수 , @학생수 as 학생수, @과목수 as 과목수;
/*변수 영어로 - 오류방지*/

delimiter // 
CREATE PROCEDURE 과목수강자수(
my과목번호 char(8),
out Count integer
) 
BEGIN 
select count(*) into Count from 수강신청내역 where 과목번호 = my과목번호;
END; 
// delimiter ;

call 과목수강자수('K20002',@Count);
select @Count;

delimiter // 
CREATE PROCEDURE 새수강신청(
in p학번 char(7),
out p수강신청번호 INTEGER) 
BEGIN 
select max(수강신청번호) into p수강신청번호 from 수강신청;
set p수강신청번호=p수강신청번호+1;
insert into 수강신청(수강신청번호,학번,날짜,연도,학기) values(p수강신청번호,p학번,curdate(),'2023','1');
END; 
// delimiter ;

call 새수강신청('1804003',@수강신청번호); -- 부모 테이블에 없는것을 넣는것 불가 1804004 안됨(참조무결성)
select @수강신청번호 ;

use db2020;

delimiter // 
CREATE PROCEDURE Interest() 
BEGIN 
DECLARE myInterest INTEGER DEFAULT 0.0; 
DECLARE Price INTEGER; 

DECLARE endOfRow BOOLEAN DEFAULT FALSE; 
DECLARE InterestCursor CURSOR FOR 
SELECT saleprice FROM Orders; 
DECLARE CONTINUE handler 
FOR NOT FOUND SET endOfRow=TRUE; 
OPEN InterestCursor; cursor_loop: LOOP 
FETCH InterestCursor INTO Price; 
IF endOfRow THEN LEAVE cursor_loop; 
END IF; 
IF Price >= 30000 THEN 
SET myInterest = myInterest + Price * 0.1; 
ELSE 
SET myInterest = myInterest + Price * 0.05; 
END IF; 
END LOOP cursor_loop; 
CLOSE InterestCursor; 
SELECT CONCAT(' 전체 이익 금액 = ', myInterest); 
END; 
// delimiter ;

/* Interest 프로시저를 실행하여 판매된 도서에 대한 이익금을 계산 */ 
CALL Interest();

/* madang 계정에서 실습을 위한 Book_log 테이블 생성해준다. */ 
CREATE TABLE Book_log( 
bookid_l INTEGER, 
bookname_l VARCHAR(40), 
publisher_l VARCHAR(40), 
price_l INTEGER);

delimiter // 
CREATE TRIGGER AfterInsertBook 
AFTER INSERT ON Book FOR EACH ROW 
BEGIN 
DECLARE average INTEGER; 
INSERT INTO Book_log 
VALUES(new.bookid, new.bookname, new.publisher, new.price); 
END; 
// delimiter ;

/* 삽입한 내용을 기록하는 트리거 확인 */ 
INSERT INTO Book VALUES(14, '스포츠 과학 1', '이상미디어', 25000); 
SELECT * FROM Book WHERE BOOKID=14; 
SELECT * FROM Book_log WHERE BOOKID_L='14' ; -- 결과 확인

use db0306;

-- 상품 테이블 작성
CREATE TABLE 상품 (
상품코드 VARCHAR(6) NOT NULL PRIMARY KEY,
상품명 VARCHAR(30)  NOT NULL,
제조사 VARCHAR(30)  NOT NULL,
소비자가격 int,
재고수량 int DEFAULT 0
);

-- 입고 테이블 작성
CREATE TABLE 입고 (
입고번호 int PRIMARY KEY,
상품코드 VARCHAR(6) NOT NULL,
입고일자 DATEtime,
입고수량 int,
입고단가 int
);

-- 판매 테이블 작성
CREATE TABLE 판매 (
판매번호 int PRIMARY KEY,
상품코드 VARCHAR(6) NOT NULL,
판매일자 DATEtime,
판매수량 int,
판매단가 int
);

-- 상품 테이블에 자료 추가
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('AAAAAA', '디카', '삼싱', 100000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('BBBBBB', '컴퓨터', '엘디', 1500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('CCCCCC', '모니터', '삼싱', 600000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('DDDDDD', '핸드폰', '다우', 500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
         ('EEEEEE', '프린터', '삼싱', 200000);
COMMIT;
SELECT * FROM 상품;

#===========================================================

/* 상품이 입고되면 입고수량+ > 재고수량 + , 입고.상품코드 = 상품.상품코드
상품이 출고되면 출고수량+ > 재고수량 - , 출고.상품코드 = 상품.상품코드
if 출고수량 <= 재고수량*/

delimiter // 
CREATE TRIGGER 상품입고 
declare 입고수 int;
set 입고수=재고수량+입고수량;
AFTER INSERT ON 상품 FOR EACH ROW 
BEGIN  
INSERT INTO 상품 
VALUES; 
END; 
// delimiter ;

insert into 입고 values (1,'AAAAAA',curdate(),10,50000);
select * from 입고;
select * from 상품;


delimiter // 
CREATE TRIGGER 상품출고 
AFTER INSERT ON 상품 FOR EACH ROW 
BEGIN  
INSERT INTO 상품 
VALUES; 
END; 
// delimiter ;

insert into 출고 values ( , , , , );
select * from 출고;
select * from 상품;
