-- practice02

-- 문제 1
-- 최고임금(salary)과  최저임금을 “최고임금, “최저임금” 프로젝션 타이틀로 함께 출력해 보세요.
-- 두 임금의 차이는 얼마인가요? 함께 “최고임금 – 최저임금”이란 타이틀로 출력해 보세요.
select max(salary) as "최고임금", min(salary) as "최저임금" from salaries;
select max(salary) - min(salary) as "최고임금 - 최저임금" from salaries;

-- 문제 2
-- 마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요.
-- 예) 2014년 07월 10일
-- 고용일 출력 (hire_date)
select max(date_format(e.hire_date, '%Y년%m월%d일')) as "최근 신입사원 입사일" 
	from employees e, titles t
    where e.emp_no = t.emp_no
    and t.to_date = '9999-01-01';

-- 문제 3
-- 가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
-- 예) 2014년 07월 10일
-- 고용일의 최저값 출력
select e.emp_no,
	min(date_format(hire_date, '%Y년%m월%d일')) as "가장 오래 근속한 직원 입사일" 
    from employees e, dept_emp d
    where e.emp_no = d.emp_no
    and d.to_date = '9999-01-01';

-- 문제 4
-- 현재 이 회사의 평균 연봉은 얼마입니까?
select avg(salary) as "회사 평균 연봉" from salaries;

-- 문제 5
-- 현재 이 회사의 최고/최저 연봉은 얼마입니까?
select 
	max(salary) as "회사 최고 연봉"
	from salaries
    where to_date = '9999-01-01';
    
select 
	min(salary) as "회사 최저 연봉" 
    from salaries
    where to_date = '9999-01-01';

-- 문제 6
-- 최고 어린 사원의 나이와 최 연장자의 나이는?
select (year(now()) - year(min(birth_date))) as "최 연장자 사원" from employees;
select (year(now()) - year(max(birth_date))) as "최고 어린 사원" from employees;



