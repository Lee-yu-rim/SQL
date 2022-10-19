-- DQL(질의어) -> 데이터 조회용
-- select 컬럼명 
-- from 테이블명

desc emp;  --테이블의 컬럼구조 확인

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

--============================================================================================
--함수
--문자함수 : upper,lower,length,substr,instr,replace,lpad,rpad,concat
--숫자함수
--날짜함수

--1. 문자함수
-- #upper 함수 : 문자열을 소문자 -> 대문자로 변환
select 'Welcome',upper('Welcome')
from dual;  --dual : 가상테이블

-- #lower 함수 : 문자열을 대문자 -> 소문자로 변환
select lower(ename),upper(ename)
from emp;

select *
from emp
where ename = 'FORD';

--emp 안에 scott은 대문자로 되어있지만, lower을 사용하여 전체 이름을 소문자로 바꾼뒤 조회 -> 검색의 효율성을 높임
select *
from emp
where lower(ename) = 'scott';

-- #length 함수 : 문자열의 길이 반환
select ename,length(ename)
from emp;

-- #substr 함수 : 문자열 반환
--      1234567891011121314151617
--     -17                     -1   
select 'Welcome to Oracle',substr('Welcome to Oracle',2,3)  --문자의 2번째 열부터 3개의 문자열 가져오기  elc
,substr('Welcome to Oracle',10)  --시작위치만 지정  o Oracle
from dual;

select 'Welcome to Oracle',substr('Welcome to Oracle',-3,3)  --cle
,substr('Welcome to Oracle',-10)  --to Oracle
from dual;

-- #instr 함수 : 문자열의 위치값 반환
select instr('Welcome to Oracle','o')
from dual;

select instr('Welcome to Oracle','o',6)   --시작 위치인 6번째 다음에 있는 o를 반환하므로 to의 o인 10번째 위치값 반환
from dual;

select instr('Welcome to Oracle','e',3,2)  --2번째 나오는 e의 위치값을 반환해라 = 17
from dual;

-- #replace 함수 : 문자열 대체
select 'Welcome to Oracle',replace('Welcome to Oracle','to','of')
from dual;

-- #lpad 함수 : 문자열의 왼쪽에 공간을 확보해서 문자를 대입
-- #rpad 함수 : 문자열의 오른쪽에 공간을 확보해서 문자를 대입
select 'oracle',lpad('oracle',10,'#'),rpad('oracle',10,'*')   --10은 문자열의 총 길이를 지정하는 숫자
from dual;

select rpad('950828-',14,'*')
from dual;

-- #concat 함수 : 문자열 연결
select concat(empno,ename),empno || '' || ename
from emp;

-----------------------------------------------------------------------------
--2. 숫자함수

--round 함수 : 반올림한 값 반환
select 
round(1234.5678),
round(1234.5678,0),   --소수점 반환 안함(기본값) 1235
round(1234.5678,1),   --소수점 첫째자리까지 반환 1234.6
round(1234.5678,2),   --소수점 둘째자리까지 반환  1234.57
round(1234.5678,-1)   --정수자리에서 반올림(.기준 한칸씩 앞에서 반올림) 1230
from dual;

--trunc 함수 : 값을 버리고 반환
select 
trunc(1234.5678),
trunc(1234.5678,0),   --0까지의 자리만 사용하고 나머지는 버려라  1234
trunc(1234.5678,1),   --소수점 첫번째 자리까지만 반환하고 나머지 버림  1234.5
trunc(1234.5678,2),   --1234.56
trunc(1234.5678,-1)   --1230
from dual;

--ceil 함수 : 자신보다 큰 숫자 중 가장 가까운 정수
--floor 함수 : 자신보다 작은 숫자 중 가장 가까운 정수
select
ceil(3.14),    -- 4
floor(3.14),   -- 3
ceil(-3.14),   -- -3
floor(-3.14)   -- -4
from dual;

--mod 함수 : 나머지 구해서 반환
select mod(5,2),mod(10,4)
from dual;

select *
from emp
where mod(empno,2) = 1;   --사번이 홀수인 사원 조회

------------------------------------------------------------------------------
--3. 날짜함수

--sysdate 함수 : 현재 시스템의 날짜 조회
select sysdate -1 as 어제, sysdate, sysdate +1 as 내일
from dual;

--날짜와 날짜 연산 -> 일수로 반환함
select sysdate - hiredate as 근무일수    --차이가 일수 반환
from emp;

--근속년수
select trunc((sysdate - hiredate)/365) as 근속년수
from emp;

--날짜 데이터의 반올림
--예제 1
select sysdate,
round(sysdate,'cc') as format_cc,
round(sysdate,'yyyy') as format_yyyy,
round(sysdate,'q') as format_q,
round(sysdate,'ddd') as format_ddd,
round(sysdate,'hh') as format_hh
from dual;

--예제 2
select sysdate,
trunc(sysdate,'cc') as format_cc,
trunc(sysdate,'yyyy') as format_yyyy,
trunc(sysdate,'q') as format_q,
trunc(sysdate,'ddd') as format_ddd,
trunc(sysdate,'hh') as format_hh
from dual;

--------------------------------------------------------------------------------
--4. 자료형변환 함수
--to_char() : 숫자 > 문자 / 날짜 > 문자
--to_number() : 문자 > 숫자
--to_date() : 문자 > 날짜

--날짜 > 문자
--to_char(날짜데이터,표시할 형식)
select sysdate, to_char(sysdate,'YYYY-MM-DD-DAY HH24:MI:SS') as 현재시간
from dual;

select hiredate, to_char(hiredate,'YYYY-MM-DD-DAY HH24:MI:SS') as 입사일자
from emp;

