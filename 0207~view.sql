/*질의 4-3   고객별 평균 주문 금액을 백 원 단위로 반올림한 값을 구하시오.*/ 
SELECT custid ‘고객번호’, ROUND(SUM(saleprice)/COUNT(*), -2) ‘평균금액’ 
FROM Orders 
GROUP BY custid;
/*GROUP BY
 "중복되지 않은 정보를 보여주는 것"*/

SELECT bookid, REPLACE(bookname, '야구', '배구') bookname, publisher, price 
FROM Book;/*야구>배구 실제로 바뀌는건 아니고 출력만*/

select bookname, char_length(bookname) '문자수'
from book
where publisher='굿스포츠';

/*질의 4-5   굿스포츠에서 출판한 도서의 제목과 제목의 글자 수를 확인하시오. (한글은 2바이트 혹은 UNICODE 경우는 3바이트를 차지함) */
SELECT bookname ‘제목’, CHAR_LENGTH(bookname) ‘문자수’, LENGTH(bookname) ‘바이트수’ 
FROM Book 
WHERE publisher='굿스포츠';

/*SUBSTR : 지정한 길이만큼의 문자열을 반환하는 함수
질의 4-6   마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오. */
SELECT SUBSTR(name, 1, 1) ‘성’, COUNT(*) ‘인원’ 
FROM Customer 
GROUP BY SUBSTR(name, 1, 1);
/*SUBSTR(s,n,k)
대상 문자열의 지정된 자리에서부터 지정된 길이만큼 잘라서 반환 SUBSTR('ABCDEFG', 3, 4) => 'CDEF'
*/

/*질의 4-7   마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오. */
select orderid'주문번호', orderdate'주문일', adddate(orderdate, interval 10 day) '확정'
from orders;

/*질의 4-8   마당서점이 2014년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 
단, 주문일은 '%Y-%m-%d' 형태로 표시한다. */
select orderid, str_to_date(orderdate,'%Y-%m-%d'), custid, bookid
from orders
where orderdate=date_format('20140707','%Y-%m-%d');

/* SYSDATE : MySQL의 현재 날짜와 시간을 반환하는 함수
질의 4-9   DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오. 
>>> 시스템의 시간을 불러와서 내가 원하는 방식으로 출력하는것이 가능함.*/
SELECT SYSDATE(), DATE_FORMAT(SYSDATE(), '%Y/%m/%d %M %h:%s') 'SYSDATE_1'; 

/*질의 4-10   이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 ‘연락처없음’으로 표시한다.*/
select name, ifnull(phone, '연락처없음')/*ifnull - null이라면 대체값 주기*/
from customer;

/*질의 4-11   고객 목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오. */
SET @seq:=0; 
SELECT (@seq:=@seq+1) '순번', custid, name, phone 
FROM Customer 
WHERE @seq < 2; /* 오류있음. */

/*질의 4-12   마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액을 출력).*/
SELECT (SELECT name 
		FROM Customer cs 
		WHERE cs.custid=od.custid ) ‘name’, SUM(saleprice) ‘total’ 
FROM Orders od 
GROUP BY od.custid;

/*join*/
select cs.name, sum(od.saleprice)
from customer cs, orders od
where cs.custid=od.custid
GROUP BY od.custid;

select cs.custid, sum(saleprice)
from customer cs, orders od
where cs.custid=od.custid
GROUP BY od.custid;

/*질의 4-14   고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력).*/
select cs.name, sum(od.saleprice)
from (select custid, name
		from customer
        where custid <=2) cs,
        orders od
where cs.custid=od.custid
group by cs.name;

/*>>> 성능상 더 좋을 뿐 굳이 서브쿼리 사용할  필요 없음. 자기가 더 편한거 쓰면됨.*/

/*질의 4-15   평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.*/
select orderid, saleprice
from orders
where saleprice <=(select agv(saleprice)
					from orders);

/*질의 4-16   각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오.*/
SELECT orderid, custid, saleprice 
FROM Orders od 
WHERE saleprice > (SELECT AVG(saleprice) 
					FROM Orders so 
					WHERE od.custid=so.custid);

/*질의 4-17   대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.*/
SELECT SUM(saleprice) ‘total’ 
FROM Orders 
WHERE custid IN (SELECT   custid 
					FROM    Customer
					 WHERE   address LIKE '%대한민국%');
                     
					SELECT   custid 
					FROM    Customer
					 WHERE   address LIKE '%대한민국%';

/*질의 4-18   3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번 호와 금액을 보이시오.*/
SELECT orderid, saleprice 
FROM Orders 
WHERE saleprice > ALL (SELECT  saleprice 
						FROM   Orders 
						WHERE custid='3');/*서브쿼리의 조건 모두(all)보다 큰 saleprice값*/
                    
SELECT  saleprice FROM   Orders WHERE custid='3';
SELECT  saleprice FROM   Orders;

/*질의 4-19   EXISTS 연산자로 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구 하시오.*/
select sum(saleprice)
from orders od
where exists (select * 
				from customer cs 
				where address like '%대한민국%' and cs.custid=od.custid);
                
select * from customer cs, orders od where address like '%대한민국%' and cs.custid=od.custid;


CREATE VIEW    vw_Book AS SELECT * FROM Book WHERE bookname LIKE '%축구%'; /*book이라는 릴레이션에서 축구가 포함되는 것만 보여줌*/

/*질의 4-21   Orders 테이블에 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, 
‘김 연아’ 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.*/
CREATE VIEW  vw_Orders (orderid, custid, name, bookid, bookname, saleprice, orderdate) 
AS SELECT od.orderid, od.custid, cs.name, od.bookid, bk.bookname, od.saleprice, od.orderdate 
FROM Orders od, Customer cs, Book bk 
WHERE od.custid =cs.custid AND od.bookid =bk.bookid;

SELECT orderid, bookname, saleprice FROM vw_Orders WHERE name='김연아'; 

/*질의 4-22   [질의 4-20]에서 생성한 뷰 vw_Customer는 주소가 대한민국인 고객을 보여준다. 
이 뷰를 영국을 주소로 가진 고객으로 변경하시오. phone 속성은 필요 없으므로 포함시키지 마 시오.*/
CREATE VIEW vw_Customer 
AS SELECT * 
FROM  Customer 
WHERE address LIKE '%대한민국%';

SELECT * FROM vw_Customer;

CREATE OR REPLACE VIEW vw_Customer (custid, name, address) 
AS SELECT custid, name, address 
FROM Customer 
WHERE address LIKE '%영국%';

SELECT * FROM vw_Customer;

/*테이블은 근본적으로 쉽게 수정하지 않음 */

















