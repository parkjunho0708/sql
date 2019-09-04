-- 테이블간 조인(JOIN) SQL 문제입니다.

-- 문제 1
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
select e.emp_no as '사번', 
	concat(e.first_name, ' ', e.last_name) as '이름', 
	s.salary as '연봉'
	from salaries s, employees e
	where e.emp_no = s.emp_no 
    and s.to_date = '9999-01-01' 
    order by s.salary desc;
    
-- 문제 2
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
select e.emp_no as 사번, 
	concat(e.first_name, ' ', e.last_name) as 이름, 
    t.title as 직책 
	from employees e, titles t
    where e.emp_no = t.emp_no
    and t.to_date = '9999-01-01'
    order by 이름 asc;
    
-- 문제 3
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요.
select e.emp_no as '사번', 
	concat(e.first_name, ' ', e.last_name) as '이름', 
	p.dept_name as '현재 부서 이름'
	from employees e, dept_emp d, departments p
    where e.emp_no = d.emp_no
    and d.dept_no = p.dept_no
    and d.to_date = '9999-01-01'
    order by 이름 asc;
    
-- 문제 4
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
select e.emp_no as 사번, 
	concat(e.first_name, ' ', e.last_name) as 이름, 
    s.salary as 연봉, 
    t.title as 직책, 
    p.dept_name as 부서
	from employees e, titles t, salaries s, dept_emp d, departments p
    where e.emp_no = t.emp_no
    and e.emp_no = s.emp_no
    and e.emp_no = d.emp_no
    and d.dept_no = p.dept_no
    and d.to_date = '9999-01-01'
    and	t.to_date = '9999-01-01'
    and s.to_date = '9999-01-01'
    order by 이름 asc;

-- 문제 5
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요.
-- (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.) 이름은 first_name과 last_name을 합쳐 출력 합니다.
select e.emp_no as 사번,
	concat(e.first_name, ' ', e.last_name) as 이름
	from titles t, employees e
    where t.emp_no = e.emp_no
    and t.title = 'Technique Leader'
    and t.to_date != '9999-01-01';

-- 문제 6
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
select 
	distinct concat(e.first_name, ' ', e.last_name) as 이름,
    m.dept_name as 부서명,
    t.title as 직책
	from employees e, titles t, dept_emp p, departments m
    where e.emp_no = t.emp_no
    and e.emp_no = p.emp_no
    and p.dept_no = m.dept_no
    and p.to_date = '9999-01-01'
    and t.to_date = '9999-01-01'
    and e.last_name like 'S%';

-- 문제 7
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.
select t.title as 사원,
	concat(e.first_name, ' ', e.last_name) as 이름,
	s.salary as 현재급여
	from employees e, titles t, salaries s
    where t.emp_no = s.emp_no
    and e.emp_no = s.emp_no
    and t.title = 'Engineer'
    and	t.to_date = '9999-01-01'
	and	s.to_date = '9999-01-01'
    and s.salary >= 40000
    order by 현재급여 desc;

-- 문제 8
-- 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오
select t.title as 직책, s.salary as 급여
	from titles t, salaries s
    where t.emp_no = s.emp_no
    and s.salary >= 50000
    group by t.title
    order by 급여 desc;

-- 문제 9
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
select d.dept_name as 부서, avg(s.salary) as 평균연봉
	from salaries s, titles t, departments d, dept_emp m
	where s.emp_no = t.emp_no
	and d.dept_no = m.dept_no
	and m.emp_no = s.emp_no
	and m.to_date = '9999-01-01'
	and s.to_date = '9999-01-01'
	and t.to_date = '9999-01-01'
	group by d.dept_name
	order by 평균연봉 desc;

-- 문제 10
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
select t.title as 직책, avg(s.salary) as 평균연봉
	from salaries s, titles t
	where s.emp_no = t.emp_no
	and s.to_date = '9999-01-01'
	and t.to_date = '9999-01-01'
	group by t.title
	order by 평균연봉 desc;
