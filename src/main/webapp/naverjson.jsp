<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.HttpURLConnection" %>
<%@page import="java.net.URL" %>
<%@page import="java.net.URLEncoder" %>
<%--/naversearch/src/main/webapp/naverapi.html --%>
<%
String clientId = "SUb_wbFMWpsQx0GXBt0P";
String clientSecret = "6pQrarqGmS";
StringBuffer json = new StringBuffer();
try{
	request.setCharacterEncoding("UTF-8");
	String data = request.getParameter("data");
	String display = request.getParameter("display"); //조회데이터 건수
	String start = request.getParameter("start");    //데이터 페이지
	int cnt = (Integer.parseInt(start) - 1) * Integer.parseInt(display) +1;//1,11
	//web : 2바이트(한글) 코드 회피.
	String text = URLEncoder.encode(data, "UTF-8");//유니코드값으로 표현
	System.out.println(text);
	//https://openapi.naver.com/v1/search/blog.xml : 네이버 블로그 검색을 위한 url
	//query : 검색데이터. UTF-8 인코딩 필요 필수 파라미터
	//display : 한번의 요청에 조회 데이터 건수
	//start : 조회 시작 건수
	String apiURL ="https://openapi.naver.com/v1/search/news.json?query="
			+ text+"&display="+display+"&start="+cnt; //json결과
	//URL : 프로토콜, 호스트, 경로(path),파라미터,포트번호 구분하여 인식
	URL url = new URL(apiURL);
	// HttpURLConnection : url 정보를 이용하여 직접 접속
	// con : 네이버 환경 접속 객체
	HttpURLConnection con = (HttpURLConnection) url.openConnection();
	con.setRequestMethod("GET");
	con.setRequestProperty("X-Naver-Client-Id", clientId);
	con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	int responseCode = con.getResponseCode(); //결과코드
	BufferedReader br; //네이버가 전송한 데이터
	if(responseCode == 200) { //정상응답 코드 검색 결과 수신
		//con.getInputStream() : 입력스트림 네이버데이터 수신
		br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
	} else {//에러 발생 검색시 오류 발생.
		//con.getErrorStream() : 입력스트림 네이버 오류데이터 수신
		br = new BufferedReader(new InputStreamReader(con.getErrorStream(),"UTF-8"));
	}
	String inputLine;
	//readline() : 한줄입력
	//xml : 네이버에서 전송된 데이터 전체.
	while ((inputLine = br.readLine()) != null) {
		json.append(inputLine);//StringBuffer 객체에 내용 추가
	}
	br.close();
} catch(Exception e) {
	System.out.println(e);
}
System.out.println(json);
%><%=json.toString()%>