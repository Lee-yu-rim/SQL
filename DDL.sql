--DDL(������ ���Ǿ�) : table(��� ��ü)�� ����, ����, �����ϴ� ��ɾ�
--create(����) , alter(����) , drop(����)

--1. create : ���̺��� ����
--create table ���̺��(    --table : ��ü
--    �÷���1 Ÿ��,          --column : �Ӽ�
--    �÷���2 Ÿ��,
--    �÷���3 Ÿ��    
--);

drop table emp_ddl;

create table emp_ddl(
    empno number(4),
    ename varchar2(10),   --byteũ��
    job varchar2(9),
    mgr number(4),
    hiredate date,    --date�� ũ������ x
    sal number(7,2),  --��ü 7�ڸ� �� ���ڸ��� �Ҽ���
    comm number(7,2),
    deptno number(2)
);

select *
from emp_ddl;

insert into emp_ddl
values (9999,'�̼���','MANAGER',1111,sysdate,1000,null,10);

--���̺��� ���� : ������ �����ϴ� ���̺��� �����͸� �����ͼ� ���ο� ���̺��� ����� ��
create table dept_ddl
as
select * from dept;

--���̺��� �����͸� �����ؼ� �Ϻ� �����͸� ����
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

--���̺��� �����͸� ������ ������ ����
create table dept_d
as
select * from dept
where 1 != 1;

--2. alert : ���̺��� ���� ���� (�÷��� ���� ����)
--add : ���ο� �÷� �߰�
--rename : �÷��� �̸� ����
--modify : �ڷ����� ����
--drop : �÷� ����

create table emp_alter
as
select * from emp;

select *
from emp_alter;

--���̺� ���ο� �÷� �߰�
alter table emp_alter
add address varchar2(100);

--�÷��� �̸� ����
alter table emp_alter
rename column address to addr;

--�ڷ����� ����
alter table emp_alter
modify empno number(10);

--�÷��� ����
alter table emp_alter
drop column addr;

drop table emp_alter;

select *
from emp_alter;

--�������� 1
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
    
--�������� 1-1 
alter table emp_hw
add BIGO varchar2(20);

--�������� 1-2   
alter table emp_hw
modify BIGO varchar2(30);

--�������� 1-3
alter table emp_hw
rename column BIGO to remark;

--�������� 1-4
insert into emp_hw
select empno,ename,job,mgr,hiredate,sal,comm,deptno,NULL 
from emp;

--�������� 1-5
drop table emp_hw;

--------------------------------------------------------------------------------
--������ ����
desc user_tables;  

select table_name
from user_tables; --soctt �������� ����� �� �ִ� ���̺� ������ ������

select owner,table_name
from all_tables;   --�ٸ� ������ ���̺��� ��� ��ȸ

--------------------------------------------------------------------------------
--index : �˻� �ӵ��� ����ϱ� ���� ����ϴ� ��ü
--create(����) , drop(����)
--select ������ �˻��ӵ��� ����Ų��.
--��ü���ڵ��� 3% ~ 5% ���� �� ��
--indext ��ü�� �÷��� �����ؼ� ���

--create index �ε�����
--on ���̺��(�÷���)

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

--index ��ü ���� �� ��ȸ �ӵ�(0.032��)
select empno,ename
from emp01
where ename = 'bts';

--index ��ü ���� �� ��ȸ �ӵ�(0.001��)
create index idx_emp01_ename
on emp01(ename);

--index ��ü ����
drop index idx_emp01_ename;

show recyclebin; --�����뿡 ������ ���̺� ���� Ȯ��

--���̺� ���� �� ���󺹱�
flashback table emp_hw
to before drop;

--������ ����
purge recyclebin;

--------------------------------------------------------------------------------
--��������(���Ἲ) : �߸��� ���� �����ͷ� ���Ǵ� ���� ���� ��
--not null : �ݵ�� null�� �ƴ� �����͸� �����Ѵ�.
--unique : ���Ἲ�� üũ (�ߺ����� �� �� ����) but, null�����ʹ� �ް� �ߺ��� �� ����
--primary key(�⺻Ű) : not null + unique
--foreign key(�ܷ�Ű,����Ű)
    --�θ�� �ڽ��� ���踦 ������ �ڽ� �� ���̺��� �÷��� foreign key �� �����Ѵ�.
    --�θ� �� ���̺��� �÷��� �ݵ�� primary key �Ǵ� unique �ؾ��Ѵ�.
    --�θ� : �ڽ�  =  n : 1 ����
    --null �����͸� ����Ѵ�.
--check : ���� ������ �����Ͽ� �� ������ �Ѿ�� ���ϰ� ������ �Ŵ� ��
--defalt
--�������Ǹ� ���� : constraint ���̺��_�÷���_�������Ǿ��

