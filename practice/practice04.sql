-- 서브쿼리(SUBQUERY) SQL 문제입니다.

-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select
	count(s.salary) as '평균 월급보다 적은 사람'  
	from employees e, salaries s
	where e.emp_no = s.emp_no
	and s.to_date = '9999-01-01'
	and s.salary > (
		select avg(salary)
			from salaries
			where to_date='9999-01-01'
);

-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요.
-- 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다.
select 
	a.emp_no as '사번',
    concat(a.first_name, ' ', a.last_name) as '이름',
	c.dept_no as '부서',
    b.salary as '연봉'
    from employees a,
         salaries b,
         dept_emp c,
         (select c.dept_no, max(b.salary) as max_salary -- 부서별 최고 연봉 쿼리
			from employees a, salaries b, dept_emp c
			where a.emp_no = b.emp_no
               and a.emp_no = c.emp_no
               and b.to_date = '9999-01-01'
               and c.to_date = '9999-01-01'
			group by c.dept_no) d
				   where a.emp_no = b.emp_no
					 and a.emp_no = c.emp_no
					 and c.dept_no = d.dept_no
					 and b.salary = d.max_salary
					 and b.to_date = '9999-01-01'
					 and c.to_date = '9999-01-01'
                     order by 연봉 desc;

-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요
select a.emp_no as 사번, 
	concat(a.first_name , ' ', a.last_name) as 이름, 
	b.salary as 연봉
	from 
    employees a, 
    salaries b, 
    dept_emp c,
        (select c.dept_no, avg(b.salary) as avg_salary 
			from employees a, salaries b, dept_emp c
			where a.emp_no = b.emp_no
               and a.emp_no = c.emp_no
               and b.to_date = '9999-01-01'
               and c.to_date = '9999-01-01'
			group by c.dept_no) d
		where a.emp_no = b.emp_no
		and a.emp_no = c.emp_no
        and c.dept_no = d.dept_no
		and b.to_date = '9999-01-01'
        and c.to_date = '9999-01-01'
		and	b.salary > d.avg_salary; -- 일반 사원 연봉 > 부서 평균 연봉

-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
select
	a.emp_no as '사번',
	concat(a.first_name , ' ', a.last_name) as '이름',
    concat(b.first_name , ' ', b.last_name) as '매니저 이름',
    d.dept_name as '부서 이름'
		from employees a, employees b, dept_manager c, departments d, dept_emp e
			where a.emp_no = e.emp_no
			and e.dept_no = c.dept_no
            and c.emp_no = b.emp_no
			and d.dept_no = e.dept_no
			and c.to_date = '9999-01-01'
			and e.to_date = '9999-01-01' order by 사번;
            
-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select 
	employees.emp_no as '사번',
    concat(employees.first_name, ' ', employees.last_name) as '이름',
    titles.title as '직책',
    salaries.salary as '연봉',
    dept_emp.dept_no as '부서'
		from 
        employees, 
        titles, 
        salaries, 
        dept_emp 
        where 
		employees.emp_no = salaries.emp_no
		and employees.emp_no = titles.emp_no
		and dept_emp.emp_no = employees.emp_no
		and employees.emp_no = titles.emp_no
		and titles.to_date = '9999-01-01'
		and salaries.to_date = '9999-01-01'
        and dept_emp.to_date = '9999-01-01'
        and dept_emp.dept_no = (select dept_emp.dept_no 
									from employees, salaries, dept_emp
									where employees.emp_no = salaries.emp_no
										and employees.emp_no = dept_emp.emp_no
										and salaries.to_date = '9999-01-01'
										and dept_emp.to_date = '9999-01-01'
									group by dept_emp.dept_no
									order by avg(salaries.salary) desc
									limit 0, 1)
			order by 연봉 desc;

-- 문제6.
-- 평균 연봉이 가장 높은 부서는?
select dept_emp.dept_no, avg(salaries.salary) as avg_salary 
			from employees, salaries, dept_emp
			where employees.emp_no = salaries.emp_no
               and employees.emp_no = dept_emp.emp_no
               and salaries.to_date = '9999-01-01'
               and dept_emp.to_date = '9999-01-01'
			group by dept_emp.dept_no
            order by avg_salary desc
            limit 0, 1;

-- 문제7.
-- 평균 연봉이 가장 높은 직책?
select titles.title, avg(salaries.salary) as avg_salary 
			from titles, salaries
			where titles.emp_no = salaries.emp_no
               and titles.to_date = '9999-01-01'
               and salaries.to_date = '9999-01-01'
			group by titles.title
            order by avg_salary desc
            limit 0, 1;

-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
select 
	departments.dept_name as '부서이름',
	concat(employees1.first_name, ' ', employees1.last_name) as '사원이름',
    salaries1.salary as '연봉',
    concat(employees2.first_name, ' ', employees2.last_name) as '매니저이름',
    salaries2.salary as '매니저 연봉'
		from departments, 
        dept_emp, 
        employees employees1,
        employees employees2,
        dept_manager, 
        salaries salaries1,
        salaries salaries2
			where salaries1.emp_no = employees1.emp_no
            and employees1.emp_no = dept_emp.emp_no
            and dept_emp.dept_no = departments.dept_no
            and departments.dept_no = dept_manager.dept_no
            and dept_manager.emp_no = employees2.emp_no
            and employees2.emp_no = salaries2.emp_no
            and salaries1.salary > salaries2.salary
            and salaries1.to_date = '9999-01-01'
            and salaries2.to_date = '9999-01-01'
            and dept_emp.to_date = '9999-01-01'
            and dept_manager.to_date = '9999-01-01';