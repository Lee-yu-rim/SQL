
--제약조건(무결성) : 잘못된 값이 데이터로 사용되는 것을 못하게 하는 것
-- - not null : 지정한 열에 NULL을 허용하지 않는다. NULL을 제외한 데이터의 중복은 허용.
-- - unique : 지정한 열이 유일한 값을 가져야 한다. 즉 중복될 수 없다. 단 NULL은 값의 중복에서 제외된다.
-- - primary key(기본키) : 지정한 열이 유일한 값이면서 NULL을 허용하지 않는다. PRIMARY KEY는 테이블에 하나만 지정 가능하다.
-- - foreign key(외래키,참조키) : 다른 테이블의 열을 참조하여 존재하는 값만 입력할 수 있다.
    -- 1. 부모와 자식의 관계를 가지는 자식쪽 테이블에 컬럼을 설정한다.
    -- 2. 부모쪽 테이블의 컬럼은 반드시 primary key 또는 unique해야한다.
    -- 3. null 데이터를 허용합니다.
-- - check : 설정한 조건식을 만족하는 데이터만 입력 가능하다.
-- - default :

--------------------------------------------------------------------------------

--foreign key 예시

--create table dept07(
--    deptno NUMBER(2) constraint emp07_deptno_pk primary key,
--    dname varchar2(20) constraint dept07_dname_nn not null,
--    loc varchar2(20) constraint dept07_loc_nn not null
--);
--create table emp07(
--    empno number(4) constraint emp07_empno_pk primary key,
--    ename varchar2(9) constraint emp07_empno_nn not null,
--    job varchar2(9),
--    deptno number(2) constraint emp07_empno_fk references dept07(deptno)
--);
--
--drop table dept07;
--drop table emp07;
--select * from dept07;
--select * from emp07;
--
---- 서브쿼리문을 사용한 데이터 삽입
--insert into dept07
--select * from dept;
--
--insert into emp07
--select empno, ename, job, deptno from emp;
--
--insert into emp07
--values(1111,'aaa',"MANAGER',50);

-----------------------------------------------------------------------
-- check 예시
drop table emp08;

create table emp08(
    empno number(4) primary key,
    ename varchar2(10) not null, 
    sal number(7) constraint emp08_sal_ck check(sal between 500 and 5000),
    gender varchar2(2) constraint emp08_gender_ck check(gender in('M','F')) -- M 또는 F만 값으로 들어올수있음
);

select * from emp08;

insert into emp08
values(1111,'hong',1000,'M');

insert into emp08
values(2222,'hong',200,'M');

insert into emp08
values(2222,'hong',2000,'A');

--------------------------------------------------------------------------------
-- default 예시
drop table dept09;

create table dept09(
    deptno number(2) primary key,
    dname varchar2(10) not null,
    loc varchar2(15) default 'SEOUL' -- 이 컬럼에 값을 넣지 않으면 기본값으로 null이 아니라 seoul이 들어간다.
);

insert into dept09(deptno,dname,loc)
values (20,'SALES','BUSAN');

select * from dept09;

-- 제약조건 설정 방식
-- 컬럼레벨의 설정(not null은 컬럼 레벨에서만 사용가능)
-- 테이블 레벨의 설정(not null을 적용할수 없다.)

create table emp09(
    empno number(4),
    ename varchar2(20) constraint emp09_ename_nn not null,
    job varchar2(20),
    deptno number(20),
    
    constraint emp09_empno_pk primary key(empno),
    constraint emp09_job_uk unique(job),
    constraint emp09_deptno_fk foreign key(deptno) references dept(deptno)
);

insert into emp09
values(3333,'hong','PRESIDENT',80);

-- 복합키( 기본키를 두개의 컬럼을 사용하는 경우)
-- 테이블 레벨 방식으로만 적용 가능
    -- 1. 테이블 안에서 정의하는 방식
    -- 2. alter명령어 사용하는 방식

create table member(
    name varchar2(10),
    address varchar2(30),
    hphone varchar2(10),
    
    constraint member_name_address_pk primary key(name,address)
);

create table emp10( 
    empno number(4),
    ename varchar2(20),
    job varchar2(20),
    deptno number(20)
);

alter table emp10
add constraint emp10_empno_pk primary key(empno); --컬럼에 제약조건 추가

alter table emp10
add constraint emp10_empno_fk foreign key(deptno) references dept(deptno);

-- not null은 변경의 개념(null을 not null로 바꾸는것) 그래서 modify를 사용
alter table emp10
modify job constraint emp10_job_nn not null;

alter table emp10
modify ename constraint emp10_ename_nn not null;

alter table emp10
drop constraint emp10_empno_pk;--제약조건명(constraint) 또는 제약조건(primary key)

--------------------------------------------------------------------------------

create table emp11( 
    empno number(4),
    ename varchar2(20),
    job varchar2(20),
    deptno number(20)
);

alter table emp11
add constraint emp11_empno_pk primary key(empno);

alter table emp11
add constraint emp11_empno_fk foreign key(deptno) references dept11(deptno);

create table dept11(
    deptno number(2),
    dname varchar2(10),
    loc varchar2(15)
);

alter table dept11
add constraint dept11_deptno_pk primary key(deptno);

insert into dept11
select * from dept;

insert into emp11
select empno, ename, job, deptno
from emp;

delete from dept11
where deptno = 10;

alter table dept11 
disable primary key cascade;

alter table dept11 
drop primary key cascade; --제약조건까지 지움                                       


-------------------------------------------------------------------------------
--문제풀기 ㅔ 394

--1. alter 사용
create table dept_const(
    deptno number(2),
    dname varchar2(14),
    loc varchar2(13)
);

alter table dept_const 
add constraint deptconst_deptno_pk primary key(deptno);

alter table dept_const 
add constraint deptconst_dname_unq unique(dname);

alter table dept_const 
modify loc constraint deptconst_loc_nn not null;

--2

create table emp_const( 
    empno number(4),
    ename varchar2(10),
    job varchar2(9),
    tel varchar2(20),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2)
);

