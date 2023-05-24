-- Training(1)
drop table if exists th_grade; # 있으면 지워라
create table th_grade( # th_grade 테이블 생성
	id int not null primary key, # int not null, pk id
    name varchar(10), # varchar(10) name
    kor int, # int kor
    eng int, # int eng
    mat int, # int mat
    sum int, # int sum
    avg double); # double avg

-- 테이블에 값 insert
drop procedure if exists tr1; # 있으면 지워라
delimiter $$
create procedure tr1(_last integer) # tr1 프로시저 생성
begin # 시작
declare _name varchar(10); # varchar(10) 변수 _name 생성
declare _id integer; # integer 변수 _id 생성
declare _cnt integer; # integer 변수 _cnt 생성
declare _kor integer; # integer 변수 _kor 생성
declare _eng integer; # integer 변수 _eng 생성
declare _mat integer; # integer 변수 _mat 생성
declare _sum integer; # integer 변수 _sum 생성
declare _avg float; # integer 변수 _avg 생성

set _cnt = 0; # _cnt를 0으로 초기화

delete from th_grade where id > 0; # id가 1 이상인 th_grade 전체 데이터 삭제
	_loop : loop # 반복문
		set _cnt = _cnt + 1; # _cnt++
        set _name = concat("홍길", cast(_cnt as char(4)));
        # concat : 2개 이상의 문자열을 합치는 함수
		# cast : 데이터 타입을 바꿔주는 함수 (= 형변환 함수)
        set _id = _cnt; # id = _cnt (1씩 증가)
        set _kor = floor(rand()*100) + 1; # 국어 : 1~100 사이 정수
        set _eng = floor(rand()*100) + 1; # 영어 : 1~100 사이 정수
        set _mat = floor(rand()*100) + 1; # 수학 : 1~100 사이 정수
        set _sum = _kor + _eng + _mat; # 총점 : 국영수 총합
        set _avg = _sum / 3; # 평균 : 총점 / 3
        
        insert into th_grade value (_id, _name, _kor, _eng, _mat, _sum, _avg);
        # th_grade에 학번, 이름, 국어, 영어, 수학, 총점, 평균 데이터 입력
        
        if _cnt = _last then # _cnt가 입력받은 숫자와 같으면
			leave _loop; # break
		end if; # if 종료
	end loop _loop; # 반복문 종료
end $$ # delimiter 끝
delimiter ;

call tr1(1000); # tr1에 1000을 대입
select * from th_grade; # th_grade 전체 데이터 출력
select * from th_grade limit 100,25;

-- print_report() procedure 내용 테이블 생성
drop procedure if exists print_report; # 있다면 지워라
delimiter //
create procedure print_report(_nwpage integer, _to integer) # print_report 프로시저 생성
begin # delimiter 
declare _bfpage integer; # integer 변수 _bfpage 생성
# _bfpage를 생성한 이유 : limit x, y는 x+1번째 데이터값부터 y번째 데이터까지 범위를 지정한다.
# 그래서 parameter _nwpage를 받아 x값을 계산해서 도출해내기 위해 생성함

if _nwpage < 1 then # _nwpage가 1보다 작으면
    select * from th_grade limit 0, _to; # 0부터 _to번째 데이터까지 출력
elseif _nwpage > 40 then # _nwpage가 40보다 크다면
	set _bfpage = 39 * _to; # _bfpage는 39 * _to
	select * from th_grade limit _bfpage, _to; # _bfpage(39)+1부터 _to번째 데이터까지 출력
else
	set _bfpage = (_nwpage -1) * _to; # _bfpage = (_nwpage-1) X _to
    select * from th_grade limit _bfpage, _to; # _bfpage+1부터 _to번째 데이터까지 출력
    end if; # if 종료
end // # delimiter 종료
delimiter ;

call print_report(5, 25); # 5번째 페이지 결과 테이블 출력

-- print_now() procedure 현재 테이블 생성
drop procedure if exists print_now; # 있으면 지워라
delimiter //
create procedure print_now(_nwpage integer, _to integer) # print_now 프로시저 생성
begin # 시작
declare _bfpage integer; # integer 변수 _bfpage 생성
# _bfpage를 생성한 이유 : limit x, y는 x+1번째 데이터값부터 y번째 데이터까지 범위를 지정한다.
# 그래서 parameter _nwpage를 받아 x값을 계산해서 도출해내기 위해 생성함

