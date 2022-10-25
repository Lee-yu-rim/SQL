--DDL(데이터 정의어) : table(모든 객체)을 생성, 삭제, 변경하는 명령어
--create(생성) , alter(변경) , drop(삭제)

--1. create : 테이블의 생성
--create table 테이블명(    --table : 객체
--    컬럼명1 타입,          --column : 속성
--    컬럼명2 타입,
--    컬럼명3 타입    
--);

drop table emp_ddl;

create table emp_ddl(
    empno number(4),
    ename varchar2(10),   --byte크기
    job varchar2(9),
    mgr number(4),
    hiredate date,    --date는 크기지정 x
    sal number(7,2),  --전체 7자리 중 두자리는 소수점
    comm number(7,2),
    deptno number(2)
);

select *
from emp_ddl;

insert into emp_ddl
values (9999,'이순신','MANAGER',1111,sysdate,1000,null,10);

--테이블의 복사 : 기존에 존재하는 테이블의 데이터를 가져와서 새로운 테이블을 만드는 것
create table dept_ddl
as
select * from dept;

--테이블의 데이터를 선택해서 일부 데이터만 복사
create table dept_30
as
select * from dept
where deptno = 30;

select *
from dept_30;

create table dept_m
as
select dname,loc
from dept;

--테이블의 데이터를 제외한 구조만 복사
create table dept_d
as
select * from dept
where 1 != 1;

--2. alert : 테이블의 정보 변경 (컬럼의 정보 수정)
--add : 새로운 컬럼 추가
--rename : 컬럼의 이름 변경
--modify : 자료형의 변경
--drop : 컬럼 삭제

create table emp_alter
as
select * from emp;

select *
from emp_alter;

--테이블에 새로운 컬럼 추가
alter table emp_alter
add address varchar2(100);

--컬럼의 이름 변경
alter table emp_alter
rename column address to addr;

--자료형의 변경
alter table emp_alter
modify empno number(10);

--컬럼의 삭제
alter table emp_alter
drop column addr;

drop table emp_alter;

select *
from emp_alter;

--연습문제 1
create table EMP_HW(
    empno number(4),
    ename varchar2(10),
    job varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2)
);

select *
from emp_hw;
    
--연습문제 1-1 
alter table emp_hw
add BIGO varchar2(20);

--연습문제 1-2   
alter table emp_hw
modify BIGO varchar2(30);

--연습문제 1-3
alter table emp_hw
rename column BIGO to remark;

--연습문제 1-4
insert into emp_hw
select empno,ename,job,mgr,hiredate,sal,comm,deptno,NULL 
from emp;

--연습문제 1-5
drop table emp_hw;

--------------------------------------------------------------------------------
--데이터 사전
desc user_tables;  

select table_name
from user_tables; --soctt 계정에서 사용할 수 있는 테이블 정보를 보여줌

select owner,table_name
from all_tables;   --다른 계정의 테이블을 모두 조회

--------------------------------------------------------------------------------
--index : 검색 속도를 향상하기 위해 사용하는 객체
--create(생성) , drop(삭제)
--select 구문의 검색속도를 향상시킨다.
--전체레코드의 3% ~ 5% 정도 일 때
--indext 객체를 컬럼에 생성해서 사용

--create index 인덱스명
--on 테이블명(컬럼명)

drop table emp01;

create table emp01
as
select * from emp;

select *
from emp01;

insert into emp01
select * from emp01;

insert into emp01(empno,ename)
values (1111,'bts');

--index 객체 생성 전 조회 속도(0.032초)
select empno,ename
from emp01
where ename = 'bts';

--index 객체 생성 후 조회 속도(0.001초)
create index idx_emp01_ename
on emp01(ename);

--index 객체 삭제
drop index idx_emp01_ename;

show recyclebin; --휴지통에 버려진 테이블 정보 확인

--테이블 삭제 후 원상복구
flashback table emp_hw
to before drop;

--휴지통 비우기
purge recyclebin;

