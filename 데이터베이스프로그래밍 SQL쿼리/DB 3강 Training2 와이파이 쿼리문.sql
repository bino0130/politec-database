show tables;
select * from freewifi; # id, place_addr_road, latitude, longitude, f_get_distance()

-- 와이파이 데이터 입력할 테이블 생성
drop table if exists five_wifi; # 있으면 지워라
create table five_wifi( # five_wifi 테이블 생성
id int, # int id
addr varchar(50), # varchar(50) addr
latitude double, # double latitude
longitude double, # double longitude
distance double); # double distance

-- 거리 구하는 함수 생성
drop function if exists f_get_distance; # 있으면 지워라
delimiter $$
create function f_get_distance(lng double, lat double) returns double # 거리구하는 함수 생성
begin # 시작
declare distance double; # double 변수 distance 생성
declare _lng double; # double 변수 _lng 생성
declare _lat double; # double 변수 _lat 생성
	set _lng = 127.1214038; # 현재 내 경도
    set _lat = 37.3860521; # 현재 내 위도
	set @location1 = point(lng, lat); # 변수 location1 초기화
    set @location2 = point(_lng, _lat); # 변수 location2 초기화
    select ST_distance_Sphere(@location1, @location2) into distance; # 두 좌표 사이의 거리 계산해서 distance에 대입
    # ST_distance_Sphere : 두 좌표 사이의 거리를 미터(meter)단위로 계산하는 함수
return distance; # distance 리턴
end $$ # delimiter 종료
delimiter ;

insert into five_wifi 
select id, place_addr_road, latitude, longitude, round(f_get_distance(longitude, latitude),1) from freewifi;
# freewifi 테이블을 참조하고 f_get_distance 함수를 사용해서 five-wifi 테이블에 데이터 입력

-- print_report() 프로시저 생성
drop procedure if exists print_report; # 있으면 지워라
delimiter //
create procedure print_report (_nwpage integer, _to integer)
begin
declare _maxpage integer;
declare _dataNum integer;
declare _bfpage integer; # integer 변수 _bfpage 생성
# _bfpage를 생성한 이유 : limit x, y는 x+1번째 데이터값부터 y번째 데이터까지 범위를 지정한다.
# 그래서 parameter _nwpage를 받아 x값을 계산해서 도출해내기 위해 생성함.
select count(id) into _dataNum from five_wifi;
set _maxpage = _dataNum / _to;

if _nwpage < 1 then # _nwpage가 1보다 작으면
    select * from five_wifi limit 0, _to; # 0부터 _to번째 데이터까지 출력
elseif _nwpage > _maxpage then # _nwpage가 _maxpage보다 크다면
	set _bfpage = _maxpage * _to; # _bfpage는 _maxpage * _to
	select * from five_wifi limit _bfpage, _to; # _bfpage(39)+1부터 _to번째 데이터까지 출력
else
	set _bfpage = (_nwpage -1) * _to; # _bfpage = (_nwpage-1) X _to
    select * from five_wifi limit _bfpage, _to; # _bfpage+1부터 _to번째 데이터까지 출력
    end if; # if 종료
end // # delimiter 종료
delimiter ;

call print_report(5,25); # 와이파이 테이블의 n번째 페이지 출력

-- 우리 집에서 거리
drop function if exists f_get_home_distance; # 있으면 지워라
delimiter $$
create function f_get_home_distance(lng double, lat double) returns double # 우리 집까지의 거리구하는 함수 생성
begin # 시작
declare distance double; # double 변수 distance 생성
declare _lng double; # double 변수 _lng 생성
declare _lat double; # double 변수 _lat 생성
	set _lng = 127.097062; # 우리집 경도
    set _lat = 37.309461; # 우리집 위도
	set @location1 = point(lng, lat); # 변수 location1 초기화
    set @location2 = point(_lng, _lat); # 변수 location2 초기화
    select ST_distance_Sphere(@location1, @location2) into distance; # 두 좌표 사이의 거리 계산해서 distance에 대입
    # ST_distance_Sphere : 두 좌표 사이의 거리를 미터(meter)단위로 계산하는 함수
return distance; # distance 리턴
end $$ # delimiter 종료
delimiter ;

delete from five_wifi; # five_wifi 데이터 삭제
insert into five_wifi
select id, place_addr_road, latitude, longitude, round(f_get_home_distance(longitude, latitude),1) from freewifi;
# freewifi 테이블을 참조하고 f_get_home_distance 함수를 사용해서 five-wifi 테이블에 데이터 입력

-- print_homeDistance_report() 프로시저 생성
drop procedure if exists print_homeDistance_report; # 있으면 지워라
delimiter //
create procedure print_homeDistance_report (_nwpage integer, _to integer) # 집까지 거리 데이터 들어간 테이블 값 limit로 출력하는 프로시저 생성
begin
declare _maxpage integer; # integer 변수 _maxpage 생성
declare _dataNum integer; # integer 변수 _dataNum 생성
declare _bfpage integer; # integer 변수 _bfpage 생성
# _bfpage를 생성한 이유 : limit x, y는 x+1번째 데이터값부터 y번째 데이터까지 범위를 지정한다.
# 그래서 parameter _nwpage를 받아 x값을 계산해서 도출해내기 위해 생성함.
select count(id) into _dataNum from five_wifi; # dataNum에 id 데이터 개수 입력
set _maxpage = _dataNum / _to; # maxpage = dataNum / to

if _nwpage < 1 then # _nwpage가 1보다 작으면
    select * from five_wifi limit 0, _to; # 0부터 _to번째 데이터까지 출력
elseif _nwpage > _maxpage then # _nwpage가 _maxpage보다 크다면
	set _bfpage = _maxpage * _to; # _bfpage는 _maxpage * _to
	select * from five_wifi limit _bfpage, _to; # _bfpage(39)+1부터 _to번째 데이터까지 출력
else
	set _bfpage = (_nwpage -1) * _to; # _bfpage = (_nwpage-1) X _to
    select * from five_wifi limit _bfpage, _to; # _bfpage+1부터 _to번째 데이터까지 출력
    end if; # if 종료
end // # delimiter 종료
delimiter ;

call print_homeDistance_report (5,25); # 우리 집까지의 거리가 들어간 데이터 출력하는 함수 호출