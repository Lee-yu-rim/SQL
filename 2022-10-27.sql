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


-- 저장 프로시저
    -- 1. 실행(create)
    -- 2. 실행(execute or exec)
    -- 실행구문을 작성해서 실행해야한다.
-- 사용방법

--create or replace procedure 프로시저명(매개변수) 
--
--is or as : 보통 is를 많이 사용함 : declare
--    변수 정의
--begin
--    SQL문
--    출력구문
--    조건문, 반복문
--end;
--/
--

drop table emp01;

create table emp01
as
select * from emp;

-------------------------------
--저장프로시저

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
-- 프로시저만 잘 만들어주면 매번 생성하여 지우지 않아도 된다. 프로시저를 삭제하지 않는 한 반영구적으로 사용가능.


--저장 프로시저의 매개변수 유형
-- in, out, in out
-- in : 값을 전달받는 용도
-- out : 프로시저 내부의 실행 결과를 실행을 요청한 쪽으로 값을 전달
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

--바인드변수 만드는 법
variable var_ename varchar2(15);
variable var_sal number; --숫자 타입은 크기 지정x!
variable var_job varchar2(9);

--exec sal_empno(7499,:바인드변수1, :바인드변수2, :바인드변수3);
exec sel_empno(7499,:var_ename,:var_sal,:var_job);

print var_ename;
print var_sal;
print var_job;


-- 사원 정보를 저장하는 저장 프로시저 
-- 사번, 이름, 직책, 매니저, 부서
-- 사원정보는 매개변수를 사용하여 받아온다.

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


-- 저장함수
-- 저장함수와 저장 프로시저의 차이점 : return값 유무
-- 1. 생성(create)
-- 2. 실행(execute)
-- 사용방법
--create or replace function 함수명(매개변수)
--    return 값의 타입 --세미콜론을 생략한다.
--is
--begin
--    sql 구문
--    출력함수
--    조건문,반복문
--    return 리턴값; -- 하지만 여기에는 붙인다.
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
--exec뒤쪽에 바인드 변수를 선언해야한다.

print var_res;

drop procedure insert_sawon;
drop function cal_bonus;

-------------------------------------------------------------------------------
-- 커서
-- - 데이터를 참조할 용도
-- - select 구문이 실행하는 결과를 가리킨다.
-- 사용방법
declare
    --커서
    cursor 커서명 is sql구문(select); -- 커서 선언
begin
    open 커서명;
    loop
        fetch 커서명 into 변수명; --테이블로부터 가져와서 변수에 저장하는 역할
        exit when 커서명%notfound;
    end loop;
    close 커서명;
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


--for문 이용
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

------------hr 이용--------------------------
-- 출력하기 아이디,이름,이름의 성, 부서이름
--employees, departments

-- 조인방식
select employee_id,first_name,last_name,department_name
from employees e inner join departments d
on e.department_id= d.department_id;

--서브쿼리
select employee_id, first_name, last_name,department_id,
    (
        select department_name
        from departments d
        where e.department_id = d.department_id
    )as dep_name
from employees e
where department_id = 100;


--프로시저(함수)

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
--문제풀기

--employees, jobs
--사원아이디, 이름, 성, job id
-- join 방식,서브쿼리문 방식, get_job_title 함수 만들어서 사용하는 방식