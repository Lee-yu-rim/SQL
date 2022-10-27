--PL/SQL : Ȯ��Ǿ��� SQL ���
--����,���ǹ�,�ݺ���

--PL/SQL������ ����
--declare
--  ��������
--begin
--  SQL����
--  ��±��� -> �������� �������� �ݵ�� ����Լ��� ���ؼ� Ȯ���ؾ��Ѵ�.
--exception
--  ����ó������
--end;
--/

set serveroutput on;   --�� ������ �����ؾ� ����� ����

begin
    dbms_output.put_line('Hello World');   --����Լ�
end;
/
-----------------------------------------
declare
    --vempno number(4);  --������ ����
    --vename varchar2(10);
    
    --������ ����� �ʱ�ȭ
    vempno constant number(4) := 7777;   --����� ����
    vename varchar2(10) not null := 'SCOTT';  --null���� ������ ������ ��� �Ұ�
begin 
   --vempno := 7777;     --������ �ʱ�ȭ  /  := ���Կ�����
   --vename := 'SCOTT';
    
    dbms_output.put_line(' ��� / �̸� ');
    dbms_output.put_line(vempno ||' '|| vename);
end;
/
----------------------------------------------------
--������ �����ϴ� ���
declare
    --��Į�� ��� : ���� Ÿ�� ����
    --vempno number(4);
    --���۷��� ��� : ���� ���̺� �÷��� Ÿ�� ����
    vempno emp.empno%type := 7777;
begin
    --vempno := 7777;
    dbms_output.put_line(vempno);
end;
/
----------------------------------------------------
declare
    vempno emp.empno%type;
    vename emp.ename%type;
begin
    select empno,ename into vempno,vename
    from emp
    where empno = 7788;  --�������� ���� 1���� �ۿ� �ȵ��� ������ where���� ���� ������ ���� �ʼ������� �����ؾ��Ѵ�, �������� ������ 14���� ���� ��� �������� ���̱� ����
    
    dbms_output.put_line('��� / �̸�');
    dbms_output.put_line(vempno ||' '|| vename);
exception   
    when TOO_MANY_ROWS then dbms_output.put_line('���� ���� ������ �Դϴ�.');  --where�� �Ƚ��� ����� ����ó��
    when OTHERS then dbms_output.put_line('��� ���ܸ� ó���߽��ϴ�.');   --��� ���� ó��
end;
/
----------------------------------------------------------
declare
    --���̺� type : ���۷��� ����� ���� �迭 ������ Ÿ�� ���� => ����� ���� ����Ÿ��
    
    type empno_table_type is table of emp.empno%type
    index by binary_integer;
    
    type ename_table_type is table of emp.ename%type
    index by binary_integer;
    
    type job_table_type is table of emp.job%type
    index by binary_integer;
    
    type mgr_table_type is table of emp.mgr%type
    index by binary_integer;
    
    type hiredate_table_type is table of emp.hiredate%type
    index by binary_integer;
    
    type sal_table_type is table of emp.sal%type
    index by binary_integer;
    
    type comm_table_type is table of emp.comm%type
    index by binary_integer;
    
    type deptno_table_type is table of emp.deptno%type
    index by binary_integer;
    
    empnoArr empno_table_type;   --���̺� Ÿ�� ���� ����(�迭������ ���� ����) -> ���� �ȿ� �������� ���� ���� �� �ִ�. 
    enameArr ename_table_type;   
    jobArr job_table_type;
    mgrArr mgr_table_type;
    hiredateArr hiredate_table_type;
    salArr sal_table_type;
    commArr comm_table_type;
    deptnoArr deptno_table_type;
    
    i binary_integer := 0;
begin
    for k in (select * from emp) loop
        i := i + 1;
        empnoArr(i) := k.empno;
        enameArr(i) := k.ename;
        jobArr(i) := k.job;
        mgrArr(i) := k.mgr;
        hiredateArr(i) := k.hiredate;
        salArr(i) := k.sal;
        commArr(i) := k.comm;
        deptnoArr(i) := k.deptno;
        
    end loop;
    
    for j in 1..i loop
        dbms_output.put_line(empnoArr(j) ||'  '|| enameArr(j) ||'  '|| jobArr(j) ||'  '|| mgrArr(j) ||'  '|| hiredateArr(j) 
        ||'  '|| salArr(j) ||'  '|| commArr(j) ||'  '|| deptnoArr(j));
    end loop;
