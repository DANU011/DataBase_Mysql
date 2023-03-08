use db0308;
DROP TABLE IF EXISTS Summer; /* 기존 테이블이 있으면 삭제 */
CREATE TABLE Summer ( sid INTEGER, class VARCHAR(20), price INTEGER );
INSERT INTO Summer VALUES (100, 'FORTRAN', 20000); 
INSERT INTO Summer VALUES (150, 'PASCAL', 15000); 
INSERT INTO Summer VALUES (200, 'C', 10000); 
INSERT INTO Summer VALUES (250, 'FORTRAN', 20000);
/* 생성된 Summer 테이블 확인 */ SELECT * FROM   Summer;


SELECT sid, class FROM  Summer;

SELECT price FROM  Summer WHERE class=‘C’;

SELECT DISTINCT class FROM  Summer WHERE price = (SELECT max(price) FROM Summer);

SELECT COUNT(*), SUM(price) FROM  Summer;

-- 잘못 설계된 계절학기 수강 테이블
-- 질의 7-1   200번 학생의 계절학기 수강신청을 취소하시오.
-- 삭제이상
/* C 강좌 수강료 조회 */ SELECT price "C 수강료" FROM Summer WHERE class='C';
/* 200번 학생의 수강신청 취소 */ DELETE FROM  Summer WHERE  sid=200;
/* C 강좌 수강료 다시 조회 => C 수강료 조회 불가능!!  */SELECT price "C 수강료" FROM Summer WHERE class='C';
/* 다음 실습을 위해 200번 학생 자료 다시 입력 */ INSERT INTO Summer VALUES (200, 'C', 10000);

-- 질의 7-2   계절학기에 새로운 자바 강좌를 개설하시오. 
-- 삽입이상
/* 자바 강좌 삽입  => NULL을 삽입해야 한다. NULL 값은 문제가 있을 수 있다. */
INSERT INTO Summer VALUES (NULL, 'JAVA', 25000);
/* Summer 테이블 조회 */ SELECT * FROM Summer;
/* NULL 값이 있는 경우 주의할 질의 : 투플은 다섯 개지만 수강학생은 총 네 명임 */ 
SELECT COUNT(*) "수강인원" FROM Summer;
SELECT COUNT(sid) "수강인원" FROM Summer;
SELECT count(*) "수강인원" FROM Summer WHERE sid IS NOT NULL;

-- 질의 7-3   FORTRAN 강좌의 수강료를 20,000원에서 15,000원으로 수정하시오.
-- 수정이상
/* FORTRAN 강좌 수강료 수정 */ 
UPDATE Summer SET price=15000 WHERE class='FORTRAN';
SELECT * FROM Summer;
SELECT DISTINCT price "FORTRAN 수강료" FROM Summer WHERE class='FORTRAN';
/* 다음 실습을 위해 FORTRAN 강좌의 수강료를 다시 20,000원으로 복구 */ 
UPDATE Summer SET price=20000 WHERE class='FORTRAN';
/* 만약 UPDATE 문을 다음과 같이 작성하면 데이터 불일치 문제가 발생함 */ 
UPDATE Summer SET price=15000 WHERE class='FORTRAN' AND sid=100;


/* Summer 테이블을 조회하면 FORTRAN 강좌의 수강료가 한 건만 수정되었음 */ 
SELECT * FROM Summer;
/* FORTRAN 수강료를 조회하면 두 건이 나옴(데이터 불일치 문제 발생) */ 
SELECT price "FORTRAN 수강료" FROM Summer WHERE class='FORTRAN';
/* 다음 실습을 위해 FORTRAN 강좌의 수강료를 다시 20,000원으로 복구 */ 
UPDATE Summer SET price=20000 WHERE class='FORTRAN';
/* 다음 실습을 위해 sid가 NULL인 투플 삭제 */ 
DELETE FROM   Summer WHERE   sid IS NULL;

-- SummerPrice 테이블과 SummerEnroll 테이블을 생성하는 SQL 문
/* 기존 테이블이 있으면 삭제하고 새로 생성하기 위한 준비 */ 
DROP TABLE SummerPrice; DROP TABLE SummerEnroll;
/* SummerPrice 테이블 생성 */ 
CREATE TABLE SummerPrice (   class VARCHAR(20), price int );
INSERT INTO SummerPrice VALUES ('FORTRAN', 20000); 
INSERT INTO SummerPrice VALUES ('PASCAL', 15000); 
INSERT INTO SummerPrice VALUES ('C', 10000);
SELECT * FROM SummerPrice;
/* SummerEnroll 테이블 생성 */ 
CREATE TABLE SummerEnroll (   sid int, class VARCHAR(20) );
INSERT INTO SummerEnroll VALUES (100, 'FORTRAN'); 
INSERT INTO SummerEnroll VALUES (150, 'PASCAL'); 
INSERT INTO SummerEnroll VALUES (200, 'C'); 
INSERT INTO SummerEnroll VALUES (250, 'FORTRAN');
SELECT * FROM SummerEnroll;

-- 표 7-2 SummerPrice 테이블과 SummerEnroll 테이블을 이용하여 처리하는 질의와 SQL 문
-- 계절학기를 듣는 학생의 학번과 수강하는 과목은?
SELECT sid, class FROM  SummerEnroll;
-- C 강좌의 수강료는?
SELECT price FROM  SummerPrice WHERE class=‘C’;
-- 수강료가 가장 비싼 과목은?
SELECT DISTINCT class 
FROM  SummerPrice 
WHERE price = (SELECT max(price) 
				FROM SummerPrice);
-- 계절학기를 듣는 학생 수와 수강료 총액은?
SELECT COUNT(*), SUM(price) 
FROM    SummerPrice, SummerEnroll 
WHERE  SummerPrice.class=SummerEnroll.class;





