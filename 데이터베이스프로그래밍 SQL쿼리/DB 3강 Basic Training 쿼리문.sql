use kopo10;
-- Basic Training 1
drop table if exists grade_rank_Table; # 있으면 지워라
create table grade_rank_Table( # grade_rank_Table 생성
	name varchar(20), # varchar(20) name
    id int not null primary key, # int, not null, pk id
    kor int, eng int, mat int); # int kor, eng, mat

drop procedure if exists bt1; # 있으면 지워라
delimiter $$
create procedure bt1(_last integer) # bt1 프로시저 생성
begin # 시작
declare _name varchar(20); # varchar(20) 변수 name 생성
declare _id integer; # integer _id 생성
declare _cnt integer; # integer _cnt 생성
set _cnt=0; # _cnt = 0으로 초기화
delete from grade_rank_Table where id > 0; # id가 1 이상인 데이터 삭제
	_loop : loop # 반복문
		set _cnt = _cnt + 1; # _cnt++
        set _name = concat("홍길", cast(_cnt as char(5)));
        # concat : 2개 이상의 문자열을 합치는 함수
        # cast : 데이터 타입을 바꿔주는 함수 (= 형변환 함수)
        set _id = _cnt;
        # id = _cnt
        
        insert into grade_rank_Table value (_name, _id, rand()*100 + 1, rand()*100 + 1, rand()*100 + 1);
        # grade_rank_Table에 데이터 입력
        
        if _cnt = _last then # _cnt가 입력받은 값과 같으면
			leave _loop; # break
		end if; # if문 종료
	end loop _loop; # 반복문 종료
end $$ # delimiter 종료
delimiter ;

call bt1(10000); # 프로시저 bt1에 10000 대입
select *, gr1.kor+gr1.eng+gr1.mat as sum, (gr1.kor+gr1.eng+gr1.mat)/3 as avg,
(select count(*) + 1 from grade_rank_Table as gr2 where (gr2.kor+gr2.eng+gr2.mat) > (gr1.kor+gr1.eng+gr1.mat)) as rnk
from grade_rank_Table as gr1; # grade_rank_Table 전체 데이터 출력

drop function if exists f_get_rank; # 있으면 지워라
delimiter $$
create function f_get_rank(_kor integer,_eng integer, _mat integer) returns integer # f_get_rank 함수 생성
begin
   declare _rank integer; #integer 변수 _rank 생성
    declare _sum integer; #integer 변수 _sum 생성
    set _sum = _kor+_eng+_mat; # sum = _kor_eng_mat
    select count(*) into _rank from grade_rank_Table where kor+eng+mat>_sum;
    # _rank에 국영수의 총합이 _sum보다 큰 데이터 개수 입력
return _rank+1; # _rank + 1 리턴
end $$ # delimiter 종료
delimiter ;

select id as 학번, name as 이름, kor as 국어, eng as 영어, mat as 수학
 , (kor+eng+mat) as 총점,  (kor+eng+mat)/3 as 평균, f_get_rank(kor, eng, mat)as 등수 from grade_rank_Table 
 order by f_get_rank(kor,eng,mat);
 # 등수 기준으로 정렬해서 id를 학번으로, name을 이름, kor를 국어, eng를 영어, mat를 수학, kor+eng+mat를 총점, (kor+eng+mat)/3을 평균,
 # f_get_rank(kor,eng,mat)를 등수로 출력
 
 #######################################################
 
-- Basic Training 2
drop procedure if exists input_data; # 있으면 지워라
delimiter //
create procedure input_data(_last integer) # input_data 프로시저 생성
begin # 시작
declare _name varchar(20); # varchar(20) 변수 _name 생성
declare _age integer; # integer 변수 _age 생성
declare _cnt integer; # integer 변수 _cnt 생성
set _cnt=0; # _cnt = 0으로 초기화

delete from voteTable; # voteTable 데이터 삭제
	_loop : loop # 반복문
		set _cnt = _cnt + 1; # _cnt++
        set _name = ( # _name에 트와이스 멤버 9명 중 1명의 이름이 무작위로 들어가게 쿼리문 설정
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

        set _age = (floor(rand()*9) + 1) * 10; # 연령대
        # _age = 10 ~ 90 사이 무작위 정수 (10, 20, 30, ,,, ,90)
        
        insert into voteTable value (_name, _age); # voteTable에 _name, _age 입력
        
        if _cnt = _last then # _cnt가 입력받은 값과 같으면
			leave _loop; # break
		end if; # if문 종료
	end loop _loop; # 반복문 종료
end // # delimiter 종료
delimiter ;
 
call input_data(1000); # input_data 프로시저에 1000 대입
select * from voteTable; # voteTable 전체 데이터 출력

drop function if exists f_get_rate; # 있으면 지워라
delimiter //
create function f_get_rate(_name varchar(5)) returns float # 선호도비율 함수 f_get_rate 생성
begin # 시작
    declare _vote_rate float; # float 변수 _vote_rate 생성
select (count(_name) / (select count(*) from voteTable)) * 100 into _vote_rate 
from voteTable where name=_name;
# _vote_rate에 name이 _name과 같은 데이터 중 (count(_name)/(select count(*) from voteTable))*100의 값 입력
return _vote_rate; # _vote_rate 리턴
end // # delimiter 종료
delimiter ;

select name as 이름, f_get_rate(name) as 득표율 from voteTable group by name order by 득표율 desc;
# 선호도 비율 함수를 사용해서 이름, 득표율 출력