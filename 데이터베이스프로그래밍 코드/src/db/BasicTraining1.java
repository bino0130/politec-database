package db;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class BasicTraining1 {

//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // basicTraining 실습 (1) - create table
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//		
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//		
//		k10_stmt.execute("create table firstBasic(" // firstBasic 테이블 생성
//				+ "id int not null," // ID
//				 +"manage_office   varchar(50), " // 관리기관명
//		            +"addr_road varchar(200), " // 도로명주소
//		            +"addr_land varchar(200), " // 지번주소
//		            +"install_purpose varchar(50), " // 설치목적
//		            +"camera_num int, " // 카메라 대수
//		            +"camera_pixel int, " // 카메라 화소
//		            +"film_information varchar(100), " // 촬영전방정보
//		            +"storage_days int, " // 보관일수
//		            +"install_date date, " // 설치년월
//		            +"office_number varchar(50), " // 관리 기관 전화번호
//		            +"latitude double, " // 위도
//		            +"longitude double, " // 경도
//		            +"write_date date not null," // 데이터 기준일자
//		            +"primary key (id, write_date)" // id와 데이터 기준일자를 복합 primary key로 지정
//		            +") DEFAULT CHARSET=utf8;" // UTF-8로 default
//		             );
//		
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}
	
//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // basicTraining 실습 (1) - drop table
//	Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//	// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//	// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//	Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//	
//	Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//	
//	k10_stmt.execute("drop table firstBasic;"); // firstBasic 테이블 통째로 삭제
//	
//	k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//	k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//}
	
