-- ��¥�Լ�

-- SYSDATE : ���� ��¥�� ��ȸ
    -- sysdate -1 : ����
    -- sysdate : ����
    -- sysdate +1 : ���� 
-- round
-- trunk
select sysdate -1 from dual;
select sysdate from dual;
select sysdate +1 from dual;

select sysdate - hiredate as �ٹ��ϼ� from emp; --�� ���̴� �ϼ��� ��ȯ��

-- �ټӳ��
select trunc((sysdate - hiredate) / 365) as �ټӳ�� from emp; --�����ڰ� �ΰ� �̻� ���� ��ȣ�� ����α�


select sysdate,
    round(sysdate,'CC') as format_cc, 
    round(sysdate,'YYYY') as format_yyyy, 
    round(sysdate,'Q') as format_Q, 
    round(sysdate,'DDD') as format_DDD,
    round(sysdate,'HH') as format_HH
FROM DUAL;

select sysdate,
    trunc(sysdate,'CC') as format_cc, 
    trunc(sysdate,'YYYY') as format_yyyy, 
    trunc(sysdate,'Q') as format_Q, 
    trunc(sysdate,'DDD') as format_DDD,
    trunc(sysdate,'HH') as format_HH
FROM DUAL;

--�ڷ�����ȯ �Լ�
--to_char()
--to_number() :���ڰ� ���� �������� �����ؾ���
--to_date()


--��¥�� ���ڷ�
select sysdate, to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') as ����ð� from dual;
select hiredate, to_char(hiredate,'YYYY-MM-DD HH24:MI:SS:DAY') from emp;

select to_char(123456,'L999,999') from dual; --���ڸ����� , �� ����ش޶�
select to_char(sal,'L999,999') from emp; --���ڸ��� Ư���� ä��������
select to_char(sal,'L000,000') from emp; --���ڸ��� 0���� ä��


--���ڸ� ���ڷ�
select '20000' - 10000 from dual; --�ڵ�����ȯ�� �Ͼ��.
select '20,000' - '10,000' from dual; 
--��� �ڵ�����ȯ�� �Ͼ�� ����. to_number() ����ȯ�� �ؾ��Ѵ�.

select to_number('20,000','999,999') - to_number('5,000','999,999') from dual;

--���ڸ� ��¥�� �ٲٱ�
select to_date('20221019','YYYY/MM/DD') from dual; 
select * from emp where hiredate < to_date('19820101','YYYY/MM/DD');

-- null������ ó��
-- nvl(null,�ٲٰ���� ������)
-- nvl�� null�������� Ÿ�԰� ���� Ÿ������ �������־�� �Ѵ�.
-- nvl(����, ����), nvl(����,����)
select ename �����, sal, sal * 12 + nvl(comm,0) as ����, comm from emp;

select * from emp where mgr is null;
select ename,job,mgr from emp where mgr is null;

--���� ���� ����. �޸� �����صα�
select ename,job,nvl(mgr,'CEO') from emp where mgr is null;
select ename,job,nvl(to_char(mgr,'9999'),'CEO')as mgr from emp where mgr is null;

--null�̸� ���� ��, �ƴ϶�� �տ���
select comm, nvl2(comm,'O','X') from emp;

-- ���ǹ� ǥ���ϴ� �Լ�
-- decode() -> switch
-- case() -> if

select ename,job,deptno,decode(deptno,10,'AAA',20,'BBB',30,'CCC','��Ÿ')as �μ��� from emp;

--������ ���ǽ����� ���� �� �� �ִ�.
case
    when ���ǽ� then ���๮
    when ���ǽ� then ���๮
    when ���ǽ� then ���๮
    else
end as ��Ī

select ename, job, deptno,
    case
    when deptno = 10 then 'AAA'
    when deptno = 20 then 'BBB'
    when deptno = 30 then 'CCC'
    else '��Ÿ'
    end as �μ���
from emp;


    --case sal>= 3000 and sal <= 5000 then'�ӿ�'
select ename,job,sal, 
    case
        when sal between 3000 and 5000 then'�ӿ�'
        when sal < 3000 and sal >= 2000 then '������'
        when sal >= 500 and sal < 2000 then '���'
        else '��Ÿ'
    end as ����
from emp;


------------------------------------------------------
-- 1������
select rpad('930103-',14,'*') from dual;

select empno,rpad(substr(empno,1,2),4,'*'),ename,rpad(substr(ename,1,1),length(ename),'*')
from emp
where ename like '_____';
--where length(ename) >= 5 and length(ename) <6;


--2������
select empno,ename,sal, trunc((sal / 21.5),2) as DAY_PAY,round((sal / 21.5)/8,1) as TIME_PAY from emp;


--4������ 
select empno, ename, mgr,
    case
        --when mgr != 1 then 0000
        when substr(mgr,1,2) = 75 then '5555'
        when substr(mgr,1,2) = 76 then '6666'
        when substr(mgr,1,2) = 77 then '7777'
        when substr(mgr,1,2) = 78 then '8888'
        when mgr is null then '0000'
        else to_char(mgr)
        end as CHG_MGR
from emp;
-- substr�� ��Ȯ�� �����ؼ� Ǯ������ �ٽ� ��� �����صѰ�

select sal from EMP;
select sum(sal) from emp; --��
select avg(sal) from emp; --���
select count(*) from emp; --��ü���� ���� ���� ex)�Խ����� �Խñ� ����
select max(sal),min(sal) from emp;
select count(*),count(comm) from emp; --Ư�� �÷��� ī��Ʈ �� �� ����.
select min(hiredate),max(hiredate) from emp where deptno = 20;

-- �׷��Լ�
-- sum(),avg(),count(),max(),min(),
-- �Ϲ� �÷��� ���� ����� �Ұ����ϴ�.
-- ������ ��ȸ�Ǵ� ������ ���ٸ� �Բ� ��밡���ϴ�.
-- ũ�� �񱳰� ������ ��� Ÿ�Կ� ��밡���ϴ�.

-- select �÷���
-- from ���̺��
-- where ���ǽ�(�׷��Լ� ���Ұ�/group by, having ���� ���� ����)
-- group by �����÷���
-- having ���ǽ� -> ���ǽ��� �ι����� �����  (�׷��Լ��� ����Ѵ�)
-- order by �÷��� ���Ĺ�� => �� �������� �ۼ��Ѵ�.

select avg(sal) from emp where deptno = 10
union
select avg(sal) from emp where deptno = 20
union
select avg(sal) from emp where deptno = 30;

select deptno from emp group by deptno;
select deptno, avg(sal) from emp group by deptno order by deptno;
select deptno,job, avg(sal) from emp group by deptno ,job order by deptno, job, desc; --orderby �� ������ �������� �տ� �ִ� �ͺ��� ���ʴ�� �����Ѵ�. deptno��� ���ĵ� �� �߿��� job���� �ٽ� �����ϰ� desc�� �����ϴ�...

select deptno, avg(sal) 
from emp 
group by deptno 
having avg(sal)>2000; --group by�� ���ؼ� ��ȸ ����� ������ �ش�. ���ǽ��� �ۼ��� �� �׷��Լ��� ����Ѵ�.

select deptno, avg(sal) 
from emp 
where deptno != 10
group by deptno 
having avg(sal)>=2000;