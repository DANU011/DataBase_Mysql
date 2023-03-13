use db0309;
-- 견적서

CREATE TABLE 공급자 (

	등록번호 VARCHAR(15) NOT NULL,

	상호 VARCHAR(45) NOT NULL,

	대표성명 VARCHAR(45),

	사업장주소 VARCHAR(45),

	업태 VARCHAR(45),

	종목 VARCHAR(45),

	전화번호 VARCHAR(13),

	PRIMARY KEY (등록번호)

  );

  

  CREATE TABLE 제품 (

	제품번호 VARCHAR(45) NOT NULL,

	품명 VARCHAR(45)	NOT NULL,

	규격 VARCHAR(45),

	단가 INT,

	PRIMARY KEY (제품번호)

  );

  

  CREATE TABLE IF NOT EXISTS 견적서 (

	견적번호 VARCHAR(45) NOT NULL,

	견적일 DATE,

	접수자 VARCHAR(10),

	담당 VARCHAR(10),

	공급가액 INT,

	비고 VARCHAR(45),

    공급자 VARCHAR(15) NOT NULL,

	PRIMARY KEY (견적번호),

    FOREIGN KEY (공급자) REFERENCES 공급자 (등록번호)

);



CREATE TABLE IF NOT EXISTS 견적세부내용 (

	일련번호 INT NOT NULL AUTO_INCREMENT,

	수량 INT,

	합계 INT,

	제품 VARCHAR(45),

	견적번호 VARCHAR(45),

	PRIMARY KEY (일련번호),

	FOREIGN KEY (제품) REFERENCES 제품 (제품번호),

    FOREIGN KEY (견적번호) REFERENCES 견적서 (견적번호)

);



INSERT INTO 공급자 VALUES('123-456-789', '부산가구', '김가구', '부산시 금정구', '제조업', '가구제조', '051-111-1111');

INSERT INTO 견적서 (견적번호, 견적일, 접수자, 담당, 공급가액, 비고, 공급자) VALUES ('3',curdate(), '김접수', '김담당', 5000, '', '123-456-789');

INSERT INTO 제품 (제품번호, 품명, 규격, 단가) VALUES ('1','스툴', '1a2a3a', 4000);

INSERT INTO 견적세부내용 (수량, 합계, 제품, 견적번호) VALUES (5, 20000, '1', '3');	
