package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class BasicTraining2 {

//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // basicTraining2 실습(1) - 테이블 생성
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//		
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//		
//		k10_stmt.execute("create table secondBasic" // secondBasic 테이블 생성
//					+"(studentid int not null primary key," // 학번 (PK)
//					+"name varchar(20), " // 이름
//		            +"kor int, " // 국어
//		            +"eng int, " // 영어
//		            +"mat int) " // 수학
//		            +"DEFAULT CHARSET=utf8;" // UTF-8로 default
//		             );
//		
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}
	
//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // basicTraining2 실습 (1) - drop table
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//	
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//	
//		k10_stmt.execute("drop table secondBasic;"); // secondBasic 테이블 통째로 삭제
//	
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}
	
//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // basicTraining2 실습 (2) - insert data
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//		int k10_kor, k10_eng, k10_mat, k10_studentid = 1; // int형 변수 국영수 생성 및 studentid = 1로 초기화 
//		
//		while(k10_studentid < 1001) {  // studentid가 1부터 1000까지 동작하는 반복문
//			k10_kor = (int)(Math.random()*100 + 1); // 국어점수 : 1 ~ 100 사이 정수
//			k10_eng = (int)(Math.random()*100 + 1); // 영어점수 : 1 ~ 100 사이 정수
//			k10_mat = (int)(Math.random()*100 + 1); // 수학점수 : 1 ~ 100 사이 정수
//			
//			String k10_name = "아무개" + Integer.toString(k10_studentid); // String형 변수 name -> 아무개1 ~ 아무개1000
//			
//			String k10_QueryTxt; // String타입 변수 QueryTxt 생성
//			
//			// Querytxt에 mysql 쿼리문 작성 후 저장 -> 각 column에 해당하는 String배열 field의 값을 인덱스 순으로 대입
//			k10_QueryTxt = String.format("insert into secondBasic"
//					+ "(studentid, name, kor, eng, mat)"
//					+ " values "
//					+ "(%d, '%s', %d, %d, %d);",
//					k10_studentid, k10_name, k10_kor, k10_eng, k10_mat);
//			k10_stmt.execute(k10_QueryTxt); // 쿼리문 실행
//			System.out.printf("%d번째 항목 insert OK [%s]\n", k10_studentid, k10_QueryTxt); // n번째 항목 insert OK [QueryTxt] 출력
//			
//			k10_studentid++; // LineCnt + 1 증가
//		}
//		
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}
	
//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // basicTraining2 실습(3) - 테이블 생성 (sum/avg column 추가)
//	Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//	// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//	// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//	Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//	
//	Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//	
//	k10_stmt.execute("create table secondBasic" // secondBasic 테이블 생성
//				+"(studentid int not null primary key," // 학번 (PK)
//				+"name varchar(20), " // 이름
//	            +"kor int, " // 국어
//	            +"eng int, " // 영어
//	            +"mat int, " // 수학
//				+"sum int, " // 총점
//				+"avg int) " // 평균
//	            +"DEFAULT CHARSET=utf8;" // UTF-8로 default
//	             );
//	
//	k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//	k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//}
	
//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // basicTraining2 실습 (3) - drop table
//	Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//	// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//	// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//	Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//
//	Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//
//	k10_stmt.execute("drop table secondBasic;"); // secondBasic 테이블 통째로 삭제
//
//	k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//	k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//}
	