insert into emp
values (1111,'aaa','MANAGER','9999',sysdate,1000,null,50);
--���Ἲ ��������(SCOTT.FK_DEPTNO)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�

drop table emp02;

create table emp02(
    empno number(4) constraint emp02_empno_pk primary key,  --���� ����� ����� ��������� �ʵ����ϰ�, ���� �ʼ��� ���� �Ѵ�.
    ename varchar2(10) constraint emp02_ename_nn not null,  --����� �̸��� ���� ����� ������ ���ϵ��� ����
    job varchar2(9),
    deptno number(2)
);

insert into emp02
values (null,null,'MANAGER',30);  

insert into emp02
values (1111,'ȫ�浿','MANAGER',30);

insert into emp02
values (2222,'ȫ�浿','MANAGER',30);

insert into emp02
values (null,'������','SALESMAN',20);  --NULL�� ("SCOTT"."EMP02"."EMPNO") �ȿ� ������ �� �����ϴ�

insert into emp02
values (2222,'������','SALESMAN',20);  --���Ἲ ���� ����(SCOTT.SYS_C0011062)�� ����˴ϴ�
                                      --���Ἲ ���� ����(SCOTT.EMP02_EMPNO_PK)�� ����˴ϴ�
select * from emp02;


--�θ� ���̺� ���� -> �׻� �θ����̺� ���� �����ؾ� �Ѵ�.
create table dept03(
    deptno number(2) constraint dept03_deptno_pk primary key,   --�ڽ� ���̺��� �����ϴ� �����ʹ� primary key�� �����Ǿ�� �Ѵ�.
    dname varchar2(20) constraint dept_03_dname_nn not null,
    loc varchar2(20) constraint dept_03_loc_nn not null
);

--�ڽ� ���̺� ����
create table emp03(
    empno number(4) constraint emp03_empno_pk primary key,
    ename varchar2(9)constraint emp03_ename_nn not null,
    job varchar2(9),
    deptno number(2) constraint emp03_deptno_fk references dept03(deptno)  --�θ� ���̺��� deptno �����͸� �����ϰڴ�.
);

--������������ ����� ������ ����(���� ���̺��� �����͸� ����Ѵ�.)
--�θ� ���̺��� ������ ���� -> �������� ���Ե� �θ� ���̺� ����
insert into dept03
select * from dept;   --dept ���̺�� dept03 ���̺��� �÷������� ����.

--�ڽ� ���̺��� ������ ����
--insert into emp03
--select * from emp;    --emp ���̺��� 8���� �÷��� ���� , emp03 ���̺��� 4���� �÷��� ���� -> �̽� ��Ī���� ������ ���� ������ �ʿ��� �����͸� �����;���
insert into emp03
select empno,ename,job,deptno from emp;

select * from dept03;
select * from emp03;

insert into emp03
values (1111,'aaa','MANAGER',9999,sysdate,1000,null,50);  --50�� �μ��� �������� �ʱ⶧���� ���� �߻���(SQL ����: ORA-00913: ���� ���� �ʹ� �����ϴ�)

insert into emp03
values (1111,'aaa','MANAGER',50);  --������ �� �ִ� �����Ͱ� �������� ���� (ORA-02291: ���Ἲ ��������(SCOTT.EMP03_DEPTNO_FK)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�)
 
create table emp04(
    empno number(4) constraint emp04_empno_pk primary key,
    ename varchar2(10) constraint emp04_ename_nn not null,
    sal number(7) constraint emp04_sal_ck check(sal between 500 and 5000),  --check ���� ����
    gender varchar2(2) constraint emp04_gender_ck check(gender in('M','F'))
);

select * from emp04;

insert into emp04
values (1111,'hong',1000,'F');

insert into emp04
values (2222,'hong',200,'F');  --ORA-02290: üũ ��������(SCOTT.EMP04_SAL_CK)�� ����Ǿ����ϴ�

insert into emp04
values (3333,'hong',1000,'A');  --ORA-02290: üũ ��������(SCOTT.EMP04_GENDER_CK)�� ����Ǿ����ϴ�

create table dept05(
    deptno number(2),
    dname varchar(10),
    loc varchar(15) default 'SEOUL'  --�⺻���� seoul�� �ǵ��� ����(���� ���� �������� ������ �⺻������ ��ȸ��)
);

insert into dept05(deptno,dname)
values (10,'SALES');   --loc�� �⺻���� SEOUL �� ��ȸ��

insert into dept05(deptno,dname,loc)
values (10,'SALES','BUSAN');   --������ �ϰԵǸ� �⺻���� �ƴ� ������ ������ ��ȸ��

