select date_of_birth, to_char(date_of_birth,'YYYY/MM/DD') as 생년월일, round((sysdate-date_of_birth)/365)||'살' as 나이 from customers;

select date_of_birth, to_char(date_of_birth,'YYYY/MM/DD') as 생년월일, round((sysdate-date_of_birth)/365)||'살' as 나이 from customers;
select to_char(date_of_birth,'YYYY/MM/DD') as 생년월일, round((sysdate-date_of_birth)/365)||'살' as 나이,
    case
        when round((sysdate-date_of_birth)/365) between 0 and 9 then '영유아'
        when round((sysdate-date_of_birth)/365) between 10 and 19 then '10대'
        when round((sysdate-date_of_birth)/365) between 20 and 29 then '20대'
        when round((sysdate-date_of_birth)/365) between 30 and 39 then '30대'
        when round((sysdate-date_of_birth)/365) between 40 and 49 then '40대'
        when round((sysdate-date_of_birth)/365) between 50 and 59 then '50대'
        when round((sysdate-date_of_birth)/365) between 60 and 69 then '60대'
        when round((sysdate-date_of_birth)/365) between 70 and 79 then '70대'
        else '기타'
    end as 연령대
from customers;