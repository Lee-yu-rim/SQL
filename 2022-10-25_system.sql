drop user user01 CASCADE;
create user user01 identified by 1234;
grant CREATE SESSION  to user01;

revoke create table --권한뺏끼이
from user01;

grant CREATE SESSION
to user01;

grant create table
to user01;

alter user user01
quota 2m on users;

create user user02 identified by 1234;
grant connect,resource
to user02;

drop user nbac;
create user nbac identified by 1234;
grant dba,connect,resource
to nbac; --system 계정과 같아진다

revoke role mrole3 
from user01;

set ROLE all;
create user user05 identified by 1234;
grant connect, resource
to user05;

grant mrole3 to user05;

revoke mrole3
from user05;