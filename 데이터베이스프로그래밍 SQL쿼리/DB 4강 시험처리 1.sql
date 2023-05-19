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