if _nwpage < 1 then # _nwpage가 1보다 작으면
    select '현재-합계' , # 가독성을 위해 가상 필드 생성
	sum(kor) as sumkor, # 국어 총합
	sum(eng) as sumeng, # 영어 총합
	sum(mat) as summat, # 수학 총합
	sum(kor+eng+mat) as sumsum, # 총합의 총합
	round(sum((kor+eng+mat)/3),1) as sumavg # 평균 총합
	from (select * from th_grade limit 0, _to) as a # limit 0, _to를 사용한 서브쿼리문 사용
	union all # union all : 2개 이상의 select문 결과를 합친다. 중복 포함
	select '현재-평균', # 가독성을 위해 가상 필드 생성
	floor(avg(kor)) as avgkor, # 국어 평균
	floor(avg(eng)) as avgeng, # 영어 평균
	floor(avg(mat)) as avgmat, # 수학 평균
	floor(avg(kor+eng+mat)) as avgsum, # 총점 평균
	round(avg((kor+eng+mat)/3),1) as avgavg # 평균의 평균
	from (select * from th_grade limit 0, _to) as a; # limit 0, _to를 사용한 서브쿼리문 사용
elseif _nwpage > 40 then # _nwpage가 40보다 크다면
	set _bfpage = 39 * _to; # _bfpage를 39 * _to로 설정
	select '현재-합계' , # 가독성을 위해 가상 필드 생성
	sum(kor) as sumkor, # 국어 총합
	sum(eng) as sumeng, # 영어 총합
	sum(mat) as summat, # 수학 총합
	sum(kor+eng+mat) as sumsum, # 총합의 총합
	round(sum((kor+eng+mat)/3),1) as sumavg # 평균 총합
	from (select * from th_grade limit _bfpage, _to) as a # limit _bfpage, _to를 사용한 서브쿼리문 사용
	union all # union all : 2개 이상의 select문 결과를 합친다. 중복 포함
	select '현재-평균', # 가독성을 위해 가상 필드 생성
	floor(avg(kor)) as avgkor, # 국어 평균
	floor(avg(eng)) as avgeng, # 영어 평균
	floor(avg(mat)) as avgmat, # 수학 평균
	floor(avg(kor+eng+mat)) as avgsum, # 총점 평균
	round(avg((kor+eng+mat)/3),1) as avgavg # 평균의 평균
	from (select * from th_grade limit _bfpage, _to) as a; # limit _bfpage, _to를 사용한 서브쿼리문 사용
else
	set _bfpage = (_nwpage - 1) * _to; # _bfpage를 (_nwpage-1) * _to로 설정
    select '현재-합계' , # 가독성을 위해 가상 필드 생성
	sum(kor) as sumkor, # 국어 총합
	sum(eng) as sumeng, # 영어 총합
	sum(mat) as summat, # 수학 총합
	sum(kor+eng+mat) as sumsum, # 총합의 총합
	round(sum((kor+eng+mat)/3),1) as sumavg # 평균 총합
	from (select * from th_grade limit _bfpage, _to) as a # limit _bfpage, _to를 사용한 서브쿼리문 사용
	union all # union all : 2개 이상의 select문 결과를 합친다. 중복 포함
	select '현재-평균', # 가독성을 위해 가상 필드 생성
	floor(avg(kor)) as avgkor, # 국어 평균
	floor(avg(eng)) as avgeng, # 영어 평균
	floor(avg(mat)) as avgmat, # 수학 평균
	floor(avg(kor+eng+mat)) as avgsum, # 총점 평균
	round(avg((kor+eng+mat)/3),1) as avgavg # 평균의 평균
	from (select * from th_grade limit _bfpage, _to) as a; # limit _bfpage, _to를 사용한 서브쿼리문 사용
    end if; # if문 종료
end // # delimiter 끝
delimiter ;

call print_now(5, 25); # n번째 페이지의 현재 테이블 출력

-- print_tot() procedure 누적 테이블 생성
drop procedure if exists print_tot; # 있으면 지워라
delimiter //
create procedure print_tot(_nwpage integer, _to integer) # print_tot 프로시저 생성
begin # delimiter 시작
declare _bfpage integer; # integer 변수 _bfpage 생성
declare _topage integer; # integer 변수 _topage 생성
# _topage를 사용하는 이유 : 누적 테이블은 항상 1번째 값부터 값을 더하거나 평균을 구하기 때문에
# 기존에 쓰던 _bfpage를 사용해서 limit x,y의 y값을 구하기 위해 생성했다.

