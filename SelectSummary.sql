-- DQL(���Ǿ�) -> ������ ��ȸ��
-- select �÷��� 
-- from ���̺��

desc emp;  --���̺��� �÷����� Ȯ��

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

--============================================================================================
--�Լ�
--�����Լ� : upper,lower,length,substr,instr,replace,lpad,rpad,concat
--�����Լ�
--��¥�Լ�

--1. �����Լ�
-- #upper �Լ� : ���ڿ��� �ҹ��� -> �빮�ڷ� ��ȯ
select 'Welcome',upper('Welcome')
from dual;  --dual : �������̺�

-- #lower �Լ� : ���ڿ��� �빮�� -> �ҹ��ڷ� ��ȯ
select lower(ename),upper(ename)
from emp;

select *
from emp
where ename = 'FORD';

--emp �ȿ� scott�� �빮�ڷ� �Ǿ�������, lower�� ����Ͽ� ��ü �̸��� �ҹ��ڷ� �ٲ۵� ��ȸ -> �˻��� ȿ������ ����
select *
from emp
where lower(ename) = 'scott';

-- #length �Լ� : ���ڿ��� ���� ��ȯ
select ename,length(ename)
from emp;

-- #substr �Լ� : ���ڿ� ��ȯ
--      1234567891011121314151617
--     -17                     -1   
select 'Welcome to Oracle',substr('Welcome to Oracle',2,3)  --������ 2��° ������ 3���� ���ڿ� ��������  elc
,substr('Welcome to Oracle',10)  --������ġ�� ����  o Oracle
from dual;

select 'Welcome to Oracle',substr('Welcome to Oracle',-3,3)  --cle
,substr('Welcome to Oracle',-10)  --to Oracle
from dual;

-- #instr �Լ� : ���ڿ��� ��ġ�� ��ȯ
select instr('Welcome to Oracle','o')
from dual;

select instr('Welcome to Oracle','o',6)   --���� ��ġ�� 6��° ������ �ִ� o�� ��ȯ�ϹǷ� to�� o�� 10��° ��ġ�� ��ȯ
from dual;

select instr('Welcome to Oracle','e',3,2)  --2��° ������ e�� ��ġ���� ��ȯ�ض� = 17
from dual;

-- #replace �Լ� : ���ڿ� ��ü
select 'Welcome to Oracle',replace('Welcome to Oracle','to','of')
from dual;

-- #lpad �Լ� : ���ڿ��� ���ʿ� ������ Ȯ���ؼ� ���ڸ� ����
-- #rpad �Լ� : ���ڿ��� �����ʿ� ������ Ȯ���ؼ� ���ڸ� ����
select 'oracle',lpad('oracle',10,'#'),rpad('oracle',10,'*')   --10�� ���ڿ��� �� ���̸� �����ϴ� ����
from dual;

select rpad('950828-',14,'*')
from dual;

-- #concat �Լ� : ���ڿ� ����
select concat(empno,ename),empno || '' || ename
from emp;

-----------------------------------------------------------------------------
--2. �����Լ�

--round �Լ� : �ݿø��� �� ��ȯ
select 
round(1234.5678),
round(1234.5678,0),   --�Ҽ��� ��ȯ ����(�⺻��) 1235
round(1234.5678,1),   --�Ҽ��� ù°�ڸ����� ��ȯ 1234.6
round(1234.5678,2),   --�Ҽ��� ��°�ڸ����� ��ȯ  1234.57
round(1234.5678,-1)   --�����ڸ����� �ݿø�(.���� ��ĭ�� �տ��� �ݿø�) 1230
from dual;

--trunc �Լ� : ���� ������ ��ȯ
select 
trunc(1234.5678),
trunc(1234.5678,0),   --0������ �ڸ��� ����ϰ� �������� ������  1234
trunc(1234.5678,1),   --�Ҽ��� ù��° �ڸ������� ��ȯ�ϰ� ������ ����  1234.5
trunc(1234.5678,2),   --1234.56
trunc(1234.5678,-1)   --1230
from dual;

