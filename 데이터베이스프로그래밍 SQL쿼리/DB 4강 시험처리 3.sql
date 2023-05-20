-- 채점 테이블 scoring insert
use kopo10;
delete from scoring where subjectID < 4;
   INSERT INTO scoring
   SELECT
      t.subjectID, t.stu_name, t.stu_id,
      if(t.a01 = a.a01, 1, 0) AS s01, if(t.a02 = a.a02, 1, 0) AS s02,  if(t.a03 = a.a03, 1, 0) AS s03, if(t.a04 = a.a04, 1, 0) AS s04, if(t.a05 = a.a05, 1, 0) AS s05,
      if(t.a06 = a.a06, 1, 0) AS s06, if(t.a07 = a.a07, 1, 0) AS s07,  if(t.a08 = a.a08, 1, 0) AS s08, if(t.a09 = a.a09, 1, 0) AS s09, if(t.a10 = a.a10, 1, 0) AS s10,
      if(t.a11 = a.a11, 1, 0) AS s11, if(t.a12 = a.a12, 1, 0) AS s12,  if(t.a13 = a.a13, 1, 0) AS s13, if(t.a14 = a.a14, 1, 0) AS s14, if(t.a15 = a.a15, 1, 0) AS s15,
      if(t.a16 = a.a16, 1, 0) AS s16, if(t.a17 = a.a17, 1, 0) AS s17,  if(t.a18 = a.a18, 1, 0) AS s18, if(t.a19 = a.a19, 1, 0) AS s19, if(t.a20 = a.a20, 1, 0) AS s20,

      ((t.a01 = a.a01) + (t.a02 = a.a02) + (t.a03 = a.a03) + (t.a04 = a.a04) + (t.a05 = a.a05) +
      (t.a06 = a.a06) + (t.a07 = a.a07) + (t.a08 = a.a08) + (t.a09 = a.a09) + (t.a10 = a.a10) +
      (t.a11 = a.a11) + (t.a12 = a.a12) + (t.a13 = a.a13) + (t.a14 = a.a14) + (t.a15 = a.a15) +
      (t.a16 = a.a16) + (t.a17 = a.a17) + (t.a18 = a.a18) + (t.a19 = a.a19) + (t.a20 = a.a20)) AS sum
   FROM testing AS t, answer AS a
   WHERE t.subjectID = a.subjectID;
    
    select * from scoring;
    select count(*) from scoring;

-- 채점결과 테이블 insert (stu_name, stu_id(PK), kor, eng, mat)
delete from report where stu_id > 0;
INSERT INTO report (stu_id) # report 테이블에 stu_id(학번) 먼저 입력
SELECT DISTINCT stu_id
FROM scoring;
select * from report;

INSERT INTO report (stu_name, kor, eng, mat) # 
SELECT s1.stu_name, s1.score * 5, s2.score * 5, s3.score * 5
FROM scoring as s, scoring as s1, scoring as s2, scoring as s3, report as r
WHERE s.stu_id = r.stu_id and (s1.subjectID = 1 or s2.subjectID = 2 or s3.subjectID = 3);
select count(*) from report;