alter table emp_const
add constraint empconst_empno_pk primary key(empno);

alter table emp_const
modify ename constraint empconst_ename_nn not null;

alter table emp_const
add constraint empconst_tel_unq unique(tel);

alter table emp_const
add constraint empconst_sal_chk check(sal between 1000 and 9999);

alter table emp_const
add constraint empconst_detpno_fk foreign key(deptno) references dept_const(deptno);


-------------------------------------------
-- 뷰
-- - 보기위한 목적
-- 1. 보안
-- 2. 범위(변경불가)

-- SQL (crud)-> 데이터 변경을 목적으로 하고 있음.
-- DML : create(insert)
-- DQL : read(select)
-- DML : update
-- DML : delete

-- 객체: table, index, view -> create의 명령을 이용하여 만들어 사용해야 한다.
-- create or replace view 뷰테이블명(alias)
-- as
-- 서브쿼리(select)
-- with check option
-- with read only

create table dept_copy
as
select * from dept;

create table emp_copy --복사되는 테이블은 제약조건이 안 넘어온다.
as
select * from emp;

alter table emp_copy
add constraint emp_copy_edptno_fk foreign key(deptno) references dept(deptno);

select * from emp_copy;

create or replace view emp_view30
as
select empno,ename,sal,deptno 
from emp_copy
where deptno = 30;

select * from emp_view30;

insert into emp_view30
values (1111,'HONGIL',1000,30);

select * from emp_copy;

insert into emp_view30(empno,ename,sal,deptno)
values (2222,'HONGIL',2000,50);


-----------------

insert into emp_view30 (empno, ename, sal, deptno)
values (2222,'hong',2000,50);

create or replace view emp_view(사원번호, 사원명, 급여, 부서번호)
as
select empno,ename,sal,deptno
from emp_copy;

select * from emp_view;

select *
from emp_view
where 부서번호 = 20;
--원래 컬럼명은 사용불가능

create or replace view emp_dept_view
as
select empno,ename,sal,e.deptno,dname,loc
from emp e inner join dept d
on e.deptno = d.deptno
order by empno desc;

select * from emp_dept_view;

create or replace view sal_view(dname,min_sal,max_sal)
as
select d.dname, min(sal),max(sal) 
from emp e inner join dept d
on e.deptno = d.deptno 
group by d.dname;

select * from sal_view;
