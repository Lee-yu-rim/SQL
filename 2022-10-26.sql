--scott����

select * from emp;

set serveroutput on; --���� ����� ȭ�鿡 ���

--�⺻ ���๮
begin
    dbms_output.put_line('HELLO WORLD');
end;
/

--declare ���
declare 
    vempno number(4); --������ ����
    vename varchar2(10);
begin
    vempno := 7777; --������ �ʱ�ȭ
    vename:= 'SCOTT';
    
    dbms_output.put_line('���/�̸�');
    dbms_output.put_line(vempno ||' '|| vename);
end;
/

declare 
    vempno constant number(4) := 7777; --����� �ʱ�ȭ�� ���ÿ� �� ���� ����. constant�� �ٿ��ָ� ����� ���ǰ� �ȴ�.
    vename varchar2(10) not null := 'SCOTT'; --null���� ����� �� ����.
begin
    dbms_output.put_line('���/�̸�');
    dbms_output.put_line(vempno ||' '|| vename);
end;
/

declare
--��Į����
    --vempno number(4);
--���۷��� ���
    vempno emp.empno%type := 7777; --�̰͵� ����
begin
    --vempno := 7777;
    dbms_output.put_line(vempno);
end;
/


declare
    vempno emp.empno%type;
    vename emp.ename%type;
begin
    select empno, ename into vempno,vename
    from emp
    where empno = 7788; --(�ʼ�)
    dbms_output.put_line('���/�̸�');
    dbms_output.put_line(vempno ||' '|| vename);
exception
    when TOO_MANY_ROWS then dems_output.put_line('���Ǽ��� ������ �Դϴ�');
    when OTHERS then dbms_output_put_line('��� ���ܿ� ���� �޼���');
end;
/

declare
    -- ���̺� type(����� ���� ���� Ÿ���� ����)
    -- �迭�� ����
    -- vename varchar2(10)
    TYPE empno_table_type IS TABLE OF emp.job%type
    INDEX BY BINARY_INTEGER;
    TYPE ename_table_type IS TABLE OF emp.ename%type
    INDEX BY BINARY_INTEGER;
    TYPE job_table_type IS TABLE OF emp.job%type
    INDEX BY BINARY_INTEGER;
    TYPE mgr_table_type IS TABLE OF emp.job%type
    INDEX BY BINARY_INTEGER;
    TYPE sal_table_type IS TABLE OF emp.job%type
    INDEX BY BINARY_INTEGER;
    TYPE comm_table_type IS TABLE OF emp.job%type
    INDEX BY BINARY_INTEGER;
    TYPE deptno _table_type IS TABLE OF emp.job%type
    INDEX BY BINARY_INTEGER;
    
    empnoArr empno_table_type;
    enameArr ename_table_type; --�迭������ ���� ����
    jobArr job_table_type; --�迭������ ���� ����
    mgrArr mgr_table_type;
    salArr sal_table_type;
    commArr comm_table_type;
    deptnoArr deptno_table_type;
    
    i BINARY_INTEGER := 0;
begin
    for k in (select empno,ename,job,mgr,sal,comm,deptno from emp) loop
        i := i+1;
        empnoArr(i) := k.empno;
        enameArr(i) := k.ename;
        jobArr(i) := k.job;
        mgrArr(i) := k.mgr;
        salArr(i) := k.sal;
        commArr(i) := k.comm;
        deptnoArr(i) := k.deptno;
        
    end loop;
    
    for j in 1..i loop
        dbms_output.put_line(empnoArr(j)||' / '||enameArr(j) || ' / ' || jobArr(j)|| ' / '|| mgrArr(j)|| ' / ' ||salArr(j)|| ' / ' ||commArr(j)|| ' / ' ||deptnoArr(j));
    end loop;
end;
/

--���ڵ庯��
declare
    -- ���̺� type(����� ���Ǻ���Ÿ��)
    -- �迭�� ����
    -- vename varchar2(10)
    TYPE emp_record_type IS RECORD(
        -- �빮�� �κ��� �ʼ������� ����� ��.
        v_empno emp.empno%type,
        v_ename emp.ename%type,
        v_job emp.job%type,
        v_deptno emp.deptno%type
    );  
    emp_record emp_record_type; --���ڵ� Ÿ���� ������ �����
begin 
    -- ���ڵ� type(�������� ������ ��� ����Ѵ�) -> ����� ���� ���� Ÿ��
    -- Ŭ������ �����ϴ�.
    select empno, ename, job, deptno
    into emp_record
    from emp
    where empno = 7788;
    
    dbms_output.put_line( emp_record.v_empno || ' ' || emp_record.v_ename || ' ' || emp_record.v_job || ' ' || emp_record.v_deptno);
end;
/

create table dept_record
as 
select * from dept;

declare
    TYPE rec_dept IS RECORD (
        v_deptno dept_record.deptno%TYPE,
        v_dname dept_record.dname%TYPE,
        v_loc dept_record.loc%TYPE
    );
      
    dept_rec rec_dept;