//	public static void main(String[] args) throws ClassNotFoundException, SQLException, IOException { // basicTraining 실습 (1) - insert data
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//
//		// 바탕화면의 전국cctv표준데이터를 경로로하는 파일 객체 f 생성
//		File k10_f = new File("C:\\Users\\Bino\\Desktop\\전국cctv표준데이터.txt");
//		BufferedReader k10_br = new BufferedReader(new FileReader(k10_f)); // 생성한 객체 f 를 읽어주는 buffereader 객체 br 생성
//
//		String k10_readtxt; // String타입 변수 readtxt 생성
//		if ((k10_readtxt = k10_br.readLine()) == null) { // readtxt를 읽은 값이 null이면
//			System.out.printf("빈 파일입니다\n"); // 빈 파일입니다라고 출력
//			return; // 리턴
//		}
//		String[] k10_field_name = k10_readtxt.split("\t"); // readtxt를 탭을 기준으로 나눈 String타입 배열 field_name 생성
//
//		int k10_LineCnt = 0; // int형 변수 LineCnt = 0으로 초기화
//		while ((k10_readtxt = k10_br.readLine()) != null) { // readtxt를 읽은 값이 null이 아니면
//			String[] k10_field = k10_readtxt.split("\t"); // readtxt를 탭으로 구분한 String배열 field 생성
//			String k10_QueryTxt; // String타입 변수 QueryTxt 생성
//			
//			// Querytxt에 mysql 쿼리문 작성 후 저장 -> 각 column에 해당하는 String배열 field의 값을 인덱스 순으로 대입
//			k10_QueryTxt = String.format("insert into firstBasic("
//					+ "id, manage_office, addr_road, addr_land, install_purpose," 
//					+ "camera_num, camera_pixel, film_information, storage_days, install_date,"
//					+ "office_number, latitude, longitude, write_date)"
//					+ "values ("
//					+ "'%s', '%s', '%s', '%s', '%s',"
//					+ "'%s', '%s', '%s', '%s', '%s',"
//					+ "'%s', '%s', '%s', '%s');",
//					k10_field[0], k10_field[1], k10_field[2], k10_field[3], k10_field[4],
//					k10_field[5], k10_field[6], k10_field[7], k10_field[8], k10_field[9],
//					k10_field[10], k10_field[11], k10_field[12], k10_field[13]);
//			k10_stmt.execute(k10_QueryTxt);
//			System.out.printf("%d번째 항목 insert OK [%s]\n",k10_LineCnt,k10_QueryTxt); // n번째 항목 insert OK [QueryTxt] 출력
//			k10_LineCnt++; // LineCnt + 1 증가
//		}
//		k10_br.close(); // 리소스 정리 -> 메모리 누수 방지
//		
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}
	
	public static void main(String[] args) throws ClassNotFoundException, SQLException, IOException { // basicTraining 실습 (1) - 가장 가까운 거리, where
		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");

		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
		
		double k10_lat = 37.3860521; // 나의 현재 위도 37.386...으로 설정
		double k10_lng = 127.1214038; // 나의 현재 경도 127.121...으로 설정

		String k10_QueryTxt; // String타입 변수 QueryTxt 생성
//		k10_QueryTxt = String.format("select * from firstBasic where "
//								+ "SQRT(POWER(latitude-%f , 2) + POWER(longitude-%f , 2)) = "
//								+ "(select MIN( SQRT( POWER( latitude-%f , 2 ) + POWER (longitude-%f, 2) ) ) from firstBasic);",
//								k10_lat, k10_lng, k10_lat, k10_lng);
		// 가장 거리가 가까운 곳 찾는 쿼리문 QueryTxt에 작성

//		k10_QueryTxt = "select * from firstBasic";
		// freewifi 전체 데이터를 출력하는 쿼리문 QueryTxt에 작성
		
// 		k10_QueryTxt = "select * from firstBasic where camera_pixel=42";
		// freewifi 데이터 중 카메라 화소가 42인 row를 출력하는 쿼리문 QueryTxt에 작성

		k10_QueryTxt = "select * from firstBasic where storage_days=20";
		// freewifi 데이터 중 보관일수가 20일인 row를 출력하는 쿼리문 QueryTxt에 작성

		ResultSet k10_rset = k10_stmt.executeQuery(k10_QueryTxt); // QueryTxt의 실행 결과를 ResultSet에 저장
		int k10_iCnt = 0; // int형 변수 iCnt 0으로 초기화
		while (k10_rset.next()) { // rset이 있으면
			System.out.printf("*(%d)*************************************\n\n", k10_iCnt++); // n번째 순서 출력하는 별찍기
			System.out.printf("id : %s\n", k10_rset.getString(1)); // id 출력
			System.out.printf("관리기관명 : %s\n", k10_rset.getString(2)); // 관리기관명 출력
			System.out.printf("도로명주소 : %s\n", k10_rset.getString(3)); // 도로명주소 출력
			System.out.printf("지번주소 : %s\n", k10_rset.getString(4)); // 지번주소 출력
			System.out.printf("설치목적 : %s\n", k10_rset.getString(5)); // 설치목적 출력
			System.out.printf("카메라 대수 : %s\n", k10_rset.getString(6)); // 카메라 대수 출력
			System.out.printf("카메라 화소 : %s\n", k10_rset.getString(7)); // 카메라 화소 출력
			System.out.printf("촬영전방정보 : %s\n", k10_rset.getString(8)); // 촬영전방정보 출력
			System.out.printf("보관일수 : %s\n", k10_rset.getString(9)); // 보관일수 출력
			System.out.printf("설치년월 : %s\n", k10_rset.getDate(10)); // 설치년월 출력
			System.out.printf("관리기관 전화번호 : %s\n", k10_rset.getString(11)); // 관리기관 전화번호 출력
			System.out.printf("위도 : %f\n", k10_rset.getFloat(12)); // 위도 출력
			System.out.printf("경도 : %f\n", k10_rset.getFloat(13)); // 경도 출력
			System.out.printf("데이터기준일자 : %s\n", k10_rset.getDate(14)); // 데이터기준일자 출력
			System.out.printf("*********************************************\n"); // 별찍기
		}
		
		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
	}
}
