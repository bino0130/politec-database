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

public class FreeWifi {

//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // freewifi(2) - create table date 형식, 복합 키 추가
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//		
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//		
//		k10_stmt.execute("create table freewifi("
//				+ "id int not null," // ID
//				 +"inst_place   varchar(50), " // 설치장소명
//		            +"inst_place_detail   varchar(50), " // 설치 장소상세
//		            +"inst_city   varchar(50), " // 설치 시도명
//		            +"inst_country   varchar(50), " // 설치 시군구명
//		            +"inst_place_flag   varchar(50), " // 설치 시설구분
//		            +"service_provider   varchar(50), " // 서비스 제공사명
//		            +"wifi_ssid   varchar(50), " // 와이파이 SSID
//		            +"inst_date   date null, " // 설치년월(정제해야할 정보)
//		            +"place_addr_road   varchar(200), " // 소재지 도로명 주소
//		            +"place_addr_land   varchar(200), " // 소재지 지번 주소
//		            +"manage_office   varchar(50), " // 관리 기관명
//		            +"manage_office_phone   varchar(50), " // 관리 기관 전화번호
//		            +"latitude   double, " // 위도
//		            +"longitude   double, " // 경도
//		            +"write_date   date not null," // 데이터 기준일자
//		            +"primary key (id, write_date)" // id와 데이터 기준일자를 복합 primary key로 지정
//		            +") DEFAULT CHARSET=utf8;" // UTF-8로 default
//		             );
//		
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}

//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // freewifi(1) - create table
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//		
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//		
//		k10_stmt.execute("create table freewifi("
//				 +"inst_place   varchar(50), " // 설치장소명
//		            +"inst_place_detail   varchar(50), " // 설치 장소상세
//		            +"inst_city   varchar(50), " // 설치 시도명
//		            +"inst_country   varchar(50), " // 설치 시군구명
//		            +"inst_place_flag   varchar(50), " // 설치 시설구분
//		            +"service_provider   varchar(50), " // 서비스 제공사명
//		            +"wifi_ssid   varchar(50), " // 와이파이 SSID
//		            +"inst_date   date null, " // 설치년월(정제해야할 정보)
//		            +"place_addr_road   varchar(200), " // 소재지 도로명 주소
//		            +"place_addr_land   varchar(200), " // 소재지 지번 주소
//		            +"manage_office   varchar(50), " // 관리 기관명
//		            +"manage_office_phone   varchar(50), " // 관리 기관 전화번호
//		            +"latitude   double, " // 위도
//		            +"longitude   double, " // 경도
//		            +"write_date   date" // 데이터 기준일자
//		            +") DEFAULT CHARSET=utf8;" // UTF-8로 default
//		             );
//		
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}

//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // freewifi(1) - drop table
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//		
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//		
//		k10_stmt.execute("drop table freewifi;"); // freewifi 테이블 통째로 삭제
//		
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}