begin
    dept_rec.v_deptno := 50;
    dept_rec.v_dname := 'DEV';
    dept_rec.v_loc := 'BUSAN';
    
    insert into dept_record
    values dept_rec;
    
    dbms_output.put_line( dept_rec.v_dname || ' ' ||dept_rec.v_loc || ' ' || dept_rec.v_deptno);
end;
/

-- ���� �����ϴ� �ڵ�
declare
    TYPE rec_dept IS RECORD (
        v_deptno dept_record.deptno%TYPE not null := 99, --�� ���� ������ �� ���� 99�� �ΰڴ�.
        v_dname dept_record.dname%TYPE,
        v_loc dept_record.loc%TYPE
    );
    dept_rec rec_dept;
begin
    dept_rec.v_deptno := 50;
    dept_rec.v_dname := 'INSA';
    dept_rec.v_loc := 'SEOUL';
    
    update dept_record
    set dname = dept_rec.v_dname, loc= dept_rec.v_loc
    where deptno =  dept_rec.v_deptno;
end;
/

-- delete
declare
    v_deptno dept_record.deptno%type := 50;
begin
    delete from dept_record
    where deptno = v_deptno;
end;
/


--���ǹ�
-- if(���ǽ�) 
--      ���๮
--  end if;
declare
    --��Į����
    vempno number(4);
    vename varchar2(10);
    vdeptno number(10);
    vdname varchar2(10) := null;
    
begin
    select empno, ename, deptno
    into vempno, vename, vdeptno
    from emp
    where empno = 7788;
    
    if(vdeptno = 10) then
        vdname := 'AAA';
    end if;
    if(vdeptno = 20) then
        vdname := 'BBB';
    end if;
    if(vdeptno = 30) then
        vdname := 'CCC';
    end if;
    if(vdeptno = 40) then
        vdname := 'DDD';
    end if;
    
    dbms_output.put_line(vdname);
end;
/

declare
    -- %rowtype : ���̺��� ��� �÷��� �̸��� ������ �����ϰڴ�.
    -- �÷����� ���������� ���ǰ� �÷��� Ÿ���� ������ Ÿ������ ����Ѵ�.
    
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
    dbms_output.put_line(vemp.sal);
    dbms_output.put_line(vemp.hiredate);
    dbms_output.put_line(vemp.comm);
    dbms_output.put_line(vemp.mgr);
end;
/

--��Į����
--���۷��� ���
-- 1. emp.empno%type
-- 2. emp%rowtype

-- ����� ���Ǻ���Ÿ��
-- 1. ���̺� type
    -- type xxxx
-- 2. ���ڵ� type


-- ����Ǯ��
-- rowtype���

declare
    vemp emp%rowtype;
    annsal number(7,2);
begin
    dbms_output.put_line('��� / �̸� / ����');
    dbms_output.put_line('-----------------');
    
    SELECT * 
    into vemp
    from emp
    where empno = 7788;
    if(vemp.comm is not null) then
        annsal := vemp.sal*12 + vemp.comm;
        dbms_output.put_line(vemp.empno||' '|| vemp.ename ||' '|| annsal);
    end if;
    if(vemp.comm is null) then
        annsal := vemp.sal*12;
        dbms_output.put_line(vemp.empno||' '|| vemp.ename ||' '|| annsal);
    end if;
    
    -- else if�������� ����ٸ�
    if(vemp.comm is not null) then
        annsal := vemp.sal*12 + vemp.comm;
        dbms_output.put_line(vemp.empno||' '|| vemp.ename ||' '|| annsal);
    else
        annsal := vemp.sal*12;
        dbms_output.put_line(vemp.empno||' '|| vemp.ename ||' '|| annsal);
    end if;
    --dbms_output.put_line(vemp.empno||' '|| vemp.ename ||' '|| annsal);
    -- �ش����� ������ ����ϼ���. ��, Ŀ�̼�(comm)�� null�� ��� 0���� ���ǰ� �ض�.
    
end;
/

--------------------

declare
    vemp emp%rowtype;
    vdname varchar2(10);
begin
    select * 
    into vemp
    from emp
    where empno = 7788;
    
    if(vemp.deptno = 10) then
        vdname := 'AAA';
    elsif(vemp.deptno = 20) then
        vdname := 'BBB';
    elsif(vemp.deptno = 30) then
        vdname := 'CCC';
    elsif(vemp.deptno = 40) then
        vdname := 'DDD';
    end if;
    
    dbms_output.put_line(vdname);
end;
/


------------------------------------------------
--�ݺ���

declare
    n number := 1;
begin
    loop
        dbms_output.put_line(n);
        n := n+1;
        exit when n > 10; --�ݺ��� ���߱� ���� ����
    end loop;
end;
/

declare
begin
    --in ���� �ڿ� �ۼ��Ǵ� ���� �ݺ��� Ƚ���� �����Ѵ�.
    for n in 1..10 loop -- in ���۰�.. ���� 1�� ���� 1~10
        dbms_output.put_line(n);
    end loop;
end;
/
declare
begin
    for n in reverse 1..10 loop -- in ���۰�.. ���� 1�� ���� 1~10
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
        dbms_output.put_line(vdept.deptno || ' ' || vdept.dname || ' ' || vdept.loc);
    end loop;
end;
/

--while
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