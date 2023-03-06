use db2020; 
delimiter // -- '를 /로 
CREATE PROCEDURE InsertBook(
 IN myBookID INTEGER,
 IN myBookName VARCHAR(40),
 IN myPublisher VARCHAR(40),
 IN myPrice INTEGER) 
 BEGIN
 INSERT INTO Book(bookid, bookname, publisher, price) -- *** 
 VALUES(myBookID, myBookName, myPublisher, myPrice);  -- ***
 END; 
 // 
 delimiter ; -- /를 다시 '로 에러 방지용
 
 
 /* 프로시저 InsertBook을 테스트하는 부분 */ 
 CALL InsertBook(13, '스포츠과학', '마당과학서적', 25000); 
 SELECT * FROM Book;
