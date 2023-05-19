-- 슬라이드 4
show databases;
use kopo10;
show tables;
drop table if exists examtable;
create table examtable(
	name varchar(20),
    id int not null primary key,
    kor int, eng int, mat int);
desc examtable;

-- 슬라이드 5
delete from examtable where id > 0;
insert into examtable value ("나연",209901, rand()*100, rand()*100, rand()*100);
insert into examtable value ("정연",209902, rand()*100, rand()*100, rand()*100);
insert into examtable value ("모모",209903, rand()*100, rand()*100, rand()*100);
insert into examtable value ("사나",209904, rand()*100, rand()*100, rand()*100);
insert into examtable value ("지효",209905, rand()*100, rand()*100, rand()*100);
insert into examtable value ("미나",209906, rand()*100, rand()*100, rand()*100);
insert into examtable value ("다현",209907, rand()*100, rand()*100, rand()*100);
insert into examtable value ("채영",209908, rand()*100, rand()*100, rand()*100);
insert into examtable value ("쯔위",209909, rand()*100, rand()*100, rand()*100);
insert into examtable value ("송가인",209910, rand()*100, rand()*100, rand()*100);
insert into examtable value ("나연",209911, rand()*100, rand()*100, rand()*100);
insert into examtable value ("정연",209912, rand()*100, rand()*100, rand()*100);
insert into examtable value ("모모",209913, rand()*100, rand()*100, rand()*100);
insert into examtable value ("사나",209914, rand()*100, rand()*100, rand()*100);
insert into examtable value ("지효",209915, rand()*100, rand()*100, rand()*100);
insert into examtable value ("미나",209916, rand()*100, rand()*100, rand()*100);
insert into examtable value ("다현",209917, rand()*100, rand()*100, rand()*100);
insert into examtable value ("채영",209918, rand()*100, rand()*100, rand()*100);
insert into examtable value ("쯔위",209919, rand()*100, rand()*100, rand()*100);
insert into examtable value ("송가인",209920, rand()*100, rand()*100, rand()*100);

-- 슬라이드 6-3,4번
select * from examtable; # examtable 전체 데이터 출력
select * from examtable order by kor; # 국어 점수 기준 오름차순 정렬
select * from examtable order by eng; # 영어 점수 기준 오름차순 정렬
select * from examtable order by kor,eng;
# 국어점수 순으로 먼저 오름차순 정렬을 하고, 국어점수가 동점이면 영어 점수로 오름차순 정렬한다.
select * from examtable order by kor asc; # asc : 오름차순 정렬
select * from examtable order by kor desc; # desc : 내림차순 정렬

-- 슬라이드 6-5번
select * from examtable order by name desc; # 이름 순으로 내림차순 정렬
select * from examtable order by mat desc; # 수학점수 순으로 내림차순 정렬
select (kor+eng+mat), (kor+eng+mat)/3 from examtable order by (kor+eng+mat) desc;
# 가상의 총점 필드, 평균 필드를 2개 만들고 총점 순으로 내림차순 정렬한다.

-- 슬라이드 7
select *, kor+eng+mat, (kor+eng+mat)/3 from examtable;
# 전체 데이터 출력 후 뒤에 총점, 평균이라는 가상의 필드 생성 후 출력
select *, kor+eng+mat, (kor+eng+mat)/3 from examtable order by kor+eng+mat desc;
# 전체 데이터 출력 후 뒤에 총점, 평균이라는 가상의 필드 생성 후 총점의 내림차순으로 출력
select *, kor+eng+mat as total, (kor+eng+mat)/3 as average from examtable order by total desc;
# 이전까지 생성한 총점, 평균의 가상 필드 이름은 변수명 그대로 출력이 되었다.
# 이번에는 as를 사용해서 해당 변수명의 필드 명칭을 지정하는 작업을 해보았다.
select name as 이름, id as 학번, kor as 국어, eng as 영어, mat as 수학, kor+eng+mat as 합계,
	(kor+eng+mat)/3 as 평균 from examtable order by 합계 desc;
# 지금까지 데이터를 출력할 때는 처음 테이블을 생성할 때 지정한 필드명이 그대로 출력되었다.
# 이번에도 as를 사용해서 해당 필드명을 한글로 바꾸는 작업을 해보았다.