end;
/
---------------------------------------------------------
declare
    --���ڵ� type : �������� ������ ��� ����Ѵ�. => ����� ���� ����Ÿ��
    --�ڹ��� Ŭ������ ������
    
    type emp_record_type is record (
        v_empno emp.empno%type,
        v_ename emp.ename%type,
        v_job emp.job%type,
        v_deptno emp.deptno%type
    );
    
    emp_record emp_record_type;   --���ڵ� Ÿ�� ���� ����

begin 
    select empno,ename,job,deptno
    into emp_record
    from emp
    where empno = 7788;
    
    --��½� ��������� ����Ͽ� �Է��Ѵ�.
    dbms_output.put_line(emp_record.v_empno ||' '|| emp_record.v_ename ||' '|| emp_record.v_job ||' '|| emp_record.v_deptno);
    
end;
/
-----------------------------------------------------
create table dept_record
as
select * from dept;

--���ڵ� Ÿ���� �̿��Ͽ� ���̺� ������ ����(insert)
declare
    type rec_dept is record (
        v_deptno dept.deptno%type,
        v_dname dept.dname%type,
        v_loc dept.loc%type
    );
    
    dept_rec rec_dept;   -- ������ - ������ ������ ���ڵ�Ÿ��
    
begin
    dept_rec.v_deptno := 50;
    dept_rec.v_dname := 'DEV';
    dept_rec.v_loc := 'BUSAN';
    
    --������ ����
    insert into dept_record   --��ȣ ����
    values dept_rec;
    
end;
/

select * from dept_record;
-------------------------------------------------
--���ڵ� Ÿ���� �̿��Ͽ� ���̺� ������ ����(update)
declare
    type rec_dept is record (
        v_deptno dept.deptno%type not null := 99,  --�⺻���� 99�� ����(���� ��������� 99�� ��)
        v_dname dept.dname%type,
        v_loc dept.loc%type
    );
    
    dept_rec rec_dept;

begin
    dept_rec.v_deptno := 50;
    dept_rec.v_dname := 'PRESON';
    dept_rec.v_loc := 'SEOUL';
    
    --������ ����
    update dept_record
    set dname = dept_rec.v_dname,loc = dept_rec.v_loc
    where deptno = dept_rec.v_deptno;
    
end;
/

select * from dept_record;
--------------------------------------------------
--������ ����
declare
    v_deptno dept_record.deptno%type := 50;
begin
    delete from dept_record
    where deptno = v_deptno;
end;
/
------------------------------------------------------
--���ǹ�
--if(���ǽ�) then 
    --    ���๮
    --end if;
    
declare
    vempno number(4);
    vename varchar2(10);
    vdeptno number(2);
    vdname varchar2(10) := null;
begin
    select empno,ename,deptno
    into vempno,vename,vdeptno
    from emp
    where empno = 7788;
    
    if (vdeptno = 10) then
        vdname := 'aaa';
    end if;
    
    if(vdeptno = 20) then
        vdname := 'bbb';
    end if;
    
    if(vdeptno = 30) then
        vdname := 'ccc';
    end if;
    
    if(vdeptno = 40) then
        vdname := 'ddd';
    end if;
    
    dbms_output.put_line('�μ���: ' || vdname);
    
end;
/
------------------------------------
declare
    --%ROWTYPE : ���̺��� ��� �÷��� �̸��� ������ ����
    --�÷����� ���������� ���ǰ� �÷��� Ÿ���� ������ Ÿ������ ���
    vemp emp%rowtype;
begin
    select *
    into vemp
    from emp
    where empno = 7788;
    
    dbms_output.put_line(vemp.empno);
    dbms_output.put_line(vemp.ename);
    dbms_output.put_line(vemp.deptno);
    dbms_output.put_line(vemp.job);
    dbms_output.put_line(vemp.mgr);
    dbms_output.put_line(vemp.sal);
    dbms_output.put_line(vemp.comm);
    dbms_output.put_line(vemp.hiredate);