--ceil �Լ� : �ڽź��� ū ���� �� ���� ����� ����
--floor �Լ� : �ڽź��� ���� ���� �� ���� ����� ����
select
ceil(3.14),    -- 4
floor(3.14),   -- 3
ceil(-3.14),   -- -3
floor(-3.14)   -- -4
from dual;

--mod �Լ� : ������ ���ؼ� ��ȯ
select mod(5,2),mod(10,4)
from dual;

select *
from emp
where mod(empno,2) = 1;   --����� Ȧ���� ��� ��ȸ

------------------------------------------------------------------------------
--3. ��¥�Լ�

--sysdate �Լ� : ���� �ý����� ��¥ ��ȸ
select sysdate -1 as ����, sysdate, sysdate +1 as ����
from dual;

--��¥�� ��¥ ���� -> �ϼ��� ��ȯ��
select sysdate - hiredate as �ٹ��ϼ�    --���̰� �ϼ� ��ȯ
from emp;

--�ټӳ��
select trunc((sysdate - hiredate)/365) as �ټӳ��
from emp;

--��¥ �������� �ݿø�
--���� 1
select sysdate,
round(sysdate,'cc') as format_cc,
round(sysdate,'yyyy') as format_yyyy,
round(sysdate,'q') as format_q,
round(sysdate,'ddd') as format_ddd,
round(sysdate,'hh') as format_hh
from dual;

--���� 2
select sysdate,
trunc(sysdate,'cc') as format_cc,
trunc(sysdate,'yyyy') as format_yyyy,
trunc(sysdate,'q') as format_q,
trunc(sysdate,'ddd') as format_ddd,
trunc(sysdate,'hh') as format_hh
from dual;

--------------------------------------------------------------------------------
--4. �ڷ�����ȯ �Լ�
--to_char() : ���� > ���� / ��¥ > ����
--to_number() : ���� > ����
--to_date() : ���� > ��¥

--��¥ > ����
--to_char(��¥������,ǥ���� ����)
select sysdate, to_char(sysdate,'YYYY-MM-DD-DAY HH24:MI:SS') as ����ð�
from dual;

select hiredate, to_char(hiredate,'YYYY-MM-DD-DAY HH24:MI:SS') as �Ի�����
from emp;

--���� > ����
--to_char(���ڵ�����, ǥ���� ����)
select to_char(123456, 'L999,999')   --L�� ����ȭ�� ������ ��Ÿ�� / 9�� ���ڸ� ����
from dual;

select sal, to_char(sal,'L000,000')  --0�� ���ڸ��� 0���� ��Ÿ��
from emp;

--���� > ����
--to_number(���ڵ�����, ǥ���� ����) : ���ڵ����ʹ� ������ ������ ������Ѵ�.
select '20000' - 10000  --�ڵ�����ȯ
from dual;

select '20,000' - '5,000'   --to_number()�� �̿��� ��������ȯ �ʿ�
from dual;

select to_number('20,000','999,999') - to_number('5,000','999,999')
from dual;

--���� > ��¥
--to_date(���ڵ�����, ǥ���� ����) : ���ڵ����͵� ��¥�� ������ ������Ѵ�.
select to_date('20221019','YYYY/MM/DD')
from dual;

select *
from emp
where hiredate < to_date('19820101','YYYY-MM-DD');

------------------------------------------------------------------------------
--5. null ó�� �Լ�
--nvl(null, �ٲٰ� ���� ������)
--nvl�� null �������� Ÿ�԰� ������ Ÿ������ �����ؾ��Ѵ�.
--nvl(����, ����) , nvl(���� , ����)
select ename �����,sal,sal * 12 + nvl(comm,0) as ����,comm
from emp;                       --nvl(comm(���ڵ�����),����0)