//	public static void main(String[] args) throws ClassNotFoundException, SQLException, IOException { // freewifi(2) - 데이터 insert
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");
//		
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//		
//		// 바탕화면의 전국무료와이파이표준데이터를 경로로하는 파일 객체 f 생성
//		File k10_f = new File("C:\\Users\\Bino\\Desktop\\전국무료와이파이표준데이터.txt");
//		BufferedReader k10_br = new BufferedReader(new FileReader(k10_f)); // 생성한 객체 f 를 읽어주는 buffereader 객체 br 생성
//		
//		String k10_readtxt; // String타입 변수 readtxt 생성
//		if((k10_readtxt = k10_br.readLine()) == null) { // readtxt를 읽은 값이 null이면
//			System.out.printf("빈 파일입니다\n"); // 빈 파일입니다라고 출력
//			return; // 리턴
//		}
//		String[] k10_field_name = k10_readtxt.split("\t"); // readtxt를 탭을 기준으로 나눈 String타입 배열 field_name 생성 
//		
//		int k10_LineCnt = 0; // int형 변수 LineCnt = 0으로 초기화
//		while((k10_readtxt = k10_br.readLine()) != null) { // readtxt를 읽은 값이 null이 아니면
//			String[] k10_field = k10_readtxt.split("\t"); // readtxt를 탭으로 구분한 String배열 field 생성
//			String k10_QueryTxt; // String타입 변수 QueryTxt 생성
//			
//			// Querytxt에 mysql 쿼리문 작성 후 저장 -> 각 column에 해당하는 String배열 field의 값을 인덱스 순으로 대입
//			k10_QueryTxt = String.format("insert into freewifi("
//					+ "id, inst_place, inst_place_detail, inst_city, inst_country, inst_place_flag," 
//					+ "service_provider, wifi_ssid, inst_date, place_addr_road, place_addr_land,"
//					+ "manage_office, manage_office_phone, latitude, longitude, write_date)"
//					+ "values ("
//					+ "'%s', '%s', '%s', '%s', '%s', '%s',"
//					+ "'%s', '%s', '%s', '%s', '%s',"
//					+ "'%s', '%s', '%s', '%s', '%s');",
//					k10_field[0], k10_field[1], k10_field[2], k10_field[3], k10_field[4], k10_field[5], 
//					k10_field[6], k10_field[7], k10_field[8], k10_field[9], k10_field[10],
//					k10_field[11], k10_field[12], k10_field[13], k10_field[14], k10_field[15]);
//			k10_stmt.execute(k10_QueryTxt); // 쿼리문 실행
//			System.out.printf("%d번째 항목 insert OK [%s]\n",k10_LineCnt,k10_QueryTxt); // n번째 항목 insert OK [QueryTxt] 출력
//			
//			k10_LineCnt++; // LineCnt + 1 증가
//		}
//		k10_br.close(); // 리소스 정리 -> 메모리 누수 방지
//		
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}

	public static void main(String[] args) throws ClassNotFoundException, SQLException, IOException { // free wifi(3) 실습
		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
		// 192.168.23.59 : MySQL 서버 IP주소, 33060 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33060/kopo10", "root", "kopoctc");

		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
		
		double k10_lat = 37.3860521; // 나의 현재 위도 37.386...으로 설정
		double k10_lng = 127.1214038; // 나의 현재 경도 127.121...으로 설정

		String k10_QueryTxt; // String타입 변수 QueryTxt 생성
//		k10_QueryTxt = String.format("select * from freewifi where "
//								+ "SQRT(POWER(latitude-%f , 2) + POWER(longitude-%f , 2)) = "
//								+ "(select MIN( SQRT( POWER( latitude-%f , 2 ) + POWER (longitude-%f, 2) ) ) from freewifi);",
//								k10_lat, k10_lng, k10_lat, k10_lng);
		// 가장 거리가 가까운 곳 찾는 쿼리문 QueryTxt에 작성

		k10_QueryTxt = "select * from freewifi";
		// freewifi 전체 데이터를 출력하는 쿼리문 QueryTxt에 작성
		
// 		k10_QueryTxt = "select * from freewifi where service_provider='SKT'";
		// freewifi 데이터 중 서비스제공사명이 skt인 row를 출력하는 쿼리문 QueryTxt에 작성

//		k10_QueryTxt = "select * from freewifi where inst_country='수원시'";
		// freewifi 데이터 중 설치 시군구명이 수원시인 row를 출력하는 쿼리문 QueryTxt에 작성

		ResultSet k10_rset = k10_stmt.executeQuery(k10_QueryTxt); // QueryTxt의 실행 결과를 ResultSet에 저장
		int k10_iCnt = 0; // int형 변수 iCnt 0으로 초기화
		while (k10_rset.next()) { // rset이 있으면
			System.out.printf("*(%d)******************************************\n\n", k10_iCnt++); // n번째 순서 출력하는 별찍기
			System.out.printf("id : %s\n", k10_rset.getString(1)); // id 출력
			System.out.printf("설치장소명 : %s\n", k10_rset.getString(2)); // 설치장소 출력
			System.out.printf("설치장소상세 : %s\n", k10_rset.getString(3)); // 설치장소상세 출력
			System.out.printf("설치시도명 : %s\n", k10_rset.getString(4)); // 설치시도명 출력
			System.out.printf("설치시군구명 : %s\n", k10_rset.getString(5)); // 설치시군구명 출력
			System.out.printf("설치시설구분 : %s\n", k10_rset.getString(6)); // 설치시설구분 출력
			System.out.printf("서비스제공사명 : %s\n", k10_rset.getString(7)); // 서비스제공사명 출력
			System.out.printf("와이파이SSID : %s\n", k10_rset.getString(8)); // 와이파이 SSID 출력
			System.out.printf("설치년월 : %s\n", k10_rset.getDate(9)); // 설치년월 출력
			System.out.printf("소재지도로명주소 : %s\n", k10_rset.getString(10)); // 소재지도로명주소 출력
			System.out.printf("소재지지번주소 : %s\n", k10_rset.getString(11)); // 소재지지번주소 출력
			System.out.printf("관리기관명 : %s\n", k10_rset.getString(12)); // 관리기관명 출력
			System.out.printf("관리기관전화번호 : %s\n", k10_rset.getString(13)); // 관리기관 전화번호 출력
			System.out.printf("위도 : %f\n", k10_rset.getFloat(14)); // 위도 출력
			System.out.printf("경도 : %f\n", k10_rset.getFloat(15)); // 경도 출력
			System.out.printf("데이터기준일자 : %s\n", k10_rset.getDate(16)); // 데이터기준일자 출력
			System.out.printf("***********************************************\n"); // 별찍기
		}
		
		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
	}
}
