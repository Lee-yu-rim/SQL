--DDL(데이터 정의어) : table(모든 객체)을 생성, 삭제, 변경하는 명령어
--create(생성) , alter(변경) , drop(삭제)

--1. create : 테이블의 생성
--create table 테이블명(    --table : 객체
--    컬럼명1 타입,          --column : 속성
--    컬럼명2 타입,
--    컬럼명3 타입    
--);

drop table emp_ddl;

create table emp_ddl(
    empno number(4),
    ename varchar2(10),   --byte크기
    job varchar2(9),
    mgr number(4),
    hiredate date,    --date는 크기지정 x
    sal number(7,2),  --전체 7자리 중 두자리는 소수점
    comm number(7,2),
    deptno number(2)
);

select *
from emp_ddl;

insert into emp_ddl
values (9999,'이순신','MANAGER',1111,sysdate,1000,null,10);

--테이블의 복사 : 기존에 존재하는 테이블의 데이터를 가져와서 새로운 테이블을 만드는 것
create table dept_ddl
as
select * from dept;

--테이블의 데이터를 선택해서 일부 데이터만 복사
create table dept_30
as
select * from dept
where deptno = 30;

select *
from dept_30;

create table dept_m
as
select dname,loc
from dept;

--테이블의 데이터를 제외한 구조만 복사
create table dept_d
as
select * from dept
where 1 != 1;

--2. alert : 테이블의 정보 변경 (컬럼의 정보 수정)
--add : 새로운 컬럼 추가
--rename : 컬럼의 이름 변경
--modify : 자료형의 변경
--drop : 컬럼 삭제

create table emp_alter
as
select * from emp;

select *
from emp_alter;

--테이블에 새로운 컬럼 추가
alter table emp_alter
add address varchar2(100);

--컬럼의 이름 변경
alter table emp_alter
rename column address to addr;

--자료형의 변경
alter table emp_alter
modify empno number(10);

--컬럼의 삭제
alter table emp_alter
drop column addr;

drop table emp_alter;

select *
from emp_alter;

--연습문제 1
create table EMP_HW(
    empno number(4),
    ename varchar2(10),
    job varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2)
);

select *
from emp_hw;
    
--연습문제 1-1 
alter table emp_hw
add BIGO varchar2(20);

--연습문제 1-2   
alter table emp_hw
modify BIGO varchar2(30);

--연습문제 1-3
alter table emp_hw
rename column BIGO to remark;

--연습문제 1-4
insert into emp_hw
select empno,ename,job,mgr,hiredate,sal,comm,deptno,NULL 
from emp;

--연습문제 1-5
drop table emp_hw;

--------------------------------------------------------------------------------
--데이터 사전
desc user_tables;  

select table_name
from user_tables; --soctt 계정에서 사용할 수 있는 테이블 정보를 보여줌

select owner,table_name
from all_tables;   --다른 계정의 테이블을 모두 조회

--------------------------------------------------------------------------------
--index : 검색 속도를 향상하기 위해 사용하는 객체
--create(생성) , drop(삭제)
--select 구문의 검색속도를 향상시킨다.
--전체레코드의 3% ~ 5% 정도 일 때
--indext 객체를 컬럼에 생성해서 사용

--create index 인덱스명
--on 테이블명(컬럼명)

drop table emp01;

create table emp01
as
select * from emp;

select *
from emp01;

insert into emp01
select * from emp01;

insert into emp01(empno,ename)
values (1111,'bts');

--index 객체 생성 전 조회 속도(0.032초)
select empno,ename
from emp01
where ename = 'bts';

--index 객체 생성 후 조회 속도(0.001초)
create index idx_emp01_ename
on emp01(ename);

--index 객체 삭제
drop index idx_emp01_ename;

show recyclebin; --휴지통에 버려진 테이블 정보 확인

--테이블 삭제 후 원상복구
flashback table emp_hw
to before drop;

--휴지통 비우기
purge recyclebin;

--------------------------------------------------------------------------------
--제약조건(무결성) : 잘못된 값이 데이터로 사용되는 것을 막는 것
--not null : 반드시 null이 아닌 데이터만 들어가야한다.
--unique : 무결성을 체크 (중복값이 들어갈 수 없다) but, null데이터는 받고 중복될 수 있음
--primary key : 기본키 not null + unique
--foreign key
--check
--제약조건명 설정 : constraint 테이블명_컬럼명_제약조건약어

insert into emp
values (1111,'aaa','MANAGER','9999',sysdate,1000,null,50);
--무결성 제약조건(SCOTT.FK_DEPTNO)이 위배되었습니다- 부모 키가 없습니다

drop table emp02;

create table emp02(
    empno number(4) constraint emp02_empno_pk primary key,  --같은 사번인 사원이 만들어지지 않도록하고, 값이 필수로 들어가게 한다.
    ename varchar2(10) constraint emp02_ename_nn not null,  --사번과 이름이 없는 사원을 만들지 못하도록 제약
    job varchar2(9),
    deptno number(2)
);

insert into emp02
values (null,null,'MANAGER',30);  

insert into emp02
values (1111,'홍길동','MANAGER',30);

insert into emp02
values (2222,'홍길동','MANAGER',30);

insert into emp02
values (null,'김유신','SALESMAN',20);  --NULL을 ("SCOTT"."EMP02"."EMPNO") 안에 삽입할 수 없습니다

insert into emp02
values (2222,'옥동자','SALESMAN',20);  --무결성 제약 조건(SCOTT.SYS_C0011062)에 위배됩니다
                                      --무결성 제약 조건(SCOTT.EMP02_EMPNO_PK)에 위배됩니다
select * from emp02;











