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
drop table if exists voteTable; # 있으면 지워라
create table voteTable( # voteTable 생성
name varchar(5), # varchar(5) name
age int);  # int age

# 트와이스 데이터 입력
insert into voteTable value ("나연", (floor(rand()*9) + 1) * 10);
insert into voteTable value ("정연", (floor(rand()*9) + 1) * 10);
insert into voteTable value ("모모", (floor(rand()*9) + 1) * 10);
insert into voteTable value ("사나", (floor(rand()*9) + 1) * 10);
insert into voteTable value ("지효", (floor(rand()*9) + 1) * 10);
insert into voteTable value ("미나", (floor(rand()*9) + 1) * 10);
insert into voteTable value ("다현", (floor(rand()*9) + 1) * 10);
insert into voteTable value ("채영", (floor(rand()*9) + 1) * 10);
insert into voteTable value ("쯔위", (floor(rand()*9) + 1) * 10);

select count(*) from voteTable; # 개수 세기
select * from voteTable; # voteTable 전체 데이터 출력

# 9-1 실습
select name as 이름, count(name) as 득표수, (count(name) / (select count(*) from voteTable)) * 100 as 득표율
from voteTable group by name; # name을 이름으로, count(name)을 득표수로, (count(name)/(select count(*) from voteTable))*100을 득표율로 출력

# 9-2 실습
select age as 연령대, count(name) as 득표수, count(name)/(select count(*) from voteTable where name='나연')*100 as 득표율
from voteTable where name='나연' group by name, age order by count(name) desc;
# age를 연령대로, count(name)을 득표수로, count(name)/(select count(*) from voteTable where name='나연')*100을 득표율로 
# 득표수를 기준으로 역순 출력

# 9-3 실습
select age as 연령대, count(name) as 득표수, count(name)/(select count(*) from voteTable where name='정연')*100 as 득표율
from voteTable where name='정연' group by name, age order by count(name) desc;
# age를 연령대로, count(name)을 득표수로, count(name)/(select count(*) from voteTable where name='정연')*100을 득표율로,
# 득표수를 기준으로 역순 출력

-- procedure, function
drop procedure if exists get_sum; # 있으면 지워라
delimiter $$
create procedure get_sum( # get_sum 프로시저 생성
	in _id integer, # integer 변수 _id, 
    # in : 프로시저에 값을 전달하며, 프로시저 내부에서 값을 수정할 수는 있지만 프로시저가 반환되고나서 호출자가 수정할 수는 없다.
    out _name varchar(20), # varchar(20) _name 변수 생성
    # out : 프로시저의 값을 호출자에게 다시 전달한다.
    out _sum integer # integer _sum 변수 생성
)
begin # 시작
	declare _kor integer; # integer 변수 _kor 생성
    declare _eng integer; # integer 변수 _eng 생성
    declare _mat integer; # integer 변수 _mat 생성
    set _kor = 0; #로직상 의미는 없지만 declare / set으로 정의하고 값을 넣는다.
    
    select name, kor, eng, mat 
		into _name, _kor, _eng, _mat from examtable where id=_id;
	# 변수 _name, _kor, _eng, _mat에 데이터 입력
    
    set _sum = _kor + _eng + _mat; # _sum = _kor+_eng_mat
end $$ # delimiter 종료
delimiter ;

call get_sum(209905, @name, @sum); #프로시저 호출 가져오는 값은 @변수명 사용
select @name, @sum; # 값 확인하는 방법

drop function if exists f_get_sum; # 있으면 지워라
delimiter $$
create function f_get_sum(_id integer) returns integer # 함수 f_get_sum 생성
begin # 시작
	declare _sum integer; # integer 변수 _sum 생성
    select kor+eng+mat into _sum from examtable where id=_id; # _sum에 kor+eng+mat 값 입력
return _sum; # _sum 리턴
end $$ # delimiter 종료
delimiter ;

select *, f_get_sum(id) from examtable; # examtable 전체 데이터, f_get_sum(id) 값 출력


drop procedure if exists insert_examtable; # 있으면 지워라
delimiter $$
create procedure insert_examtable(_last integer) # insert_examtable 프로시저 생성
begin # 시작
declare _name varchar(20); # varchar(20) 변수 _name 생성
declare _id integer; # integer 변수 _id 생성
declare _cnt integer; # integer 변수 _cnt 생성
set _cnt=0; # _cnt = 0으로 초기화
delete from examtable where id > 0; # id가 1 이상인 데이터 전부 삭제
	_loop : loop # 반복문
		set _cnt = _cnt + 1; # _cnt++
        set _name = concat("홍길", cast(_cnt as char(4)));
        # concat : 2개 이상의 문자열을 합치는 함수
        # cast : 데이터 타입을 바꿔주는 함수 (= 형변환 함수)
        set _id = 209900 + _cnt;
        # id = 209900 + _cnt
        
        insert into examtable value (_name, _id, rand()*100, rand()*100, rand()*100);
        # examtable에 데이터 입력
        
        if _cnt = _last then # _cnt가 입력받은 값과 같으면
			leave _loop; # break
		end if; # if문 종료
	end loop _loop; # 반복문 종료
end $$ # delimiter 종료
delimiter ;

call insert_examtable(1000); # insert_examtable에 1000 대입
select * from examtable; # examtable 전체 데이터 출력

select *, kor+eng+mat as sum, (kor+eng+mat)/3 as avg from examtable limit 30,59; # examtable의 31번째 값부터 
desc voteTable; 

