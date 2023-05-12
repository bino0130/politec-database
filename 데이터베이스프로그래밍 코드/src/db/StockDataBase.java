package db;

import java.io.*;
import java.sql.*;

public class StockDataBase {

//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // 주식 실습(1) - 테이블 생성
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33061 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33061/kopo10", "root", "kopoctc");
//		
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//		
//		k10_stmt.execute("create table stockData" // stockData 테이블 생성
//					+"(stockCode varchar(100) not null," // 단축코드 (PK)
//					+"openDate int not null, " // 일자 (PK)
//		            +"openPrice int, " // 시가
//		            +"highPrice int, " // 고가
//		            +"lowPrice int, " // 저가
//		            +"endPrice int, " // 종가
//		            +"totalTransaction int, " // 누적 거래량
//		            +"totalTransMoney bigint, " // 누적 거래대금
//		            +"primary key (stockCode, openDate))" // 단축코드, 일자를 PK로
//		            +"DEFAULT CHARSET=utf8;" // UTF-8로 default
//		             );
//		
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}

//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // 주식 실습(1) - drop table
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33061 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33061/kopo10", "root", "kopoctc");
//	
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//	
//		k10_stmt.execute("drop table stockData;"); // stockData 테이블 통째로 삭제
//	
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}

//	public static void main(String[] args) throws ClassNotFoundException, SQLException, IOException{ // 주식 실습(2) - insert data
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33061 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33061/kopo10", "root", "kopoctc");
//		
//		// stockData 테이블에 필드마다 데이터 입력. PreparedStatement에서 쿼리문을 사용하기 때문에 ? 입력 
//		String k10_QueryTxt = "insert into stockData values (?, ?, ?, ?, ?, ?, ?, ?)";
//		
//		// PreparedStatement : Statement의 상위 버전
//		// 코드 안정성 높음, 가독성 높음
//		// 텍스트 SQL 호출
//		PreparedStatement k10_pstmt = k10_conn.prepareStatement(k10_QueryTxt);
//		
//		// 바탕화면에 있는 stockDailyPrice csv파일을 경로로 하는 File 객체 f 생성
//		File k10_f = new File("C:\\Users\\Bino\\Desktop\\StockDailyPrice.csv");
//		BufferedReader k10_br = new BufferedReader(new FileReader(k10_f)); // 생성한 객체 f 를 읽어주는 buffereader 객체 br 생성
//		
//		String k10_readtxt; // String 변수 readtxt 생성
//
//	      if ((k10_readtxt = k10_br.readLine()) == null) { // readtxt를 읽은 값이 null이면
//	         System.out.printf("빈 파일입니다.\n"); // 빈 파일입니다라고 출력
//	         return; // 리턴
//	      }
//	      
//	      String[] k10_field_name = k10_readtxt.split(","); // readtxt를 탭을 기준으로 나눈 String타입 배열 field_name 생성
//
//	      int k10_LineCnt = 0; // int형 변수 LineCnt = 0으로 초기화
//	      k10_conn.setAutoCommit(false); // 처리속도를 줄이기위해 autoCommit을 일시적으로 꺼줌
//	      long k10_startTime = System.currentTimeMillis(); // 시작 시간 계산하는 변수 startTime 
//
//	      while ((k10_readtxt = k10_br.readLine()) != null) { // readtxt를 읽은 값이 null이 아니면
//	         String[] k10_field = k10_readtxt.split(","); // readtxt를 탭으로 구분한 String배열 field 생성
//	         k10_pstmt.setString(1, k10_field[2]); // 단축코드
//	         k10_pstmt.setString(2, k10_field[1]); // 일자
//	         k10_pstmt.setString(3, k10_field[4]); // 시가
//	         k10_pstmt.setString(4, k10_field[5]); // 고가
//	         k10_pstmt.setString(5, k10_field[6]); // 저가
//	         k10_pstmt.setString(6, k10_field[3]); // 종가
//	         k10_pstmt.setString(7, k10_field[11]); // 거래량
//	         k10_pstmt.setString(8, k10_field[12]); // 거래대금
//	         k10_pstmt.addBatch();
//	         // addBatch : 쿼리 실행을 하지 않고 쿼리 구문을 메모리에 저장해두었다가
//	         // 실행 명령 (executeBatch)가 실행되면 한번에 DB에 쿼리를 전달한다.
//	         k10_pstmt.clearParameters(); // 이전에 세팅한 parameter를 모두 삭제
//	         k10_LineCnt++; // LineCnt + 1 증가
//	         try { // try catch
//	            if (k10_LineCnt % 50000 == 0) { // LineCnt / 50000의 나머지가 0 일때
//	               System.out.printf("%d번째 항목 addBatch OK\n", k10_LineCnt); // n번째 항목 OK 출력
//	               k10_pstmt.executeBatch(); // 메모리에 올라간 쿼리 한번에 실행
//	               k10_conn.commit(); // commit
//	            }
//	         } catch (Exception k10_e) {
//	        	 k10_e.printStackTrace(); // 에러 처리
//	         }
//	      }
//	      try { // try catch
//	    	  k10_pstmt.executeBatch();  // 메모리에 올라간 쿼리 한번에 실행
//	      } catch (Exception k10_e) {
//	    	  k10_e.printStackTrace(); // 에러 처리
//	      }
//	      k10_conn.commit(); // commit
//	      k10_conn.setAutoCommit(true); // autoCommit 다시 켜줌
//	      long k10_endTime = System.currentTimeMillis(); // 종료시간 계산하는 변수 endTime 
//	      
//	      System.out.printf("Insert End\n"); // 입력 종료
//	      System.out.printf("total   : %d\n",k10_LineCnt); // 총 row 개수 출력
//	      System.out.printf("time    : %dms\n",k10_endTime - k10_startTime); // 총 소요 시간 출력
//	      
//	      k10_br.close(); // 누수 메모리 차단
//	      k10_pstmt.close(); // 누수 메모리 차단
//	}