select * from dept05;


--�������� ���� ���
    --�÷� ������ ���� : �÷� �ڿ� �ٷ� ���������� �Ŵ� ��
    --���̺� ������ ���� : ���̺� �ȿ��� ���������� �Ŵ� ��  ** not null�� ������ �� ����. -> �÷� ���������� ����

create table emp06(
    empno number(4),
    ename varchar2(20) constraint emp06_ename_nn not null,
    job varchar2(20),
    deptno number(20),
    
    --���̺� ������ ������ ���� ���� ���� ����
    constraint emp06_empno_pk primary key(empno),
    constraint emp06_job_uk unique(job),
    constraint emp06_deptno_fk foreign key(deptno) references dept(deptno)   --���̺� ���� ��Ŀ����� foreign key�� ���ش�.
);                                --���� ���̺� �÷�         --�θ� ���̺� �÷�

insert into emp06
values (3333,'hong','PRESIDENT',80);


--����Ű : �⺻Ű�� �ΰ��� �÷��� ����ϴ� ���
    --���̺� ���� ������θ� ���� ����
    --1. ���̺� �ȿ��� �����ϴ� ���
    --2. Alter ��ɾ ����ϴ� ���

--���̺� �ȿ��� �����ϴ� ���
create table member(
    name varchar2(10),
    address varchar2(30),
    hphone varchar2(10),
    
    constraint member_name_address_pk primary key(name,address)
);

--Alter ��ɾ ����ϴ� ���
create table emp07(
    empno number(4),
    ename varchar2(20),
    job varchar2(20),
    deptno number(20)
);

--add : �������� �߰�
alter table emp07
add constraint emp07_empno_pk primary key(empno);

alter table emp07
add constraint emp07_deptno_fk foreign key(deptno) references dept(deptno);

--modify : not null�� ����Ͽ� ������ �������� ����Ѵ�.(null ->  not null)
alter table emp07
modify job constraint emp07_job_nn not null;

alter table emp07
modify ename constraint emp07_ename_nn not null;

--drop : �������� ����
    --�������Ǹ�(constraint) �Ǵ� ��������(primary key)�� ����Ͽ� ����
alter table emp07
drop constraint emp07_empno_pk;   --�������Ǹ��� ����Ͽ� �����ϴ� ���


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
where deptno = 10;   --ORA-02292: ���Ἲ ��������(SCOTT.EMP08_DEPTNO_FK)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ� 
--�ڽ��� �����ϰ� ���� �� �θ����͸� ���� �� ����.

alter table dept08
disable primary key cascade;  --�θ�� �ڽİ��� foriegn key�� �ִٸ� ��Ȱ��ȭ -> �θ� ���̺� ������ ���� ����

alter table dept08
drop primary key;   --ORA-02273: ����/�⺻ Ű�� �ܺ� Ű�� ���� �����Ǿ����ϴ�
--���������� ��Ȱ��ȭ �� ���� ���̱� ������ ���������� ������ ���� ����.

alter table dept08
drop primary key cascade;  --cascade�� �־��ָ� ���������� ������ �����ȴ�.

--���� 1
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


--���� 2
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
--��ü : table, index, view
 --��ü�� create�� �̿��Ͽ� �����ؼ� ����ؾ��Ѵ�.
 
-- view : ���ϴ� �����͸� ��� ���̺��� ���� ���� ����
 --1.����
 --2.����(����Ұ�)
 
 --create or replace view �����̺��(alias-����)
 --as
 --��������(select * from ���̺��) -> �ٸ� ��ɾ�� ��ø�ؼ� ����ϴ� �� 
   --�ܼ���(���̺� 1��) or ���պ�
 --with check option (�ɼ�)
 --with read only (�ɼ�)

create table dept_copy
as
select * from dept;

create table emp_copy  --����Ǵ� ���̺��� ���������� �Ѿ���� �ʴ´�.
as
select * from emp;

--�������� �߰�
alter table emp_copy
add constraint emp_copy_deptno_fk foreign key(deptno) references dept(deptno);

select * from emp_copy;   --14�� ��

--�ܼ��� : �ϳ��� ���̺��� �̿��ؼ� �����̺� ����
create or replace view emp_view30
as
select empno,ename,sal,deptno from emp_copy  
where deptno = 30;   --������ ��� ���� �Ұ���

--�ý��� �������� ���� ����
--grant create view
--to scott;

--30�� �μ��� ����鸸 �� �� �ִ� ���̺��� ������
select *
from emp_view30;

insert into emp_view30
values (1111,'hong',1000,30);

select *
from emp_copy;
--�����̺��� ���� ���̺��̰� ���� ������ ó���� ���� ���̺��� �Ͼ��.

