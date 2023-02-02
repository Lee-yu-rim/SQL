select employee_id,first_name,last_name,department_name
from employees e inner join departments d
on e.department_id = d.department_id;

select count(*) from employees;

select * from employees
where department_id is null;

select employee_id, first_name, last_name,department_id,
    (
        select department_name
        from departments d
        where e.department_id = d.department_id
    )as dep_name
from employees e
where department_id = 100;

create or replace function get_dep_name(dept_id number)
    return varchar2
is
    sDepName varchar2(30);
begin
    select department_name
    into sDepName
    from departments
    where department_id = dept_id;
    
    return sDepName;
end;
/
variable var_depname varchar2(30);

exec :var_depname := get_dep_name(90);
print var_depname;

select employee_id, first_name,last_name,get_dep_name(department_id)
from employees e
where e.department_id = 100;

select sum(sal),max(sal)
from emp;

-------------------------------
--����Ǯ��

--employees, jobs
--������̵�, �̸�, ��, job title
-- join ���,���������� ���, get_job_title �Լ� ���� ����ϴ� ���


--join���
select employee_id,first_name,last_name,j.job_title
from employees e inner join jobs j
on e.job_id= j.job_id;

--���������� ���
select employee_id, first_name, last_name,
    (
        select job_title
        from jobs j
        where e.job_id= j.job_id
    )as job_id
from employees e;

-- ���ν������
create or replace function get_job_title(j_id varchar2)
    return varchar2
is
    sJobName varchar2(50);
begin
    select job_title
    into sJobName
    from jobs
    where job_id= j_id;
    
    return sJobName;
end;
/

select employee_id, first_name,last_name,get_job_title(job_id)
from employees e;

