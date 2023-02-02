-- DML(������ ���۾�)
-- insert : ���̺� ������ ����
--    ```
--    insert into ���̺�� (�÷��� 1, �÷��� 2......)
--    values (��1, ��2,.......)
--    ```
--    �÷��� ���� Ÿ�԰� ������ ��ġ�ؾ��Ѵ�(1:1)
--    �ۼ� ������� 1:1 ��Ī�ȴ�.

-- update
-- delete

-- ���̺� ����
create table dept_temp
as 
select * from dept;

--�����ϰ� ���� ������ 
drop table dept_temp;

--������� ���̺� ��ȸ. dept�� ���� �״�� �����ͼ� ���ο� ���̺� ������.
select *
from dept_temp;

insert into dept_temp(deptno,dname,loc) 
values (50,'DATABASE','SEOUL');

insert into dept_temp --�÷� ������
values (70,'HTML','SEOUL');

insert into dept_temp --�÷� ������, ����� Null ������ ������ �����ϴ�.
values (80,NULL,'SEOUL');

insert into dept_temp (deptno,dname) -- ������ null ������ ����
values(60,'JSP');

-------------------------------------------------------------------

--�÷��� ������ �����ϰ� ������.
create table emp_temp 
as 
select * from emp
where 1 != 1;

drop table emp_temp;

select *
from emp_temp;

insert into emp_temp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(9999,'ȫ�浿','PRESIDENT',NULL,'2001/01/01',5000,1000,10);

insert into emp_temp (empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(3111,'��û��','MANAGER',9999,sysdate,4000,null,30);

-- update : �÷��� �����͸� ����(����)
-- update ���̺��
-- set �÷��� = ��, �÷��� = ��, .... ,
-- where ���ǽ�(�ʿ信 ���� ���)
-- �������� ������� ������ �ش� �÷��� ��� ����ȴ�.

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

-- delete(�����ͻ���)
-- delete from ���̺��
-- where ���ǽ� 
-- �������� ������� ������ ��� �����Ͱ� �����ȴ�.

create table emp_temp2
as 
select * from emp;

drop table emp_temp2;

select * 
from emp_temp2;

delete from emp_temp2
where ename = 'SCOTT';


--------------------------------------------------------------------------------
-- TCL(�������� �������� �Ǵ� ���)
-- Ʈ������
-- commit, rollback, savepoint
-- commit : ������ ���� ����(���̺��� ������ �ݿ�)
--          create ������ ����ؼ� ��ü�� ������ �� �ڵ����� commit �� �߻��Ѵ�.
-- rollback : ������ ���� ���(���̺��� ������ �� �ݿ�) ���󺹱�
-- savepoint : 


create table dept01 
as 
select * from dept;

drop table dept01;

commit; -- ���̺��� ����� ������ �ѹ��� �Ұ���
rollback;

select * 
from dept01;


------------- 
-- ������ ����
-- Ʈ����� ���� ����
    -- delete : �ѹ� ����
    -- truncate : �ѹ��� �Ұ���
delete from dept01;
rollback;

truncate table dept01;

--DDL(���������Ǿ�) : table(��� ��ü)�� ���� ���� �����ϴ� ��ɾ�.
-- create ���� 
-- alter ����
-- drop ����

create table ���̺��( --table ��ü
    �÷���1 Ÿ��,    --column �Ӽ�
    �÷���2 Ÿ��,
    �÷���3 Ÿ��
);

create table emp_DDL(
    --��� ,�̸�, ��å, ������, �Ի�����, �޿�, ������, �μ���ȣ
    empno number(4),
    ename varchar2(10), --byte ũ�Ⱑ 10
    job varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2)
);

select * from emp_DDL;

insert into emp_DDL
values (9999,'�̼���','MANAGER',1111,sysdate,1000,NULL,10);

create table dept_ddl --���̺��� ����
as 
select * from dept;

create table dept_30 --���̺��� ����
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
where 1 != 1; -- �� while���� �ǹ̴� ���̺��� ������ �����ؿ��ڴٴ� �ǹ�

-- ���̺� ����(�÷��� ������ ����)
-- ���ο� �÷��߰�, �÷��� �̸�����, �ڷ����� ����, �÷��� ����
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

--�������� 324p
select * from EMP_HW;
--1��
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

--2��
alter table EMP_HW
add BIGO varchar2(20);

--3��
alter table EMP_HW
modify BIGO varchar(30);

--4��
alter table EMP_HW
rename column BIGO to REMARK;

--5��
insert into EMP_HW(empno, ename, job, mgr, hiredate, sal, comm, deptno, remark)
select empno, ename,job,mgr, hiredate, sal, comm, deptno ,null from emp;

--6��
drop table EMP_HW;

--------------------------------------------------------------------------------
--�����ͻ���
desc user_tables;

select table_name
from user_tables;

select owner , table_name
from all_tables;

-- index �˻��ӵ��� ����ϱ� ���� ����ϴ� ��ü
-- create(����), drop(����)
-- select ������ �˻� �ӵ��� ����Ų��
-- ��ü ���ڵ��� 3%~ 5%�����϶� index��ü�� �÷��� �����ؼ� ����Ѵ�.

create index �ε�����
on ���̺��(�÷���);

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

--���̺� ������ ���󺹱�
-- show recyclebin;
-- flashback table emp_temp
-- to BEFORE drop;
show recyclebin;
flashback table emp_temp
to BEFORE drop;

purge recyclebin;

--��������(���Ἲ) : �߸��� ���� �����ͷ� ���Ǵ� ���� ���ϰ� �ϴ� ��
-- - not null : ������ ���� NULL�� ������� �ʴ´�. NULL�� ������ �������� �ߺ��� ���.
-- - unique : ������ ���� ������ ���� ������ �Ѵ�. �� �ߺ��� �� ����. �� NULL�� ���� �ߺ����� ���ܵȴ�.
-- - primary key : ������ ���� ������ ���̸鼭 NULL�� ������� �ʴ´�. PRIMARY KEY�� ���̺� �ϳ��� ���� �����ϴ�.
-- - foreign key : �ٸ� ���̺��� ���� �����Ͽ� �����ϴ� ���� �Է��� �� �ִ�.
-- - check : ������ ���ǽ��� �����ϴ� �����͸� �Է� �����ϴ�.

-- emp dept
insert into emp
values (1111,'aaa','MANAGER',9999,sysdate,1000,NULL,50);

drop table emp02;
create table emp02(
    empno number(4) constraint emp02_empno_pk primary key,--unique�� null�� �������...
    ename varchar2(10) constraint emp02_empno_ename_nn not null,
    job varchar2(9),
    deptno number(2)
);
select * from emp02;

insert into emp02
values (null, null, 'MANAGER', 30);

insert into emp02
values (1111, 'ȫ�浿', 'MANAGER', 30);

insert into emp02
values (2222, 'ȫ�浿', 'MANAGER', 30);

insert into emp02
values (1111, '�̼���', 'MANAGER', 20);

insert into emp02
values (null, '������', 'SALESMAN', 20);

delete from emp02;