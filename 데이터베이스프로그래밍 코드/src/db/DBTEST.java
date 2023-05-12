package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBTEST {

//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // 기본 ResultSet 프로그램
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//		// show databases; 쿼리를 실행하기 위해 stmt.executeQuery를 호출하고 그 결과를 ResultSet에 저장한다
//		ResultSet k10_rset = k10_stmt.executeQuery("show databases;");
//		
//		while (k10_rset.next()) { // ResultSet이 있으면
//			System.out.println("값 : " + k10_rset.getString(1)); // ResultSet을 하나씩 가져와서 출력
//		}
//		k10_rset.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}

//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // 테이블 만들기
//		Class.forName("com.mysql.cj.jdbc.Driver");  // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//		
//		k10_stmt.execute(	"create table otherExamtable("
//				+ "name varchar(20), studentid int not null primary key, kor int, eng int, mat int)"
//				+ "DEFAULT CHARSET=utf8;"); // ResultSet이 의미없음 -> executeQuery -> execute
//		// 기존에 있는 테이블 examtable과 같은 형식인 테이블 otherExamtable 생성
//		
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}

//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // 테이블 지우기
//		Class.forName("com.mysql.cj.jdbc.Driver");  // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출 
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//		
//		k10_stmt.execute("delete from otherExamtable"); // 테이블의 형태는 그대로 두고 내부 데이터만 삭제
//		
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}

	public static void main(String[] args) throws ClassNotFoundException, SQLException { // 레코드 집어넣기
		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출  
		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
		
		// otherExamtable에 티아라 데이터 입력
		k10_stmt.execute("insert into otherExamtable (name, studentid, kor, eng, mat) values ('효민',209901,95,100,95);");
		k10_stmt.execute("insert into otherExamtable (name, studentid, kor, eng, mat) values ('보람',209902,95,95,95);");
		k10_stmt.execute("insert into otherExamtable (name, studentid, kor, eng, mat) values ('은정',209903,100,100,100);");
		k10_stmt.execute("insert into otherExamtable (name, studentid, kor, eng, mat) values ('지연',209904,100,95,90);");
		k10_stmt.execute("insert into otherExamtable (name, studentid, kor, eng, mat) values ('소연',209905,80,100,70);");
		k10_stmt.execute("insert into otherExamtable (name, studentid, kor, eng, mat) values ('큐리',209906,100,100,70);");
		k10_stmt.execute("insert into otherExamtable (name, studentid, kor, eng, mat) values ('화영',209907,70,70,70);");
		
		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
	}

//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // 테이블 읽기
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//		// otherExamtable의 전체 출력 결과를 ResultSet에 저장
//		ResultSet k10_rset = k10_stmt.executeQuery("select * from otherExamtable;");
//
//		System.out.printf("  이름   학번   국어 영어 수학\n"); // 이름 학번 국어 영어 수학 출력 후 개행
//		while (k10_rset.next()) { // ResultSet이 있으면
//			System.out.printf("%4s %6d %3d %3d %3d \n", k10_rset.getString(1), k10_rset.getInt(2), k10_rset.getInt(3),
//					k10_rset.getInt(4), k10_rset.getInt(5)); // 해당 값 String, int형태로 받아서 출력
//		}
//
//		k10_rset.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}
}