//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // 주식 실습(3) - 테이블 읽기
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33061 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33061/kopo10", "root", "kopoctc");
//		
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//		
//		//	일자가 20150112인 데이터를 찾는 쿼리의 실행 결과를 ResultSet에 저장
//		ResultSet k10_rset = k10_stmt.executeQuery("select * from stockData where openDate = 20150112;");
//		
//		//	종목코드가 A005930인 데이터를 찾는 쿼리의 실행 결과를 ResultSet에 저장
////		ResultSet k10_rset = k10_stmt.executeQuery("select * from stockData where stockCode = 'A005930';");
//
//		int cnt = 0; // int형 변수 cnt = 0으로 초기화
//		
//		while (k10_rset.next()) { // rset이 있으면
//			System.out.printf("*************************\n"); // 별찍기
//			System.out.printf("단축코드 : %s\n", k10_rset.getString(1)); // 단축코드 출력
//			System.out.printf("일자 : %d\n", k10_rset.getInt(2)); // 일자 출력
//			System.out.printf("시가 : %d\n", k10_rset.getInt(3)); // 시가 출력
//			System.out.printf("고가 : %d\n", k10_rset.getInt(4)); // 고가 출력
//			System.out.printf("저가 : %d\n", k10_rset.getInt(5)); // 저가 출력
//			System.out.printf("종가 : %d\n", k10_rset.getInt(6)); // 종가 출력
//			System.out.printf("누적 거래량 : %d\n", k10_rset.getInt(7)); // 누적 거래량 출력
//			System.out.printf("누적 거래대금 : %d\n", k10_rset.getLong(8)); // 누적 거래대금 출력
//			// 누적 거래대금의 숫자 크기가 커서 처음엔 getBigDecimal로 값을 받으려 했으나 에러가 떠서
//			// getLong으로 받았더니 정상적으로 출력되었다
//			System.out.printf("*************************\n"); // 별찍기
//			cnt++; // 반복문 한번 끝날때마다 cnt + 1씩 증가 
//			
//		}
//		
//		System.out.println("총 데이터 개수 : " + cnt + "개 있음"); // 총 데이터 개수 출력
//
//		k10_rset.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지	
//	}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////// -- otherStock