select ename,job,mgr
from emp
where mgr is null;

select ename,job,nvl(to_char(mgr,'9999'),'CEO') as mgr   --mgr�� ����Ÿ���̰� CEO�� �����̹Ƿ� Ÿ���� ����ġ�� -> to_char�� �̿��Ͽ� ����Ÿ������ ��ȯ
from emp
where mgr is null;

select comm,nvl2(comm,'O','X') --null�� ���� O��ȯ, null�� �ƴϸ� X��ȯ / Ÿ�� ��� ��
from emp;

------------------------------------------------------------------------------
--6. ���ǹ� ǥ���ϴ� �Լ�
--decode()  -> switch 
--case()    -> if

--decode() �Լ�
select ename,job,deptno,
    decode(deptno,10,'AAA',20,'BBB',30,'CCC','��Ÿ') as �μ���   --�������� ����Ʈ��
    --deptno�� 10�� ���ؼ� ������ AAA, deptno�� 20�̶� ���ؼ� ������ BBB ... �̷������� �����
from emp;

--case() �Լ�
--������ �������� ��������
--  case 
--       when ���ǽ� then ���๮
--       when ���ǽ� then ���๮
--       else ���๮
--  end as ��Ī
select ename,job,deptno,
    case
    when deptno = 10 then 'AAA'
    when deptno = 20 then 'BBB'
    when deptno = 30 then 'CCC'
    else '��Ÿ'
end as �μ���
from emp;

select ename,job,sal,
    case 
    when sal between 3000 and 5000 then '�ӿ�'
    when sal >= 2000 and sal < 3000 then '������'
    when sal >= 500 and sal < 2000 then '���'
    else '��Ÿ'
end as ����
from emp;

--------------------------------------------------------------------------------
--���� 1
select 
empno,rpad(substr(empno,1,2),4,'*') as MASKING_EMPNO,
ename,rpad(substr(ename,1,1),length(ename),'*') as MASKING_ENAME
from emp
where length(ename) >=5 and length(ename) <6;

--���� 2
select empno,ename,sal,
trunc((sal/21.5),2) as DAY_PAY,
round((sal/21.5/8),1) as TIME_PAY
from emp;

--���� 4
select empno,ename,mgr,
case 
    when mgr is null then '0000'
    when substr(mgr,1,2) = '75' then '5555'
    when substr(mgr,1,2) = '76' then '6666'
    when substr(mgr,1,2) = '77' then '7777'
    when substr(mgr,1,2) = '78' then '8888'
    else to_char(mgr)
end as CHG_MGR
from emp;

-------------------------------------------------------------------------------
--7. ������ �Լ�(�׷��Լ�)
--sum(),avg(),count(),max(),min()
--����� �ϳ��� ������ ��ȯ��
--�Ϲ� �÷��� ���� ��� �Ұ�
--ũ�� �񱳰� ������ ��� Ÿ�Կ� ��� ����(��¥, ���� ...)

--��ü ������ ������ ����
select sum(sal)   -29025
from emp;

select avg(sal)
from emp;

--count(*) : ��ü ���ڵ��� ���� Ȯ��
select count(*),count(comm)
from emp;

select max(sal),min(sal)
from emp;

select ename,max(sal)   --������ �Լ��� �Ϲ� �÷��� ���� ����� �� ����.
from emp;

--��¥ �񱳵� ����
select min(hiredate)    --���� ���� ���� ����(�Ի����� ���� ���� ���)
from emp
where deptno = 20;

select max(hiredate)    --���� �ֱٿ� �Ի��� ����
from emp
where deptno = 20;

--------------------------------------------------------------------------------
--select �÷���
--from ���̺��
--where ���ǽ�(�׷��Լ� ��� �Ұ�/group by,having ���� ���� ����)
--group by ���� �÷���
--having ���ǽ�(��κ� �׷��Լ� ���)
--order by �÷��� ���Ĺ�� ===> �׻� �� �������� �ۼ�

--group by��
select avg(sal) from emp where deptno = 10   --deptno�� 10�� �μ��� sal ���
UNION
select avg(sal) from emp where deptno = 20   --deptno�� 20�� �μ��� sal ���
UNION
select avg(sal) from emp where deptno = 30;  --deptno�� 30�� �μ��� sal ���

select deptno
from emp
group by deptno;

select deptno, avg(sal)   --���� ������ ���� ���� ���� ��� ����
from emp
group by deptno
order by deptno;

select deptno,job,avg(sal)
from emp
group by deptno,job
order by deptno,job desc;


--having��
--group by�� ���� ��ȸ�� ���� ���� ������ �Ǵ�.
--���ǽ��� �ۼ��� �� �׷��Լ��� ����Ѵ�.
select deptno, avg(sal)
from emp
group by deptno
having avg(sal) >= 2000;   
-- �μ�(deptno)�� ����� ���ϰ� �� ����� 2000�̻��� ��� ��ȸ

select deptno, avg(sal)
from emp
where deptno != 10
group by deptno
having avg(sal) >= 2000;

--------------------------------------------------------------------------------
--����(join)
--2�� �̻��� ���̺��� �����͸� ��ȸ
--from ���� �ΰ� �̻��� ���̺��� �ۼ��Ѵ�.
--where ���� ���� ������ �ۼ��Ѵ�.

--cross join (where �� ���� ����)
--equals join (where ���� ������� ��� : =)
--non equals join (where ���� ���������� ��� : and,or)
--self join (where ���� �ϳ��� ���̺��� ���)
--out join ( where ���� ������ �����͸� ���� ��ȸ�ϱ� ���� ��� : (+))

--equals join
--emp ���̺��� ����� �ٹ��μ�(dname)�� ��ȸ�ϱ� ���� dept ���̺��� ������ -> �� ���̺��� ����ɷ��� deptno(�μ���ȣ)�� ����Ͽ� ��ȸ
select ename,job,e.deptno,dname,loc  --�÷����� �ߺ��Ǵ� ��쿡�� �տ� ���̺���� �������
from emp e,dept d   --���̺� ��Ī �ο� => ��Ī�� �ִ� ���� ���̺���� ���� ���� ��Ī�� ���������Ѵ�.
where e.deptno = d.deptno and sal >= 3000;

--non equals join
--emp ���̺� ����� �޿����(grade)�� ��ȸ�ϱ� ���� salgrade ���̺��� ���� -> between and�� ����Ͽ� sal�� ���� ���ؼ� ��ȸ
select ename,sal,losal,hisal,grade
from emp e,salgrade s
--where e.sal >= s.losal and e.sal <= s.hisal
where e.sal between s.losal and s.hisal
order by grade;

--���, �̸�, �޿�, �μ���ȣ, �μ���, �޿���� 
--emp             dept           salgrade
--3������ ���̺� ��ȸ
select empno,ename,sal,e.deptno,dname,grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno and e.sal between s.losal and s.hisal; 

--self join : ��ȸ�Ϸ��� �����Ͱ� �� ���̺� �ȿ� ����ִ� ��쿡 ���
select e.empno,e.ename,e.mgr,m.ename   --����� mgr(�Ŵ���)�� �̸��� ���� ��ȸ�Ϸ��� �� -> mgr �̸��� emp ���� ���̺� �ȿ� �������
from emp e, emp m  -- emp e(���)  emp m(�Ŵ���) �� ���̺������� ������ ����Ѵٰ� �����ϸ� �� **���̺��� �̸��� ������ �ݵ�� ��Ī �ο�
where e.mgr = m.empno;    -- emp ���̺�ȿ� mgr ��ȣ�� mgr ��ȣ �� empno ��ȣ�� ���Ͽ� �������� Ȯ��
--mgr�� �����ȣ�̱� ������ mgr�� ��ȣ�� �����ȣ�� �����ϴٸ� �� ����� mgr��ȣ�� �̸��� �Ǳ� ������ mgr ��ȣ�� empno �����ȣ�� ��Ȯ��

