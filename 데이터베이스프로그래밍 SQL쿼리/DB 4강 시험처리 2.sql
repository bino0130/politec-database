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
insert into scoring select 
t.subjectID, t.stu_name, t.stu_id,
(a.a01 = t.a01) as s01,
(a.a02 = t.a02) as s02,
(a.a03 = t.a03) as s03,
(a.a04 = t.a04) as s04,
(a.a05 = t.a05) as s05,
(a.a06 = t.a06) as s06,
(a.a07 = t.a07) as s07,
(a.a08 = t.a08) as s08,
(a.a09 = t.a09) as s09,
(a.a10 = t.a10) as s10,
(a.a11 = t.a11) as s11,
(a.a12 = t.a12) as s12,
(a.a13 = t.a13) as s13,
(a.a14 = t.a14) as s14,
(a.a15 = t.a15) as s15,
(a.a16 = t.a16) as s16,
(a.a17 = t.a17) as s17,
(a.a18 = t.a18) as s18,
(a.a19 = t.a19) as s19,
(a.a20 = t.a20) as s20,
s01 + s02 + s03 + s04 + s05 + s06 + s07 + s08 + s09 + s10 +
s11 + s12 + s13 + s14 + s15 + s16 + s07 + s08 + s09 + s10
from answer as a,testing as t where a.subjectID = t.subjectID;