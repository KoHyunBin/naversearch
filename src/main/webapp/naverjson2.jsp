<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String clientId = "33MDGiIOpPfSeu3to0lf";// 애플리케이션 클라이언트 아이디값";
String clientSecret = "l2sMMZ7LXB";// 애플리케이션 클라이언트 시크릿값";
StringBuffer json = new StringBuffer();
try {
	request.setCharacterEncoding("UTF-8");
	String data = request.getParameter("data");
	String display = request.getParameter("display");
	String start = request.getParameter("start");
	int cnt = (Integer.parseInt(start) - 1) * Integer.parseInt(display)+1;
	String text = URLEncoder.encode(data, "UTF-8");
	String apiURL = 
	"https://openapi.naver.com/v1/search/news.json?query=" + text+
	                                      "&display="+display+"&start="+cnt; // json 결과
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
		json.append(inputLine);
	}
	br.close();
} catch (Exception e) {
	System.out.println(e);
}
System.out.println(json.toString());
%><%=json.toString()%>