//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // 주식 실습(1) - 테이블 생성
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33061 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33061/kopo10", "root", "kopoctc");
//
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//
//		k10_stmt.execute("create table otherStock" // otherStock 테이블 생성
//				+ "(stockCode varchar(100) not null," // 단축코드 (PK)
//				+ "openDate int not null, " // 일자 (PK)
//				+ "openPrice int, " // 시가
//				+ "highPrice int, " // 고가
//				+ "lowPrice int, " // 저가
//				+ "endPrice int, " // 종가
//				+ "totalTransaction int, " // 누적 거래량
//				+ "totalTransMoney bigint, " // 누적 거래대금
//				+ "primary key (stockCode, openDate))" // 단축코드, 일자를 PK로
//				+ "DEFAULT CHARSET=utf8;" // UTF-8로 default
//		);
//
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}

//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // 주식 실습(1) - drop table
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33061 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33061/kopo10", "root", "kopoctc");
//	
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//	
//		k10_stmt.execute("drop table otherStock;"); // otherStock 테이블 통째로 삭제
//	
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}

//	public static void main(String[] args) throws ClassNotFoundException, SQLException, IOException { // 주식 실습(2) - insert data
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33061 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33061/kopo10", "root", "kopoctc");
//
//		// otherStock 테이블에 필드마다 데이터 입력. PreparedStatement에서 쿼리문을 사용하기 때문에 ? 입력
//		String k10_QueryTxt = "insert into otherStock values (?, ?, ?, ?, ?, ?, ?, ?)";
//
//		// PreparedStatement : Statement의 상위 버전
//		// 코드 안정성 높음, 가독성 높음
//		// 텍스트 SQL 호출
//		PreparedStatement k10_pstmt = k10_conn.prepareStatement(k10_QueryTxt);
//
//		// 바탕화면에 있는 stockDailyPrice csv파일을 경로로 하는 File 객체 f 생성
//		File k10_f = new File("C:\\Users\\Bino\\Desktop\\StockDailyPrice.csv");
//		BufferedReader k10_br = new BufferedReader(new FileReader(k10_f)); // 생성한 객체 f 를 읽어주는 buffereader 객체 br 생성
//
//		String k10_readtxt; // String 변수 readtxt 생성
//
//		int k10_LineCnt = 0; // int형 변수 LineCnt = 0으로 초기화
//		k10_conn.setAutoCommit(false); // 처리속도를 줄이기위해 autoCommit을 일시적으로 꺼줌
//		long k10_startTime = System.currentTimeMillis(); // 시작 시간 계산하는 변수 startTime
//
//		while ((k10_readtxt = k10_br.readLine()) != null) { // readtxt를 읽은 값이 null이 아니면
//			String[] k10_field = k10_readtxt.split(","); // readtxt를 탭으로 구분한 String배열 field 생성
//			k10_pstmt.setString(1, k10_field[2]); // 단축코드
//			k10_pstmt.setString(2, k10_field[1]); // 일자
//			k10_pstmt.setString(3, k10_field[4]); // 시가
//			k10_pstmt.setString(4, k10_field[5]); // 고가
//			k10_pstmt.setString(5, k10_field[6]); // 저가
//			k10_pstmt.setString(6, k10_field[3]); // 종가
//			k10_pstmt.setString(7, k10_field[11]); // 거래량
//			k10_pstmt.setString(8, k10_field[12]); // 거래대금
//			k10_pstmt.addBatch();
//			// addBatch : 쿼리 실행을 하지 않고 쿼리 구문을 메모리에 저장해두었다가
//			// 실행 명령 (executeBatch)가 실행되면 한번에 DB에 쿼리를 전달한다.
//			k10_pstmt.clearParameters(); // 이전에 세팅한 parameter를 모두 삭제
//			k10_LineCnt++; // LineCnt + 1 증가
//			try { // try catch
//				if (k10_LineCnt % 10000 == 0) { // LineCnt / 50000의 나머지가 0 일때
//					System.out.printf("%d번째 항목 addBatch OK\n", k10_LineCnt); // n번째 항목 OK 출력
//					k10_pstmt.executeBatch(); // 메모리에 올라간 쿼리 한번에 실행
//					k10_conn.commit(); // commit
//				}
//			} catch (Exception k10_e) {
//				k10_e.printStackTrace(); // 에러 처리
//			}
//		}
//		try { // try catch
//			k10_pstmt.executeBatch(); // 메모리에 올라간 쿼리 한번에 실행
//		} catch (Exception k10_e) {
//			k10_e.printStackTrace(); // 에러 처리
//		}
//		k10_conn.commit(); // commit
//		k10_conn.setAutoCommit(true); // autoCommit 다시 켜줌
//		long k10_endTime = System.currentTimeMillis(); // 종료시간 계산하는 변수 endTime
//
//		System.out.printf("Insert End\n"); // 입력 종료
//		System.out.printf("total   : %d\n", k10_LineCnt); // 총 row 개수 출력
//		System.out.printf("time    : %dms\n", k10_endTime - k10_startTime); // 총 소요 시간 출력
//
//		k10_br.close(); // 누수 메모리 차단
//		k10_pstmt.close(); // 누수 메모리 차단
//	}
	
	///////////////////////////////////////////////////////////////////////////////////////// -- anotherStock
	
