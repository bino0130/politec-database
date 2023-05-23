-- 후보 테이블 만들기
drop table if exists hubo; # 후보 테이블이 있다면 지워라
create table hubo( # 후보 테이블 생성
	kiho int not null primary key,  #kiho int (pk)
	name varchar(10),  # name varchar(10)
	gongyak varchar(50), # 공약 varchar(50)
	index(kiho)); # 필드 kiho의 인덱스 생성
# 인덱스는 데이터가 많을 대 해당 필드를 작업 시 빠른 검색이 가능하다. 영어 백과사전에서 단어를 찾을 때
# 해당 단어의 가장 앞자리 알파벳을 알아내 a부터 시작하는 단어 ~ z부터 시작하는 단어 중 찾는 원리
desc hubo; # 후보 테이블 구조 출력
select * from hubo; # 후보 테이블 전체 데이터 출력

drop table if exists tupyo; # 투표 테이블이 있다면 지워라
create table tupyo( # 투표 테이블 생성
	kiho int, # int kiho
	age int, # int age
    foreign key(kiho) references hubo(kiho) # hubo테이블의 kiho와 연동되는 foreign key kiho
	);
desc tupyo; # 투표 테이블 구조 출력

-- hubo 테이블에 데이터 입력
delete from hubo where kiho>0; # kiho가 1 이상인 데이터 전부 삭제
insert into hubo values (1, "나연", "정의사회 구현"); # 후보 테이블에 나연 데이터 입력
insert into hubo values (2, "정연", "모두 1억"); # 후보 테이블에 정연 데이터 입력
insert into hubo values (3, "모모", "주 4일제"); # 후보 테이블에 모모 데이터 입력
insert into hubo values (4, "사나", "살맛나는 세상"); # 후보 테이블에 사나 데이터 입력 
insert into hubo values (5, "지효", "먹다 죽은 귀신이 때깔도 곱다"); # 후보 테이블에 지효 데이터 입력
insert into hubo values (6, "미나", "하고싶은거 다 해"); # 후보 테이블에 미나 데이터 입력
insert into hubo values (7, "다현", "장바구니 다 사줄게"); # 후보 테이블에 다현 데이터 입력
insert into hubo values (8, "채영", "노는게 젤조은 뽀로로세상 구현"); # 후보 테이블에 채영 데이터 입력
insert into hubo values (9, "쯔위", "커플지옥 싱글 파라다이스"); # 후보 테이블에 쯔위 데이터 입력
select kiho as 기호, name as 성명, gongyak as 공약 from hubo; # 각 필드 별 이름 설정 후 전체 데이터 출력

-- tupyo 테이블에 데이터 입력
delete from tupyo where kiho>0; # kiho가 1 이상인 데이터 모두 삭제
drop procedure if exists insert_tupyo; # insert_tupyo 프로시저가 있으면 삭제
delimiter $$
create procedure insert_tupyo(_limit integer) #insert_tupyo 프로시저 생성
begin # 시작
declare _cnt integer; # integer 변수 _cnt 생성
set _cnt = 0; # _cnt = 0으로 초기화
	_loop: loop # 반복문
		set _cnt = _cnt + 1; # _cnt = _cnt + 1
        insert into tupyo value (rand()*8+1, rand()*8+1); # 투표 테이블에 1~9 사이 정수 입력
        if _cnt = _limit then # _cnt가 입력받은 수 _limit과 같으면
			leave _loop; # break
		end if; # if 종료
	end loop _loop; # 반복문 종료
end $$ # delimiter 종료
delimiter ;
call insert_tupyo(1000); # insert_tupyo 프로시저에 1000 대입
select kiho as 투표한기호, age as 투표자연령대 from tupyo; # 각 필드별로 이름 지정해서 출력

# kiho 필드로 그룹지어서 출력
select kiho, count(*) from tupyo group by kiho;

select a.name, a.gongyak, count(b.kiho) # 4. a의 name, a의 gongyak, b의 kiho의 개수를 세서 출력한다
	from hubo as a, tupyo as b # 1. hubo 테이블을 a, tupyo 테이블을 b라고 명명한다
    where a.kiho = b.kiho # 2. a의 kiho와 b의 kiho가 같은 곳을 찾아
    group by b.kiho; # 3. b의 kiho로 그룹지어서

select
	(select name from hubo as a where a.kiho = b.kiho) as 이름, # 이름
    (select gongyak from hubo as a where a.kiho = b.kiho) as 공약, # 공약
    count(b.kiho) as 득표수
    from tupyo as b
    group by tupyo.kiho;
# 바로 전에 작성한 쿼리를 select 안에 select로 바꿔보았다. 형태는 좀 더 길어졌지만
# 같은 결과가 출력되는 것을 확인할 수 있다.
