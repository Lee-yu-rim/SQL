-- DQL(���Ǿ�) ��������ȸ

--��ü������
select empno,ename,job,mgr,hiredate,sal,comm,deptno
from emp;

--��ü �÷� �˻�
select * from emp;

--�κ��÷� ������
select empno,ename,sal
from emp;

select deptno from emp;

select DISTINCT(deptno) from emp; --distinct �ߺ�����?

select job from emp;
select DISTINCT(job) from emp;

SELECT ename,sal from emp;
--  +,-,*,/ ������ �����ڴ� ����. �÷��� ������� �����Ѵ�.
--null���� ������ �Ұ��ϴ�
-- �÷��� ��Ī�� ����� �� �ִ�.
select ename,sal,sal *12+comm,comm from emp;
select ename �����,sal,sal *12+nvl(comm,0) as ����,comm from emp;

desc emp;

----------------------------------------------------------------------------

-- ������ ����
-- select �÷���
-- from ���̺��
-- order by �÷���(���� ������ �Ǵ� ��) asc/desc;
-- ����: 1~ 10
-- ��¥: ���ų�¥~ �ֱٳ�¥
-- ����: ��������
select * from emp order by sal asc; --��������
select * from emp order by sal desc; --��������
--���������� ���������ϴ�

select * from emp order by hiredate asc;
select * from emp order by hiredate desc;


--���ǰ˻� 
-- select �÷���
-- from ���̺��
-- where ���ǽ�(�÷���=��);
-- ���ǽ� = <,>,=,!=,<>,<=,>=,and,or

-- ���ڸ� �������� ����Ҷ�
-- ��ҹ���
-- ''
select * from emp where sal >=3000;
select * from emp where deptno =30 and job = 'SAILSMAN' and empno = 7499;
select * from emp where ename = 'FORD'; --�˻��ÿ� �����ʹ� ��ҹ��ڸ� �����⶧���� �����ؼ� �˻��ؾ��Ѵ�.

-- ��¥�� �������� ����Ҷ�
-- ''
-- ��¥�� ũ�Ⱑ �ִ�.
-- 80/12/20 -> 1980 12 20 �ð� �� �� ����
select * from emp where HIREDATE < '1982/01/01';

--or: �ΰ� �̻��� �����߿� �ϳ� �̻� ���� ��쿡 ����
select * from emp where deptno = 10 or sal > 2000;

--not ������ ������

select * from emp where sal != 3000;
select * from emp where not sal = 3000;

--and or
--���������� ǥ���� �� ���
select * from emp where sal >= 1000 and sal<=3000;
select * from emp where sal <=1000 or sal >=3000;

--between and 
select * from emp where sal between 1000 and 3000; -- select * from emp where sal >= 1000 and sal<=3000; �� ���� �ǹ�

--in
select * from emp where sal = 800 or sal = 3000 or sal = 5000;
select * from emp where sal in(800,3000,5000);

--like������
--���� �Ϻθ� ������ �����͸� ��ȸ�Ѵ�.
--���̵� ī�带 ����Ѵ� (%,_)
-- %: ��� ���ڸ� ��ü�Ѵ�
-- _: �� ���ڸ� ��ü�Ѵ�
select * from emp where ename like 'F%';
select * from emp where ename like '%O%';
select * from emp where ename like '___D';
select * from emp where ename like 'S___%';

--null ������
--is null / is not null
select * from emp where comm is not null;


-- ---------------
-- ���տ�����
-- �� ���� select ������ ����Ѵ�
-- �÷��� ������ �����ؾ��Ѵ�.
-- �÷��� Ÿ���� �����ؾ��Ѵ�.
-- �÷��� �̸��� �������.
-- ������, ������, ������
-- UNION  MINUS  INTERSECT
select empno, ename,sal,deptno from emp where deptno = 10;
select empno, ename,sal,deptno from emp where deptno = 20;

select empno, ename,sal,deptno from emp where deptno = 10 union --(������)
select empno, ename,sal,deptno from emp where deptno = 20;

select empno, ename,sal,deptno from emp where deptno = 10 union all
select empno, ename,sal,deptno from emp where deptno = 10;
-- �ߺ��Ǹ� �ϳ��� ������ش�. ������ all�� ���̸� �ߺ��Ǵ��� ������ش�

select empno, ename,sal,deptno from emp MINUS --(������)
select empno, ename,sal,deptno from emp where deptno = 10;

select empno, ename,sal,deptno from emp INTERSECT --(������)
select empno, ename,sal,deptno from emp where deptno = 10;


--1������
select * from emp where ename like '%S';

--2������
select empno,ename,job,sal,deptno from emp where job = 'SALESMAN';

--3������
--���տ����� ���x
select empno,ename,job,sal,deptno from emp where deptno between 20 and 30 and sal >=2000;
select empno,ename,job,sal,deptno from emp where deptno in(20,30) and sal >=2000;
--���տ����� ���
select empno,ename,job,sal,deptno from emp  INTERSECT --(������)
select empno,ename,job,sal,deptno from emp where deptno != 10 and sal >=2000;

select empno,ename,job,sal,deptno from emp where deptno  = 20 and sal >2000  INTERSECT --(������)
select empno,ename,job,sal,deptno from emp where deptno  = 30 and sal >2000;

--4������
select * from emp where sal < 2000 or sal > 3000;

--5������
select ename,empno,sal,deptno from emp where ename like '%E%' and sal not between 1000 and 2000 and deptno = 30;

--6������
select * from emp where job = 'MANAGER' and ename not like '_L%' or job ='CLERK' and ename not like '_L%';

select 'Welcome', upper('Welcome') from dual;

select lower(ename),upper(ename) from emp;

select * from emp where lower(ename) = 'scott'; --����صα�

select ename,LENGTH(ename) from emp;

select 'Welcome to Oracle',substr('Welcome to Oracle',2,3),substr('Welcome to Oracle',10) from dual;
select 'Welcome to Oracle',substr('Welcome to Oracle',-3,3),substr('Welcome to Oracle',10) from dual;
select instr('Welcome to Oracle','o') from dual;
select instr('Welcome to Oracle','o',6) from dual;
select instr('Welcome to Oracle','e',3,2) from dual;

select 'Welcome to Oracle',replace('Welcome to Oracle', 'to','of') from dual;

select 'oracle',lpad('oracle',10,'#'),rpad('oracle',10,'*') from dual;

select rpad('930103-',14,'*') from dual;

select concat(empno,ename), empno||''||ename from emp;

--�����Լ�
select round(1234.5678),round(1234.5678,0),round(1234.5678,1),round(1234.5678,2),round(1234.5678,-1) from dual; --�ݿø�. �Ҽ��� ù°�ڸ����� ��� �ݿø��ض�... 
--�ڿ� ���� ������ �� ������ ��� �ݿø��϶�� �Ҹ� -�� ����(�������� ����)
select trunc(1234.5678),trunc(1234.5678,0),trunc(1234.5678,1),trunc(1234.5678,2),trunc(1234.5678,-1) from dual;
-- ù��° �Ǽ��� ����� ������
select ceil(3.14),floor(3.14),ceil(-3.14),floor(-3.14) from dual;
--ceil: ���� ������ ���� ����� ���κ��� ū ���� / floor: ���� ������ ���� ����� ���κ��� ���� ����
select mod(5,2),mod(10,4) from dual; --���������ϱ�

select * from emp where mod(empno,2) =1;

