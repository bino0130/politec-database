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
drop procedure if exists insert_test; # 있으면 지워라
delimiter $$
create procedure insert_test(_subid integer, _last integer) # insert_test 프로시저 생성
begin # 시작
declare _name varchar(20); # varchar(20) _name 변수 생성
declare _id integer; # integer _id 변수 생성
declare _cnt1 integer; # integer _cnt1 변수 생성 -> subjectID에 사용
declare _cnt2 integer; # integer _cnt2 변수 생성
set _cnt1 = 0; # _cnt1 = 0으로 초기화

delete from testing; # 시험 테이블 전체 데이터 삭제
_loop1 : loop # 반복문 1
set _cnt1 = _cnt1 + 1; # cnt1++
set _cnt2 = 0; # cnt2 = 0으로 초기화
		_loop2 : loop # 반복문 2
			set _cnt2 = _cnt2 + 1; # _cnt2++
			set _name = concat("학번", cast(_cnt2 as char(4)));
            # concat : 2개 이상의 문자열을 합치는 함수
			# cast : 데이터 타입을 바꿔주는 함수 (= 형변환 함수)
			set _id = _cnt2; # _id = _cnt2으로 설정
			insert into testing value (_cnt1, _name, _id, # subjectID, stu_name, stu_id
			rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, # a01~a05 성적
			rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, # a06~a10 성적
			rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, # a11~a15 성적
			rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1, rand()*3 + 1); # a16~a20 성적
			
			if _cnt2 = _last then # _cnt2가 입력받은 숫자와 같으면
				leave _loop2; # break
			end if; # if 종료
		end loop; # 반복문 종료

if _cnt1 = _subid then # _cnt1이 _subid와 같으면
	leave _loop1; # break
end if; # if 종료
end loop; # 반복문 종료

end $$ # delimiter 종료
delimiter ;

call insert_test(3, 1000); # insert_test에 3,1000 입력

select * from testing; # 시험 테이블 출력
select count(*) from testing; # 시험 테이블 데이터 개수 출력