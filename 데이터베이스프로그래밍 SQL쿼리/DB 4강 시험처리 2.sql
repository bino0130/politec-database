insert into answer values ( # 국어 정답 입력
1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1,
rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1,
rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1,
rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1);
insert into answer values ( # 영어 정답 입력
2, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1,
rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1,
rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1,
rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1);
insert into answer values ( # 수학 정답 입력
3, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1,
rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1,
rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1,
rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1);
select * from answer;

-- 시험 테이블 데이터 입력
drop procedure if exists insert_test;
delimiter $$
create procedure insert_test(_subid integer, _last integer)
begin
declare _name varchar(20);
declare _id integer;
declare _cnt1 integer;
declare _cnt2 integer;
set _cnt1 = 0;

delete from testing;
_loop1 : loop
set _cnt1 = _cnt1 + 1;
set _cnt2 = 0;
		_loop2 : loop
			set _cnt2 = _cnt2 + 1;
			set _name = concat("학번", cast(_cnt2 as char(4)));
			set _id = _cnt2;
			insert into testing value (_cnt1, _name, _id, 
			rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1,
			rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1,
			rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1,
			rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1);
			
			if _cnt2 = _last then
				leave _loop2;
			end if;
		end loop;

if _cnt1 = _subid then
	leave _loop1;
end if;
end loop;

end $$
delimiter ;

call insert_test(3, 1000);

select * from testing order by stu_id;
select * from testing;
select count(*) from testing;

-- 채점하기
