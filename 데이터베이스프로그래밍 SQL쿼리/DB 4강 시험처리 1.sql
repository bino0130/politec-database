-- examtable 생성
drop table if exists examtable; # 있다면 지워라
create table examtable( # examtable 생성 
	name varchar(20), # varchar(20) name
    id int not null primary key, # int pk id
    kor int, eng int, mat int); # int kor, eng, mat
desc examtable; # examtable 구조 출력

drop procedure if exists insert_examtable; # 있다면 지워라
delimiter $$
create procedure insert_examtable(_last integer) #insert_examtable 프로시저 생성
begin # 시작
declare _name varchar(20); # varchar(20) 변수 _name 생성
declare _id integer; # integer 변수 _id 생성
declare _cnt integer; # integer 변수 _cnt 생성
set _cnt=0; # _cnt = 0으로 초기화
delete from examtable where id > 0; # id가 1 이상인 데이터 전부 삭제
	_loop : loop # 반복문
		set _cnt = _cnt + 1; # _cnt++
        set _name = concat("홍길", cast(_cnt as char(4)));
        # concat : 2개 이상의 문자열을 합치는 함수
        # cast : 데이터 타입을 바꿔주는 함수 (= 형변환 함수)
        set _id = 209900 + _cnt; # id = 209900 + _cnt
        
        insert into examtable value (_name, _id, rand()*100, rand()*100, rand()*100);
        # examtable에 _name, _id, 1~100 사이 정수 3번 입력
        
        if _cnt = _last then # 만약 _cnt가 입력받은 숫자와 같다면
			leave _loop; # break;
		end if; # if 종료
	end loop _loop; # 반복문 종료
end $$ # delimiter 종료
delimiter ;
call insert_examtable(1000); # insert_examtable 프로시저에 1000 대입
select * from examtable; # examtable 전체 데이터 출력

-- view
drop view if exists examview; # 있다면 지워라
create view examview(name,id,kor,eng,mat,sum,avg,ran) # examview 생성
as select *,  # 이름, 학번, 국어, 영어, 수학
	b.kor + b.eng + b.mat, # 총합
    (b.kor + b.eng + b.mat) / 3, #평균
    (select count(*) + 1 from examtable as a # examtable을 a로 정함
		where (a.kor + a. eng + a.mat) > (b.kor + b.eng + b.mat) ) #등수
	from examtable as b; # examtable을 b로 정함
    
select * from examview; # 출력 -> 된다
select name, ran from examview; # 특정 필드 출력 -> 된다
select * from examview where ran > 5; # 범위 지정 출력 -> 된다
insert into examview values ('test', 1,1,1,1,1,1,1); # view에 데이터 입력 -> 안된다

drop table if exists examtableEX; # 있으면 지워라
create table examtableEX( # examtableEX 테이블 생성
	name varchar(20), # varchar(20) name
    id int not null primary key, # int pk id
    kor int, eng int, mat int, sum int, avg double, ranking int); # int kor,eng,mat,sum,avg,ranking
desc examtableEX; # examtableEX 구조 출력

insert into examtableEX # examtableEX에 데이터 입력
	select *, b.kor + b.eng + b.mat, (b.kor + b.eng + b.mat) / 3,
    (select count(*) + 1 from examtable as a where (a.kor + a.eng + a.mat) > (b.kor + b.eng + b.mat))
    from examtable as b; # insert 안에 select를 사용해서 examtableEX에 데이터 입력하기
    
select * from examtableEX order by ranking desc; # ranking의 역순을 기준으로 examtableEX 데이터 출력


-- 정답테이블 생성
drop table if exists answer; # 있으면 지워라
create table answer ( # 정답 테이블 생성
subjectID int not null primary key,
a01 int, a02 int, a03 int, a04 int, a05 int, a06 int, a07 int, a08 int, a09 int, a10 int,
a11 int, a12 int, a13 int, a14 int, a15 int, a16 int, a17 int, a18 int, a19 int, a20 int
);

-- 시험테이블 생성
drop table if exists testing; # 있으면 지워라
create table testing ( # 시험 테이블 생성
subjectID int not null,
stu_name varchar(20),
stu_id int not null,
a01 int, a02 int, a03 int, a04 int, a05 int, a06 int, a07 int, a08 int, a09 int, a10 int,
a11 int, a12 int, a13 int, a14 int, a15 int, a16 int, a17 int, a18 int, a19 int, a20 int,
primary key(subjectID, stu_id) # 과목코드, 학번 PK
);

-- 채점테이블 생성
drop table if exists scoring; # 있으면 지워라
create table scoring( # 채점 테이블 생성
subjectID int not null,
stu_name varchar(20),
stu_id int not null,
a01 int, a02 int, a03 int, a04 int, a05 int, a06 int, a07 int, a08 int, a09 int, a10 int,
a11 int, a12 int, a13 int, a14 int, a15 int, a16 int, a17 int, a18 int, a19 int, a20 int,
score int,
primary key(subjectID, stu_id) # 과목코드, 학번 PK
);

-- 채점리포트테이블 생성
drop table if exists report; # 있으면 지워라
create table report(
stu_name varchar(20),
stu_id int not null primary key, # 학번 PK
kor int, eng int, mat int
);

desc answer; -- 정답지
desc testing; -- 학생 시험지
desc scoring; -- 채점 결과
desc report; -- 한 반의 시험결과