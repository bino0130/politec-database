-- examtable 생성
drop table if exists examtable;
create table examtable(
	name varchar(20),
    id int not null primary key,
    kor int, eng int, mat int);
desc examtable;

drop procedure if exists insert_examtable;
delimiter $$
create procedure insert_examtable(_last integer)
begin
declare _name varchar(20);
declare _id integer;
declare _cnt integer;
set _cnt=0;
delete from examtable where id > 0;
	_loop : loop
		set _cnt = _cnt + 1;
        set _name = concat("홍길", cast(_cnt as char(4)));
        set _id = 209900 + _cnt;
        
        insert into examtable value (_name, _id, rand()*100, rand()*100, rand()*100);
        
        if _cnt = _last then
			leave _loop;
		end if;
	end loop _loop;
end $$
delimiter ;

call insert_examtable(1000);
select * from examtable;

-- view
drop view if exists examview;
create view examview(name,id,kor,eng,mat,sum,avg,ran)
as select *,
	b.kor + b.eng + b.mat,
    (b.kor + b.eng + b.mat) / 3, #평균
    (select count(*) + 1 from examtable as a 
		where (a.kor + a. eng + a.mat) > (b.kor + b.eng + b.mat) ) #등수
	from examtable as b;
    
select * from examview;
select name, ran from examview;
select * from examview where ran > 5;
insert into examview values ('test', 1,1,1,1,1,1,1); # view에는 데이터를 insert 할 수 없음

drop table if exists examtableEX;
create table examtableEX(
	name varchar(20),
    id int not null primary key,
    kor int, eng int, mat int, sum int, avg double, ranking int);
desc examtableEX;

insert into examtableEX
	select *, b.kor + b.eng + b.mat, (b.kor + b.eng + b.mat) / 3,
    (select count(*) + 1 from examtable as a where (a.kor + a.eng + a.mat) > (b.kor + b.eng + b.mat))
    from examtable as b;
    
select * from examtableEX order by ranking desc;

-- 정답테이블 생성
drop table if exists answer;
create table answer (
subjectID int not null primary key,
a01 int, a02 int, a03 int, a04 int, a05 int, a06 int, a07 int, a08 int, a09 int, a10 int,
a11 int, a12 int, a13 int, a14 int, a15 int, a16 int, a17 int, a18 int, a19 int, a20 int
);

-- 시험테이블 생성
drop table if exists testing;
create table testing (
subjectID int not null,
stu_name varchar(20),
stu_id int not null,
a01 int, a02 int, a03 int, a04 int, a05 int, a06 int, a07 int, a08 int, a09 int, a10 int,
a11 int, a12 int, a13 int, a14 int, a15 int, a16 int, a17 int, a18 int, a19 int, a20 int,
primary key(subjectID, stu_id)
);

-- 채점테이블 생성
drop table if exists scoring;
create table scoring(
subjectID int not null,
stu_name varchar(20),
stu_id int not null,
a01 int, a02 int, a03 int, a04 int, a05 int, a06 int, a07 int, a08 int, a09 int, a10 int,
a11 int, a12 int, a13 int, a14 int, a15 int, a16 int, a17 int, a18 int, a19 int, a20 int,
score int,
primary key(subjectID, stu_id)
);

-- 채점리포트테이블 생성
drop table if exists report;
create table report(
stu_name varchar(20),
stu_id int not null primary key,
kor int, eng int, mat int
);

desc answer; -- 정답지
desc testing; -- 학생 시험지
desc scoring; -- 채점 결과
desc report; -- 한 반의 시험결과