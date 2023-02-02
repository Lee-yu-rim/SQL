--조인(join)
-- 2개 이상의 테이블에서 데이터를 조회
-- from절에 두개이상의 테이블을 작성한다
-- where에 조인 조건을 작성한다

-- equi join(등가조인,equals) 젇ㄱㄷ 
-- cross join(where절 없이 조인)
-- non equi join (where 범위연산지: and. or
-- self join(where 하나의 테이블을 사용한다)
-- out join (where에 누락되는 데이터를 같이 조회하기 위해 : (+) 사용)

select emp.ename,emp.job,emp.deptno,dept.dname,dept.loc
from emp,dept
where emp.deptno = dept.deptno;

-- 컬럼이름이 동일하지 않으면 매번 앞에 쓸 필요는 없다. 단, deptno는 양쪽 테이블에 존재하기때문에 꼬옥 소속을 써주어야한다.
select e.ename,job,e.deptno,d.dname,loc
from emp e,dept d --테이블에 별칭 주는방법 별칭을 사용하면 모든 부분을 별칭으로 고쳐주어야 한다.
where e.deptno = d.deptno;

select ename,sal,grade,losal,hisal
from emp e, salgrade s --테이블에 별칭 주는방법 별칭을 사용하면 모든 부분을 별칭으로 고쳐주어야 한다.
where e.sal between s.losal and s.hisal;
--where e.sal >= s.losal and e.sal <= s.hisal;

--사번, 이름, 급여, 부서번호, 부서명, 급여등급
--emp              dept           salgrade

select empno,ename,sal,d.deptno,dname,grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno
and e.sal between s.local and s.hisal;

select e.empno,e.ename,e.mgr,m.ename
from emp e, emp m --셀프조인은 반드시 별칭부여 
where e.mgr= m.empno;

--scott 같은 부서에 근무하는 사원을 알고싶음. 알고있는건 scott뿐
--ename ename
--scott smith
--scott jones
--scott adams
--scott ford

select work.ename, friend.ename
from emp work, emp friend
where work.deptno = friend.deptno
and work.ename = 'SCOTT'
and friend.ename != 'SCOTT';

--외부조인
-- 등가시 누락되는 데이터를 같이 조회하기 위해서 사용

select e.empno, e.ename, e.mgr, m.ename
from emp e, emp m --반드시 별칭 부여
where e.mgr = m.empno(+); --데이터가 없는 테이블쪽에 (+)를 붙인다.

select ename, sal, d.deptno, dname
from emp e, dept d
where e.deptno(+) = d.deptno;

-- ANSI-JOIN(표준조인방식)
-- where 대신에 on 사용함
-- using(컬럼이름) 제공. 컬럼이름이 다르면 쓸 수 없음
-- 별칭 사용시에는 using 적용이 제한될 수 있다

 -- cross join, inner join(equi not equi), natural join, outer join(+) -> [left, right, full] outer join(셋중 하나를 필수로 붙여야 함)
select ename, sal, dname, loc
from emp e inner join dept d
on e.deptno = d.deptno;

select ename, sal, dname, loc
from emp e inner join dept d
using(deptno); --양쪽 테이블의 컬럼명이 동일한경우만 사용가능

select ename, sal, dname, loc
from emp e inner join dept d
using(deptno)
where ename = 'SCOTT'; --조건 추가 가능

select e.empno,e. ename,e.mgr,m.ename
from emp e inner join emp m
on e.mgr = m.empno;

select empno, ename,sal,grade
from emp e inner join salgrade s
on e.sal between s.losal and s.hisal;

select e.empno, e.ename, e.mgr, m.ename
from emp e left outer join emp m -- 데이터가 있는 쪽을 지정한다
on e.mgr = m.empno;

select empno, ename,sal,d.deptno,dname,grade
from emp e inner join dept d
on e.deptno = d.deptno
inner join salgrade s
on e.sal between s.losal and s.hisal;

--------------------------------
select ename,sal,d.deptno,dname
from emp e, dept d
where e.deptno(+) = d.deptno;
-- ansi-join 방식으로 만들기--

select ename, sal, d.deptno, dname
from emp e right outer join dept d
on e.deptno = d.deptno;

-----------문제풀이 안시조인방식
--1번
select d.deptno, d.dname,e.empno,e.ename,e.sal
from emp e join dept d
on e.deptno = d.deptno
where sal>2000
order by d.dname asc;
-- 강사님풀이
select d.deptno, d.dname,e.empno,e.ename,e.sal
from emp e inner join dept d
on e.deptno = d.deptno
where sal>2000;

--2번
select e.deptno, d.dname, trunc(avg(sal)), max(sal), min(e.sal),
case
    when e.deptno = 10 then count(10)
    when e.deptno = 20 then count(20)
    when e.deptno = 30 then count(30)
    else 0
end as cnt
from emp e join dept d
on e.deptno = d.deptno 
group by e.deptno, d.dname;
--강사님풀이
select e.deptno, d.dname, trunc(avg(sal)), max(sal), min(e.sal),count(*)
from emp e join dept d
on e.deptno = d.deptno 
group by e.deptno,d.dname;

--3번 --40번을 못봣네...........
select e.deptno,d.dname,empno,e.ename,job,sal
from emp e join dept d
on e.deptno = d.deptno
order by d.dname asc;
--강사님풀이
select e.deptno,d.dname,e.empno,e.ename,e.job,e.sal
from emp e right outer join dept d
on e.deptno = d.deptno
order by e.deptno asc;


--4번
select d.deptno,d.dname,
       e.empno,e.ename,e.mgr,e.sal,e.deptno as DEPTNO_1, 
       s.losal,s.hisal,s.grade, 
       m.empno,m.ename
from emp e right outer join dept d
on e.deptno = d.deptno
    full outer join salgrade s
on e.sal between s.losal and s.hisal
    left outer join emp m
on e.mgr = m.empno
    order by e.deptno, e.empno asc;


-- 서브쿼리
-- select 구문을 중첩해서 사용하는 것(where)
-- select (select)
-- from (select)
-- where (select) ->보통 서브쿼리라고 부름
select max(sal) from emp;

select ename, sal
from emp
where sal = (
            select max(sal)
            from emp
            );

--------------------------
select deptno
from emp
where ename = 'SCOTT';

select dname
from dept
where deptno = 20;

--메인쿼리문
select dname
from dept
where deptno = (
        --서브쿼리문
        select deptno
        from emp
        where ename='SCOTT'
      );
      
------------------
--dallas 이름, 부서번호

select ename, deptno
from emp
where deptno = (
                select deptno
                from dept
                where loc = 'DALLAS'
                );
                
-- 자신의 직속상관이 KING인 사원의 이름과 급여를 조회하세요
select ename,sal
from emp
where mgr = ( --매니저
            select empno --사번
            from emp
            where ename = 'KING'
            );
            
            
--단일행 서브쿼리: =, !=, > , <....
--다중행 서브쿼리: in, any...

select *
from emp
where sal in(5000,3000,2850);

select *
from emp
where sal in(
-- 다중행
    select max(sal)
    from emp
    group by deptno
    );
    
select *
from emp
where sal > any ( --any는 부등호 연산자 필수
-- 다중행
    select max(sal)
    from emp
    group by deptno
    );
    
select ename, sal
from emp
where sal > all(
    select sal
    from emp
    where deptno = 30
    );
    
    
    
    
--다중행 연산자
-- in : 메인쿼리의 데이터가 서브쿼리의 결과 중 하나라도 일치한 데이터가 있다면 true
-- any, some : 메인쿼리의 조건식을 만족하는 서브쿼리의 결과가 하나 이상이면 true
-- all : 메인쿼리의 조건식을 서브쿼리의 결과 모두가 만족하면 true
-- exists : 서브쿼리의 결과가 존재하면(즉, 행이 1개 이상일 경우) true


select * 
from emp
where (deptno,sal) in (
    select deptno, max(sal)
    from emp
    group by deptno
    );