--------------------------------------------------------------------------------
--제약조건(무결성) : 잘못된 값이 데이터로 사용되는 것을 막는 것
--not null : 반드시 null이 아닌 데이터만 들어가야한다.
--unique : 무결성을 체크 (중복값이 들어갈 수 없다) but, null데이터는 받고 중복될 수 있음
--primary key(기본키) : not null + unique
--foreign key(외래키,참조키)
    --부모와 자식의 관계를 가지는 자식 쪽 테이블의 컬럼에 foreign key 를 설정한다.
    --부모 쪽 테이블의 컬럼은 반드시 primary key 또는 unique 해야한다.
    --부모 : 자식  =  n : 1 관계
    --null 데이터를 허용한다.
--check : 값의 범위를 설정하여 그 범위를 넘어서지 못하게 제약을 거는 것
--defalt
--제약조건명 설정 : constraint 테이블명_컬럼명_제약조건약어

insert into emp
values (1111,'aaa','MANAGER','9999',sysdate,1000,null,50);
--무결성 제약조건(SCOTT.FK_DEPTNO)이 위배되었습니다- 부모 키가 없습니다

drop table emp02;

create table emp02(
    empno number(4) constraint emp02_empno_pk primary key,  --같은 사번인 사원이 만들어지지 않도록하고, 값이 필수로 들어가게 한다.
    ename varchar2(10) constraint emp02_ename_nn not null,  --사번과 이름이 없는 사원을 만들지 못하도록 제약
    job varchar2(9),
    deptno number(2)
);

insert into emp02
values (null,null,'MANAGER',30);  

insert into emp02
values (1111,'홍길동','MANAGER',30);

insert into emp02
values (2222,'홍길동','MANAGER',30);

insert into emp02
values (null,'김유신','SALESMAN',20);  --NULL을 ("SCOTT"."EMP02"."EMPNO") 안에 삽입할 수 없습니다

insert into emp02
values (2222,'옥동자','SALESMAN',20);  --무결성 제약 조건(SCOTT.SYS_C0011062)에 위배됩니다
                                      --무결성 제약 조건(SCOTT.EMP02_EMPNO_PK)에 위배됩니다
select * from emp02;


--부모 테이블 생성 -> 항상 부모테이블 먼저 생성해야 한다.
create table dept03(
    deptno number(2) constraint dept03_deptno_pk primary key,   --자식 테이블에서 참조하는 데이터는 primary key로 지정되어야 한다.
    dname varchar2(20) constraint dept_03_dname_nn not null,
    loc varchar2(20) constraint dept_03_loc_nn not null
);

--자식 테이블 생성
create table emp03(
    empno number(4) constraint emp03_empno_pk primary key,
    ename varchar2(9)constraint emp03_ename_nn not null,
    job varchar2(9),
    deptno number(2) constraint emp03_deptno_fk references dept03(deptno)  --부모 테이블의 deptno 데이터를 참조하겠다.
);

--서브쿼리문을 사용한 데이터 삽입(기존 테이블의 데이터를 사용한다.)
--부모 테이블의 데이터 삽입 -> 데이터의 삽입도 부모 테이블 먼저
insert into dept03
select * from dept;   --dept 테이블과 dept03 테이블의 컬럼갯수는 같다.

--자식 테이블의 데이터 삽입
--insert into emp03
--select * from emp;    --emp 테이블은 8개의 컬럼을 가짐 , emp03 테이블은 4개의 컬럼을 가짐 -> 미스 매칭으로 오류가 나기 때문에 필요한 데이터만 가져와야함
insert into emp03
select empno,ename,job,deptno from emp;

select * from dept03;
select * from emp03;

insert into emp03
values (1111,'aaa','MANAGER',9999,sysdate,1000,null,50);  --50번 부서는 존재하지 않기때문에 오류 발생함(SQL 오류: ORA-00913: 값의 수가 너무 많습니다)

