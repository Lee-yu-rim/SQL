--DCL(Data Control Language - ������ �����)
--grant(���Ѻο�), revoke(��ȯȸ��)
--grant �ý��۱��� to ������
--revoke �ý��۱��� from ������

--����� ���� -> ��� ��ɾ�� ������ ������ system ���������� ��� �����ϴ�.
--create,drop,alter
--���� ���� : create user ������ identified by �н�����
--���� ���� : alter user ������ identified by �н�����
--���� ���� : drop user ������ cascade

--���� ����
create user user01 identified by 1234;  --���̵�� ��ҹ��� ����X, �н������ ����O

--���� �ο�
grant CREATE SESSION 
to user01; 

--���� ȸ��
revoke create table  
from user01;

--���� ���� �ο�
grant create table --���̺� ���� ����
to user01;

--���� ���� ����
alter user user01 identified by tiger; --�н����� ����

--���� ����
drop user user01 CASCADE;

--���̺� �����̽��� �����͸� ������ �� �ִ� ���� �ο�(�뷮 �Ҵ�)
alter user user01
quota 2m on USERS;

--�ý��� ����(create ...)

--��ü ����(select ...)
--grant ��ü���� ���� 
--on ��ü��
--to ������

--��ü ���� �ο�
grant select
on emp
to user01;  --emp���̺��� scott������ �ֱ⶧���� scott�������� ������

--��ü ��ȯ ȸ��
revoke select
on emp
from user01;


--roll�� �̿��� ���Ѻο�
--connect 
--resource
--dba

--grant dba,connect,resource  --������ ���� �ο�(�ý��۰����� ����)
--to nbac;

--����� ���� �� : ���ϴ� ��ü ������ ��� �� ����
--������ ���������� ����
--create role �Ѹ�
--grant ���� to �Ѹ�


--1. ������ ���ѿ��� �� ����  --> system ����
--create role mrole2;  

--2.�����(scott)�������� �����ؼ� ��ü ���� �ο�(����)
grant select  
on emp
to mrole;

--3. �� ������ ������ �������� �� -> system ����
--grant mrole2
--to user04;

--4. user04�������� emp ���̺��� ��ȸ��

--5. system �������� �ѱ��� ȸ�� 






