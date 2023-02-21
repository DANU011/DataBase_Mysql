/*출판사가 굿스포츠 또는 대한미디어가 아닌 도서 검색*/
select *
from book
where not (publisher='굿스포츠'or publisher='대한미디어');

/*도서의 이름이 축구의 역사인 도서 검색*/
select bookname, publisher
from book
where bookname like '축구의 역사';
/*where bookname='축구의 역사'; 같은 결과*/

/*도서 이름에 축구가 들어간 도서 검색*/
select bookname, publisher
from book
where bookname like '%축구%';

/*도서의 이름 왼쪽 두번째에 구가 나오는 도서 검색*/
select bookid, bookname, publisher, price
from book
where bookname like '_구%';

/*축구 관련 도서중 20000원 이상인 도서*/
select * /* bookid, bookname, publisher, price */
from book
where bookname like '%축구%' and price >=20000;

/*출판사가 굿스포츠 혹은 대한미디어인 도서*/
select * /* bookid, bookname, publisher, price */
from book
where publisher='굿스포츠'or publisher='대한미디어';

/*도서 이름순 출력*/
select *
from book
order by bookname;

/*도서 가격순 > 같으면 이름순*/
select *
from book
order by price, bookname;

/*도서 가격 내림차순 > 같으면 출판사 오름차순*/
select *
from book
order by price desc, publisher /*asc 생략가능*/;

/*고객이 주문한 도서의 총 판매액 열 이름 총매출로*/
select sum(saleprice) as 총매출
from orders;

/*김연아 고객이 주문한 도서의 총판매액*/
select sum(saleprice) as 김연아총매출
from orders
where custid=2;

/*고객이 주문한 도서의 총 판매액,평균값,최저가,최고가*/
select sum(saleprice) as 총매출,
avg (saleprice) as 총평균,
max(saleprice) as 최고가,
min(saleprice) as 최저가
from orders;

/*도서 판매 건수*/
select count(*) /* count(distinct) > 중복제거 */
from orders;

/*고객별로 주문한 도서의 충 수랑과 충 판매액*/
select custid, count(*) as 도서수량, sum(saleprice) as 총액
from orders
group by custid with rollup /*with rollup 소계출력*/;

/*가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량, 단 두권 이상 구매한 고객*/
select custid, count(*) as 도서수량
from orders
where saleprice >= 8000
group by custid
having count(*)>=2;

/*카티전 프로덕트*/
select *
from customer, orders;

/*고객과 고객의 주문에 관한 데이터를 모두 보이시오*/
select *
from customer, orders
where customer.custid=orders.custid;

/*고객별로 주문한 총액*/

/*고객의 이름과 고객이 주문한 도서의 이름을 구하시오*/
select customer.name, book.bookname
from customer,orders,book 
/*조인 > 테이블명.필드 형식으로 써라.(혼선방지) 컬럼명이 구분되면 안써도 출력은 가능*/
where customer.custid=orders.custid 
and book.bookid=orders.bookid;

/*가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오*/
select customer.name, book.bookname
from customer,orders,book
where customer.custid=orders.custid 
	and orders.bookid=book.bookid 
	and book.price=20000;

/*외부 조인 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오*/
select customer.name,saleprice
from customer left outer join orders on customer.custid=orders.custid;

/*도서를 주문하지 않은 고객만 조회*/
select customer.name
from customer left outer join orders on customer.custid=orders.custid
where saleprice is null;

/*부속질의-서브쿼리*/
select bookname
from book
where price=(select max(price) from book);
/*     2번                   1번*/

/*도서를 구매한적이 있는 고객의 이름*/
select name
from customer
where custid in(select custid from orders);
/*위에거 조인으로*/
select distinct(customer.name)
from customer, orders
where customer.custid=orders.custid;

/*대한미디어에서 출판한 도서를 구매한 고객의 이름*/
select name
from customer
where custid in(select custid
				from orders
				where bookid in (select bookid
								from book
								where publisher='대한미디어'));/*아래부터 순차적으로*/
/*조인*/
select customer.name
from customer, orders, book
where  customer.custid=orders.custid 
	and book.bookid=orders.bookid 
	and book.publisher='대한미디어';

/*집합연산 합집합union 차집합minus 교집합intersect
대한민국에서 거주하는 고객의 이름과 도서를 주문한 고객의 이름을 보이시오.*/
select name
from customer
where address like '대한민국%'
union
select name
from customer
where custid in (select custid from orders);

/*대한민국에서 거주하는 고객에서 도서를 주문한 이름을 빼라*/
select name
from customer
where address like '대한민국%' and 
	name not in(select name
				from customer
				where custid in (select custid 
								from orders));

/*대한민국, 도서주문*/
select name
from customer
where address like '대한민국%' and 
	name in(select name
			from customer
			where custid in (select custid 
							from orders));
                            
/*상관 중첩 쿼리(상관부속질의 or 중첩 같은 릴레이션, 상위하위부속 질의가 독립적이지 않음.)
상위를 가져와서 맵핑*/




