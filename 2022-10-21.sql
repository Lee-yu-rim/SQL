-- DML(데이터 조작어)
-- insert : 테이블 데이터 삽입
--    ```
--    insert into 테이블명 (컬럼명 1, 컬럼명 2......)
--    values (값1, 값2,.......)
--    ```
--    컬럼과 값의 타입과 갯수가 일치해야한다(1:1)
--    작성 순서대로 1:1 매칭된다.

-- update
-- delete

-- 테이블 생성
create table dept_temp
as 
select * from dept;

--삭제하고 싶을 때에는 
drop table dept_temp;

--만들어진 테이블 조회. dept의 값을 그대로 가져와서 새로운 테이블 생성함.
select *
from dept_temp;

insert into dept_temp(deptno,dname,loc) 
values (50,'DATABASE','SEOUL');

insert into dept_temp --컬럼 생략함
values (70,'HTML','SEOUL');

insert into dept_temp --컬럼 생략함, 명시적 Null 데이터 삽입이 가능하다.
values (80,NULL,'SEOUL');

insert into dept_temp (deptno,dname) -- 묵시적 null 데이터 삽입
values(60,'JSP');

-------------------------------------------------------------------

--컬럼의 구조만 동일하게 가져옴.
create table emp_temp 
as 
select * from emp
where 1 != 1;

drop table emp_temp;

select *
from emp_temp;

insert into emp_temp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(9999,'홍길동','PRESIDENT',NULL,'2001/01/01',5000,1000,10);

insert into emp_temp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(3111,'심청이','MANAGER',9999,sysdate,4000,null,30);

-- update : 컬럼의 데이터를 변경(수정)
-- update 테이블명
-- set 컬럼명 = 값, 컬럼명 = 값, .... ,
-- where 조건식(필요에 따라서 사용)
-- 조건절을 사용하지 않으면 해당 컬럼이 모두 변경된다.

create table dept_temp2
as 
select * from dept;

drop table dept_temp2;

select * 
from dept_temp2;

update dept_temp2
set loc = 'SEOUL';

update dept_temp2
set dname = 'DATABASE',loc = 'SEOUL'
where deptno = 40;

-- delete(데이터삭제)
-- delete from 테이블명
-- where 조건식 
-- 조건절을 사용하지 않으면 모든 데이터가 삭제된다.

create table emp_temp2
as 
select * from emp;

drop table emp_temp2;

select * 
from emp_temp2;

delete from emp_temp2
where ename = 'SCOTT';


--------------------------------------------------------------------------------
-- TCL(데이터의 영구저장 또는 취소)
-- 트랜젝션
-- commit, rollback, savepoint
-- commit : 데이터 영구 저장(테이블의 데이터 반영)
--          create 구문을 사용해서 객체를 생성할 때 자동으로 commit 이 발생한다.
-- rollback : 데이터 변경 취소(테이블의 데이터 미 반영) 원상복귀
-- savepoint : 


create table dept01 
as 
select * from dept;

drop table dept01;

commit; -- 테이블을 지우고 나서는 롤백이 불가능
rollback;

select * 
from dept01;


------------- 
-- 데이터 삭제
-- 트랜잭션 적용 유무
    -- delete : 롤백 가능
    -- truncate : 롤백이 불가능
delete from dept01;
rollback;

truncate table dept01;

--DDL(데이터정의어) : table(모든 객체)을 생성 삭제 변경하는 명령어.
-- create 생성 
-- alter 변경
-- drop 삭제

create table 테이블명( --table 객체
    컬럼명1 타입,    --column 속성
    컬럼명2 타입,
    컬럼명3 타입
);

create table emp_DDL(
    --사번 ,이름, 직책, 관리자, 입사일자, 급여, 성과금, 부서번호
    empno number(4),
    ename varchar2(10), --byte 크기가 10
    job varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2)
);

select * from emp_DDL;

insert into emp_DDL
values (9999,'이순신','MANAGER',1111,sysdate,1000,NULL,10);

