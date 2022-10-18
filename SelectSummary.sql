-- DQL(질의어) -> 데이터 조회용
-- select 컬럼명 
-- from 테이블명

desc emp;  --테이블 조회

--전체 데이터 조회
select empno,ename,job,mgr,hiredate,sal,comm,deptno
from emp;

--전체 데이터 조회
select * 
from emp;

--부분 컬럼 데이터 조회
select empno,ename,sal
from emp;

select deptno 
from emp;

select DISTINCT(deptno) --distinct : 중복값 제거 후 조회
from emp; 

select job 
from emp;

select DISTINCT(job) 
from emp;

SELECT ename,sal 
from emp;

-- +,-,*,/ 이외의 연산자는 없다
--컬럼을 대상으로 연산한다.
--null값은 연산이 불가하다. -> nvl을 이용하여 null값을 대체할 수 있음
--컬럼에 별칭을 사용할 수 있다. -> as 사용 , as는 생략 가능
select ename 사원명,sal,sal * 12 + comm as 연봉,comm   --comm : 성과급
from emp;

-----------------------------------------------------------
--데이터 정렬
--select 컬럼명
--from 테이블명
--order by 컬럼명(정렬 기준이 되는 값) asc(오름차순)/desc(내림차순)

select *
from emp
order by ename asc;   --오름차순 : 생략 가능(기본 정렬은 오름차순)

select *
from emp
order by sal desc;  --내림차순

--유형별 정렬 기준(오름차순)
--숫자(1~10), 날짜(과거~최근), 문자(사전순)

--조건 검색
--select 컬럼명
--from 테이블명
--where 조건식(컬럼명 연산자 값); < , > , = , != / <> , >= , <= , and , or

select *
from emp
where sal >= 3000;

select *
from emp
where deptno = 30;

--and : 두가지 이상의 조건이 모두 참인 경우
select *
from emp
where deptno = 30 and job = 'SALESMAN' and empno = 7499;

--문자를 조건절에 사용할 때
--대소문자 구분
--''사용
select *
from emp
where ename = 'ford';  --소문자 ford는 없다.

--날짜를 조건절에 사용할 때
--''사용
--날짜도 크기가 있다.(과거 < 최근)
--표시되는 값 yy/mm/dd  -> 들어있는 값 yyyy/mm/dd/시간/분/초/요일
select *
from emp
where hiredate < '1982/01/01';

--or : 두가지 이상의 조건 중 하나 이상이 참인 경우
select *
from emp
where deptno = 10 or sal >= 2000;

--not : 논리부정 연산자
select *
from emp
where sal != 3000;
--같은 결과
select *
from emp
where not sal = 3000;

--abd , or 
--범위 조건을 표현할 때 사용
select *
from emp
where sal >= 1000 and sal <= 3000;

select *
from emp
where sal <= 1000 or sal >=3000;

--between and : and 를 대신하는 논리연산자
select *
from emp
where sal >= 1000 and sal <= 3000;
--같은 결과
select *
from emp
where sal between 1000 and 3000;

--in : or 를 대신하는 논리연산자
select *
from emp
where sal = 800 or sal = 3000 or sal = 5000;
-- 같은 결과
select *
from emp
where sal in(800,3000,5000);

--like 연산자
--값의 일부만 가지고 데이터를 조회한다.
--와일드 카드를 사용한다.(% , _)
-- % : 모든 문자를 대체한다.
-- _ : 한가지 문자를 대체한다.
select *
from emp
where ename like 'F%';  -- F로 시작하는 모든 이름(F 뒤에 값이 없는 것도 포함)

select *
from emp
where ename like '%D';

select *
from emp
where ename like '%O%';

select *
from emp
where ename like '___D';

select *
from emp
where ename like 'S___%';

--null 연산자
--is null / is not null 의 형태로 사용하여 값 조회
select *
from emp
where comm = null;  --null은 비교불가

select *
from emp
where comm is null;

select *
from emp
where comm is not null;

----------------------------
--집합연산자
--두개의 select 구문을 사용한다.
--컬럼의 갯수가 동일해야한다.
--컬럼의 타입이 동일해야한다.
--컬럼의 이름은 상관없다.
--합집합(UNION), 차집합(MINUS), 교집합(INTERSECT)

select empno,ename,sal,deptno
from emp
where deptno = 10
UNION --합집합
select empno,ename,sal,deptno
from emp
where deptno = 20;

select empno,ename,sal,deptno
from emp
where deptno = 10
UNION --합집합
select empno,ename,sal,deptno
from emp
where deptno = 10;
--중복값의 경우 한번만 출력됨

select empno,ename,sal,deptno
from emp
where deptno = 10
UNION ALL --합집합
select empno,ename,sal,deptno
from emp
where deptno = 10;
--ALL을 붙이면 중복값이더라도 출력됨

-------------------------------
select empno,ename,sal,deptno
from emp
MINUS --차집합
select empno,ename,sal,deptno
from emp
where deptno = 10;
--10번 부서를 뺀 나머지 값만 출력됨

-------------------------------
select empno,ename,sal,deptno
from emp
INTERSECT --교집합
select empno,ename,sal,deptno
from emp
where deptno = 10;
--10번 부서만 조회됨

----------------------------------------------------------------------
--where 조건절 구성요소
--비교연산자, 논리연산자, like, is (not) null, 집합연산자를 사용하여 데이터 조회
--비교연산자 : >, <, >=, <=, =, !=
--논리연산자 : and, or, not, between and, in
--like : % , _ (와일드 카드)
--is null , is not null : null 데이터 조회
--집합연산자 : UNION , UNION ALL , MINUS , INTERSECT 


--연습문제 1번
select *
from emp
where ename like '%S';

--연습문제 2번
select empno,ename,job,sal,deptno
from emp
where deptno = 30 and job = 'SALESMAN';

--연습문제 3번
select empno,ename,job,sal,deptno
from emp
where deptno in(20,30) and sal > 2000;

select empno,ename,job,sal,deptno
from emp
where deptno = 20 and sal > 2000
UNION
select empno,ename,job,sal,deptno
from emp
where deptno = 30 and sal > 2000;

--연습문제 4번
select *
from emp
where sal < 2000 or sal > 3000;

--연습문제 5번
select ename,empno,sal,deptno
from emp
where deptno = 30 and ename like '%E%' and sal not between 1000 and 2000;

--연습문제 6번
select *
from emp
where comm is null and MGR is not null
INTERSECT
select *
from emp
where job = 'MANAGER' or job = 'CLERK'
MINUS
select *
from emp
where ename like '_L%';

select *
from emp
where comm is null and job in('MANAGER','CLERK') and mgr is not null and ename not like '_L%';


