--숫자 > 문자
--to_char(숫자데이터, 표시할 형식)
select to_char(123456, 'L999,999')   --L은 지역화폐 단위를 나타냄 / 9는 빈자리 무시
from dual;

select sal, to_char(sal,'L000,000')  --0은 빈자리를 0으로 나타냄
from emp;

--문자 > 숫자
--to_number(문자데이터, 표시할 형식) : 문자데이터는 숫자의 형식을 띄워야한다.
select '20000' - 10000  --자동형변환
from dual;

select '20,000' - '5,000'   --to_number()를 이용한 강제형변환 필요
from dual;

select to_number('20,000','999,999') - to_number('5,000','999,999')
from dual;

--문자 > 날짜
--to_date(문자데이터, 표시할 형식) : 문자데이터도 날짜의 형식을 띄워야한다.
select to_date('20221019','YYYY/MM/DD')
from dual;

select *
from emp
where hiredate < to_date('19820101','YYYY-MM-DD');

------------------------------------------------------------------------------
--5. null 처리 함수
--nvl(null, 바꾸고 싶은 데이터)
--nvl은 null 데이터의 타입과 동일한 타입으로 변경해야한다.
--nvl(숫자, 숫자) , nvl(문자 , 문자)
select ename 사원명,sal,sal * 12 + nvl(comm,0) as 연봉,comm
from emp;                       --nvl(comm(숫자데이터),숫자0)

select ename,job,mgr
from emp
where mgr is null;

select ename,job,nvl(to_char(mgr,'9999'),'CEO') as mgr   --mgr은 숫자타입이고 CEO는 문자이므로 타입이 불일치함 -> to_char을 이용하여 문자타입으로 변환
from emp
where mgr is null;

select comm,nvl2(comm,'O','X') --null인 경우는 O반환, null이 아니면 X반환 / 타입 상관 무
from emp;

------------------------------------------------------------------------------
--6. 조건문 표현하는 함수
--decode()  -> switch 
--case()    -> if

--decode() 함수
select ename,job,deptno,
    decode(deptno,10,'AAA',20,'BBB',30,'CCC','기타') as 부서명   --마지막은 디폴트값
    --deptno랑 10을 비교해서 맞으면 AAA, deptno랑 20이랑 비교해서 맞으면 BBB ... 이런식으로 진행됨
from emp;

--case() 함수
--범위를 조건으로 설정가능
--  case 
--       when 조건식 then 실행문
--       when 조건식 then 실행문
--       else 실행문
--  end as 별칭
select ename,job,deptno,
    case
    when deptno = 10 then 'AAA'
    when deptno = 20 then 'BBB'
    when deptno = 30 then 'CCC'
    else '기타'
end as 부서명
from emp;

select ename,job,sal,
    case 
    when sal between 3000 and 5000 then '임원'
    when sal >= 2000 and sal < 3000 then '관리자'
    when sal >= 500 and sal < 2000 then '사원'
    else '기타'
end as 직급
from emp;

--------------------------------------------------------------------------------
--예제 1
select 
empno,rpad(substr(empno,1,2),4,'*') as MASKING_EMPNO,
ename,rpad(substr(ename,1,1),length(ename),'*') as MASKING_ENAME
from emp
where length(ename) >=5 and length(ename) <6;

--예제 2
select empno,ename,sal,
trunc((sal/21.5),2) as DAY_PAY,
round((sal/21.5/8),1) as TIME_PAY
from emp;

--예제 4
select empno,ename,mgr,
case 
    when mgr is null then '0000'
    when substr(mgr,1,2) = '75' then '5555'
    when substr(mgr,1,2) = '76' then '6666'
    when substr(mgr,1,2) = '77' then '7777'
    when substr(mgr,1,2) = '78' then '8888'
    else to_char(mgr)
end as CHG_MGR
from emp;

-------------------------------------------------------------------------------
--7. 다중행 함수(그룹함수)
--sum(),avg(),count(),max(),min()
--결과를 하나의 값으로 반환함
--일반 컬럼과 같이 사용 불가
--크기 비교가 가능한 모든 타입에 사용 가능(날짜, 숫자 ...)

--전체 직원의 월급을 더함
select sum(sal)   -29025
from emp;

select avg(sal)
from emp;

--count(*) : 전체 레코드의 개수 확인
select count(*),count(comm)
from emp;

select max(sal),min(sal)
from emp;

select ename,max(sal)   --다중행 함수와 일반 컬럼은 같이 사용할 수 없다.
from emp;

--날짜 비교도 가능
select min(hiredate)    --가장 오래 일한 직원(입사일이 가장 빠른 사람)
from emp
where deptno = 20;

select max(hiredate)    --가장 최근에 입사한 직원
from emp
where deptno = 20;

--------------------------------------------------------------------------------
--select 컬럼명
--from 테이블명
--where 조건식(그룹함수 사용 불가/group by,having 보다 먼저 실행)
--group by 기준 컬럼명
--having 조건식(그룹함수 사용)
--order by 컬럼명 정렬방식 ===> 항상 맨 마지막에 작성

--group by절
select avg(sal) from emp where deptno = 10
UNION
select avg(sal) from emp where deptno = 20
UNION
select avg(sal) from emp where deptno = 30;

select deptno
from emp
group by deptno;

select deptno, avg(sal)   --행의 갯수가 같을 때는 같이 사용 가능
from emp
group by deptno
order by deptno;

select deptno,job,avg(sal)
from emp
group by deptno,job
order by deptno,job desc;


--having절
--group by에 의해 조회된 값에 대한 조건을 건다.
--조건식을 작성할 때 그룹함수를 사용한다.
select deptno, avg(sal)
from emp
group by deptno
having avg(sal) >= 2000;   

select deptno, avg(sal)
from emp
where deptno != 10
group by deptno
having avg(sal) >= 2000;





