use mysql;
create table reservation( # reservation 테이블 생성
name varchar(5), reserve_date date,
room int, addr varchar(5),
tel varchar(20), ipgum_name varchar(5),
memo varchar(20), input_date date);
desc reservation;

# reservation 데이터 입력
delete from reservation;
insert into reservation values ("체흐","2023-05-23",2,"서울","010-1234-1234","체흐","안녕하세요",NOW());
insert into reservation values ("보싱와","2023-05-24",3,"경기","010-1234-4562","보싱와","안녕하세요",now());
insert into reservation values ("존테리","2023-05-25",1,"부산","010-4423-1234","존테리","안녕하세요",now());
insert into reservation values ("이바노비치","2023-05-26",1,"강릉","010-1234-6485","이바노비치","안녕하세요",now());
insert into reservation values ("콜","2023-05-27",3,"속초","010-6425-1234","콜","안녕하세요",now());
insert into reservation values ("하미레스","2023-05-28",1,"강원","010-8476-1234","하미레스","안녕하세요",now());
insert into reservation values ("램파드","2023-05-29",3,"서울","010-1234-4058","램파드","안녕하세요",now());
insert into reservation values ("미켈","2023-05-30",2,"포항","010-4695-1234","미켈","안녕하세요",now());
insert into reservation values ("아넬카","2023-05-31",2,"제주","010-4695-2586","아넬카","안녕하세요",now());
insert into reservation values ("드록바","2023-06-01",1,"인천","010-6245-5588","드록바","안녕하세요",now());
insert into reservation values ("토레스","2023-06-02",3,"부천","010-2045-5588","토레스","반가워요",now());
insert into reservation values ("아자르","2023-06-03",2,"송도","010-2045-2068","아자르","반가워요",now());
insert into reservation values ("케파","2023-06-04",2,"용인","010-3215-2068","케파","반가워요",now());
insert into reservation values ("탄코","2023-06-05",1,"분당","010-3214-5682","탄코","반가워요",now());
insert into reservation values ("코스타","2023-06-06",3,"동탄","010-6215-0608","코스타","잘지내요",now());
insert into reservation values ("모라타","2023-06-07",2,"동탄","010-6215-3212","모라타","잘지내요",now());
insert into reservation values ("오스카","2023-06-08",1,"서현","010-6215-1111","오스카","잘지내요",now());
insert into reservation values ("김덕배","2023-06-09",2,"정자","010-6215-2256","김덕배","잘지내요",now());
insert into reservation values ("실바","2023-06-10",1,"판교","010-3278-9526","실바","잘지내요",now());
insert into reservation values ("제임스","2023-06-11",2,"수내","010-4468-0306","제임스","잘지내요",now());
select * from reservation;

# 한달 간 예약상황 보여주는 procedure 생성
drop procedure if exists reservstat_calc;
delimiter //
create procedure reservstat_calc()
begin
	declare _date date;
    declare _cnt integer;
    declare _room1 varchar(20);
    declare _room2 varchar(20);
    declare _room3 varchar(20);
    
    set _date = now();
    set _cnt = 0;
    drop table if exists reserv_stat;
    create table reserv_stat(
		reserve_date date not null primary key,
        room1 varchar(20),
        room2 varchar(20),
        room3 varchar(20));
_loop : loop
	set _cnt = _cnt + 1;
	insert into reserv_stat
    select 
    r1.reserve_date, 
    if(r1.room = 1, r1.name, if(r2.room = 2, r2.name, if(r3.room = 3, r3.name, "예약가능"))),
    if(r1.room = 1, r1.name, if(r2.room = 2, r2.name, if(r3.room = 3, r3.name, "예약가능"))),
    if(r1.room = 1, r1.name, if(r2.room = 2, r2.name, if(r3.room = 3, r3.name, "예약가능")))
    from reservation as r1, reservation as r2, reservation as r3;
    
    select * from reserv_stat;
end//
delimiter ;
call reservstat_calc();
select * from reserv_stat;
insert into reserv_stat
    select 
    r1.reserve_date, 
    if(r1.room = 1, r1.name, if(r2.room = 2, r2.name, if(r3.room = 3, r3.name, "예약가능"))),
    if(r1.room = 1, r1.name, if(r2.room = 2, r2.name, if(r3.room = 3, r3.name, "예약가능"))),
    if(r1.room = 1, r1.name, if(r2.room = 2, r2.name, if(r3.room = 3, r3.name, "예약가능")))
    from reservation as r1, reservation as r2, reservation as r3;