end;
/

--��Į�� ���
--���۷��� ���
    --1.�÷��� ���� ����
    --emp.empno%type
    --2.���̺� ��ü�� ��� ����
    --emp%rowtype
    
--����� ���� ���� Ÿ��
    --1.���̺� type
    --type empno_table_type is table of emp.empno%type
    --index by binary_integer;
    --2.���ڵ� type
    --type emp_record_type is record (
    --    v_empno emp.empno%type);

--

declare
    vemp emp%rowtype;
    annsal number(7,2); 
begin
    dbms_output.put_line('��� / �̸� / ����');
    dbms_output.put_line('--------------------');
    
    select * 
    into vemp
    from emp
    where empno = 7788;
    
    --�ش� ����� ���� ��� / Ŀ�̼��� null�� ��� 0���� ����Ͽ� ���
    
    --if �������� ���
    --if(vemp.comm is null) then
    --    vemp.comm := 0;
    --end if;
    
    --annsal := vemp.sal * 12 + vemp.comm;
    
    --if else �������� ���
    if(vemp.comm is null) then
        annsal := vemp.sal * 12;
    else
        annsal := vemp.sal * 12 + vemp.comm;
    end if;

    dbms_output.put_line(vemp.empno ||' '|| vemp.ename ||' '|| annsal);
end;
/

------------------------------------------------
--���� if ����

declare
    vemp emp%rowtype;
    vdname varchar2(10);
begin
    select *
    into vemp
    from emp
    where empno = 7788;
    
    if (vemp.deptno = 10) then
        vdname := 'AAA';
    elsif (vemp.deptno = 20) then
        vdname := 'BBB';
    elsif (vemp.deptno = 30) then
        vdname := 'CCC';
    elsif (vemp.deptno = 40) then
        vdname := 'DDD';
    end if;
    
    dbms_output.put_line(vdname);
end;
/

--���ǹ�
--if then end if;
--if then else end if;
--if then elsif then end if;

-----------------------------------------------------------------------------
--�ݺ���(���ѹݺ���)
--loop
--  ���๮
--  ���� �ݺ����� ����
--  1.exit when ���ǽ�;
--  2.if then end if;
--end loop;

declare
    n number := 1;
begin
    loop
        dbms_output.put_line(n);
        n := n + 1;
        exit when n > 10;   --�ݺ����� ���Ḧ ���� ����
    end loop;
end;
/

--for �ݺ���
declare
--�������� ���ʿ�
begin
    --in ���� �ڿ� �ۼ��Ǵ� ���� �ݺ��� Ƚ���� ������
    for n in 1..10 loop   -- in ���۰�..����  -> 1�� ����(10ȸ �ݺ�)
        dbms_output.put_line(n);
    end loop;
end;
/

declare

begin
    for n in reverse 1..10 loop   -- in ���۰�..����  -> 1�� ����(10ȸ �ݺ�)
        dbms_output.put_line(n);
    end loop;
end;
/

declare
    vdept dept%rowtype;
begin
    for n in 1..4 loop
        select *
        into vdept
        from dept
        where deptno = 10 * n;
        dbms_output.put_line(vdept.deptno ||' '|| vdept.dname ||' '|| vdept.loc);
    end loop;
end;
/

----------------------------------------------------------
--while �ݺ���
--while(���ǽ�) loop
--end loop;

declare
    n number := 1;
begin
    while(n <= 10) loop
        dbms_output.put_line(n);
        n := n + 1;
        end loop;
end;
/
declare
    vdept dept%rowtype;
    n number := 1;
begin
    while (n <= 4) loop
        select *
        into vdept
        from dept
        where deptno = 10 * n;
        dbms_output.put_line(vdept.deptno ||' '|| vdept.dname ||' '|| vdept.loc);
        n := n + 1;
    end loop;
end;
/

--�ݺ���
--loop end loop;
--for in loop end loop;
--while loop end loop;




















