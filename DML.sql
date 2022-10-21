--DML(데이터 조작어) : insert , update , delete

--1. insert : 테이블에 데이터 삽입
--insert into 테이블명 (컬럼명1, 컬럼명2,...)
--values (값1,값2...)
--컬럼과 값의 타입과 갯수가 일치해야한다.
--작성 순서대로 1 : 1 매칭된다.

--테이블 생성
create table dept_temp  --테이블 이름
as
select * from dept;

select *
from dept_temp;

--데이터 생성
insert into dept_temp (deptno,dname,loc)
values (50,'DATABASE','SEOUL');  --데이터의 타입에 맞춰서 작성

insert into dept_temp (deptno,dname)
values (60,'JSP');    --loc 데이터는 null 데이터로 자동 생성된다. (묵시적 null 데이터 삽입) 

insert into dept_temp    --컬럼 생략 (테이블의 전체컬럼을 사용할 땐 생략 가능)
values (70,'HTML','SEOUL'); 

insert into dept_temp    
values (80,'NULL','SEOUL');   --명시적 null 데이터 삽입

--테이블 생성 
create table emp_temp
as
select * from emp
where 1 != 1;    --데이터는 제외하고 컬럼만 가져옴

select *
from emp_temp;

insert into emp_temp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
values (9999,'홍길동','PRESIDENT',NULL,'2001/01/01',5000,1000,10);

insert into emp_temp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
values (3111,'심청이','MANAGER',9999,sysdate,4000,NULL,30);

--2. update : 컬럼의 데이터를 변경(수정)
--update 테이블명
--set 컬럼명 = 변경할 값, 컬럼명 = 변경할 값, ...
--where 조건식
--조건절을 사용하지 않으면 해당 컬럼이 모두 변경된다.

drop table dept_temp2;   --테이블 삭제

create table dept_temp2
as
select * from dept;

select *
from dept_temp2;

update dept_temp2
set dname = 'DATABASE' , loc = 'SEOUL'
where deptno = 40;

--3. delete : 데이터 삭제
--delete from 테이블명
--where 조건절
--조건절을 사용하지 않으면 모든 데이터가 삭제된다.

drop table emp_temp2;

create table emp_temp2
as
select * from emp;

delete from emp_temp2;   --데이터 삭제(전체 데이터가 삭제됨)

delete from emp_temp2
where ename = 'SCOTT';  --where 절을 사용하여 일부 데이터만 삭제

select *
from emp_temp2;

--------------------------------------------------------------------------------
--TCL(데이터의 영구 저장 또는 취소)
--트랜잭션
--commit , rollback, savepoint
--commit : 데이터의 영구 저장(테이블에 데이터 반영), create 구문을 사용하여 객체를 생성할 때 자동으로 커밋이 이루어진다.
--rollback : 데이터 변경 취소(테이블에 데이터 미반영) 원상복구 , 천재지변,정전,전쟁과 같은 예측 불가 상태일 때 자동으로 롤백이 이루어진다.

drop table dept01;

create table dept01
as
select * from dept;

select *
from dept01;


delete from dept01;   --내부적으로는 테이블을 삭제했지만, 외부적으로 완전히 데이터가 삭제되진 않음
-- = 같은 명령어, 트랜잭션 적용 유무가 다르다.
truncate table dept01;  --트랜잭션 적용 불가(데이터 삭제와 동시에 커밋이 일어남 - 영구 삭제)

commit;   --commit을 하게되면 위에서 한 작업이 온전하게 테이블에 반영됨. 
rollback;   --원래 테이블로 복구함 but, 커밋이 일어나고 난 뒤에는 롤백 불가, 커밋 이전 지점까지만 반영
