insert into emp03
values (1111,'aaa','MANAGER',50);  --참조할 수 있는 데이터가 존재하지 않음 (ORA-02291: 무결성 제약조건(SCOTT.EMP03_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다)
 
create table emp04(
    empno number(4) constraint emp04_empno_pk primary key,
    ename varchar2(10) constraint emp04_ename_nn not null,
    sal number(7) constraint emp04_sal_ck check(sal between 500 and 5000),  --check 제약 조건
    gender varchar2(2) constraint emp04_gender_ck check(gender in('M','F'))
);

select * from emp04;

insert into emp04
values (1111,'hong',1000,'F');

insert into emp04
values (2222,'hong',200,'F');  --ORA-02290: 체크 제약조건(SCOTT.EMP04_SAL_CK)이 위배되었습니다

insert into emp04
values (3333,'hong',1000,'A');  --ORA-02290: 체크 제약조건(SCOTT.EMP04_GENDER_CK)이 위배되었습니다

create table dept05(
    deptno number(2),
    dname varchar(10),
    loc varchar(15) default 'SEOUL'  --기본값이 seoul이 되도록 지정(값이 따로 지정되지 않으면 기본값으로 조회됨)
);

insert into dept05(deptno,dname)
values (10,'SALES');   --loc가 기본값인 SEOUL 로 조회됨

insert into dept05(deptno,dname,loc)
values (10,'SALES','BUSAN');   --지정을 하게되면 기본값이 아닌 지정한 값으로 조회됨

select * from dept05;


--제약조건 설정 방식
    --컬럼 레벨의 설정 : 컬럼 뒤에 바로 제약조건을 거는 것
    --테이블 레벨의 설정 : 테이블 안에서 제약조건을 거는 것  ** not null은 적용할 수 없다. -> 컬럼 레벨에서만 가능

create table emp06(
    empno number(4),
    ename varchar2(20) constraint emp06_ename_nn not null,
    job varchar2(20),
    deptno number(20),
    
    --테이블 레벨의 설정을 통한 제약 조건 설정
    constraint emp06_empno_pk primary key(empno),
    constraint emp06_job_uk unique(job),
    constraint emp06_deptno_fk foreign key(deptno) references dept(deptno)   --테이블 레벨 방식에서는 foreign key를 써준다.
);                                --본인 테이블 컬럼         --부모 테이블 컬럼

insert into emp06
values (3333,'hong','PRESIDENT',80);


--복합키 : 기본키를 두개의 컬럼에 사용하는 경우
    --테이블 레벨 방식으로만 적용 가능
    --1. 테이블 안에서 정의하는 방식
    --2. Alter 명령어를 사용하는 방식

--테이블 안에서 정의하는 방식
create table member(
    name varchar2(10),
    address varchar2(30),
    hphone varchar2(10),
    
    constraint member_name_address_pk primary key(name,address)
);

--Alter 명령어를 사용하는 방식
create table emp07(
    empno number(4),
    ename varchar2(20),
    job varchar2(20),
    deptno number(20)
);

--add : 제약조건 추가
alter table emp07
add constraint emp07_empno_pk primary key(empno);

alter table emp07
add constraint emp07_deptno_fk foreign key(deptno) references dept(deptno);

--modify : not null을 사용하여 변경의 개념으로 사용한다.(null ->  not null)
alter table emp07
modify job constraint emp07_job_nn not null;

alter table emp07
modify ename constraint emp07_ename_nn not null;

--drop : 제약조건 삭제
    --제약조건명(constraint) 또는 제약조건(primary key)을 사용하여 삭제
alter table emp07
drop constraint emp07_empno_pk;   --제약조건명을 사용하여 삭제하는 방식


drop table emp08;
drop table dept08;

create table dept08(
    deptno number(2),  
    dname varchar2(10),
    loc varchar2(15)
);

alter table dept08
add constraint dept08_deptno_pk primary key(deptno);

create table emp08(
    empno number(4),
    ename varchar2(20),
    job varchar2(20),
    deptno number(20)
);

alter table emp08
add constraint emp08_empno_pk primary key(empno);

alter table emp08
add constraint emp08_deptno_fk foreign key(deptno) references dept08(deptno); 

insert into dept08
select * from dept;

insert into emp08
select empno,ename,job,deptno from emp;

delete from dept08
where deptno = 10;   --ORA-02292: 무결성 제약조건(SCOTT.EMP08_DEPTNO_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다 
--자식이 참조하고 있을 때 부모데이터를 지울 수 없다.

alter table dept08
disable primary key cascade;  --부모와 자식간의 foriegn key가 있다면 비활성화 -> 부모 테이블 데이터 삭제 가능

alter table dept08
drop primary key;   --ORA-02273: 고유/기본 키가 외부 키에 의해 참조되었습니다
--제약조건이 비활성화 된 것일 뿐이기 때문에 제약조건을 삭제할 수는 없다.

alter table dept08
drop primary key cascade;  --cascade를 넣어주면 제약조건이 완전히 삭제된다.

--예제 1
create table dept_const(
    deptno number(2),
    dname varchar2(14),
    loc varchar2(13)
);

alter table dept_const
add constraint deptconst_deptno_pk primary key(deptno);

alter table dept_const
add constraint deptconst_dname_unq unique(dname);

alter table dept_const
modify loc constraint deptconst_loc_nn not null;


--예제 2
create table emp_const(
    empno number(4),
    ename varchar2(10),
    job varchar2(9),
    tel varchar2(20),
    hiredate date,
    sal number(7),
    comm number(7),
    deptno number(2)
);

alter table emp_const
add constraint empconst_empno_pk primary key(empno);

alter table emp_const
modify ename constraint empconst_ename_nn not null;

alter table emp_const
add constraint empconst_tel_unq unique(tel);

alter table emp_const
add constraint empconst_sal_chk check(sal between 1000 and 9999);

alter table emp_const
add constraint empconst_deptno_fk foreign key(deptno) references dept(deptno);


--SQL CRUD
 --DML - Create(insert)
 --DQL - Read(select)
 --DML - Update
 --DML - Delete
--------------------------------------------------------------------------------
--객체 : table, index, view
 --객체는 create를 이용하여 생성해서 사용해야한다.
 
-- view : 원하는 데이터만 담긴 테이블을 보기 위한 목적
 --1.보안
 --2.범위(변경불가)
 
 --create or replace view 뷰테이블명(alias-선택)
 --as
 --서브쿼리(select * from 테이블명) -> 다른 명령어와 중첩해서 사용하는 것 
   --단순뷰(테이블 1개) or 복합뷰
 --with check option (옵션)
 --with read only (옵션)

create table dept_copy
as
select * from dept;

create table emp_copy  --복사되는 테이블에는 제약조건이 넘어오지 않는다.
as
select * from emp;

--제약조건 추가
alter table emp_copy
add constraint emp_copy_deptno_fk foreign key(deptno) references dept(deptno);

select * from emp_copy;   --14개 행

--단순뷰 : 하나의 테이블을 이용해서 뷰테이블 생성
create or replace view emp_view30
as
select empno,ename,sal,deptno from emp_copy  
where deptno = 30;   --권한이 없어서 생성 불가능

--시스템 계정에서 권한 생성
--grant create view
--to scott;

--30번 부서의 사원들만 볼 수 있는 테이블이 생성됨
select *
from emp_view30;

insert into emp_view30
values (1111,'hong',1000,30);

select *
from emp_copy;
--뷰테이블은 가상 테이블이고 실제 데이터 처리는 원래 테이블에서 일어난다.

insert into emp_view30 (empno,ename,sal,deptno)
values (2222,'hong',2000,50);    --원래는 부서번호를 넣지 않으면 외부키 제약조건에 위배되지만, 복사된 테이블에는 제약조건이 들어오지 않기때문에 위배되지 않음.
--실제 데이터는 copy테이블에 들어가있기 때문에 foreign key 제약조건에 위배됨

create or replace view emp_view(사원번호,사원명,급여,부서번호)
as
select empno,ename,sal,deptno from emp_copy;

select * from emp_view
where 부서번호 = 20;
--where deptno = 20;  --error 별칭을 지정하게 되면 원래 컬럼명은 사용할 수 없다.

--복합뷰 : 두 개 이상의 테이블을 사용하여 뷰테이블 생성
create or replace view emp_dept_view
as
select empno,ename,sal,e.deptno,dname,loc
from emp e inner join dept d 
on e.deptno = d.deptno 
order by empno desc;

select *
from emp_dept_view;

--부서별 최소급여와 최대급여
--dname min_sal max_sal

drop table sal_view;

create or replace view sal_view
as
select dname, min(sal) as min_sal, max(sal) as max_sal
from emp e inner join dept d
on e.deptno = d.deptno 
group by dname;

select *
from sal_view;

--뷰테이블 삭제
drop view sal_view;

--모든 객체의 이름은 중복될 수 없다. = 유일해야 한다.
create or replace view sal_view   --기존 뷰테이블의 내용을 수정하고 싶을 때 or replace를 입력해서 수정하게 되면 내용이 덮어쓰기 된다.
as
select dname, min(sal) as min_sal, max(sal) as max_sal, avg(sal) as avg_sal
from emp e inner join dept d
on e.deptno = d.deptno 
group by dname;

--with check option
create or replace view view_chk30
as
select empno,ename,sal,comm,deptno 
from emp_copy
where deptno = 30 with check option;   --조건절의 컬럼을 수정 및 변경하지 못하게 한다.
 
--데이터를 수정하는 작업이 불가함
update view_chk30
set deptno = 10;  
--ORA-01402: 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다

--with read only
create or replace view view_read30
as
select empno,ename,sal,comm,deptno 
from emp_copy
where deptno = 30 with read only;    --모든 컬럼에 대한 C(생성) U(수정) D(삭제)가 불가능 , 데이터 조회만 가능함
 
update view_read30
set deptno = 10;
--SQL 오류: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다 (insert,update,delete)

--뷰의 활용
--TOP - N 조회하기
--ROWNUM(의사 컬럼)

select * from emp;

--입사일이 가장 빠른 5명의 사원 조회
select * from emp
order by hiredate asc;

select * from emp
where hiredate <= '81/05/01';

select rownum,empno,ename,hiredate
from emp
where rownum <= 5;

select rownum,empno,ename,hiredate
from emp
where rownum <= 5
order by hiredate asc;   --정렬이 가장 마지막에 동작하기 때문에 빠른 입사일 순으로 조회되지 않음

--뷰테이블을 이용하여 hiredate 가 입사일이 빠른 순으로 정렬되어있는 상태의 테이블을 생성한다.
create or replace view view_hiredate
as
select empno,ename,hiredate
from emp
order by hiredate asc;

select * from view_hiredate;

select rownum,empno,ename,hiredate
from view_hiredate;

select rownum,empno,ename,hiredate
from view_hiredate
where rownum <= 7;

select rownum,empno,ename,hiredate
from view_hiredate
where rownum between 2 and 5;   --rownum은 조건절에 직접 사용시 반드시 1을 포함하는 조건식을 만들어야 한다.(범위연산이 불가함) 

create or replace view view_hiredate_rm
as
select rownum rm,empno,ename,hiredate   --rownum에 별칭을 부여하여 고정된 컬럼으로 사용함
from view_hiredate;

select rm,empno,ename,hiredate
from view_hiredate_rm;

select rm,empno,ename,hiredate
from view_hiredate_rm
where rm between 2 and 5;

--중첩
--select (select) -> 일반쿼리
--from (select) -> 인라인뷰
--where (select) -> 서브쿼리

--인라인뷰
select rownum rm,b.*
from (
    select rownum rm,a.*
    from (
        select empno,ename,hiredate
        from emp
        order by hiredate asc
        ) a    -- 안쪽 테이블 별칭
    ) b  --바깥쪽 테이블 별칭
where rm between 2 and 5;

--입사일이 가장 빠른 5명 조회
select rownum,a.*
from(
    select empno,ename,hiredate
    from emp
    order by hiredate asc
    ) a
where rownum <= 5;

--시퀀스
--자동으로 번호를 증가시키는 기능 수행
--create,drop
--nextval,currval 명령어

--create sequence 시퀀스명
--옵션
--start with : 시작값 => 1
--increment by : 증가치 => 1
--maxvalue : 최댓값 => 10의 1027승
--minvalue : 최솟값 => 10의 -1027승

create sequence dept_deptno_seq
increment by 10
start with 10;   --10부터 시작해서 10씩 증가, 옵션을 주지않은 것들은 기본값으로 생성됨

select dept_deptno_seq.nextval  --실행할 때마다 값이 증가함(시퀀스 실행)
from dual;  --back 불가

select dept_deptno_seq.currval  --현재의 값이 얼만지 확인
from dual;

create sequence emp_seq
start with 1
increment by 1
maxvalue 1000;

drop table emp01;

create table emp01
as
select empno,ename,hiredate from emp
where 1 != 1;

select * from emp01;

insert into emp01
values (emp_seq.nextval,'hong',sysdate);





























