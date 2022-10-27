--PL/SQL : 확장되어진 SQL 언어
--변수,조건문,반복문

--PL/SQL구문의 형식
--declare
--  변수정의
--begin
--  SQL구문
--  출력구문 -> 쿼리문의 실행결과를 반드시 출력함수를 통해서 확인해야한다.
--exception
--  예외처리구문
--end;
--/

set serveroutput on;   --이 구문을 실행해야 출력이 가능

begin
    dbms_output.put_line('Hello World');   --출력함수
end;
/
-----------------------------------------
declare
    --vempno number(4);  --변수의 선언
    --vename varchar2(10);
    
    --변수의 선언과 초기화
    vempno constant number(4) := 7777;   --상수의 정의
    vename varchar2(10) not null := 'SCOTT';  --null값을 변수의 값으로 사용 불가
begin 
   --vempno := 7777;     --변수의 초기화  /  := 대입연산자
   --vename := 'SCOTT';
    
    dbms_output.put_line(' 사원 / 이름 ');
    dbms_output.put_line(vempno ||' '|| vename);
end;
/
----------------------------------------------------
--변수를 정의하는 방식
declare
    --스칼라 방식 : 직접 타입 지정
    --vempno number(4);
    --래퍼런스 방식 : 기존 테이블 컬럼의 타입 참조
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
    where empno = 7788;  --변수에는 값이 1개씩 밖에 안들어가기 때문에 where절을 통해 가져올 값을 필수적으로 지정해야한다, 지정하지 않으면 14개의 행을 모두 가져오는 것이기 때문
    
    dbms_output.put_line('사번 / 이름');
    dbms_output.put_line(vempno ||' '|| vename);
exception   
    when TOO_MANY_ROWS then dbms_output.put_line('행의 수가 여러개 입니다.');  --where을 안썼을 경우의 예외처리
    when OTHERS then dbms_output.put_line('모든 예외를 처리했습니다.');   --모든 예외 처리
end;
/
----------------------------------------------------------
declare
    --테이블 type : 래퍼런스 방식을 통한 배열 형식의 타입 지정 => 사용자 정의 변수타입
    
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
    
    empnoArr empno_table_type;   --테이블 타입 변수 선언(배열형식의 변수 선언) -> 변수 안에 여러개의 값을 받을 수 있다. 
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
    --레코드 type : 여러개의 변수를 묶어서 사용한다. => 사용자 정의 변수타입
    --자바의 클래스와 유사함
    
    type emp_record_type is record (
        v_empno emp.empno%type,
        v_ename emp.ename%type,
        v_job emp.job%type,
        v_deptno emp.deptno%type
    );
    
    emp_record emp_record_type;   --레코드 타입 변수 선언

begin 
    select empno,ename,job,deptno
    into emp_record
    from emp
    where empno = 7788;
    
    --출력시 참조방법을 사용하여 입력한다.
    dbms_output.put_line(emp_record.v_empno ||' '|| emp_record.v_ename ||' '|| emp_record.v_job ||' '|| emp_record.v_deptno);
    
end;
/
-----------------------------------------------------
create table dept_record
as
select * from dept;

--레코드 타입을 이용하여 테이블에 데이터 삽입(insert)
declare
    type rec_dept is record (
        v_deptno dept.deptno%type,
        v_dname dept.dname%type,
        v_loc dept.loc%type
    );
    
    dept_rec rec_dept;   -- 변수명 - 위에서 지정한 레코드타입
    
begin
    dept_rec.v_deptno := 50;
    dept_rec.v_dname := 'DEV';
    dept_rec.v_loc := 'BUSAN';
    
    --데이터 삽입
    insert into dept_record   --괄호 생략
    values dept_rec;
    
end;
/

select * from dept_record;
-------------------------------------------------
--레코드 타입을 이용하여 테이블에 데이터 수정(update)
declare
    type rec_dept is record (
        v_deptno dept.deptno%type not null := 99,  --기본값을 99로 설정(값이 비어있으면 99가 들어감)
        v_dname dept.dname%type,
        v_loc dept.loc%type
    );
    
    dept_rec rec_dept;

begin
    dept_rec.v_deptno := 50;
    dept_rec.v_dname := 'PRESON';
    dept_rec.v_loc := 'SEOUL';
    
    --데이터 수정
    update dept_record
    set dname = dept_rec.v_dname,loc = dept_rec.v_loc
    where deptno = dept_rec.v_deptno;
    
end;
/

select * from dept_record;
--------------------------------------------------
--데이터 삭제
declare
    v_deptno dept_record.deptno%type := 50;
begin
    delete from dept_record
    where deptno = v_deptno;
end;
/
------------------------------------------------------
--조건문
--if(조건식) then 
    --    실행문
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
    
    dbms_output.put_line('부서명: ' || vdname);
    
end;
/
------------------------------------
declare
    --%ROWTYPE : 테이블의 모든 컬럼의 이름과 변수를 참조
    --컬럼명이 변수명으로 사용되고 컬럼의 타입을 변수의 타입으로 사용
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

--스칼라 방식
--래퍼런스 방식
    --1.컬럼을 직접 참조
    --emp.empno%type
    --2.테이블 자체를 모두 참조
    --emp%rowtype
    
--사용자 정의 변수 타입
    --1.테이블 type
    --type empno_table_type is table of emp.empno%type
    --index by binary_integer;
    --2.레코드 type
    --type emp_record_type is record (
    --    v_empno emp.empno%type);

--

declare
    vemp emp%rowtype;
    annsal number(7,2); 
begin
    dbms_output.put_line('사번 / 이름 / 연봉');
    dbms_output.put_line('--------------------');
    
    select * 
    into vemp
    from emp
    where empno = 7788;
    
    --해당 사원의 연봉 출력 / 커미션이 null인 경우 0으로 계산하여 출력
    
    --if 구문으로 출력
    --if(vemp.comm is null) then
    --    vemp.comm := 0;
    --end if;
    
    --annsal := vemp.sal * 12 + vemp.comm;
    
    --if else 구문으로 출력
    if(vemp.comm is null) then
        annsal := vemp.sal * 12;
    else
        annsal := vemp.sal * 12 + vemp.comm;
    end if;

    dbms_output.put_line(vemp.empno ||' '|| vemp.ename ||' '|| annsal);
end;
/

------------------------------------------------
--다중 if 구문

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

--조건문
--if then end if;
--if then else end if;
--if then elsif then end if;

-----------------------------------------------------------------------------
--반복문(무한반복문)
--loop
--  실행문
--  무한 반복문의 제어
--  1.exit when 조건식;
--  2.if then end if;
--end loop;

declare
    n number := 1;
begin
    loop
        dbms_output.put_line(n);
        n := n + 1;
        exit when n > 10;   --반복문의 종료를 위한 조건
    end loop;
end;
/

--for 반복문
declare
--변수선언 불필요
begin
    --in 구문 뒤에 작성되는 값이 반복의 횟수를 결정함
    for n in 1..10 loop   -- in 시작값..끝값  -> 1씩 증가(10회 반복)
        dbms_output.put_line(n);
    end loop;
end;
/

declare

begin
    for n in reverse 1..10 loop   -- in 시작값..끝값  -> 1씩 감소(10회 반복)
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
--while 반복문
--while(조건식) loop
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

--반복문
--loop end loop;
--for in loop end loop;
--while loop end loop;




















