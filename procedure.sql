set serveroutput on;  

--저장 프로시저 : 프로시저를 삭제하지 않는 이상 계속해서 사용할 수 있음
--1.생성(create)
--2.실행(execute / exec)

--create or replace procedure 프로시저명 (매개변수)
--is / as
--  변수정의
--begin
--  sql
--  출력구문
--  조건문 , 반복문 ...
--end;
--/

drop table emp01;

create table emp01
as
select * from emp;

--생성
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

--실행
execute emp01_print; 

--삭제
create or replace procedure emp01_del
is
begin
    delete from emp01;
end;
/

exec emp01_del;

select * from emp01;

--원하는 데이터만 지우기
create or replace procedure del_ename(vename emp01.ename%type)
is
begin
    delete from emp01
    where ename = vename;   --매개변수를 이용한 데이터 삭제
end;
/

exec del_ename('SCOTT');

select * from emp01
where ename = 'SMITH';

exec del_ename('SMITH');

--저장 프로시저의 매개변수 유형
--in , out , in out
--in : 값을 전달 받는 용도 , 매개변수 안에 기본적으로 생략되어있음
--out : 프로시저 내부의 실행 결과를 외부로(실행 요청한 곳) 전달
--in out : in + out 기능

--사번을 통해 특정 사원 조회
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
    into vename,vsal,vjob   --매개변수로 정의된 변수들을 is 안에서 따로 선언 하지않고 바로 into절에 사용
    from emp
    where empno = vempno;
end;
/

--바인드 변수 생성
variable var_ename varchar2(15);
variable var_job varchar2(9);
variable var_sal number;   
--바인드 변수에서 number 타입은 크기를 지정하지 않는다.

exec sel_empno (7499,:var_ename,:var_sal,:var_job);  
--in 타입에는 값을 넣어주고, out 타입에는 값을 받아오는 바인드 변수를 넣어준다.
--바인드 변수를 사용할 때 앞에 : 을 붙여야한다, 정의할 땐 x

print var_ename;
print var_sal;
print var_job;


--사원 정보를 저장하는 저장 프로시저 
--사번,이름,직책,매니저,부서
--사원정보는 매개변수를 사용하여 받아온다.

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
--저장 함수
--저장 함수와 저장 프로시저의 차이점 : return 값 유무
--1.생성(create)
--2.실행(exxcute / exec)

--create or replace function 함수명(매개변수)
--  return 값의 타입  --세미콜론 생략
--is
--begin
--  sql 구문
--  출력함수
--  조건문,반복문...

--  return 리턴값;  --세미콜론 필수
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
--execute 뒤에 바인드 변수를 선언해야한다.

print var_res;

drop procedure info_emp;

drop function cal_bonus;

--------------------------------------
--커서
--declare
--    커서 :select 구문이 실행하는 결과를 가리킨다.
--    cursor 커서명 is sql 구문(select 구문);  --커서선언
--begin
--    open 커서명;   
--    loop
--      fetch 커서명 into 변수명;   --테이블로부터 레코드를 가져와서 변수에 저장하는 역할
--      exit when 커서명%notfound;  --커서가 가리키는 데이터가 없을 때 종료
--    end loop;
--    close 커서명;
--end;
--/


declare
    cursor c1 is select * from emp;
    vemp emp%rowtype;
begin
    open c1;   
    loop
      fetch c1 into vemp;  
      exit when c1%notfound;  --emp 테이블에 있는 14개의 데이터를 다 가져오면 반복문 종료
      dbms_output.put_line(vemp.empno ||' '|| vemp.ename ||' '|| vemp.job ||' '|| vemp.mgr ||' '|| vemp.hiredate ||' '|| vemp.sal ||' '|| vemp.comm ||' '|| vemp.deptno);
    end loop;
    close c1;
end;
/

--for문을 이용한 cursor 사용
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















































