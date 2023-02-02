--scott계정

select * from emp;

set serveroutput on; --실행 결과를 화면에 출력

--기본 실행문
begin
    dbms_output.put_line('HELLO WORLD');
end;
/

--declare 사용
declare 
    vempno number(4); --변수의 선언
    vename varchar2(10);
begin
    vempno := 7777; --변수의 초기화
    vename:= 'SCOTT';
    
    dbms_output.put_line('사원/이름');
    dbms_output.put_line(vempno ||' '|| vename);
end;
/

declare 
    vempno constant number(4) := 7777; --선언과 초기화를 동시에 할 수도 있음. constant를 붙여주면 상수의 정의가 된다.
    vename varchar2(10) not null := 'SCOTT'; --null값을 사용할 수 없다.
begin
    dbms_output.put_line('사원/이름');
    dbms_output.put_line(vempno ||' '|| vename);
end;
/

declare
--스칼라방식
    --vempno number(4);
--레퍼런스 방식
    vempno emp.empno%type := 7777; --이것도 가능
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
    where empno = 7788; --(필수)
    dbms_output.put_line('사번/이름');
    dbms_output.put_line(vempno ||' '|| vename);
exception
    when TOO_MANY_ROWS then dems_output.put_line('행의수가 여러개 입니다');
    when OTHERS then dbms_output_put_line('모든 예외에 대한 메세지');
end;
/

declare
    -- 테이블 type(사용자 정의 변수 타입을 정의)
    -- 배열의 형식
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
    enameArr ename_table_type; --배열형식의 변수 선언
    jobArr job_table_type; --배열형식의 변수 선언
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

--레코드변수
declare
    -- 테이블 type(사용자 정의변수타입)
    -- 배열의 형식
    -- vename varchar2(10)
    TYPE emp_record_type IS RECORD(
        -- 대문자 부분은 필수적으로 적어야 함.
        v_empno emp.empno%type,
        v_ename emp.ename%type,
        v_job emp.job%type,
        v_deptno emp.deptno%type
    );  
    emp_record emp_record_type; --레코드 타입의 변수가 선언됨
begin 
    -- 레코드 type(여러개의 변수를 묶어서 사용한다) -> 사용자 정의 변수 타입
    -- 클래스랑 유사하다.
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

-- 값을 수정하는 코드
declare
    TYPE rec_dept IS RECORD (
        v_deptno dept_record.deptno%TYPE not null := 99, --빈 값이 들어오면 그 값을 99로 두겠다.
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


--조건문
-- if(조건식) 
--      실행문
--  end if;
declare
    --스칼라방식
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
    -- %rowtype : 테이블의 모든 컬럼의 이름과 변수를 참조하겠다.
    -- 컬럼명이 변수명으로 사용되고 컬럼의 타입을 변수의 타입으로 사용한다.
    
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

--스칼라방식
--레퍼런스 방식
-- 1. emp.empno%type
-- 2. emp%rowtype

-- 사용자 정의변수타입
-- 1. 테이블 type
    -- type xxxx
-- 2. 레코드 type


-- 문제풀기
-- rowtype사용

declare
    vemp emp%rowtype;
    annsal number(7,2);
begin
    dbms_output.put_line('사번 / 이름 / 연봉');
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
    
    -- else if버전으로 만든다면
    if(vemp.comm is not null) then
        annsal := vemp.sal*12 + vemp.comm;
        dbms_output.put_line(vemp.empno||' '|| vemp.ename ||' '|| annsal);
    else
        annsal := vemp.sal*12;
        dbms_output.put_line(vemp.empno||' '|| vemp.ename ||' '|| annsal);
    end if;
    --dbms_output.put_line(vemp.empno||' '|| vemp.ename ||' '|| annsal);
    -- 해당사원의 연봉을 출력하세요. 단, 커미션(comm)이 null인 경우 0으로 계산되게 해라.
    
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
--반복문

declare
    n number := 1;
begin
    loop
        dbms_output.put_line(n);
        n := n+1;
        exit when n > 10; --반복문 멈추기 위한 조건
    end loop;
end;
/

declare
begin
    --in 구문 뒤에 작성되는 값이 반복의 횟수를 결정한다.
    for n in 1..10 loop -- in 시작값.. 끝값 1씩 증가 1~10
        dbms_output.put_line(n);
    end loop;
end;
/
declare
begin
    for n in reverse 1..10 loop -- in 시작값.. 끝값 1씩 감소 1~10
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