//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // 주식 실습(1) - 테이블 생성
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33061 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33061/kopo10", "root", "kopoctc");
//
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//
//		k10_stmt.execute("create table anotherStock" // anotherStock 테이블 생성
//				+ "(stockCode varchar(100) not null," // 단축코드 (PK)
//				+ "openDate int not null, " // 일자 (PK)
//				+ "openPrice int, " // 시가
//				+ "highPrice int, " // 고가
//				+ "lowPrice int, " // 저가
//				+ "endPrice int, " // 종가
//				+ "totalTransaction int, " // 누적 거래량
//				+ "totalTransMoney bigint, " // 누적 거래대금
//				+ "primary key (stockCode, openDate))" // 단축코드, 일자를 PK로
//				+ "DEFAULT CHARSET=utf8;" // UTF-8로 default
//		);
//
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}
	
//	public static void main(String[] args) throws ClassNotFoundException, SQLException { // 주식 실습(1) - drop table
//		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
//		// 192.168.23.59 : MySQL 서버 IP주소, 33061 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
//		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
//		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33061/kopo10", "root", "kopoctc");
//	
//		Statement k10_stmt = k10_conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
//	
//		k10_stmt.execute("drop table anotherStock;"); // anotherStock 테이블 통째로 삭제
//	
//		k10_stmt.close(); // 리소스 정리 -> 메모리 누수 방지
//		k10_conn.close(); // 리소스 정리 -> 메모리 누수 방지
//	}
	
	public static void main(String[] args) throws ClassNotFoundException, SQLException, IOException { // 주식 실습(2) - insert data
		Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
		// 192.168.23.59 : MySQL 서버 IP주소, 33061 : MySQL 서버 포트번호, kopo10 : 데이터베이스 이름
		// getConnection 안의 url을 사용하여 DriverManger클래스의 getConnection메소드를 호출
		Connection k10_conn = DriverManager.getConnection("jdbc:mysql://192.168.23.59:33061/kopo10", "root", "kopoctc");

		// anotherStock 테이블에 필드마다 데이터 입력. PreparedStatement에서 쿼리문을 사용하기 때문에 ? 입력
		String k10_QueryTxt = "insert into anotherStock values (?, ?, ?, ?, ?, ?, ?, ?)";

		// PreparedStatement : Statement의 상위 버전
		// 코드 안정성 높음, 가독성 높음
		// 텍스트 SQL 호출
		PreparedStatement k10_pstmt = k10_conn.prepareStatement(k10_QueryTxt);

		// 바탕화면에 있는 stockDailyPrice csv파일을 경로로 하는 File 객체 f 생성
		File k10_f = new File("C:\\Users\\Bino\\Desktop\\StockDailyPrice.csv");
		BufferedReader k10_br = new BufferedReader(new FileReader(k10_f)); // 생성한 객체 f 를 읽어주는 buffereader 객체 br 생성

		String k10_readtxt; // String 변수 readtxt 생성

		int k10_LineCnt = 0; // int형 변수 LineCnt = 0으로 초기화
		k10_conn.setAutoCommit(false); // 처리속도를 줄이기위해 autoCommit을 일시적으로 꺼줌
		long k10_startTime = System.currentTimeMillis(); // 시작 시간 계산하는 변수 startTime
		int k10_batchSize = 500000; // 일정 수준 이상의 쿼리가 쌓이면 한 번에 커밋할 배치 크기

		while ((k10_readtxt = k10_br.readLine()) != null) { // readtxt를 읽은 값이 null이 아니면
			String[] k10_field = k10_readtxt.split(","); // readtxt를 탭으로 구분한 String배열 field 생성
			k10_pstmt.setString(1, k10_field[2]); // 단축코드
			k10_pstmt.setString(2, k10_field[1]); // 일자
			k10_pstmt.setString(3, k10_field[4]); // 시가
			k10_pstmt.setString(4, k10_field[5]); // 고가
			k10_pstmt.setString(5, k10_field[6]); // 저가
			k10_pstmt.setString(6, k10_field[3]); // 종가
			k10_pstmt.setString(7, k10_field[11]); // 거래량
			k10_pstmt.setString(8, k10_field[12]); // 거래대금
			k10_pstmt.addBatch();
			// addBatch : 쿼리 실행을 하지 않고 쿼리 구문을 메모리에 저장해두었다가
			// 실행 명령 (executeBatch)가 실행되면 한번에 DB에 쿼리를 전달한다.
			k10_pstmt.clearParameters(); // 이전에 세팅한 parameter를 모두 삭제
			k10_LineCnt++; // LineCnt + 1 증가
		
			try {
				if (k10_LineCnt % k10_batchSize == 0) { // 누적 쿼리 수가 일정 수준에 달하면
					k10_pstmt.executeBatch(); // 저장했던 쿼리문 가져와서
					k10_conn.commit(); // db에 올리기
					System.out.printf("%s번까지 레코드 처리 완료\n", k10_LineCnt); // 처리 완료 메시지
				}
			} catch (BatchUpdateException e) { // BatchUpdateException 예외가 발생하면					
				int[] k10_updateCounts = e.getUpdateCounts(); // 각 쿼리별 처리 결과 배열
				
				for (int k10_i = 0; k10_i < k10_updateCounts.length; k10_i++) {	// db에 업데이트한 레코드에 대하여
					int k10_code = k10_updateCounts[k10_i]; // 해당 쿼리의 처리 결과, 에러 시 -3
					if (k10_code == Statement.EXECUTE_FAILED) {	// EXECUTE_FAILED = -3							
						System.err.printf("%s번 레코드의 primary key 중복으로 인해 레코드 처리를 건너뛰었습니다\n", 
								k10_i+k10_LineCnt - (k10_batchSize - 1));	// 에러걸린 코드 번호 출력
					}
				}

			} catch (Exception e) { // 그 외의 발생하면
				e.printStackTrace(); // 에러 메시지 출력
			}
		}

		try {
			if (k10_LineCnt % k10_batchSize != 0) { // 남아있는 경우
				k10_pstmt.executeBatch(); // 저장했던 쿼리문 가져와서
				k10_conn.commit(); // db에 올리기
				System.out.printf("%s번까지 레코드 처리 완료\n", k10_LineCnt); // 처리 완료 메시지
			}
		} catch (BatchUpdateException e) { // BatchUpdateException 예외가 발생하면					
			int[] k10_updateCounts = e.getUpdateCounts(); // 각 쿼리별 처리 결과 배열
			
			for (int k10_i = 0; k10_i < k10_updateCounts.length; k10_i++) {	// db에 업데이트한 레코드에 대하여
				int k10_code = k10_updateCounts[k10_i]; // 해당 쿼리의 처리 결과, 에러 시 -3
				if (k10_code == Statement.EXECUTE_FAILED) {	// EXECUTE_FAILED = -3							
					System.err.printf("%s번 레코드의 primary key 중복으로 인해 레코드 처리를 건너뛰었습니다\n", 
							k10_i+k10_LineCnt - (k10_batchSize - 1));	// 에러걸린 코드 번호 출력
				}
			}

		} catch (Exception e) { // 예외가 발생하면
			e.printStackTrace(); // 에러 메시지 출력
		}
		
		k10_conn.commit(); // commit
		k10_conn.setAutoCommit(true); // autoCommit 다시 켜줌
		long k10_endTime = System.currentTimeMillis(); // 종료시간 계산하는 변수 endTime

		System.out.printf("Insert End\n"); // 입력 종료
		System.out.printf("total   : %d\n", k10_LineCnt); // 총 row 개수 출력
		System.out.printf("time    : %dms\n", k10_endTime - k10_startTime); // 총 소요 시간 출력

		k10_br.close(); // 누수 메모리 차단
		k10_pstmt.close(); // 누수 메모리 차단
	}
}