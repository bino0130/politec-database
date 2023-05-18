use kopo10;
-- Basic Training 1
create table grade_rank_Table(
	name varchar(20),
    id int not null primary key,
    kor int, eng int, mat int);
drop table if exists grade_rank_Table;
drop procedure if exists bt1;
delimiter $$
create procedure bt1(_last integer)
begin
declare _name varchar(20);
declare _id integer;
declare _cnt integer;
set _cnt=0;
delete from grade_rank_Table where id > 0;
	_loop : loop
		set _cnt = _cnt + 1;
        set _name = concat("홍길", cast(_cnt as char(5)));
        set _id = _cnt;
        
        insert into grade_rank_Table value (_name, _id, rand()*100 + 1, rand()*100 + 1, rand()*100 + 1);
        
        if _cnt = _last then
			leave _loop;
		end if;
	end loop _loop;
end $$
delimiter ;

call bt1(10000);
select * from grade_rank_Table;

drop function if exists f_get_rank;
delimiter $$
create function f_get_rank(_kor integer,_eng integer, _mat integer) returns integer 
begin
   declare _rank integer;
    declare _sum integer;
    set _sum = _kor+_eng+_mat;
    select count(*) into _rank from grade_rank_Table where kor+eng+mat>_sum;
return _rank+1;
end $$
delimiter ;
select id as 학번, name as 이름, kor as 국어, eng as 영어, mat as 수학
 , (kor+eng+mat) as 총점,  (kor+eng+mat)/3 as 평균, f_get_rank(kor, eng, mat)as 등수 from grade_rank_Table 
 order by f_get_rank(kor,eng,mat);
 
 #######################################################
 
-- Basic Training 2
drop procedure if exists input_data;
delimiter //
create procedure input_data(_last integer)
begin
declare _name varchar(20);
declare _age integer;
declare _cnt integer;
set _cnt=0;

delete from voteTable;
	_loop : loop
		set _cnt = _cnt + 1;
        set _name = (
  SELECT name
  FROM (
    SELECT '나연' AS name
    UNION ALL SELECT '정연'
    UNION ALL SELECT '모모'
    UNION ALL SELECT '사나'
    UNION ALL SELECT '지효'
    UNION ALL SELECT '미나'
    UNION ALL SELECT '다현'
    UNION ALL SELECT '채영'
    UNION ALL SELECT '쯔위'
  ) AS random_names
  ORDER BY RAND()
  LIMIT 1
);

        set _age = (floor(rand()*9) + 1) * 10;
        
        insert into voteTable value (_name, _age);
        
        if _cnt = _last then
			leave _loop;
		end if;
	end loop _loop;
end //
delimiter ;
 
call input_data(1000);
select * from voteTable;

drop function if exists f_get_rate;
delimiter //
create function f_get_rate(_name varchar(5)) returns float
begin
    declare _vote_rate float;
select (count(_name) / (select count(*) from voteTable)) * 100 into _vote_rate 
from voteTable where name=_name;
return _vote_rate;
end //
delimiter ;

select age as 연령대, count(name) as 득표수, count(name)/(select count(*) from voteTable where name='나연')*100 as 득표율
from voteTable where name='나연' group by name, age;
select name as 이름, f_get_rate(name) as 득표율 from voteTable group by name order by 득표율 desc;