if _nwpage < 1 then # _nwpage가 1보다 작으면
set _topage = 0 + _to; # _topage = _to
	select '누적-합계' , # 가독성을 위한 가상 필드 생성
	sum(kor) as sumkor, # 국어 총합
	sum(eng) as sumeng, # 영어 총합
	sum(mat) as summat, # 수학 총합
	sum(kor+eng+mat) as sumsum, # 총합의 총합
	round(sum((kor+eng+mat)/3),1) as sumavg # 평균 총합
	from (select * from th_grade limit 0, _topage) as a # limit 0, _topage를 사용한 서브쿼리문 사용
	union all # union all : 2개 이상의 select문 결과를 합친다. 중복 포함
	select '누적-평균', # 가독성을 위한 가상 필드 생성
	floor(avg(kor)) as avgkor, # 국어 평균
	floor(avg(eng)) as avgeng, # 영어 평균
	floor(avg(mat)) as avgmat, # 수학 평균
	floor(avg(kor+eng+mat)) as avgsum, # 총점 평균
	round(avg((kor+eng+mat)/3),1) as avgavg # 평균의 평균
	from (select * from th_grade limit 0, _topage) as a; # limit 0, _topage를 사용한 서브쿼리문 사용
elseif _nwpage > 40 then # _nwpage가 40보다 크다면
set _bfpage = 39 * _to; # _bfpage = 39 * _to
set _topage = _bfpage + _to; # _topage = _bfpage + _to
	select '누적-합계' , # 가독성을 위한 가상 필드 생성
	sum(kor) as sumkor, # 국어 총합
	sum(eng) as sumeng, # 영어 총합
	sum(mat) as summat, # 수학 총합
	sum(kor+eng+mat) as sumsum, # 총합의 총합
	round(sum((kor+eng+mat)/3),1) as sumavg # 평균 총합
	from (select * from th_grade limit 0, _topage) as a # limit 0, _topage를 사용한 서브쿼리문 사용
	union all # union all : 2개 이상의 select문 결과를 합친다. 중복 포함
	select '누적-평균', # 가독성을 위한 가상 필드 생성
	floor(avg(kor)) as avgkor, # 국어 평균
	floor(avg(eng)) as avgeng, # 영어 평균
	floor(avg(mat)) as avgmat, # 수학 평균
	floor(avg(kor+eng+mat)) as avgsum, # 총점 평균
	round(avg((kor+eng+mat)/3),1) as avgavg # 평균의 평균
	from (select * from th_grade limit 0, _topage) as a; # limit 0, _topage를 사용한 서브쿼리문 사용
else
set _bfpage = (_nwpage - 1) * _to; # _bfpage = (_nwpage-1) * _to로 설정
set _topage = _bfpage + _to; # _topage = _bfpage + _to
    select '누적-합계' , # 가독성을 위한 가상 필드 생성
	sum(kor) as sumkor, # 국어 총합
	sum(eng) as sumeng, # 영어 총합
	sum(mat) as summat, # 수학 총합
	sum(kor+eng+mat) as sumsum, # 총합의 총합
	round(sum((kor+eng+mat)/3),1) as sumavg # 평균 총합
	from (select * from th_grade limit 0, _topage) as a # limit 0, _topage를 사용한 서브쿼리문 사용
	union all # union all : 2개 이상의 select문 결과를 합친다. 중복 포함
	select '누적-평균', # 가독성을 위한 가상 필드 생성
	floor(avg(kor)) as avgkor, # 국어 평균
	floor(avg(eng)) as avgeng, # 영어 평균
	floor(avg(mat)) as avgmat, # 수학 평균
	floor(avg(kor+eng+mat)) as avgsum, # 총점 평균
	round(avg((kor+eng+mat)/3),1) as avgavg # 평균의 평균
	from (select * from th_grade limit 0, _topage) as a; # limit 0, _topage를 사용한 서브쿼리문 사용
    end if; # if문 종료
end // # delimiter 종료
delimiter ;

call print_tot(5, 25); # n번째 페이지의 누적 테이블 출력