//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // basicTraining2 실습 (3) - insert data (sum/avg 추가)
//	Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//	// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//	// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//	Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//
//	Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//	int k10_kor, k10_eng, k10_mat, k10_studentid = 1; // int형 변수 국영수 생성 및 studentid = 1로 초기화 
//	
//	while(k10_studentid < 1001) {  // studentid가 1부터 1000까지 동작하는 반복문
//		k10_kor = (int)(Math.random()*100 + 1); // 국어점수 : 1 ~ 100 사이 정수
//		k10_eng = (int)(Math.random()*100 + 1); // 영어점수 : 1 ~ 100 사이 정수
//		k10_mat = (int)(Math.random()*100 + 1); // 수학점수 : 1 ~ 100 사이 정수
//		
//		String k10_name = "아무개" + Integer.toString(k10_studentid); // String형 변수 name -> 아무개1 ~ 아무개1000
//		
//		String k10_QueryTxt; // String타입 변수 QueryTxt 생성
//		
//		// Querytxt에 mysql 쿼리문 작성 후 저장 -> 각 column에 해당하는 String배열 field의 값을 인덱스 순으로 대입
//		// sum, avg는 나중에 select 쿼리에서 계산할 예정이라서 입력하지 않음
//		k10_QueryTxt = String.format("insert into secondBasic"
//				+ "(studentid, name, kor, eng, mat)"
//				+ " values "
//				+ "(%d, '%s', %d, %d, %d);",
//				k10_studentid, k10_name, k10_kor, k10_eng, k10_mat);
//		k10_stmt.execute(k10_QueryTxt); // 쿼리문 실행
//		System.out.printf("%d번째 항목 insert OK [%s]\n", k10_studentid, k10_QueryTxt); // n번째 항목 insert OK [QueryTxt] 출력
//		
//		k10_studentid++; // LineCnt + 1 증가
//	}
//	
//	k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//	k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//}
	
	public static void main(String[] args) throws ClassNotFoundException, SQLException { // basicTraining2 실습 (3) - 30개씩 출력 및 총점/평균 구하기
		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
		Statement k10_stmt1 = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt1 생성
		Statement k10_stmt2 = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt2 생성
		Statement k10_stmt3 = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt3 생성
		Statement k10_stmt4 = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt4 생성
		Statement k10_stmt5 = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt5 생성
		// 객체를 여러 개 생성한 이유 -> 처음엔 한 개의 Statement로 다중 ResultSet을 사용했는데 Operation not allowed after ResultSet closed라는 에러가 나왔다.
		// 그래서 구글링을 해보았는데 다중 ResultSet을 사용할 때는 그에 해당하는 여러 개의 Statement를 생성해야한다고 나와있었다.
		
		String k10_QueryTxt1, k10_QueryTxt2, k10_QueryTxt3, k10_QueryTxt4, k10_QueryTxt5; // String타입 변수 QueryTxt 생성

		int k10_iCnt = 0; // int형 변수 iCnt 0으로 초기화
		
		while(k10_iCnt < 1000) { // iCnt가 1000보다 작을때 동작하는 반복문
			
			if (k10_iCnt % 30 == 0) printHead(k10_iCnt); // iCnt / 30의 나머지가 0일때 헤더 출력
			
			k10_QueryTxt1 = String.format("SELECT studentid, name, kor, eng, mat, (kor + eng + mat), FLOOR((kor + eng + mat)/3) FROM secondBasic"
					+ " limit %d, 30;", k10_iCnt); // 개인 별 성적, 총점, 평균 구하는 쿼리
			ResultSet k10_rset1 = k10_stmt1.executeQuery(k10_QueryTxt1); // QueryTxt1의 실행 결과를 ResultSet1에 저장
			
			while (k10_rset1.next()) { // rset1의 다음 행이 존재할 때 동작하는 반복문
				System.out.printf("%04d", k10_rset1.getInt(1)); // 학번 출력
				System.out.printf("%10s", k10_rset1.getString(2)); // 이름 출력
				System.out.printf("%7d", k10_rset1.getInt(3)); // 국어 출력
				System.out.printf("%7d", k10_rset1.getInt(4)); // 영어 출력
				System.out.printf("%7d", k10_rset1.getInt(5)); // 수학 출력
				System.out.printf("%8d", k10_rset1.getInt(6)); // 총점 출력
				System.out.printf("%6d\n", k10_rset1.getInt(7)); // 평균 출력
			}
			
			k10_QueryTxt2 = String.format("select sum(a.kor), sum(a.eng), sum(a.mat), sum(a.kor + a.eng + a.mat), sum((a.kor + a.eng + a.mat)/3)"
										+ " from (select * from secondBasic limit %d, 30) as a",k10_iCnt); // 현재 페이지의 합계 구하는 쿼리 작성
			k10_QueryTxt3 = String.format("select avg(b.kor), avg(b.eng), avg(b.mat), avg(b.kor + b.eng + b.mat), avg((b.kor + b.eng + b.mat)/3)"
										+ " from (select * from secondBasic limit %d, 30) as b",k10_iCnt); // 현재 페이지의 평균 구하는 쿼리 작성
			
			ResultSet k10_rset2 = k10_stmt2.executeQuery(k10_QueryTxt2); // QueryTxt2의 실행 결과를 ResultSet2에 저장
			ResultSet k10_rset3 = k10_stmt3.executeQuery(k10_QueryTxt3); // QueryTxt3의 실행 결과를 ResultSet3에 저장
			
			printCurrentPage(k10_rset2, k10_rset3); // 해당 Resultset 값들을 현재 페이지 합계, 평균 출력하는 메서드에 전달 
			
			k10_QueryTxt4 = String.format("select sum(c.kor), sum(c.eng), sum(c.mat), sum(c.kor + c.eng + c.mat), sum((c.kor + c.eng + c.mat)/3) "
										+ "from (select * from secondBasic limit 0, %d) as c", k10_iCnt + 30); // 누적 페이지의 합계 구하는 쿼리 작성
			k10_QueryTxt5 = String.format("select avg(d.kor), avg(d.eng), avg(d.mat), avg(d.kor + d.eng + d.mat), avg((d.kor + d.eng + d.mat)/3) "
					+ "from (select * from secondBasic limit 0, %d) as d", k10_iCnt + 30); // 누적 페이지의 평균 구하는 쿼리 작성
			
			ResultSet k10_rset4 = k10_stmt2.executeQuery(k10_QueryTxt4); // QueryTxt4의 실행 결과를 ResultSet4에 저장
			ResultSet k10_rset5 = k10_stmt3.executeQuery(k10_QueryTxt5); // QueryTxt5의 실행 결과를 ResultSet5에 저장
			
			printSumPage(k10_rset4, k10_rset5); // 해당 Resultset 값들을 누적 페이지 합계, 평균 출력하는 메서드에 전달
			
			k10_iCnt+=30; // iCnt 30씩 증가
		}
		
		k10_stmt1.close(); // 리소스 정리 -> 메모리 누수 방지
		k10_stmt2.close(); // 리소스 정리 -> 메모리 누수 방지
		k10_stmt3.close(); // 리소스 정리 -> 메모리 누수 방지
		k10_stmt4.close(); // 리소스 정리 -> 메모리 누수 방지
		k10_stmt5.close(); // 리소스 정리 -> 메모리 누수 방지
		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
	}
	
	public static void printHead(int k10_iCnt) { // 헤더 출력하는 메서드
		Calendar k10_calt = Calendar.getInstance(); // 달력 함수 선언
		SimpleDateFormat k10_sdt = new SimpleDateFormat("YYYY.MM.dd HH:mm:ss"); // SimpleDateFormat 함수 선언 

		System.out.printf("%28s\n", "성적집계표"); // 성적 집계표 출력
		System.out.printf("PAGE : %2d%27s출력일자 : %s\n", k10_iCnt/30 + 1, " ", k10_sdt.format(k10_calt.getTime())); // 페이지, 출력일자 
		System.out.printf("================================================================\n"); // 구분 선
		System.out.printf("%s%10s%8s%6s%6s%7s%6s\n", "학번", "이름", "국어", "영어", "수학", "총점", "평균"); // 카테고리
		System.out.printf("================================================================\n"); // 구분 선
	}
	
	public static void printCurrentPage(ResultSet k10_rset2, ResultSet k10_rset3) throws SQLException { // 현재 페이지 출력하는 메서드
		while (k10_rset2.next() && k10_rset3.next()) { // rset2, rset3의 다음 행이 존재할 때 동작하는 반복문
			System.out.printf("================================================================\n"); // 구분 선
			System.out.printf("현재페이지\n"); // 현재 페이지
			System.out.printf("합계");  // 합계
			System.out.printf("%12s%8d%7d%7d%8d%6d\n", " ", k10_rset2.getInt(1), k10_rset2.getInt(2), k10_rset2.getInt(3), 
															k10_rset2.getInt(4), k10_rset2.getInt(5)); // 합계 출력
			System.out.printf("평균"); // 평균
			System.out.printf("%12s%8d%7d%7d%8d%6d\n", " ", k10_rset3.getInt(1), k10_rset3.getInt(2),
										k10_rset3.getInt(3), k10_rset3.getInt(4), k10_rset3.getInt(5)); // 평균 출력
		}
	}
	
	public static void printSumPage(ResultSet k10_rset4, ResultSet k10_rset5) throws SQLException { // 누적 페이지 출력하는 메서드
		while (k10_rset4.next() && k10_rset5.next()) { // rset4, rset5의 다음 행이 존재할 때 동작하는 반복문
			System.out.printf("================================================================\n"); // 구분 선
			System.out.printf("누적페이지\n"); // 누적페이지
			System.out.printf("합계"); // 합계
			System.out.printf("%12s%8d%7d%7d%8d%6d\n", " ", k10_rset4.getInt(1), k10_rset4.getInt(2), k10_rset4.getInt(3), 
															k10_rset4.getInt(4), k10_rset4.getInt(5)); // 합계 출력
			System.out.printf("평균"); // 평균
			System.out.printf("%12s%8d%7d%7d%8d%6d\n\n", " ",  k10_rset5.getInt(1), k10_rset5.getInt(2), k10_rset5.getInt(3),
																k10_rset5.getInt(4), k10_rset5.getInt(5)); // 평균 출력
		}
	}
}