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