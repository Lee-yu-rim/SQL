set serveroutput on;  

--���� ���ν��� : ���ν����� �������� �ʴ� �̻� ����ؼ� ����� �� ����
--1.����(create)
--2.����(execute / exec)

--create or replace procedure ���ν����� (�Ű�����)
--is / as
--  ��������
--begin
--  sql
--  ��±���
--  ���ǹ� , �ݺ��� ...
--end;
--/

drop table emp01;

create table emp01
as
select * from emp;

--����
create or replace procedure emp01_print
is 
    vempno number(10);
    vename varchar2(10);
begin
    vempno := 1111;
    vename := 'Hong';
    
    dbms_output.put_line(vempno ||' '|| vename);
end;
/

--����
execute emp01_print; 

--����
create or replace procedure emp01_del
is
begin
    delete from emp01;
end;
/

exec emp01_del;

select * from emp01;

--���ϴ� �����͸� �����
create or replace procedure del_ename(vename emp01.ename%type)
is
begin
    delete from emp01
    where ename = vename;   --�Ű������� �̿��� ������ ����
end;
/

exec del_ename('SCOTT');

select * from emp01
where ename = 'SMITH';

exec del_ename('SMITH');

--���� ���ν����� �Ű����� ����
--in , out , in out
--in : ���� ���� �޴� �뵵 , �Ű����� �ȿ� �⺻������ �����Ǿ�����
--out : ���ν��� ������ ���� ����� �ܺη�(���� ��û�� ��) ����
--in out : in + out ���

--����� ���� Ư�� ��� ��ȸ
create or replace procedure sel_empno 
(
    vempno in emp.empno%type,
    vename out emp.ename%type,
    vsal out emp.sal%type,
    vjob out emp.job%type
)
is
begin
    select ename,sal,job
    into vename,vsal,vjob   --�Ű������� ���ǵ� �������� is �ȿ��� ���� ���� �����ʰ� �ٷ� into���� ���
    from emp
    where empno = vempno;
end;
/

--���ε� ���� ����
variable var_ename varchar2(15);
variable var_job varchar2(9);
variable var_sal number;   
--���ε� �������� number Ÿ���� ũ�⸦ �������� �ʴ´�.

exec sel_empno (7499,:var_ename,:var_sal,:var_job);  
--in Ÿ�Կ��� ���� �־��ְ�, out Ÿ�Կ��� ���� �޾ƿ��� ���ε� ������ �־��ش�.
--���ε� ������ ����� �� �տ� : �� �ٿ����Ѵ�, ������ �� x

print var_ename;
print var_sal;
print var_job;


--��� ������ �����ϴ� ���� ���ν��� 
--���,�̸�,��å,�Ŵ���,�μ�
--��������� �Ű������� ����Ͽ� �޾ƿ´�.

drop table emp02;

create table emp02
as
select empno,ename,job,mgr,deptno
from emp
where 1 != 1;

create or replace procedure info_emp
(
    vempno emp02.empno%type,
    vename emp02.ename%type,
    vjob emp02.job%type,
    vmgr emp02.mgr%type,
    vdeptno emp02.deptno%type
)
is

begin
    insert into emp02
    values (vempno,vename,vjob,vmgr,vdeptno);
end;
/

exec info_emp (1111,'hong','SALES',2222,10);

select * from emp02;

--------------------------------------------------
--���� �Լ�
--���� �Լ��� ���� ���ν����� ������ : return �� ����
--1.����(create)
--2.����(exxcute / exec)

--create or replace function �Լ���(�Ű�����)
--  return ���� Ÿ��  --�����ݷ� ����
--is
--begin
--  sql ����
--  ����Լ�
--  ���ǹ�,�ݺ���...

--  return ���ϰ�;  --�����ݷ� �ʼ�
--end;
--/

create or replace function cal_bonus(vempno emp.empno%type)
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

exec :var_res := cal_bonus(7788);   
--execute �ڿ� ���ε� ������ �����ؾ��Ѵ�.

print var_res;

drop procedure info_emp;

drop function cal_bonus;

--------------------------------------
--Ŀ��
--declare
--    Ŀ�� :select ������ �����ϴ� ����� ����Ų��.
--    cursor Ŀ���� is sql ����(select ����);  --Ŀ������
--begin
--    open Ŀ����;   
--    loop
--      fetch Ŀ���� into ������;   --���̺�κ��� ���ڵ带 �����ͼ� ������ �����ϴ� ����
--      exit when Ŀ����%notfound;  --Ŀ���� ����Ű�� �����Ͱ� ���� �� ����
--    end loop;
--    close Ŀ����;
--end;
--/


declare
    cursor c1 is select * from emp;
    vemp emp%rowtype;
begin
    open c1;   
    loop
      fetch c1 into vemp;  
      exit when c1%notfound;  --emp ���̺� �ִ� 14���� �����͸� �� �������� �ݺ��� ����
      dbms_output.put_line(vemp.empno ||' '|| vemp.ename ||' '|| vemp.job ||' '|| vemp.mgr ||' '|| vemp.hiredate ||' '|| vemp.sal ||' '|| vemp.comm ||' '|| vemp.deptno);
    end loop;
    close c1;
end;
/

--for���� �̿��� cursor ���
declare
    cursor c1 is select * from dept;
    vdept dept%rowtype;
begin
    for vdept in c1 loop
        exit when c1%notfound;
        dbms_output.put_line(vdept.deptno ||' '|| vdept.dname ||' '|| vdept.loc);
    end loop;
end;
/















































