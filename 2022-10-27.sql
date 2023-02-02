set serveroutput on;

declare
    vdept dept%rowtype;
    n number := 1;
begin
    while (n <= 4) loop
        select *
        into vdept
        from dept
        where deptno = 10 * n;
        dbms_output.put_line(vdept.deptno || ' ' || vdept.dname || ' ' || vdept.loc);
        n := n+1;
    end loop;
end;
/


-- ���� ���ν���
    -- 1. ����(create)
    -- 2. ����(execute or exec)
    -- ���౸���� �ۼ��ؼ� �����ؾ��Ѵ�.
-- �����

--create or replace procedure ���ν�����(�Ű�����) 
--
--is or as : ���� is�� ���� ����� : declare
--    ���� ����
--begin
--    SQL��
--    ��±���
--    ���ǹ�, �ݺ���
--end;
--/
--

drop table emp01;

create table emp01
as
select * from emp;

-------------------------------
--�������ν���

create or replace procedure emp01_print
is
    vempno number(10);
    vename varchar2(10);
begin
    vempno := 1111;
    vename := 'Hong';
    
    dbms_output.put_line(vempno || ' ' || vename);
end;
/

execute emp01_print;

create or replace procedure emp01_del
is 
    
begin
    delete from emp01;    
end;
/

execute emp01_del;

select * from emp01;

create or replace procedure del_ename(vename emp01.ename%type)
is

begin
    delete from emp01 
    where ename = vename;
end;
/

execute del_ename('SCOTT');
execute del_ename('SMITH');
-- ���ν����� �� ������ָ� �Ź� �����Ͽ� ������ �ʾƵ� �ȴ�. ���ν����� �������� �ʴ� �� �ݿ��������� ��밡��.


--���� ���ν����� �Ű����� ����
-- in, out, in out
-- in : ���� ���޹޴� �뵵
-- out : ���ν��� ������ ���� ����� ������ ��û�� ������ ���� ����
-- in out : in + out

create or replace procedure sel_empno
(
    vempno in emp.empno%type,
    vename out emp.ename%type,
    vsal out emp.sal%type,
    vjob out emp.job%type
)
is
begin
    select ename, sal, job
    into vename, vsal, vjob
    from emp
    where empno = vempno;
end;
/

--���ε庯�� ����� ��
variable var_ename varchar2(15);
variable var_sal number; --���� Ÿ���� ũ�� ����x!
variable var_job varchar2(9);

--exec sal_empno(7499,:���ε庯��1, :���ε庯��2, :���ε庯��3);
exec sel_empno(7499,:var_ename,:var_sal,:var_job);

print var_ename;
print var_sal;
print var_job;


-- ��� ������ �����ϴ� ���� ���ν��� 
-- ���, �̸�, ��å, �Ŵ���, �μ�
-- ��������� �Ű������� ����Ͽ� �޾ƿ´�.

drop table emp02;
create table emp02
as 
select empno, ename, job, mgr, deptno
from emp
where 1 != 1;

create or replace procedure insert_sawon
(
    vempno in emp02.empno%type,
    vename in emp02.ename%type,
    vjob in emp02.job%type,
    vmgr in emp02.mgr%type,
    vdeptno in emp02.deptno%type
)
is
begin
    insert into emp02
    values(vempno, vename, vjob, vmgr, vdeptno);
end;
/
exec insert_sawon(7499,'hong','sales',2222,10);

select * from emp02;


-- �����Լ�
-- �����Լ��� ���� ���ν����� ������ : return�� ����
-- 1. ����(create)
-- 2. ����(execute)
-- �����
--create or replace function �Լ���(�Ű�����)
--    return ���� Ÿ�� --�����ݷ��� �����Ѵ�.
--is
--begin
--    sql ����
--    ����Լ�
--    ���ǹ�,�ݺ���
--    return ���ϰ�; -- ������ ���⿡�� ���δ�.
--end;
--/

create or replace function cal_bonus( vempno emp.empno%type )
    return number
is
    vsal number(7,2);
begin
    select sal
    into vsal
    from emp
    where empno = vempno;
    
    return vsal * 200;
end;
/

variable var_res number;

execute :var_res := cal_bonus(7788); 
--exec���ʿ� ���ε� ������ �����ؾ��Ѵ�.

print var_res;

drop procedure insert_sawon;
drop function cal_bonus;

-------------------------------------------------------------------------------
-- Ŀ��
-- - �����͸� ������ �뵵
-- - select ������ �����ϴ� ����� ����Ų��.
-- �����
declare
    --Ŀ��
    cursor Ŀ���� is sql����(select); -- Ŀ�� ����
begin
    open Ŀ����;
    loop
        fetch Ŀ���� into ������; --���̺�κ��� �����ͼ� ������ �����ϴ� ����
        exit when Ŀ����%notfound;
    end loop;
    close Ŀ����;
end;
/
-----
declare

    cursor c1 is select * from emp;
    vemp emp%rowtype;
begin
    open c1;
    loop
        fetch c1 into vemp; 
        exit when c1%notfound;
        dbms_output.put_line(vemp.empno || ' ' || vemp.ename|| ' ' || vemp.job|| ' ' || vemp.mgr || ' ' || vemp.sal || ' ' || vemp.comm || ' ' || vemp.deptno || ' ' || vemp.hiredate);
    end loop;
    close c1;
end;
/


--for�� �̿�
declare

    cursor c1 is select * from dept;
    vdept dept%rowtype;
begin
    for vdept in c1 loop
        exit when c1%notfound;
        dbms_output.put_line(vdept.deptno || ' ' || vdept.dname || ' ' || vdept.loc);
    end loop;
end;
/

------------hr �̿�--------------------------
-- ����ϱ� ���̵�,�̸�,�̸��� ��, �μ��̸�
--employees, departments

-- ���ι��
select employee_id,first_name,last_name,department_name
from employees e inner join departments d
on e.department_id= d.department_id;

--��������
select employee_id, first_name, last_name,department_id,
    (
        select department_name
        from departments d
        where e.department_id = d.department_id
    )as dep_name
from employees e
where department_id = 100;


--���ν���(�Լ�)

create or replace function get_dep_name(dept_id number)
    return varchar2
is
    sDepName varchar2(30);
begin
    select department_name
    into sDepName
    from departments
    where department_id = dept_id;
    
    return sDepName;
end;
/

select employee_id, first_name,last_name,get_dep_name(department_id)
from employees e
where e.department_id = 100;

select sum(sal),max(sal)
from emp;

---------------------------
--����Ǯ��

--employees, jobs
--������̵�, �̸�, ��, job id
-- join ���,���������� ���, get_job_title �Լ� ���� ����ϴ� ���