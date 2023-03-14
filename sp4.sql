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