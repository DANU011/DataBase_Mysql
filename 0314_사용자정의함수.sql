use db2020;

/*사용자 정의 함수
n 사용자 정의 함수는 수학의 함수와 마찬가지로 입력된 값을 가공하여 결과 값을 되돌려줌
예제 5-6 판매된 도서에 대한 이익을 계산하는 함수 */

-- SET GLOBAL log_bin_trust_function_creators = 1; -- 1418오류

delimiter // 
CREATE FUNCTION fnc_Interest(price INTEGER) RETURNS INT 
 BEGIN 
 DECLARE myInterest INTEGER; 
 -- 가격이 30,000원 이상이면 10%, 30,000원 미만이면 5% 
 IF price >= 30000 THEN SET myInterest = price * 0.1; 
 ELSE SET myInterest := price * 0.05; 
 END IF; 
 RETURN myInterest; 
 END; 
 // delimiter ;
 
 /* Orders 테이블에서 각 주문에 대한 이익을 출력 */ 
 SELECT custid, orderid, saleprice, fnc_Interest(saleprice) interest 
 FROM Orders;


/* (8) 고객의 주문 총액을 계산하여 20,000원 이상이면 '우수', 20,000원 미만이면 '보통'을 반환하는 
함수 Grade()를 작성하시오. Grade()를 호출하여 고객의 이름과 등급을 보이는 SQL 문도 작성하시오. */

DROP FUNCTION if exists Grade;
delimiter // 
CREATE FUNCTION Grade(cid INT) 
	RETURNS varchar(40) 
 BEGIN 
 DECLARE total int;
 select sum(saleprice) into total from orders where custid=cid;
 -- 고객의 주문 총액을 계산하여 20,000원 이상이면 '우수', 20,000원 미만이면 '보통'을 반환 
 IF total >= 20000 THEN 
	return '우수'; 
 ELSE 
	return '보통'; 
 END IF; 
 END; 
 // delimiter ;
 
 
 
SELECT name, grade(custid) as total from customer;
 
 
