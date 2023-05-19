drop table if exists hubo;
create table hubo(
	kiho int not null primary key, 
	name varchar(10), 
	gongyak varchar(50),
	index(kiho));
desc hubo;
select * from hubo;

drop table if exists tupyo;
create table tupyo(
	kiho int, 
	age int, 
    foreign key(kiho) references hubo(kiho)
	);
desc tupyo;

-- hubo 테이블에 데이터 입력
delete from hubo where kiho>0;
insert into hubo values (1, "나연", "정의사회 구현");
insert into hubo values (2, "정연", "모두 1억");
insert into hubo values (3, "모모", "주 4일제");
insert into hubo values (4, "사나", "살맛나는 세상");
insert into hubo values (5, "지효", "먹다 죽은 귀신이 때깔도 곱다");
insert into hubo values (6, "미나", "하고싶은거 다 해");
insert into hubo values (7, "다현", "장바구니 다 사줄게");
insert into hubo values (8, "채영", "노는게 젤조은 뽀로로세상 구현");
insert into hubo values (9, "쯔위", "커플지옥 싱글 파라다이스");
select kiho as 기호, name as 성명, gongyak as 공약 from hubo;

-- tupyo 테이블에 데이터 입력
delete from tupyo where kiho>0;
drop procedure if exists insert_tupyo;
delimiter $$
create procedure insert_tupyo(_limit integer)
begin
declare _cnt integer;
set _cnt = 0;
	_loop: loop
		set _cnt = _cnt + 1;
        insert into tupyo value (rand()*8+1, rand()*8+1);
        if _cnt = _limit then
			leave _loop;
		end if;
	end loop _loop;
end $$
delimiter ;
call insert_tupyo(1000);
select count(*) from tupyo;
select kiho as 투표한기호, age as 투표자연령대 from tupyo;

select kiho, count(*) from tupyo group by kiho;

select a.name, a.gongyak, count(b.kiho)
	from hubo as a, tupyo as b
    where a.kiho = b.kiho
    group by b.kiho;

select
	(select name from hubo where kiho = tupyo.kiho) as 이름, # 이름
    (select gongyak from hubo where kiho = tupyo.kiho) as 공약, # 공약
    count(tupyo.kiho) as 득표수
    from tupyo
    group by tupyo.kiho;