--scott�� ���� �μ��� �ִ� ����� ��ȸ
--ename   ename
--scott   smith
--scott   jones
--scott   adams
--scott   ford
select work.ename , friend.ename   --scott�� �̸��� scott�� ���� �μ��� ���ϴ� ���
from emp work, emp friend
where work.deptno = friend.deptno and work.ename = 'SCOTT' and friend.ename != 'SCOTT';
--work������ �μ���ȣ�� friend�� �μ���ȣ�� �����鼭 work���� �̸��� scott�� ��� = work.ename
--work������ �μ���ȣ�� friend�� �μ���ȣ�� �����鼭 freind���� �̸��� scott�� �ƴ� ��� = freind.ename
--=> scott�� �μ��� ���� ������� ��ȸ

--out join(�ܺ�����)
--��� �����Ǵ� �����͸� ���� ��ȸ�ϱ� ���� ���
select e.empno,e.ename,e.mgr,m.ename   
from emp e, emp m  
where e.mgr = m.empno(+);   --mgr�� null�� �����ʹ� ������(king) ->�����Ͱ� ������ ���̺� �ʿ� (+)�� ���δ�.

select ename,sal,d.deptno,dname
from emp e, dept d
where e.deptno(+) = d.deptno  --emp ���̺��� �μ��� 10~30���� �ְ� dept ���̺��� 10~40���� �־ 40�� �����ǹǷ� d.deptno�� (+)����
order by deptno;
------------------------------------------
--ANSI-JOIN(ǥ�� ���� ���)
--cross join
--natural join
--inner join(equal, non equal)
--outer join( (+) ) - [left , right , full] outer  join   // full�� ���� ���̺� �����Ǵ� �����͸� ��� ��ȸ����

--inner join(equal)
select ename,sal,dname,loc
from emp e inner join dept d
on e.deptno = d.deptno;  --where ��� on ���

select ename,sal,dname,loc
from emp e join dept d
using(deptno)   --�� ���̺��� ���ϴ� �÷����� ������ �� ���
where ename = 'SCOTT';   --�߰������� ���� ���� �� ���

--ANSI-JOIN ���� self join �ϴ� ���
select e.empno,e.ename,e.mgr,m.ename
from emp e inner join emp m
on e.mgr = m.empno;   --mgr�� �̸� ��ȸ

--inner join(non equal)
select empno,ename,sal,grade
from emp e inner join salgrade s
on e.sal between s.losal and s. hisal;

--ANSI-JOIN ���� out join(�ܺ�����)�� ����Ͽ� �������� �������� ��ȸ�ϴ� ���
select e.empno,e.ename,e.mgr,m.ename
from emp e left outer join emp m  -- �����Ͱ� �ִ� ���� �����Ѵ�.
on e.mgr = m.empno;

--ANSI-JOIN�� �̿��Ͽ� dept ���̺� �ִ� 40�� �μ��� �������� �ʰ� ��ȸ�ϴ� ���
select ename,sal,d.deptno,dname
from emp e right outer join dept d
on e.deptno = d.deptno;

--3������ ���̺��� ANSI-JOIN���� ǥ���Ͽ� ��ȸ�ϴ� ���
select empno,ename,sal,d.deptno,dname,grade
from emp e inner join dept d
on e.deptno = d.deptno
inner join salgrade s
on e.sal between s.losal and s.hisal;

--�������� 1
select d.deptno,dname,empno,ename,sal
from emp e inner join dept d
on e.deptno = d.deptno 
where e.sal > 2000
order by deptno;

