-- 호감도 투표 2
drop table if exists tupyo2; # 테이블이 있다면 지워라
create table tupyo2( # 투표2 테이블 생성
	kiho1 int, # int kiho1
    kiho2 int, # int kiho2
    kiho3 int, # int kiho3
    age int); # int age
desc tupyo2; # tupyo2 구조 출력

delete from tupyo2; # tupyo2 데이터 전체 삭제
drop procedure if exists insert_tupyo2; # 프로시저가 있다면 지워라
delimiter //
create procedure insert_tupyo2(_limit integer) # insert_tupyo2 프로시저 생성
begin
declare _cnt integer; # integer 변수 _cnt 생성
set _cnt = 0; # _cnt = 0으로 초기화
	_loop : loop # 반복문
		set _cnt = _cnt + 1; # _cnt = _cnt + 1
        # tupyo2에 1~9 사이 정수 4번 입력
        insert into tupyo2 value (rand()*8 + 1, rand()*8 + 1, rand()*8 + 1, rand()*8 + 1);
        if _cnt = _limit then # _cnt가 입력받은 수 _limit과 같으면
			leave _loop; # break
		end if; # if 종료
	end loop _loop; # 반복문 종료
end // # delimiter 끝
delimiter ;
call insert_tupyo2(1000); # insert_tupyo2 프로시저에 숫자 1000 대입
select * from tupyo2; # tupyo2 전체 출력

-- 호감도 투표 2-3
select age, # 이름,
	h1.name as 투표1,  # h1.name,
	h2.name as 투표2, # h2.name,
	h3.name as 투표3 # h3.name 출력
	from tupyo2 as a, hubo as h1, hubo as h2, hubo as h3 # 동일한 테이블을 각각 다른 명칭으로 지정할 수 있다
    where a.kiho1 = h1.kiho and a.kiho2 = h2.kiho and a.kiho3 = h3.kiho;
    # a.kiho1=h1.kiho, a.kiho2=h2.kiho, a.kiho3=h3.kiho를 동시에 충족하면
    
-- 호감도 투표 2-4
select age as 연령대,
	(select name from hubo where a.kiho1 = kiho) as 투표1, # h1.name과 동일한 select 쿼리문
    (select name from hubo where a.kiho2 = kiho) as 투표2, # h2.name과 동일한 select 쿼리문
    (select name from hubo where kiho = a.kiho3) as 투표3 # h3.name과 동일한 select 쿼리문
    from tupyo2 as a; # 앞서 작성한 쿼리문을 중첩 select문으로 바꿔보았다.
    
-- 호감도 투표 3
select
(select count(*) from tupyo2 where kiho1=1 or kiho2=1 or kiho3=1) as '나연', # kiho1,2,3중 하나라도 1인 투표의 수를 나연으로 친다
(select count(*) from tupyo2 where kiho1=2 or kiho2=2 or kiho3=2) as '정연', # kiho1,2,3중 하나라도 2인 투표의 수를 정연으로 친다
(select count(*) from tupyo2 where kiho1=3 or kiho2=3 or kiho3=3) as '모모', # kiho1,2,3중 하나라도 3인 투표의 수를 모모로 친다
(select count(*) from tupyo2 where kiho1=4 or kiho2=4 or kiho3=4) as '사나', # kiho1,2,3중 하나라도 4인 투표의 수를 사나로 친다
(select count(*) from tupyo2 where kiho1=5 or kiho2=5 or kiho3=5) as '지효', # kiho1,2,3중 하나라도 5인 투표의 수를 지효로 친다
(select count(*) from tupyo2 where kiho1=6 or kiho2=6 or kiho3=6) as '미나', # kiho1,2,3중 하나라도 6인 투표의 수를 미나로 친다
(select count(*) from tupyo2 where kiho1=7 or kiho2=7 or kiho3=7) as '다현', # kiho1,2,3중 하나라도 7인 투표의 수를 다현으로 친다
(select count(*) from tupyo2 where kiho1=8 or kiho2=8 or kiho3=8) as '채영', # kiho1,2,3중 하나라도 8인 투표의 수를 채영으로 친다
(select count(*) from tupyo2 where kiho1=9 or kiho2=9 or kiho3=9) as '쯔위'; # kiho1,2,3중 하나라도 9인 투표의 수를 쯔위로 친다
    
-- 호감도 투표 4
select
(select count(*) from tupyo2 where kiho1=1 or kiho2=1 or kiho3=1) as '나연', # kiho1,2,3중 하나라도 1인 투표의 수를 나연으로 친다
(select count(*) from tupyo2 where kiho1=2 or kiho2=2 or kiho3=2) as '정연', # kiho1,2,3중 하나라도 2인 투표의 수를 정연으로 친다
(select count(*) from tupyo2 where kiho1=3 or kiho2=3 or kiho3=3) as '모모', # kiho1,2,3중 하나라도 3인 투표의 수를 모모로 친다
(select count(*) from tupyo2 where kiho1=4 or kiho2=4 or kiho3=4) as '사나', # kiho1,2,3중 하나라도 4인 투표의 수를 사나로 친다
(select count(*) from tupyo2 where kiho1=5 or kiho2=5 or kiho3=5) as '지효', # kiho1,2,3중 하나라도 5인 투표의 수를 지효로 친다
(select count(*) from tupyo2 where kiho1=6 or kiho2=6 or kiho3=6) as '미나', # kiho1,2,3중 하나라도 6인 투표의 수를 미나로 친다
(select count(*) from tupyo2 where kiho1=7 or kiho2=7 or kiho3=7) as '다현', # kiho1,2,3중 하나라도 7인 투표의 수를 다현으로 친다
(select count(*) from tupyo2 where kiho1=8 or kiho2=8 or kiho3=8) as '채영', # kiho1,2,3중 하나라도 8인 투표의 수를 채영으로 친다
(select count(*) from tupyo2 where kiho1=9 or kiho2=9 or kiho3=9) as '쯔위', # kiho1,2,3중 하나라도 9인 투표의 수를 쯔위로 친다
(select 나연 + 정연 + 모모 + 사나 + 지효 + 미나 + 다현 + 채영 + 쯔위) as '총합', # 나정모사지미다채쯔의 수를 다 더한 걸 총합으로 친다
(select count(*) from tupyo2 where kiho1=kiho2 or kiho1=kiho3 or kiho2=kiho3) as '2중복', # 값 2개가 겹치는걸 2중복으로 친다
(select count(*) from tupyo2 where kiho1=kiho2 and kiho1=kiho3 and kiho2=kiho3) as '3중복'; # 값 3개가 겹치는걸 3중복으로 친다