create table dept_ddl --테이블의 복사
as 
select * from dept;

create table dept_30 --테이블의 복사
as 
select * from dept
where deptno = 30;

create table dept_m
as
select dname,loc
from dept;

select * from dept_m;

create table dept_d
as
select * from dept
where 1 != 1; -- 이 while문의 의미는 테이블의 구조만 복사해오겠다는 의미

-- 테이블 변경(컬럼의 정보를 수정)
-- 새로운 컬럼추가, 컬럼의 이름변경, 자료형의 변경, 컬럼을 삭제
-- alter : add,rename,modify, drop
create table emp_alter
as
select * from emp;

select * from emp_alter;

alter table emp_alter
add address varchar2(100);

alter table emp_alter
rename column address to addr;

alter table emp_alter
modify empno number(10);

alter table emp_alter
drop column addr;
------------------------

--연습문제 324p
select * from EMP_HW;
--1번
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

--2번
alter table EMP_HW
add BIGO varchar2(20);

--3번
alter table EMP_HW
modify BIGO varchar(30);

--4번
alter table EMP_HW
rename column BIGO to REMARK;

--5번
insert into EMP_HW(empno, ename, job, mgr, hiredate, sal, comm, deptno, remark)
select empno, ename,job,mgr, hiredate, sal, comm, deptno ,null from emp;

--6번
drop table EMP_HW;

--------------------------------------------------------------------------------
--데이터사전
desc user_tables;

select table_name
from user_tables;

select owner , table_name
from all_tables;

-- index 검색속도를 향상하기 위해 사용하는 객체
-- create(생성), drop(삭제)
-- select 구문의 검색 속도를 향상시킨다
-- 전체 레코드의 3%~ 5%정도일때 index객체를 컬럼에 생성해서 사용한다.

create index 인덱스명
on 테이블명(컬럼명);

create table emp01
as
select * from emp;

drop table emp;
select * from emp01;

insert into emp01
select * from emp01;

insert into emp01(empno,ename)
values (1111,'bts');

select empno, ename
from emp01
where ename = 'bts';

create index idx_emp01_ename
on emp01(ename);

select empno, ename
from emp01
where ename = 'bts';

drop index idx_emp01_ename;

--테이블 삭제후 원상복귀
-- show recyclebin;
-- flashback table emp_temp
-- to BEFORE drop;
show recyclebin;
flashback table emp_temp
to BEFORE drop;

purge recyclebin;

--제약조건(무결성) : 잘못된 값이 데이터로 사용되는 것을 못하게 하는 것
-- - not null : 지정한 열에 NULL을 허용하지 않는다. NULL을 제외한 데이터의 중복은 허용.
-- - unique : 지정한 열이 유일한 값을 가져야 한다. 즉 중복될 수 없다. 단 NULL은 값의 중복에서 제외된다.
-- - primary key : 지정한 열이 유일한 값이면서 NULL을 허용하지 않는다. PRIMARY KEY는 테이블에 하나만 지정 가능하다.
-- - foreign key : 다른 테이블의 열을 참조하여 존재하는 값만 입력할 수 있다.
-- - check : 설정한 조건식을 만족하는 데이터만 입력 가능하다.

-- emp dept
insert into emp
values (1111,'aaa','MANAGER',9999,sysdate,1000,NULL,50);

drop table emp02;
create table emp02(
    empno number(4) constraint emp02_empno_pk primary key,--unique는 null은 허용해줌...
    ename varchar2(10) constraint emp02_empno_ename_nn not null,
    job varchar2(9),
    deptno number(2)
);
select * from emp02;

insert into emp02
values (null, null, 'MANAGER', 30);

insert into emp02
values (1111, '홍길동', 'MANAGER', 30);

insert into emp02
values (2222, '홍길동', 'MANAGER', 30);

insert into emp02
values (1111, '이순신', 'MANAGER', 20);

insert into emp02
values (null, '김유신', 'SALESMAN', 20);

delete from emp02;