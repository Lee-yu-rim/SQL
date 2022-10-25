--DCL(Data Control Language - 데이터 제어어)
--grant(권한부여), revoke(권환회수)
--grant 시스템권한 to 계정명
--revoke 시스템권한 from 계정명

--사용자 관리 -> 모든 명령어는 관리자 계정인 system 계정에서만 사용 가능하다.
--create,drop,alter
--계정 생성 : create user 계정명 identified by 패스워드
--계정 수정 : alter user 계정명 identified by 패스워드
--계정 삭제 : drop user 계정명 cascade

--계정 생성
create user user01 identified by 1234;  --아이디는 대소문자 구분X, 패스워드는 구분O

--권한 부여
grant CREATE SESSION 
to user01; 

--권한 회수
revoke create table  
from user01;

--계정 권한 부여
grant create table --테이블 생성 권한
to user01;

--계정 정보 수정
alter user user01 identified by tiger; --패스워드 변경

--계정 삭제
drop user user01 CASCADE;

--테이블 스페이스에 데이터를 저장할 수 있는 공간 부여(용량 할당)
alter user user01
quota 2m on USERS;

--시스템 권한(create ...)

--객체 권한(select ...)
--grant 객체권한 종류 
--on 객체명
--to 계정명

--객체 권한 부여
grant select
on emp
to user01;  --emp테이블은 scott계정에 있기때문에 scott계정에서 실행함

--객체 권환 회수
revoke select
on emp
from user01;


--roll을 이용한 권한부여
--connect 
--resource
--dba

--grant dba,connect,resource  --관리자 권한 부여(시스템계정과 같음)
--to nbac;

--사용자 정의 롤 : 원하는 객체 권한이 담긴 롤 생성
--관리자 계정에서만 가능
--create role 롤명
--grant 권한 to 롤명


--1. 관리자 권한에서 롤 생성  --> system 계정
--create role mrole2;  

--2.사용자(scott)계정으로 접속해서 객체 권한 부여(접속)
grant select  
on emp
to mrole;

--3. 롤 권한은 관리자 계정에서 줌 -> system 계정
--grant mrole2
--to user04;

--4. user04계정에서 emp 테이블을 조회함

--5. system 계정에서 롤권한 회수 






