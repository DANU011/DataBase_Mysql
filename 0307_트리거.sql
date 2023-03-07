use db0307;

-- 상품 테이블 작성
CREATE TABLE 상품 (상품코드 VARCHAR(6) NOT NULL PRIMARY KEY, 상품명 VARCHAR(30)  NOT NULL, 제조사 VARCHAR(30) NOT NULL, 소비자가격  INT, 재고수량  INT DEFAULT 0);

-- 입고 테이블 작성
CREATE TABLE 입고 (입고번호 INT PRIMARY KEY, 상품코드 VARCHAR(6) NOT NULL REFERENCES 상품(상품코드), 입고일자 DATE,입고수량 INT,입고단가 INT);

-- 판매 테이블 작성
CREATE TABLE 판매 (판매번호 INT  PRIMARY KEY,상품코드  VARCHAR(6) NOT NULL REFERENCES 상품(상품코드), 판매일자 DATE,판매수량 INT,판매단가 INT);

-- 상품 테이블에 자료 추가
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('AAAAAA', '디카', '삼싱', 100000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('BBBBBB', '컴퓨터', '엘디', 1500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('CCCCCC', '모니터', '삼싱', 600000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('DDDDDD', '핸드폰', '다우', 500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES ('EEEEEE', '프린터', '삼싱', 200000);

-- [입고] 테이블에 상품이 입고되면 [상품] 테이블에 상품의 재고수량이 수정되는 트리거 / 트리거명:afterInsert입고
delimiter // 
CREATE TRIGGER AfterInsert입고
AFTER INSERT ON 입고 FOR EACH ROW 
BEGIN 
update 상품 
set 재고수량 = 재고수량 + new.입고수량
where 상품코드=new.상품코드; 
END; 
// delimiter ;

INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) 
VALUES (1, 'AAAAAA', '2004-10-10', 5,   50000);

/*delimiter // 
CREATE TRIGGER AfterInsert입고
AFTER INSERT ON 붙는 테이블 FOR EACH ROW 
BEGIN 
(up in del..) INTO 상품 

END; 
// delimiter ;*/

-- [입고] 테이블에 상품이 수정되면 [상품] 테이블에 상품의 재고수량이 수정되는 트리거 / 트리거명:afterUpdate입고
delimiter // 
CREATE TRIGGER AfterUpdate입고
AFTER update ON 입고 FOR EACH ROW 
BEGIN 
update 상품 
set 재고수량 = 재고수량-old.입고수량+new.입고수량
where 상품코드=new.상품코드; 
END; 
// delimiter ;

update 입고 set 입고수량=30 where 입고번호=1;
update 입고 set 입고수량=25 where 입고번호=1;

-- [입고] 테이블에 상품이 삭제(취소)하면 [상품] 테이블에서 재고수량을 수정하는 트리거 / 트리거명:afterDelete입고
delimiter // 
CREATE TRIGGER AfterDelete입고
AFTER delete ON 입고 FOR EACH ROW 
BEGIN 
update 상품 
set 재고수량 = 재고수량 - old.입고수량
where 상품코드=old.상품코드; 
END; 
// delimiter ;
-- [판매] 테이블에 자료가 추가되면 [상품] 테이블에 상품의 재고수량이 변경되는 트리거 / 트리거명:beforInsert판매

delimiter // 
CREATE TRIGGER beforInsert판매
before INSERT ON 판매 FOR EACH ROW 
BEGIN 
declare stock int;
select 재고수량 into stock from 상품 where 삼품코드 = new.상품코드;
if stock >= NEW.판매수량 then
     update 상품
     set 재고수량 = stock-NEW.판매수량
     where 상품코드 =NEW.상품코드;
    else
     signal sqlstate '45000' set message_text = '재고수량 부족으로 판매 불가';
    end if;
END; 
// delimiter ;
-- 입고 테이블에 자료 추가 테스트

INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (2, 'BBBBBB', '2004-10-10', 15, 700000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (3, 'AAAAAA', '2004-10-11', 15, 52000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (4, 'CCCCCC', '2004-10-14', 15,  250000);
INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가) VALUES (5, 'BBBBBB', '2004-10-16', 25, 700000);



