-- 호감도 투표 2
drop table if exists tupyo2;
create table tupyo2(
	kiho1 int,
    kiho2 int,
    kiho3 int,
    age int);
desc tupyo2;

delete from tupyo2;
drop procedure if exists insert_tupyo2;
delimiter //
create procedure insert_tupyo2(_limit integer)
begin
declare _cnt integer;
set _cnt = 0;
	_loop : loop
		set _cnt = _cnt + 1;
        insert into tupyo2 value (rand()*8 + 1, rand()*8 + 1, rand()*8 + 1, rand()*8 + 1);
        if _cnt = _limit then
			leave _loop;
		end if;
	end loop _loop;
end //
delimiter ;
call insert_tupyo2(1000);
select * from tupyo2;
select count(*) from tupyo2;

select age, 
	h1.name as 투표1, 
	h2.name as 투표2, 
	h3.name as 투표3 
	from tupyo2 as a, hubo as h1, hubo as h2, hubo as h3
    where a.kiho1 = h1.kiho and a.kiho2 = h2.kiho and a.kiho3 = h3.kiho;
    
select age as 연령대,
	(select name from hubo where a.kiho1 = kiho) as 투표1,
    (select name from hubo where a.kiho2 = kiho) as 투표2,
    (select name from hubo where kiho = a.kiho3) as 투표3
    from tupyo2 as a;
    
-- 호감도 투표 3
select
(select count(*) from tupyo2 where kiho1=1 or kiho2=1 or kiho3=1) as '나연',
(select count(*) from tupyo2 where kiho1=2 or kiho2=2 or kiho3=2) as '정연',
(select count(*) from tupyo2 where kiho1=3 or kiho2=3 or kiho3=3) as '모모',
(select count(*) from tupyo2 where kiho1=4 or kiho2=4 or kiho3=4) as '사나',
(select count(*) from tupyo2 where kiho1=5 or kiho2=5 or kiho3=5) as '지효',
(select count(*) from tupyo2 where kiho1=6 or kiho2=6 or kiho3=6) as '미나',
(select count(*) from tupyo2 where kiho1=7 or kiho2=7 or kiho3=7) as '다현',
(select count(*) from tupyo2 where kiho1=8 or kiho2=8 or kiho3=8) as '채영',
(select count(*) from tupyo2 where kiho1=9 or kiho2=9 or kiho3=9) as '쯔위',
(select 나연 + 정연 + 모모 + 사나 + 지효 + 미나 + 다현 + 채영 + 쯔위) as '총합',
(select count(*) from tupyo2 where kiho1=kiho2 or kiho1=kiho3 or kiho2=kiho3) as '2중복',
(select count(*) from tupyo2 where kiho1=kiho2 and kiho1=kiho3 and kiho2=kiho3) as '3중복';

-- 호감도 투표 4
drop table if exists examtable;
create table examtable(
	name varchar(20),
    id int not null primary key,
    kor int, eng int, mat int);
desc examtable;

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