--����(join)
-- 2�� �̻��� ���̺��� �����͸� ��ȸ
-- from���� �ΰ��̻��� ���̺��� �ۼ��Ѵ�
-- where�� ���� ������ �ۼ��Ѵ�

-- equi join(�����,equals) ������ 
-- cross join(where�� ���� ����)
-- non equi join (where ����������: and. or
-- self join(where �ϳ��� ���̺��� ����Ѵ�)
-- out join (where�� �����Ǵ� �����͸� ���� ��ȸ�ϱ� ���� : (+) ���)

select emp.ename,emp.job,emp.deptno,dept.dname,dept.loc
from emp,dept
where emp.deptno = dept.deptno;

-- �÷��̸��� �������� ������ �Ź� �տ� �� �ʿ�� ����. ��, deptno�� ���� ���̺� �����ϱ⶧���� ���� �Ҽ��� ���־���Ѵ�.
select e.ename,job,e.deptno,d.dname,loc
from emp e,dept d --���̺� ��Ī �ִ¹�� ��Ī�� ����ϸ� ��� �κ��� ��Ī���� �����־�� �Ѵ�.
where e.deptno = d.deptno;

select ename,sal,grade,losal,hisal
from emp e, salgrade s --���̺� ��Ī �ִ¹�� ��Ī�� ����ϸ� ��� �κ��� ��Ī���� �����־�� �Ѵ�.
where e.sal between s.losal and s.hisal;
--where e.sal >= s.losal and e.sal <= s.hisal;

--���, �̸�, �޿�, �μ���ȣ, �μ���, �޿����
--emp              dept           salgrade

select empno,ename,sal,d.deptno,dname,grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno
and e.sal between s.local and s.hisal;

select e.empno,e.ename,e.mgr,m.ename
from emp e, emp m --���������� �ݵ�� ��Ī�ο� 
where e.mgr= m.empno;

--scott ���� �μ��� �ٹ��ϴ� ����� �˰����. �˰��ִ°� scott��
--ename ename
--scott smith
--scott jones
--scott adams
--scott ford

select work.ename, friend.ename
from emp work, emp friend
where work.deptno = friend.deptno
and work.ename = 'SCOTT'
and friend.ename != 'SCOTT';

--�ܺ�����
-- ��� �����Ǵ� �����͸� ���� ��ȸ�ϱ� ���ؼ� ���

select e.empno, e.ename, e.mgr, m.ename
from emp e, emp m --�ݵ�� ��Ī �ο�
where e.mgr = m.empno(+); --�����Ͱ� ���� ���̺��ʿ� (+)�� ���δ�.

select ename, sal, d.deptno, dname
from emp e, dept d
where e.deptno(+) = d.deptno;

-- ANSI-JOIN(ǥ�����ι��)
-- where ��ſ� on �����
-- using(�÷��̸�) ����. �÷��̸��� �ٸ��� �� �� ����
-- ��Ī ���ÿ��� using ������ ���ѵ� �� �ִ�

 -- cross join, inner join(equi not equi), natural join, outer join(+) -> [left, right, full] outer join(���� �ϳ��� �ʼ��� �ٿ��� ��)
select ename, sal, dname, loc
from emp e inner join dept d
on e.deptno = d.deptno;

select ename, sal, dname, loc
from emp e inner join dept d
using(deptno); --���� ���̺��� �÷����� �����Ѱ�츸 ��밡��

select ename, sal, dname, loc
from emp e inner join dept d
using(deptno)
where ename = 'SCOTT'; --���� �߰� ����

select e.empno,e. ename,e.mgr,m.ename
from emp e inner join emp m
on e.mgr = m.empno;

select empno, ename,sal,grade
from emp e inner join salgrade s
on e.sal between s.losal and s.hisal;

select e.empno, e.ename, e.mgr, m.ename
from emp e left outer join emp m -- �����Ͱ� �ִ� ���� �����Ѵ�
on e.mgr = m.empno;

select empno, ename,sal,d.deptno,dname,grade
from emp e inner join dept d
on e.deptno = d.deptno
inner join salgrade s
on e.sal between s.losal and s.hisal;

--------------------------------
select ename,sal,d.deptno,dname
from emp e, dept d
where e.deptno(+) = d.deptno;
-- ansi-join ������� �����--

select ename, sal, d.deptno, dname
from emp e right outer join dept d
on e.deptno = d.deptno;

-----------����Ǯ�� �Ƚ����ι��
--1��
select d.deptno, d.dname,e.empno,e.ename,e.sal
from emp e join dept d
on e.deptno = d.deptno
where sal>2000
order by d.dname asc;
-- �����Ǯ��
select d.deptno, d.dname,e.empno,e.ename,e.sal
from emp e inner join dept d
on e.deptno = d.deptno
where sal>2000;

--2��
select e.deptno, d.dname, trunc(avg(sal)), max(sal), min(e.sal),
case
    when e.deptno = 10 then count(10)
    when e.deptno = 20 then count(20)
    when e.deptno = 30 then count(30)
    else 0
end as cnt
from emp e join dept d
on e.deptno = d.deptno 
group by e.deptno, d.dname;
--�����Ǯ��
select e.deptno, d.dname, trunc(avg(sal)), max(sal), min(e.sal),count(*)
from emp e join dept d
on e.deptno = d.deptno 
group by e.deptno,d.dname;

--3�� --40���� ���f��...........
select e.deptno,d.dname,empno,e.ename,job,sal
from emp e join dept d
on e.deptno = d.deptno
order by d.dname asc;
--�����Ǯ��
select e.deptno,d.dname,e.empno,e.ename,e.job,e.sal
from emp e right outer join dept d
on e.deptno = d.deptno
order by e.deptno asc;


--4��
select d.deptno,d.dname,
       e.empno,e.ename,e.mgr,e.sal,e.deptno as DEPTNO_1, 
       s.losal,s.hisal,s.grade, 
       m.empno,m.ename
from emp e right outer join dept d
on e.deptno = d.deptno
    full outer join salgrade s
on e.sal between s.losal and s.hisal
    left outer join emp m
on e.mgr = m.empno
    order by e.deptno, e.empno asc;


-- ��������
-- select ������ ��ø�ؼ� ����ϴ� ��(where)
-- select (select)
-- from (select)
-- where (select) ->���� ����������� �θ�
select max(sal) from emp;

select ename, sal
from emp
where sal = (
            select max(sal)
            from emp
            );

--------------------------
select deptno
from emp
where ename = 'SCOTT';

select dname
from dept
where deptno = 20;

--����������
select dname
from dept
where deptno = (
        --����������
        select deptno
        from emp
        where ename='SCOTT'
      );
      
------------------
--dallas �̸�, �μ���ȣ

select ename, deptno
from emp
where deptno = (
                select deptno
                from dept
                where loc = 'DALLAS'
                );
                
-- �ڽ��� ���ӻ���� KING�� ����� �̸��� �޿��� ��ȸ�ϼ���
select ename,sal
from emp
where mgr = ( --�Ŵ���
            select empno --���
            from emp
            where ename = 'KING'
            );
            
            
--������ ��������: =, !=, > , <....
--������ ��������: in, any...

select *
from emp
where sal in(5000,3000,2850);

select *
from emp
where sal in(
-- ������
    select max(sal)
    from emp
    group by deptno
    );
    
select *
from emp
where sal > any ( --any�� �ε�ȣ ������ �ʼ�
-- ������
    select max(sal)
    from emp
    group by deptno
    );
    
select ename, sal
from emp
where sal > all(
    select sal
    from emp
    where deptno = 30
    );
    
    
    
    
--������ ������
-- in : ���������� �����Ͱ� ���������� ��� �� �ϳ��� ��ġ�� �����Ͱ� �ִٸ� true
-- any, some : ���������� ���ǽ��� �����ϴ� ���������� ����� �ϳ� �̻��̸� true
-- all : ���������� ���ǽ��� ���������� ��� ��ΰ� �����ϸ� true
-- exists : ���������� ����� �����ϸ�(��, ���� 1�� �̻��� ���) true


select * 
from emp
where (deptno,sal) in (
    select deptno, max(sal)
    from emp
    group by deptno
    );