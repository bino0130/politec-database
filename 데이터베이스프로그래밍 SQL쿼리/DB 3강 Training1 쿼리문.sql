-- Training(1)
use kopo10;
drop table if exists th_grade;
create table th_grade(
	id int not null primary key,
    name varchar(10),
    kor int,
    eng int,
    mat int,
    sum int,
    avg double);

-- 테이블에 값 insert
drop procedure if exists tr1;
delimiter $$
create procedure tr1(_last integer)
begin
declare _name varchar(10);
declare _id integer;
declare _cnt integer;
declare _kor integer;
declare _eng integer;
declare _mat integer;
declare _sum integer;
declare _avg float;

set _cnt=0;

delete from th_grade where id > 0;
	_loop : loop
		set _cnt = _cnt + 1;
        set _name = concat("홍길", cast(_cnt as char(4)));
        set _id = _cnt;
        set _kor = floor(rand()*100) + 1;
        set _eng = floor(rand()*100) + 1;
        set _mat = floor(rand()*100) + 1;
        set _sum = _kor + _eng + _mat;
        set _avg = _sum / 3;
        
        insert into th_grade value (_id, _name, _kor, _eng, _mat, _sum, _avg);
        
        if _cnt = _last then
			leave _loop;
		end if;
	end loop _loop;
end $$
delimiter ;

call tr1(1000);
select * from th_grade;

-- print_report() procedure 내용 테이블 생성
drop procedure if exists print_report;
delimiter //
create procedure print_report(_nwpage integer, _to integer)
begin
declare _bfpage integer;

if _nwpage < 1 then
    select * from th_grade limit 0, _to;
elseif _nwpage > 40 then
	set _bfpage = 39 * _to;
	select * from th_grade limit _bfpage, _to;
else
	set _bfpage = (_nwpage -1) * _to;
    select * from th_grade limit _bfpage, _to;
    end if;
end //
delimiter ;

call print_report(4, 25);

-- print_now() procedure 현재 테이블 생성
create table now_table(
	sumkor int,
	sumeng int,
	summat int,
	sumsum int,
	sumavg double,
	avgkor double,
	avgeng double,
	avgmat double,
	avgsum double,
	avgavg double);
drop procedure if exists print_now;
delimiter //
create procedure print_now(_nwpage integer, _to integer)
begin
declare _bfpage integer;
delete from now_table;
set _bfpage = 0;

select * from now_table;
end//
delimiter ;
call print_now(5,25);
select count(*) now_table;
select * from now_table;
delete from now_table;
select
	sum(t.kor), sum(t.eng), sum(t.mat), sum(t.sum), sum(t.avg),
	avg(t.kor), avg(t.eng), avg(t.mat), avg(t.sum), avg(t.avg)
	from th_grade as t;
    
select sum(kor) over() from th_grade limit 75,25;
SELECT
    SUM(kor) AS total_sum,
    AVG(kor) AS total_avg
FROM (
    SELECT 
    FROM th_grade as t
) AS subquery
WHERE t BETWEEN 75 AND 100;
