drop table if exists reservation;
create table reservation( # reservation 테이블 생성
name varchar(5), reserve_date date, # varchar(5) name, date reserve_date
room int, addr varchar(5), # int room, varchar(5) addr
tel varchar(20), ipgum_name varchar(5), # varchar(20) tel, varchar(5) ipgum_name
memo varchar(20), input_date date); # varchar(20) memo, date input_date
desc reservation; # reservation 구조 출력

# reservation 데이터 입력
delete from reservation;
insert into reservation values ("체흐","2023-05-23",2,"서울","010-1234-1234","체흐","안녕하세요",NOW());
insert into reservation values ("보싱와","2023-05-25",3,"경기","010-1234-4562","보싱와","안녕하세요",now());
insert into reservation values ("존테리","2023-05-26",1,"부산","010-4423-1234","존테리","안녕하세요",now());
insert into reservation values ("이바노비치","2023-05-28",1,"강릉","010-1234-6485","이바노비치","안녕하세요",now());
insert into reservation values ("콜","2023-05-29",3,"속초","010-6425-1234","콜","안녕하세요",now());
insert into reservation values ("하미레스","2023-05-30",1,"강원","010-8476-1234","하미레스","안녕하세요",now());
insert into reservation values ("램파드","2023-06-01",3,"서울","010-1234-4058","램파드","안녕하세요",now());
insert into reservation values ("미켈","2023-06-03",2,"포항","010-4695-1234","미켈","안녕하세요",now());
insert into reservation values ("아넬카","2023-06-04",2,"제주","010-4695-2586","아넬카","안녕하세요",now());
insert into reservation values ("드록바","2023-06-06",1,"인천","010-6245-5588","드록바","안녕하세요",now());
insert into reservation values ("토레스","2023-06-08",3,"부천","010-2045-5588","토레스","반가워요",now());
insert into reservation values ("아자르","2023-06-09",2,"송도","010-2045-2068","아자르","반가워요",now());
insert into reservation values ("케파","2023-06-10",2,"용인","010-3215-2068","케파","반가워요",now());
insert into reservation values ("탄코","2023-06-11",1,"분당","010-3214-5682","탄코","반가워요",now());
insert into reservation values ("코스타","2023-06-13",3,"동탄","010-6215-0608","코스타","잘지내요",now());
insert into reservation values ("모라타","2023-06-15",2,"동탄","010-6215-3212","모라타","잘지내요",now());
insert into reservation values ("오스카","2023-06-17",1,"서현","010-6215-1111","오스카","잘지내요",now());
insert into reservation values ("김덕배","2023-06-19",2,"정자","010-6215-2256","김덕배","잘지내요",now());
insert into reservation values ("실바","2023-06-20",1,"판교","010-3278-9526","실바","잘지내요",now());
insert into reservation values ("제임스","2023-06-22",2,"수내","010-4468-0306","제임스","잘지내요",now());
select * from reservation; # reservation 전체 데이터 출력

# 한달 간 예약상황 보여주는 procedure 생성
drop procedure if exists reservstat_calc; # 있으면 지워라
delimiter //
create procedure reservstat_calc(_day integer) # reservstat_calc 프로시저 생성
begin # 시작
declare _date date; # date 변수 _date 생성 
declare _cnt integer; # integer 변수 _cnt 생성
declare _room1 varchar(20); # varchar(20) 변수 _room1 생성
declare _room2 varchar(20); # varchar(20) 변수 _room2 생성
declare _room3 varchar(20); # varchar(20) 변수 _room3 생성
	drop table if exists reserv_stat; # 있다면 지워라
    create table reserv_stat( # reserv_stat 테이블 생성
		reserve_date date not null primary key, # date, not null, pk reserve_date
        room1 varchar(20), # varchar(20) room1
        room2 varchar(20), # varchar(20) room2
        room3 varchar(20)); # varchar(20) room3
	set _cnt = 0; # _cnt = 0으로 초기화
	_loop : loop # 반복문
		set _cnt = _cnt + 1; # _cnt++
        set _date = curdate() + interval (_cnt - 1) day; # _date의 초기값은 오늘, 이후로는 현재 날짜의 +1 씩 증가함
        set _room1 = (select name from reservation where reserve_date = _date and room = 1);
        if _room1 is null then set _room1 = "예약가능"; end if;
        # room1에 reservation 테이블에서 예약날짜가 _date와 같고 방 번호가 1인 데이터 입력. room1이 null이면 '예약 가능'이라고 표시
        set _room2 = (select name from reservation where reserve_date = _date and room = 2);
        if _room2 is null then set _room2 = "예약가능"; end if;
        # room2에 reservation 테이블에서 예약날짜가 _date와 같고 방 번호가 2인 데이터 입력. room2이 null이면 '예약 가능'이라고 표시
        set _room3 = (select name from reservation where reserve_date = _date and room = 3);
        if _room3 is null then set _room3 = "예약가능"; end if;
        # room3에 reservation 테이블에서 예약날짜가 _date와 같고 방 번호가 3인 데이터 입력. room3이 null이면 '예약 가능'이라고 표시
        
        insert into reserv_stat value (_date, _room1, _room2, _room3);
        # reserv_stat에 date, room1, room2, room3 입력
        
        IF _cnt = _day THEN # _cnt가 입력받은 값과 같다면
			LEAVE _loop; # break
		END IF; # if문 종료
	end loop _loop; # 반복문 종료
    
	select * from reserv_stat; # reserv_stat 전체 데이터 출력
end // # delimiter 종료
delimiter ;

call reservstat_calc(30); # reservstat_calc에 30 넣어서 호출