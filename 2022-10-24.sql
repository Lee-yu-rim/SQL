
--��������(���Ἲ) : �߸��� ���� �����ͷ� ���Ǵ� ���� ���ϰ� �ϴ� ��
-- - not null : ������ ���� NULL�� ������� �ʴ´�. NULL�� ������ �������� �ߺ��� ���.
-- - unique : ������ ���� ������ ���� ������ �Ѵ�. �� �ߺ��� �� ����. �� NULL�� ���� �ߺ����� ���ܵȴ�.
-- - primary key(�⺻Ű) : ������ ���� ������ ���̸鼭 NULL�� ������� �ʴ´�. PRIMARY KEY�� ���̺� �ϳ��� ���� �����ϴ�.
-- - foreign key(�ܷ�Ű,����Ű) : �ٸ� ���̺��� ���� �����Ͽ� �����ϴ� ���� �Է��� �� �ִ�.
    -- 1. �θ�� �ڽ��� ���踦 ������ �ڽ��� ���̺� �÷��� �����Ѵ�.
    -- 2. �θ��� ���̺��� �÷��� �ݵ�� primary key �Ǵ� unique�ؾ��Ѵ�.
    -- 3. null �����͸� ����մϴ�.
-- - check : ������ ���ǽ��� �����ϴ� �����͸� �Է� �����ϴ�.
-- - default :

--------------------------------------------------------------------------------

--foreign key ����

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
---- ������������ ����� ������ ����
--insert into dept07
--select * from dept;
--
--insert into emp07
--select empno, ename, job, deptno from emp;
--
--insert into emp07
--values(1111,'aaa',"MANAGER',50);

-----------------------------------------------------------------------
-- check ����
drop table emp08;

create table emp08(
    empno number(4) primary key,
    ename varchar2(10) not null, 
    sal number(7) constraint emp08_sal_ck check(sal between 500 and 5000),
    gender varchar2(2) constraint emp08_gender_ck check(gender in('M','F')) -- M �Ǵ� F�� ������ ���ü�����
);

select * from emp08;

insert into emp08
values(1111,'hong',1000,'M');

insert into emp08
values(2222,'hong',200,'M');

insert into emp08
values(2222,'hong',2000,'A');

--------------------------------------------------------------------------------
-- default ����
drop table dept09;

create table dept09(
    deptno number(2) primary key,
    dname varchar2(10) not null,
    loc varchar2(15) default 'SEOUL' -- �� �÷��� ���� ���� ������ �⺻������ null�� �ƴ϶� seoul�� ����.
);

insert into dept09(deptno,dname,loc)
values (20,'SALES','BUSAN');

select * from dept09;

-- �������� ���� ���
-- �÷������� ����(not null�� �÷� ���������� ��밡��)
-- ���̺� ������ ����(not null�� �����Ҽ� ����.)

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

-- ����Ű( �⺻Ű�� �ΰ��� �÷��� ����ϴ� ���)
-- ���̺� ���� ������θ� ���� ����
    -- 1. ���̺� �ȿ��� �����ϴ� ���
    -- 2. alter��ɾ� ����ϴ� ���

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
add constraint emp10_empno_pk primary key(empno); --�÷��� �������� �߰�

alter table emp10
add constraint emp10_empno_fk foreign key(deptno) references dept(deptno);

-- not null�� ������ ����(null�� not null�� �ٲٴ°�) �׷��� modify�� ���
alter table emp10
modify job constraint emp10_job_nn not null;

alter table emp10
modify ename constraint emp10_ename_nn not null;

alter table emp10
drop constraint emp10_empno_pk;--�������Ǹ�(constraint) �Ǵ� ��������(primary key)

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
drop primary key cascade; --�������Ǳ��� ����                                       


-------------------------------------------------------------------------------
--����Ǯ�� �� 394

--1. alter ���
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
-- ��
-- - �������� ����
-- 1. ����
-- 2. ����(����Ұ�)

-- SQL (crud)-> ������ ������ �������� �ϰ� ����.
-- DML : create(insert)
-- DQL : read(select)
-- DML : update
-- DML : delete

-- ��ü: table, index, view -> create�� ����� �̿��Ͽ� ����� ����ؾ� �Ѵ�.
-- create or replace view �����̺��(alias)
-- as
-- ��������(select)
-- with check option
-- with read only

create table dept_copy
as
select * from dept;

create table emp_copy --����Ǵ� ���̺��� ���������� �� �Ѿ�´�.
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

create or replace view emp_view(�����ȣ, �����, �޿�, �μ���ȣ)
as
select empno,ename,sal,deptno
from emp_copy;

select * from emp_view;

select *
from emp_view
where �μ���ȣ = 20;
--���� �÷����� ���Ұ���

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