--�������� 2
select d.deptno, d.dname, trunc(avg(sal)) as AVG_SAL, max(sal) as MAX_SAL , min(sal) as MIN_SAL , count(*) as CNT
from emp e inner join dept d
--using(deptno)  -> ��Ī ���� ���� ������ ����
on e.deptno = d.deptno 
group by d.deptno, d.dname;

--�������� 3
select d.deptno,dname,empno,ename,job,sal
from emp e right outer join dept d
on e.deptno = d.deptno
order by d.deptno, e.ename;

--�������� 4
select d.deptno,d.dname,
       e.empno,e.ename,e.mgr,e.sal,e.deptno as DEPTNO_1,
       s.losal,s.hisal,s.grade,
       m.empno as MGR_EMPNO, m.ename as MGR_ENAME
from emp e right outer join dept d
on e.deptno = d.deptno
    full outer join salgrade s
on e.sal between s.losal and s.hisal
    left outer join emp m
on e.mgr = m.empno
order by d.deptno , e.empno;

--------------------------------------------------------------------------------
--��������
--select ������ ��ø�ؼ� ���

--������ ��������: �������� �Ѱ�
select ename, max(sal)  --���� �Լ��� ������ �Լ��� ���� �� �� ���� 
from emp;
-- =
select ename,sal
from emp
where sal = 
(select max(sal)   -- ���������� �̿��ؼ� �����Լ��� ������ �Լ��� ��
from emp);

select deptno
from emp
where ename = 'SCOTT';
-- +
select dname
from dept
where deptno = 20;
-- = 
select dname   --��������
from dept
where deptno = 
(select deptno  --��������
from emp
where ename = 'SCOTT');

-- DALLAS �ٹ��ϴ� ����� �̸�, �μ���ȣ ��ȸ
select ename, deptno
from emp
where deptno = 
(select deptno
from dept
where loc = 'DALLAS');

-- �ڽ��� ���ӻ���� king �� ����� �޿��� ��ȸ�ϼ���(����������)
select ename, sal
from emp
where mgr = 
(select empno
from emp
where ename = 'KING');
--ename �� king �� ����� �����ȣ�� mgr(�Ŵ���)��ȣ�� ��


--������ �������� : �������� ������
--in : ��� �߿� �ϳ��� �����ϸ� �ȴ�.
--any : �ε�ȣ ��� / ��� �߿� ���� ���� �� or ū ������ ũ�ų� ������ �ȴ�.
--all : �ε�ȣ ��� / ��� �߿� ���� ū ������ ũ�� �ȴ�.
select *
from emp
where sal in(5000,3000,2850);

--in => ���������� �����Ͱ� ���������� ��� �� �ϳ��� ��ġ�ϸ� true
select *
from emp
where sal in
(select max(sal)
from emp
group by deptno);  --�� �μ����� ���� ������ ���� ��� ��ȸ

--any => ���������� ���ǽ��� �����ϴ� ���������� ����� �ϳ� �̻��̸� true
select *
from emp
where sal > any  -- ���������� ����� �� ���� ���� ������ ū �� (���������� ���� ���� ������� 2850���� ū ��)
(select max(sal)
from emp                 
group by deptno);      

select *
from emp
where sal < any  -- ���������� ����� �� ���� ū ������ ���� �� (���������� ���� ���� ū ������� 5000���� ���� ��)
(select max(sal)
from emp
group by deptno);

--all => ���������� ���ǽ��� ���������� ����� ��� �����ϸ� true
select ename,sal
from emp
where sal > all  --���� ū ������ ū �� (30�� �μ��� ���� �� ���� ū ���� 2850���� ū �� = 2850 �̻��� ��)
(select sal
from emp
where deptno = 30);


--���߿� ��������
--���� ������ �޾ƿͼ� �������� ���
select *
from emp
where (deptno,sal) in   --and�� ����ؼ� ����ϴ� ��
(select deptno,max(sal)
from emp
group by deptno);























