-- 날짜함수

-- SYSDATE : 현재 날짜를 조회
    -- sysdate -1 : 어제
    -- sysdate : 오늘
    -- sysdate +1 : 내일 
-- round
-- trunk
select sysdate -1 from dual;
select sysdate from dual;
select sysdate +1 from dual;

select sysdate - hiredate as 근무일수 from emp; --이 차이는 일수로 반환됨

-- 근속년수
select trunc((sysdate - hiredate) / 365) as 근속년수 from emp; --연산자가 두개 이상 들어가면 괄호로 묶어두기


select sysdate,
    round(sysdate,'CC') as format_cc, 
    round(sysdate,'YYYY') as format_yyyy, 
    round(sysdate,'Q') as format_Q, 
    round(sysdate,'DDD') as format_DDD,
    round(sysdate,'HH') as format_HH
FROM DUAL;

select sysdate,
    trunc(sysdate,'CC') as format_cc, 
    trunc(sysdate,'YYYY') as format_yyyy, 
    trunc(sysdate,'Q') as format_Q, 
    trunc(sysdate,'DDD') as format_DDD,
    trunc(sysdate,'HH') as format_HH
FROM DUAL;

--자료형변환 함수
--to_char()
--to_number() :문자가 숫자 형식으로 존재해야함
--to_date()


--날짜를 문자로
select sysdate, to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') as 현재시간 from dual;
select hiredate, to_char(hiredate,'YYYY-MM-DD HH24:MI:SS:DAY') from emp;

select to_char(123456,'L999,999') from dual; --세자리마다 , 를 찍게해달라
select to_char(sal,'L999,999') from emp; --빈자리를 특별히 채우지않음
select to_char(sal,'L000,000') from emp; --빈자리를 0으로 채움


--문자를 숫자로
select '20000' - 10000 from dual; --자동형변환이 일어난다.
select '20,000' - '10,000' from dual; 
--얘는 자동형변환이 일어나지 않음. to_number() 형변환을 해야한다.

select to_number('20,000','999,999') - to_number('5,000','999,999') from dual;

--문자를 날짜로 바꾸기
select to_date('20221019','YYYY/MM/DD') from dual; 
select * from emp where hiredate < to_date('19820101','YYYY/MM/DD');

-- null데이터 처리
-- nvl(null,바꾸고싶은 데이터)
-- nvl은 null데이터의 타입과 같은 타입으로 변경해주어야 한다.
-- nvl(숫자, 숫자), nvl(문자,문자)
select ename 사원명, sal, sal * 12 + nvl(comm,0) as 연봉, comm from emp;

select * from emp where mgr is null;
select ename,job,mgr from emp where mgr is null;

--에러 전후 수정. 메모에 정리해두기
select ename,job,nvl(mgr,'CEO') from emp where mgr is null;
select ename,job,nvl(to_char(mgr,'9999'),'CEO')as mgr from emp where mgr is null;

--null이면 뒤의 것, 아니라면 앞에것
select comm, nvl2(comm,'O','X') from emp;

-- 조건문 표현하는 함수
-- decode() -> switch
-- case() -> if

select ename,job,deptno,decode(deptno,10,'AAA',20,'BBB',30,'CCC','기타')as 부서명 from emp;

--범위를 조건식으로 설정 할 수 있다.
case
    when 조건식 then 실행문
    when 조건식 then 실행문
    when 조건식 then 실행문
    else
end as 별칭

select ename, job, deptno,
    case
    when deptno = 10 then 'AAA'
    when deptno = 20 then 'BBB'
    when deptno = 30 then 'CCC'
    else '기타'
    end as 부서명
from emp;


    --case sal>= 3000 and sal <= 5000 then'임원'
select ename,job,sal, 
    case
        when sal between 3000 and 5000 then'임원'
        when sal < 3000 and sal >= 2000 then '관리자'
        when sal >= 500 and sal < 2000 then '사원'
        else '기타'
    end as 직급
from emp;


------------------------------------------------------
-- 1번문제
select rpad('930103-',14,'*') from dual;

select empno,rpad(substr(empno,1,2),4,'*'),ename,rpad(substr(ename,1,1),length(ename),'*')
from emp
where ename like '_____';
--where length(ename) >= 5 and length(ename) <6;


--2번문제
select empno,ename,sal, trunc((sal / 21.5),2) as DAY_PAY,round((sal / 21.5)/8,1) as TIME_PAY from emp;


--4번문제 
select empno, ename, mgr,
    case
        --when mgr != 1 then 0000
        when substr(mgr,1,2) = 75 then '5555'
        when substr(mgr,1,2) = 76 then '6666'
        when substr(mgr,1,2) = 77 then '7777'
        when substr(mgr,1,2) = 78 then '8888'
        when mgr is null then '0000'
        else to_char(mgr)
        end as CHG_MGR
from emp;
-- substr을 정확히 기억못해서 풀지못함 다시 용어 정리해둘것

select sal from EMP;
select sum(sal) from emp; --합
select avg(sal) from emp; --평균
select count(*) from emp; --전체에서 갯수 세기 ex)게시판의 게시글 세기
select max(sal),min(sal) from emp;
select count(*),count(comm) from emp; --특정 컬럼을 카운트 할 수 있음.
select min(hiredate),max(hiredate) from emp where deptno = 20;

-- 그룹함수
-- sum(),avg(),count(),max(),min(),
-- 일반 컬럼과 같이 사용이 불가능하다.
-- 하지만 조회되는 갯수가 같다면 함께 사용가능하다.
-- 크기 비교가 가능한 모든 타입에 사용가능하다.

-- select 컬럼명
-- from 테이블명
-- where 조건식(그룹함수 사용불가/group by, having 보다 먼저 실행)
-- group by 기준컬럼명
-- having 조건식 -> 조건식이 두번있음 대박임  (그룹함수를 사용한다)
-- order by 컬럼명 정렬방식 => 맨 마지막에 작성한다.

select avg(sal) from emp where deptno = 10
union
select avg(sal) from emp where deptno = 20
union
select avg(sal) from emp where deptno = 30;

select deptno from emp group by deptno;
select deptno, avg(sal) from emp group by deptno order by deptno;
select deptno,job, avg(sal) from emp group by deptno ,job order by deptno, job, desc; --orderby 에 조건이 여러개면 앞에 있는 것부터 차례대로 정렬한다. deptno대로 정렬된 값 중에서 job으로 다시 정렬하고 desc로 정렬하는...

select deptno, avg(sal) 
from emp 
group by deptno 
having avg(sal)>2000; --group by에 의해서 조회 결과에 조건을 준다. 조건식을 작성할 때 그룹함수를 사용한다.

select deptno, avg(sal) 
from emp 
where deptno != 10
group by deptno 
having avg(sal)>=2000;