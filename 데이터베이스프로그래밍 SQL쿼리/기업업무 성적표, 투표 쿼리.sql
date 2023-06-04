use kopo10;
insert into kiho value (1, '김일돌');
insert into kiho value (2, '김이돌');
insert into kiho value (3, '김삼돌');
insert into kiho value (4, '김사돌');
select * from kiho;
desc kiho;
show tables;

drop table if exists voteTable; # 있으면 지워라
create table voteTable( # voteTable 생성
id int, # int id
age int);  # int age

select * from voteTable;
show tables;

drop table if exists tupyo;
create table tupyo( # 투표 테이블 생성
	id int, # int kiho
	age int, # int age
    foreign key(id) references kiho(id) # hubo테이블의 kiho와 연동되는 foreign key kiho
	on delete cascade);
select * from tupyo;
    
    SELECT a.id, a.name, (SELECT COUNT(b.id) FROM tupyo AS b WHERE a.id = b.id) AS 득표수,
    (SELECT ROUND((COUNT(b.id) / (SELECT COUNT(id) FROM tupyo) * 100), 2) 
    FROM tupyo AS b WHERE a.id = b.id) AS 득표율
    FROM kiho AS a;
    
SELECT id, age, COUNT(id) AS 득표수
FROM tupyo
WHERE id = 3
GROUP BY age;

SELECT age_range.age, COALESCE(t.vote_count, 0) AS 득표수,
       CASE WHEN COALESCE(t.vote_count, 0) = 0 THEN '0' ELSE 
           ROUND((COALESCE(t.vote_count, 0) / (SELECT COUNT(id) FROM tupyo WHERE id = 1) * 100), 2)
       END AS 득표율
FROM (
    SELECT '10대' AS age
    UNION ALL SELECT '20대' AS age
    UNION ALL SELECT '30대' AS age
    UNION ALL SELECT '40대' AS age
    UNION ALL SELECT '50대' AS age
    UNION ALL SELECT '60대' AS age
    UNION ALL SELECT '70대' AS age
    UNION ALL SELECT '80대' AS age
    UNION ALL SELECT '90대' AS age
) AS age_range
LEFT JOIN (
    SELECT age, COUNT(id) AS vote_count
    FROM tupyo
    WHERE id = 2
    GROUP BY age
) AS t ON age_range.age = t.age;

select studentid from anotherTwice;
select count(*) from anotherTwice;
select * from anotherTwice;
delete from anotherTwice;
drop table anotherTwice;
show tables;