--DML(������ ���۾�) : insert , update , delete

--1. insert : ���̺� ������ ����
--insert into ���̺�� (�÷���1, �÷���2,...)
--values (��1,��2...)
--�÷��� ���� Ÿ�԰� ������ ��ġ�ؾ��Ѵ�.
--�ۼ� ������� 1 : 1 ��Ī�ȴ�.

--���̺� ����
create table dept_temp  --���̺� �̸�
as
select * from dept;

select *
from dept_temp;

--������ ����
insert into dept_temp (deptno,dname,loc)
values (50,'DATABASE','SEOUL');  --�������� Ÿ�Կ� ���缭 �ۼ�

insert into dept_temp (deptno,dname)
values (60,'JSP');    --loc �����ʹ� null �����ͷ� �ڵ� �����ȴ�. (������ null ������ ����) 

insert into dept_temp    --�÷� ���� (���̺��� ��ü�÷��� ����� �� ���� ����)
values (70,'HTML','SEOUL'); 

insert into dept_temp    
values (80,'NULL','SEOUL');   --����� null ������ ����

--���̺� ���� 
create table emp_temp
as
select * from emp
where 1 != 1;    --�����ʹ� �����ϰ� �÷��� ������

select *
from emp_temp;

insert into emp_temp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
values (9999,'ȫ�浿','PRESIDENT',NULL,'2001/01/01',5000,1000,10);

insert into emp_temp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
values (3111,'��û��','MANAGER',9999,sysdate,4000,NULL,30);

--2. update : �÷��� �����͸� ����(����)
--update ���̺��
--set �÷��� = ������ ��, �÷��� = ������ ��, ...
--where ���ǽ�
--�������� ������� ������ �ش� �÷��� ��� ����ȴ�.

drop table dept_temp2;   --���̺� ����

create table dept_temp2
as
select * from dept;

select *
from dept_temp2;

update dept_temp2
set dname = 'DATABASE' , loc = 'SEOUL'
where deptno = 40;

--3. delete : ������ ����
--delete from ���̺��
--where ������
--�������� ������� ������ ��� �����Ͱ� �����ȴ�.

drop table emp_temp2;

create table emp_temp2
as
select * from emp;

delete from emp_temp2;   --������ ����(��ü �����Ͱ� ������)

delete from emp_temp2
where ename = 'SCOTT';  --where ���� ����Ͽ� �Ϻ� �����͸� ����

select *
from emp_temp2;

--------------------------------------------------------------------------------
--TCL(�������� ���� ���� �Ǵ� ���)
--Ʈ�����
--commit , rollback, savepoint
--commit : �������� ���� ����(���̺� ������ �ݿ�), create ������ ����Ͽ� ��ü�� ������ �� �ڵ����� Ŀ���� �̷������.
--rollback : ������ ���� ���(���̺� ������ �̹ݿ�) ���󺹱� , õ������,����,����� ���� ���� �Ұ� ������ �� �ڵ����� �ѹ��� �̷������.

drop table dept01;

create table dept01
as
select * from dept;

select *
from dept01;


delete from dept01;   --���������δ� ���̺��� ����������, �ܺ������� ������ �����Ͱ� �������� ����
-- = ���� ��ɾ�, Ʈ����� ���� ������ �ٸ���.
truncate table dept01;  --Ʈ����� ���� �Ұ�(������ ������ ���ÿ� Ŀ���� �Ͼ - ���� ����)

commit;   --commit�� �ϰԵǸ� ������ �� �۾��� �����ϰ� ���̺� �ݿ���. 
rollback;   --���� ���̺�� ������ but, Ŀ���� �Ͼ�� �� �ڿ��� �ѹ� �Ұ�, Ŀ�� ���� ���������� �ݿ�
