-- 슬라이드 8
select * from examtable group by name; 
# error code : 1055 에러 발생 -> 구글링해보니 group by절을 사용하려면
# group by 뒤에 나오는 조건이 group by 앞에 나오는 문장에 1대1 매칭이 되어야한다고 한다.
select name, count(name) from examtable group by name;
# 기존 필드 name과 count(name)이라는 가상 필드를 생성하고 그에 해당하는 값을 출력한다.
select * from examtable group by kor;
# 처음 쿼리와 동일한 에러가 발생. 1대1 매칭이 되지 않음.
select kor, count(kor) from examtable group by kor; # 1대1 매칭 충족함
select kor, count(kor) from examtable group by eng;
# 처음 쿼리와 동일한 에러가 발생. 1대1 매칭이 되지 않음.
select kor, count(kor), eng, count(eng) from examtable group by kor,eng; # 1대1 매칭 충족함
select eng, count(eng) from examtable group by eng;  # 1대1 매칭 충족함

insert into examtable value ("펭수", 209921, 100, 90, rand()*100); # examtable에 21학번 펭수 데이터 입력
insert into examtable value ("펭수", 209922, 100, 90, rand()*100); # examtable에 22학번 펭수 데이터 입력
select kor, count(kor), eng, count(eng) from examtable group by kor, eng; # 1대1 매칭 충족함
select name, count(name), kor, count(kor), eng, count(eng) from examtable group by name, kor, eng; # 1대1 매칭 충족함
select *, name, count(name), kor, count(kor), eng, count(eng) from examtable group by name, kor, eng;
# 처음 쿼리와 동일한 에러가 발생. 1대1 매칭이 되지 않음.
select eng, count(eng) from examtable group by eng having count(eng)>1;
# group by절에서는 where 대신 having을 사용해야 한다.

-- 슬라이드 9 실습
create table voteTable(
name varchar(5),
age int);
drop table if exists voteTable;

insert into voteTable value ("나연", (floor(rand()*9) + 1) * 10);
insert into voteTable value ("정연", (floor(rand()*9) + 1) * 10);
insert into voteTable value ("모모", (floor(rand()*9) + 1) * 10);
insert into voteTable value ("사나", (floor(rand()*9) + 1) * 10);
insert into voteTable value ("지효", (floor(rand()*9) + 1) * 10);
insert into voteTable value ("미나", (floor(rand()*9) + 1) * 10);
insert into voteTable value ("다현", (floor(rand()*9) + 1) * 10);
insert into voteTable value ("채영", (floor(rand()*9) + 1) * 10);
insert into voteTable value ("쯔위", (floor(rand()*9) + 1) * 10);
select count(*) from voteTable;
select * from voteTable;

select name as 이름, count(name) as 득표수, (count(name) / (select count(*) from voteTable)) * 100 as 득표율 
from voteTable group by name; # 9-1 실습

select age as 연령대, count(name) as 득표수, count(name)/(select count(*) from voteTable where name='나연')*100 as 득표율
from voteTable where name='나연' group by name, age;

select age as 연령대, count(age) as 득표수, count(age)/(select count(*) from voteTable where name="나연")*100 as 득표율 
from voteTable where name='나연' group by age; # 9-2 실습
select age as 연령대, count(name) as 득표수, (count(name) / (select count(*) from voteTable)) * 100 as 득표율 
from voteTable group by name, age having name='정연';

-- procedure, function
drop procedure if exists get_sum;
delimiter $$
create procedure get_sum(
	in _id integer,
    out _name varchar(20),
    out _sum integer
)
begin
	declare _kor integer;
    declare _eng integer;
    declare _mat integer;
    set _kor = 0; #로직상 의미는 없지만 declare / set으로 정의하고 값을 넣는다.
    
    select name, kor, eng, mat
		into _name, _kor, _eng, _mat from examtable where id=_id;
    
    set _sum = _kor + _eng + _mat;
end $$
delimiter ;

call get_sum(209905, @name, @sum); #프로시저 호출 가져오는 값은 @변수명 사용
select @name, @sum; # 값 확인하는 방법

drop function if exists f_get_sum;
delimiter $$
create function f_get_sum(_id integer) returns integer
begin
	declare _sum integer;
    select kor+eng+mat into _sum from examtable where id=_id;
return _sum;
end $$

delimiter ;

select *, f_get_sum(id) from examtable;

drop procedure if exists insert_examtable;
delimiter $$
create procedure insert_examtable(_last integer)
begin
declare _name varchar(20);
declare _id integer;
declare _cnt integer;
set _cnt=0;
delete from examtable where id > 0;
	_loop : loop
		set _cnt = _cnt + 1;
        set _name = concat("홍길", cast(_cnt as char(4)));
        set _id = 209900 + _cnt;
        
        insert into examtable value (_name, _id, rand()*100, rand()*100, rand()*100);
        
        if _cnt = _last then
			leave _loop;
		end if;
	end loop _loop;
end $$
delimiter ;

call insert_examtable(1000);
select * from examtable;

select *, kor+eng+mat as sum, (kor+eng+mat)/3 as avg from examtable limit 30,59;
desc voteTable;

