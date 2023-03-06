use employees;

-- 테이블의 색인 정보를 확인
show index from dept_emp;

-- 테이블과 관련된 정보를 조회
show table status like 'dept_emp';

-- 'index_length' 열은 기본키를 제외한 색인을 저장하는 페이지 수에 페이지 크기를 곱한 결과로 바이트 수이다

-- 'dept_emp'테이블에 설정된 색인을 삭제
-- 외래키 설정과 'dept_emp' 열에 설정된 색인만 삭제
alter table dept_emp drop foreign key dept_emp_ibfk_1;
alter table dept_emp drop foreign key dept_emp_ibfk_2;
drop index dept_no on  dept_emp;

analyze table dept_emp;
show index from dept_emp;

alter table dept_emp drop primary key;

analyze table dept_emp;
show index from dept_emp;

-- 마지막행 데이터 조회
select * from dept_emp order by emp_no DESC limit 1;

-- 첫행과 마지막행의 실행 계획의 결과? full scan
select count(*) from dept_emp;
explain select * from dept_emp where emp_no = 10001;
explain select * from dept_emp where emp_no = 499999;

alter table dept_emp add primary key (emo_no, dept_no);

-- 색인 데이터 검색 속도 최소화

/* alter table dept_emp drop primary key;
alter table dept_emp drop index `dept_emp`;
alter table dept_emp drop index `from_data`;
analyze table employees, dept_emp; */


explain select a.amp_no, b.frist_name, b.last_name
from dept_emp a inner join employees b
on a.emp_no = b.emp_no;

explain select a.amp_no, b.frist_name, b.last_name
from dept_emp a inner join employees b
on a.emp_no = b.emp_no
where a.emp_no = 10001;











