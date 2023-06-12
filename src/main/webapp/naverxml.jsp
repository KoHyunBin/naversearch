<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.HttpURLConnection" %>
<%@page import="java.net.URL" %>
<%@page import="java.net.URLEncoder" %>
<%-- /naversearch/src/main/webapp/naverxml.jsp --%>
<%
String clientId = "SUb_wbFMWpsQx0GXBt0P";
String clientSecret = "6pQrarqGmS";
StringBuffer xml = new StringBuffer();
try{
	request.setCharacterEncoding("UTF-8");
	String data = "구디아카데미";
	String display = "10"; //조회데이터 건수
	String start = "1";    //데이터 페이지
	int cnt = (Integer.parseInt(start) - 1) * Integer.parseInt(display) +1;//1,11
	//web : 2바이트(한글) 코드 회피.
	String text = URLEncoder.encode(data, "UTF-8");//유니코드값으로 표현
	System.out.println(text);
	String apiURL ="https://openapi.naver.com/v1/search/blog.xml?query="
			+ text+"&display="+display+"&start="+cnt; //xml결과
	URL url = new URL(apiURL);
	HttpURLConnection con = (HttpURLConnection) url.openConnection();
	con.setRequestMethod("GET");
	con.setRequestProperty("X-Naver-Client-Id", clientId);
	con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	int responseCode = con.getResponseCode(); //결과코드
	BufferedReader br;
	if(responseCode == 200) {
		br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
	} else {//에러 발생
		br = new BufferedReader(new InputStreamReader(con.getErrorStream(),"UTF-8"));
	}
	String inputLine;
	while ((inputLine = br.readLine()) != null) {
		xml.append(inputLine);
	}
	br.close();
} catch(Exception e) {
	System.out.println(e);
}
System.out.println(xml);
%><%=xml.toString()%>