insert into emp_view30 (empno,ename,sal,deptno)
values (2222,'hong',2000,50);    --������ �μ���ȣ�� ���� ������ �ܺ�Ű �������ǿ� ���������, ����� ���̺��� ���������� ������ �ʱ⶧���� ������� ����.
--���� �����ʹ� copy���̺� ���ֱ� ������ foreign key �������ǿ� �����

create or replace view emp_view(�����ȣ,�����,�޿�,�μ���ȣ)
as
select empno,ename,sal,deptno from emp_copy;

select * from emp_view
where �μ���ȣ = 20;
--where deptno = 20;  --error ��Ī�� �����ϰ� �Ǹ� ���� �÷����� ����� �� ����.

--���պ� : �� �� �̻��� ���̺��� ����Ͽ� �����̺� ����
create or replace view emp_dept_view
as
select empno,ename,sal,e.deptno,dname,loc
from emp e inner join dept d 
on e.deptno = d.deptno 
order by empno desc;

select *
from emp_dept_view;

--�μ��� �ּұ޿��� �ִ�޿�
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

--�����̺� ����
drop view sal_view;

--��� ��ü�� �̸��� �ߺ��� �� ����. = �����ؾ� �Ѵ�.
create or replace view sal_view   --���� �����̺��� ������ �����ϰ� ���� �� or replace�� �Է��ؼ� �����ϰ� �Ǹ� ������ ����� �ȴ�.
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
where deptno = 30 with check option;   --�������� �÷��� ���� �� �������� ���ϰ� �Ѵ�.
 
--�����͸� �����ϴ� �۾��� �Ұ���
update view_chk30
set deptno = 10;  
--ORA-01402: ���� WITH CHECK OPTION�� ���ǿ� ���� �˴ϴ�

--with read only
create or replace view view_read30
as
select empno,ename,sal,comm,deptno 
from emp_copy
where deptno = 30 with read only;    --��� �÷��� ���� C(����) U(����) D(����)�� �Ұ��� , ������ ��ȸ�� ������
 
update view_read30
set deptno = 10;
--SQL ����: ORA-42399: �б� ���� �信���� DML �۾��� ������ �� �����ϴ� (insert,update,delete)

--���� Ȱ��
--TOP - N ��ȸ�ϱ�
--ROWNUM(�ǻ� �÷�)

select * from emp;

--�Ի����� ���� ���� 5���� ��� ��ȸ
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
order by hiredate asc;   --������ ���� �������� �����ϱ� ������ ���� �Ի��� ������ ��ȸ���� ����

--�����̺��� �̿��Ͽ� hiredate �� �Ի����� ���� ������ ���ĵǾ��ִ� ������ ���̺��� �����Ѵ�.
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
where rownum between 2 and 5;   --rownum�� �������� ���� ���� �ݵ�� 1�� �����ϴ� ���ǽ��� ������ �Ѵ�.(���������� �Ұ���) 

create or replace view view_hiredate_rm
as
select rownum rm,empno,ename,hiredate   --rownum�� ��Ī�� �ο��Ͽ� ������ �÷����� �����
from view_hiredate;

select rm,empno,ename,hiredate
from view_hiredate_rm;

select rm,empno,ename,hiredate
from view_hiredate_rm
where rm between 2 and 5;

--��ø
--select (select) -> �Ϲ�����
--from (select) -> �ζ��κ�
--where (select) -> ��������

--�ζ��κ�
select rownum rm,b.*
from (
    select rownum rm,a.*
    from (
        select empno,ename,hiredate
        from emp
        order by hiredate asc
        ) a    -- ���� ���̺� ��Ī
    ) b  --�ٱ��� ���̺� ��Ī
where rm between 2 and 5;

--�Ի����� ���� ���� 5�� ��ȸ
select rownum,a.*
from(
    select empno,ename,hiredate
    from emp
    order by hiredate asc
    ) a
where rownum <= 5;

--������
--�ڵ����� ��ȣ�� ������Ű�� ��� ����
--create,drop
--nextval,currval ��ɾ�

--create sequence ��������
--�ɼ�
--start with : ���۰� => 1
--increment by : ����ġ => 1
--maxvalue : �ִ� => 10�� 1027��
--minvalue : �ּڰ� => 10�� -1027��

create sequence dept_deptno_seq
increment by 10
start with 10;   --10���� �����ؼ� 10�� ����, �ɼ��� �������� �͵��� �⺻������ ������

select dept_deptno_seq.nextval  --������ ������ ���� ������(������ ����)
from dual;  --back �Ұ�

select dept_deptno_seq.currval  --������ ���� ���� Ȯ��
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





























