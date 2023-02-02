-- 뷰

drop view sal_view;
--모든 객체의 이름은 중복될 수 없다.

-- or replace는 이미 존재하는 객체에 바뀐 내용을 반영한 새 뷰를 만들고 싶을 때 사용한다.
-- 만약 실수나 누락된 정보가 있다면 뷰를 드랍할 필요 없이 or replace를 이용하여 수정(덮어쓰기)하여 사용할 수 있다.
-- 뷰를 생성할 때 or replace를 빼놓는다면 그 뷰는 수정을 할 수가 없다.

-- 위의 코드를 드랍하지않고 아래 코드를 실행하면 수정된 결과가 된다.
create or replace view sal_view(dname,min_sal,max_sal)
as
select d.dname, min(sal),max(sal) 
from emp e inner join dept d
on e.deptno = d.deptno 
group by d.dname;

create or replace view sal_view(dname,min_sal,max_sal,avg_sal)
as
select d.dname, min(sal),max(sal), avg(sal) as avg_sal 
from emp e inner join dept d
on e.deptno = d.deptno 
group by d.dname;

select * from sal_view;


----------------------------------------------------

-- with check option
create or replace view view_chk30
as
select empno, ename, sal, comm, deptno
from emp_copy
where deptno = 30 with check option; --이 조건은 수정변경 하지 못하게 하라는 뜻. 조건절의 컬럼을 수정하지 못하게 한다.

update view_chk30
set deptno = 10;
-- 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다


-- with read only
create or replace view view_read30
as
select empno, ename, sal, comm, deptno
from emp_copy
where deptno = 30 with read only; --모든 컬럼에 대한 CRUD 중 C U D가 불가능하다(조회만 가능)

update view_read30
set deptno = 10;
-- 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.(insert, update, delete)
select * from view_read30;


-- 뷰의 활용
-- TOP - N 조회하기
-- rownum(의사컬럼)
select * from emp;

--입사일이 가장 빠른 5명의 사원을 조회
select ename, hiredate
from (SELECT ENAME,hiredate FROM EMP ORDER BY hiredate asc)
WHERE ROWNUM <=5;
-- 강사님 코드
select * from emp
order by hiredate asc;

select * from emp
where hiredate <= '81/05/01';

desc emp;

select rownum,empno,ename,hiredate
from emp
where rownum <= 5
order by hiredate asc;

create or replace view view_hiredate
as 
select empno, ename, hiredate
from emp
order by hiredate asc;

select * from view_hiredate;

select rownum, empno, ename,hiredate
from view_hiredate
where rownum >=1 and rownum <=5; --rownum은 조건절에 직접 사용시 반드시 1을 포함하는 조건식을 만들어야 한다.

create or replace view view_hiredate_rm
as
select rownum as rm, empno, ename,hiredate --rownum에 별칭을 부여해주어야 휘발성이 없어지고 뷰 테이블에 사용가능하다.
from view_hiredate;

select rm, empno, ename, hiredate
from view_hiredate_rm;

select rm, empno, ename, hiredate
from view_hiredate_rm
where rm >=2 and rm <=5;


-- 인라인뷰(일회성 뷰)
    -- 쿼리문이 다 실행되고 나면 더이상 사용하지 않음.
    -- 동작을 할 때에만 잠시 사용하는 용도.
    -- 오라클에 남아있지 않는다.
-- select (select)-> 일반쿼리
-- from (select)-> 인라인뷰   --우리가 이번에 해볼거~
-- where (select)-> 서브쿼리

select rm, b.*
from (select rownum rm, a.* 
        from (
            select empno,ename,hiredate from emp order by hiredate asc
            )a
      )b
where rm >= 2 and rm <= 5;
--이 뷰는 위에서 만들었던 뷰와 동일한 값을 가진다.
-- a,b를 다음과 같이 사용하여 뒤에 있는 값을 일일히 쓰지 않아도 된다.

--문제~~~~~~~~~~~
--입사일이 가장 빠른 5명을 조회하세요. 인라인뷰 형식으로 만드세요.
select empno, ename, hiredate
from (select empno, ename, hiredate
        from(
            select empno, ename, hiredate from emp order by hiredate asc
            )
        )
where rownum <= 5;


-- 시퀀스 객체
-- 자동으로 번호를 증가시키는 기능수행
-- create, drop
-- nextval, currval

-- 사용 방식(옵션의 순서는 상관없음)
-- create sequence 시퀀스명
-- start with 시작값 =>1
-- increment by 증가치 =>1
-- maxvalue 최대값 => 10의 1027승
-- minvalue 최소값 => 10의 -1027승


--10부터 시작하여 10씩 증가하는 시퀀스
create sequence dept_deptno_seq
increment by 10
start with 10;

select dept_deptno_seq.nextval
from dual;

select dept_deptno_seq.currval
from dual;


create sequence emp_seq
start with 1
increment by 1
maxvalue 1000;

drop table emp01;

create table emp01
as
select empno,ename,hiredate from emp
where 1 !=1;

select * from emp01;

insert into emp01
values(emp_seq.nextval,'hong',sysdate);
-- empno에서 값이 2가 되는데, 이건 오라클 에러이다. 1을 넣고 싶다면 시작 값을 0으로 넣으면 된다.

drop table product1;
drop sequence idx_product_id;

create table product1(
    pid varchar2(10),
    pname varchar2(10),
    price number(5),
    
    constraint product_pid_pk primary key(pid)
);

create sequence idx_product_id
start with 1000;

insert into product1(pid,pname,price)
values ('pid'||idx_product_id.nextval,'mike',1000);

select * from product1;



-- 사용자관리(객체)
-- 관리자 계정에서 가능한 작업들이다(ex)system
-- create, alter, drop
-- 사용방식(사용자 계정을 만드는 명령어)
--create user 계정명 identified by 패스워드;
--대소문자를 구분하니 주의!
-- alter 사용법
-- alter user 계정명 identified by 패스워드;
-- drop 사용법
-- drop user 계정명 identified by cascade;

-- DCL(제어어)
-- - grant(권한부여)
    -- - grant 시스템권한 to 계정명
-- - revoke(권환회수)
    -- - revoke 시스템권한 from  계정명
-- 예시
-- grant CREATE SESSION
-- to user01;

--변경 사용가능~
-- alter user user01 identified by tiger;

-- 시스템권한(create..)
-- 객체권한(select, ...)

-- 소유주 계정에서 진행
--grant 객체권한 종료
--on 객체명(테이블 이름)
--to 계정명

grant select
on emp
to user01;

revoke select 
on emp
from user01;

-- 

-- 사용자 정의 롤
-- create role 롤명
-- grant 권한 to 롤명
-- 시스템계정만 가능

grant select
on emp
to mrole2;

-- 롤 권한은 관리자 계정에서만 

grant select
on emp
to mrole3;


