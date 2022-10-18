-- DQL(���Ǿ�) -> ������ ��ȸ��
-- select �÷��� 
-- from ���̺��

desc emp;  --���̺� ��ȸ

--��ü ������ ��ȸ
select empno,ename,job,mgr,hiredate,sal,comm,deptno
from emp;

--��ü ������ ��ȸ
select * 
from emp;

--�κ� �÷� ������ ��ȸ
select empno,ename,sal
from emp;

select deptno 
from emp;

select DISTINCT(deptno) --distinct : �ߺ��� ���� �� ��ȸ
from emp; 

select job 
from emp;

select DISTINCT(job) 
from emp;

SELECT ename,sal 
from emp;

-- +,-,*,/ �̿��� �����ڴ� ����
--�÷��� ������� �����Ѵ�.
--null���� ������ �Ұ��ϴ�. -> nvl�� �̿��Ͽ� null���� ��ü�� �� ����
--�÷��� ��Ī�� ����� �� �ִ�. -> as ��� , as�� ���� ����
select ename �����,sal,sal * 12 + comm as ����,comm   --comm : ������
from emp;

-----------------------------------------------------------
--������ ����
--select �÷���
--from ���̺��
--order by �÷���(���� ������ �Ǵ� ��) asc(��������)/desc(��������)

select *
from emp
order by ename asc;   --�������� : ���� ����(�⺻ ������ ��������)

select *
from emp
order by sal desc;  --��������

--������ ���� ����(��������)
--����(1~10), ��¥(����~�ֱ�), ����(������)

--���� �˻�
--select �÷���
--from ���̺��
--where ���ǽ�(�÷��� ������ ��); < , > , = , != / <> , >= , <= , and , or

select *
from emp
where sal >= 3000;

select *
from emp
where deptno = 30;

--and : �ΰ��� �̻��� ������ ��� ���� ���
select *
from emp
where deptno = 30 and job = 'SALESMAN' and empno = 7499;

--���ڸ� �������� ����� ��
--��ҹ��� ����
--''���
select *
from emp
where ename = 'ford';  --�ҹ��� ford�� ����.

--��¥�� �������� ����� ��
--''���
--��¥�� ũ�Ⱑ �ִ�.(���� < �ֱ�)
--ǥ�õǴ� �� yy/mm/dd  -> ����ִ� �� yyyy/mm/dd/�ð�/��/��/����
select *
from emp
where hiredate < '1982/01/01';

--or : �ΰ��� �̻��� ���� �� �ϳ� �̻��� ���� ���
select *
from emp
where deptno = 10 or sal >= 2000;

--not : ������ ������
select *
from emp
where sal != 3000;
--���� ���
select *
from emp
where not sal = 3000;

--abd , or 
--���� ������ ǥ���� �� ���
select *
from emp
where sal >= 1000 and sal <= 3000;

select *
from emp
where sal <= 1000 or sal >=3000;

--between and : and �� ����ϴ� ��������
select *
from emp
where sal >= 1000 and sal <= 3000;
--���� ���
select *
from emp
where sal between 1000 and 3000;

--in : or �� ����ϴ� ��������
select *
from emp
where sal = 800 or sal = 3000 or sal = 5000;
-- ���� ���
select *
from emp
where sal in(800,3000,5000);

--like ������
--���� �Ϻθ� ������ �����͸� ��ȸ�Ѵ�.
--���ϵ� ī�带 ����Ѵ�.(% , _)
-- % : ��� ���ڸ� ��ü�Ѵ�.
-- _ : �Ѱ��� ���ڸ� ��ü�Ѵ�.
select *
from emp
where ename like 'F%';  -- F�� �����ϴ� ��� �̸�(F �ڿ� ���� ���� �͵� ����)

select *
from emp
where ename like '%D';

select *
from emp
where ename like '%O%';

select *
from emp
where ename like '___D';

select *
from emp
where ename like 'S___%';

--null ������
--is null / is not null �� ���·� ����Ͽ� �� ��ȸ
select *
from emp
where comm = null;  --null�� �񱳺Ұ�

select *
from emp
where comm is null;

select *
from emp
where comm is not null;

----------------------------
--���տ�����
--�ΰ��� select ������ ����Ѵ�.
--�÷��� ������ �����ؾ��Ѵ�.
--�÷��� Ÿ���� �����ؾ��Ѵ�.
--�÷��� �̸��� �������.
--������(UNION), ������(MINUS), ������(INTERSECT)

select empno,ename,sal,deptno
from emp
where deptno = 10
UNION --������
select empno,ename,sal,deptno
from emp
where deptno = 20;

select empno,ename,sal,deptno
from emp
where deptno = 10
UNION --������
select empno,ename,sal,deptno
from emp
where deptno = 10;
--�ߺ����� ��� �ѹ��� ��µ�

select empno,ename,sal,deptno
from emp
where deptno = 10
UNION ALL --������
select empno,ename,sal,deptno
from emp
where deptno = 10;
--ALL�� ���̸� �ߺ����̴��� ��µ�

-------------------------------
select empno,ename,sal,deptno
from emp
MINUS --������
select empno,ename,sal,deptno
from emp
where deptno = 10;
--10�� �μ��� �� ������ ���� ��µ�

-------------------------------
select empno,ename,sal,deptno
from emp
INTERSECT --������
select empno,ename,sal,deptno
from emp
where deptno = 10;
--10�� �μ��� ��ȸ��

----------------------------------------------------------------------
--where ������ �������
--�񱳿�����, ��������, like, is (not) null, ���տ����ڸ� ����Ͽ� ������ ��ȸ
--�񱳿����� : >, <, >=, <=, =, !=
--�������� : and, or, not, between and, in
--like : % , _ (���ϵ� ī��)
--is null , is not null : null ������ ��ȸ
--���տ����� : UNION , UNION ALL , MINUS , INTERSECT 


--�������� 1��
select *
from emp
where ename like '%S';

--�������� 2��
select empno,ename,job,sal,deptno
from emp
where deptno = 30 and job = 'SALESMAN';

--�������� 3��
select empno,ename,job,sal,deptno
from emp
where deptno in(20,30) and sal > 2000;

select empno,ename,job,sal,deptno
from emp
where deptno = 20 and sal > 2000
UNION
select empno,ename,job,sal,deptno
from emp
where deptno = 30 and sal > 2000;

--�������� 4��
select *
from emp
where sal < 2000 or sal > 3000;

--�������� 5��
select ename,empno,sal,deptno
from emp
where deptno = 30 and ename like '%E%' and sal not between 1000 and 2000;

--�������� 6��
select *
from emp
where comm is null and MGR is not null
INTERSECT
select *
from emp
where job = 'MANAGER' or job = 'CLERK'
MINUS
select *
from emp
where ename like '_L%';

select *
from emp
where comm is null and job in('MANAGER','CLERK') and mgr is not null and ename not like '_L%';


















