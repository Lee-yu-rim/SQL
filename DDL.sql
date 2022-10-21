--DDL(������ ���Ǿ�) : table(��� ��ü)�� ����, ����, �����ϴ� ��ɾ�
--create(����) , alter(����) , drop(����)

--1. create : ���̺��� ����
--create table ���̺��(    --table : ��ü
--    �÷���1 Ÿ��,          --column : �Ӽ�
--    �÷���2 Ÿ��,
--    �÷���3 Ÿ��    
--);

drop table emp_ddl;

create table emp_ddl(
    empno number(4),
    ename varchar2(10),   --byteũ��
    job varchar2(9),
    mgr number(4),
    hiredate date,    --date�� ũ������ x
    sal number(7,2),  --��ü 7�ڸ� �� ���ڸ��� �Ҽ���
    comm number(7,2),
    deptno number(2)
);

select *
from emp_ddl;

insert into emp_ddl
values (9999,'�̼���','MANAGER',1111,sysdate,1000,null,10);

--���̺��� ���� : ������ �����ϴ� ���̺��� �����͸� �����ͼ� ���ο� ���̺��� ����� ��
create table dept_ddl
as
select * from dept;

--���̺��� �����͸� �����ؼ� �Ϻ� �����͸� ����
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

--���̺��� �����͸� ������ ������ ����
create table dept_d
as
select * from dept
where 1 != 1;

--2. alert : ���̺��� ���� ���� (�÷��� ���� ����)
--add : ���ο� �÷� �߰�
--rename : �÷��� �̸� ����
--modify : �ڷ����� ����
--drop : �÷� ����

create table emp_alter
as
select * from emp;

select *
from emp_alter;

--���̺� ���ο� �÷� �߰�
alter table emp_alter
add address varchar2(100);

--�÷��� �̸� ����
alter table emp_alter
rename column address to addr;

--�ڷ����� ����
alter table emp_alter
modify empno number(10);

--�÷��� ����
alter table emp_alter
drop column addr;

drop table emp_alter;

select *
from emp_alter;

--�������� 1
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
    
--�������� 1-1 
alter table emp_hw
add BIGO varchar2(20);

--�������� 1-2   
alter table emp_hw
modify BIGO varchar2(30);

--�������� 1-3
alter table emp_hw
rename column BIGO to remark;

--�������� 1-4
insert into emp_hw
select empno,ename,job,mgr,hiredate,sal,comm,deptno,NULL 
from emp;

--�������� 1-5
drop table emp_hw;

--------------------------------------------------------------------------------
--������ ����
desc user_tables;  

select table_name
from user_tables; --soctt �������� ����� �� �ִ� ���̺� ������ ������

select owner,table_name
from all_tables;   --�ٸ� ������ ���̺��� ��� ��ȸ

--------------------------------------------------------------------------------
--index : �˻� �ӵ��� ����ϱ� ���� ����ϴ� ��ü
--create(����) , drop(����)
--select ������ �˻��ӵ��� ����Ų��.
--��ü���ڵ��� 3% ~ 5% ���� �� ��
--indext ��ü�� �÷��� �����ؼ� ���

--create index �ε�����
--on ���̺��(�÷���)

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

--index ��ü ���� �� ��ȸ �ӵ�(0.032��)
select empno,ename
from emp01
where ename = 'bts';

--index ��ü ���� �� ��ȸ �ӵ�(0.001��)
create index idx_emp01_ename
on emp01(ename);

--index ��ü ����
drop index idx_emp01_ename;

show recyclebin; --�����뿡 ������ ���̺� ���� Ȯ��

--���̺� ���� �� ���󺹱�
flashback table emp_hw
to before drop;

--������ ����
purge recyclebin;

--------------------------------------------------------------------------------
--��������(���Ἲ) : �߸��� ���� �����ͷ� ���Ǵ� ���� ���� ��
--not null : �ݵ�� null�� �ƴ� �����͸� �����Ѵ�.
--unique : ���Ἲ�� üũ (�ߺ����� �� �� ����) but, null�����ʹ� �ް� �ߺ��� �� ����
--primary key : �⺻Ű not null + unique
--foreign key
--check
--�������Ǹ� ���� : constraint ���̺��_�÷���_�������Ǿ��

insert into emp
values (1111,'aaa','MANAGER','9999',sysdate,1000,null,50);
--���Ἲ ��������(SCOTT.FK_DEPTNO)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�

drop table emp02;

create table emp02(
    empno number(4) constraint emp02_empno_pk primary key,  --���� ����� ����� ��������� �ʵ����ϰ�, ���� �ʼ��� ���� �Ѵ�.
    ename varchar2(10) constraint emp02_ename_nn not null,  --����� �̸��� ���� ����� ������ ���ϵ��� ����
    job varchar2(9),
    deptno number(2)
);

insert into emp02
values (null,null,'MANAGER',30);  

insert into emp02
values (1111,'ȫ�浿','MANAGER',30);

insert into emp02
values (2222,'ȫ�浿','MANAGER',30);

insert into emp02
values (null,'������','SALESMAN',20);  --NULL�� ("SCOTT"."EMP02"."EMPNO") �ȿ� ������ �� �����ϴ�

insert into emp02
values (2222,'������','SALESMAN',20);  --���Ἲ ���� ����(SCOTT.SYS_C0011062)�� ����˴ϴ�
                                      --���Ἲ ���� ����(SCOTT.EMP02_EMPNO_PK)�� ����˴ϴ�
select * from emp02;











