-- 채점 테이블 scoring insert
delete from scoring where subjectID < 4; # 있으면 지워라
   INSERT INTO scoring # insert 안에 select문을 사용해서 데이터 입력
   SELECT
      t.subjectID, t.stu_name, t.stu_id,
      if(t.a01 = a.a01, 1, 0) AS s01, if(t.a02 = a.a02, 1, 0) AS s02,  if(t.a03 = a.a03, 1, 0) AS s03, if(t.a04 = a.a04, 1, 0) AS s04, if(t.a05 = a.a05, 1, 0) AS s05,
      if(t.a06 = a.a06, 1, 0) AS s06, if(t.a07 = a.a07, 1, 0) AS s07,  if(t.a08 = a.a08, 1, 0) AS s08, if(t.a09 = a.a09, 1, 0) AS s09, if(t.a10 = a.a10, 1, 0) AS s10,
      if(t.a11 = a.a11, 1, 0) AS s11, if(t.a12 = a.a12, 1, 0) AS s12,  if(t.a13 = a.a13, 1, 0) AS s13, if(t.a14 = a.a14, 1, 0) AS s14, if(t.a15 = a.a15, 1, 0) AS s15,
      if(t.a16 = a.a16, 1, 0) AS s16, if(t.a17 = a.a17, 1, 0) AS s17,  if(t.a18 = a.a18, 1, 0) AS s18, if(t.a19 = a.a19, 1, 0) AS s19, if(t.a20 = a.a20, 1, 0) AS s20,
	  # a01 ~ a20의 답이 맞으면 1, 틀리면 0 입력
        
      ((t.a01 = a.a01) + (t.a02 = a.a02) + (t.a03 = a.a03) + (t.a04 = a.a04) + (t.a05 = a.a05) +
      (t.a06 = a.a06) + (t.a07 = a.a07) + (t.a08 = a.a08) + (t.a09 = a.a09) + (t.a10 = a.a10) +
      (t.a11 = a.a11) + (t.a12 = a.a12) + (t.a13 = a.a13) + (t.a14 = a.a14) + (t.a15 = a.a15) +
      (t.a16 = a.a16) + (t.a17 = a.a17) + (t.a18 = a.a18) + (t.a19 = a.a19) + (t.a20 = a.a20)) AS sum
      # a01 ~ a20의 채점결과 총합을 sum으로 정의
   FROM testing AS t, answer AS a # testing을 t, answer를 a로 정의
   WHERE t.subjectID = a.subjectID; # t.subjectID와 a.subjectID가 같은 상태에서
    
    select * from scoring; # 시험 테이블 데이터 출력
    select count(*) from scoring; # 데이터 개수 출력

-- 리포트 테이블 insert (stu_name, stu_id(PK), kor, eng, mat)
delete from report where stu_id > 0; # 있으면 지워라
INSERT INTO report (stu_name, stu_id, kor, eng, mat) # insert 안에 select문을 사용해서 데이터 입력
SELECT distinct s.stu_name, s.stu_id, s1.score * 5, s2.score * 5, s3.score * 5 # 한 문제당 5점이므로 과목 점수 * 5
FROM scoring as s, scoring as s1, scoring as s2, scoring as s3 # join으로 자기 자신을 여러번 참조
WHERE s.stu_id = s1.stu_id and s.stu_id = s2.stu_id and s.stu_id = s3.stu_id and 
s1.subjectID = 1 and s2.subjectID = 2 and s3.subjectID = 3; # 과목코드가 1,2,3이고 학번이 일치한 경우
select * from report; # 리포트 테이블 전체 데이터 출력

-- 합계, 평균, 등수 추가로 출력
select stu_name, stu_id, kor, eng, mat, kor + eng + mat as sum , (kor + eng + mat) / 3 as avg , 
(select count(*) + 1 from report as r1 where r1.kor+r1.eng+r1.mat > r.kor + r.eng + r.mat) as rnk 
from report as r order by rnk; # 3 과목의 합을 sum, 합/3을 avg, 랭킹 추가해서 다시 출력

-- 국어 문제별 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a01=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a01=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a01 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a02=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a02=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a02 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a03=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a03=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a03 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a04=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a04=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a04 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a05=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a05=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a05 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a06=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a06=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a06 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a07=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a07=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a07 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a08=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a08=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a08 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a09=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a09=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a09 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a10=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a10=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a10 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a11=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a11=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a11 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a12=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a12=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a12 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a13=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a13=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a13 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a14=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a14=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a14 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a15=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a15=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a15 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a16=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a16=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a16 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a17=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a17=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a17 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a18=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a18=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a18 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a19=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a19=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a19 득점자수, 득점률
select (select count(*) from scoring where subjectID=1 and a20=1) as 득점자수, (select count(*) from scoring 
where subjectID=1 and a20=1)/count(*) * 100 as 득점률 from scoring where subjectID=1; # 국어 a20 득점자수, 득점률

-- 영어 문제별 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a01=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a01=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a01 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a02=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a02=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a02 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a03=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a03=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a03 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a04=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a04=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a04 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a05=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a05=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a05 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a06=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a06=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a06 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a07=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a07=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a07 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a08=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a08=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a08 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a09=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a09=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a09 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a10=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a10=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a10 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a11=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a11=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a11 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a12=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a12=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a12 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a13=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a13=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a13 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a14=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a14=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a14 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a15=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a15=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a15 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a16=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a16=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a16 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a17=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a17=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a17 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a18=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a18=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a18 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a19=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a19=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a19 득점자수, 득점률
select (select count(*) from scoring where subjectID=2 and a20=1) as 득점자수, (select count(*) from scoring 
where subjectID=2 and a20=1)/count(*) * 100 as 득점률 from scoring where subjectID=2; # 영어 a20 득점자수, 득점률

-- 수학 문제별 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a01=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a01=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a01 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a02=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a02=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a02 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a03=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a03=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a03 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a04=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a04=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a04 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a05=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a05=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a05 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a06=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a06=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a06 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a07=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a07=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a07 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a08=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a08=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a08 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a09=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a09=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a09 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a10=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a10=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a10 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a11=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a11=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a11 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a12=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a12=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a12 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a13=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a13=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a13 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a14=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a14=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a14 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a15=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a15=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a15 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a16=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a16=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a16 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a17=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a17=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a17 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a18=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a18=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a18 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a19=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a19=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a19 득점자수, 득점률
select (select count(*) from scoring where subjectID=3 and a20=1) as 득점자수, (select count(*) from scoring 
where subjectID=3 and a20=1)/count(*) * 100 as 득점률 from scoring where subjectID=3; # 수학 a20 득점자수, 득점률