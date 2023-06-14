<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /naversearch/src/main/webapp/naverxml.jsp
      naverapi.html 페이지에서 ajax 방식으로 파라미터 3개 전송
      data    : query값. UTF-8의 형태로 인코딩
      display : 한번의 요청에 전달되는 응답데이터의 갯수 
      start   : 시작 데이터의 번호
--%>    
<%
String clientId = "33MDGiIOpPfSeu3to0lf";// 애플리케이션 클라이언트 아이디값";
String clientSecret = "l2sMMZ7LXB";// 애플리케이션 클라이언트 시크릿값";
StringBuffer xml = new StringBuffer(); //try 구문 밖에 선언하기
try {
	request.setCharacterEncoding("UTF-8");
	String data = request.getParameter("data");
	String display = request.getParameter("display");
	String start = request.getParameter("start");//문서의 시작점
	int cnt = (Integer.parseInt(start) - 1) * Integer.parseInt(display)+1;
	String text = URLEncoder.encode(data, "UTF-8");
	System.out.println(text);
	 String apiURL =
	  "https://openapi.naver.com/v1/search/news.xml?query="
	                       + text+"&display="+display+"&start="+cnt; // xml 결과
	URL url = new URL(apiURL);
	HttpURLConnection con = (HttpURLConnection) url.openConnection();
	con.setRequestMethod("GET");
	con.setRequestProperty("X-Naver-Client-Id", clientId);
	con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	int responseCode = con.getResponseCode();
	BufferedReader br;
	if (responseCode == 200) { // 정상 호출
		br = new BufferedReader
				(new InputStreamReader(con.getInputStream(),"UTF-8"));
	} else { // 에러 발생
		br = new BufferedReader
				(new InputStreamReader(con.getErrorStream(),"UTF-8"));
	}
	String inputLine;
	while ((inputLine = br.readLine()) != null) {
		xml.append(inputLine);
	}
	br.close();
	System.out.println(response);
} catch (Exception e) {
	System.out.println(e);
}
String naverxml =xml.toString().replace("<link>", "<naverlink>"); 
naverxml =naverxml.replace("</link>", "</naverlink>"); 
System.out.println(naverxml);
%><%=naverxml%>