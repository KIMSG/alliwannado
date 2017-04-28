<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<!doctype html>
<html lang="ko">
<head>
		<meta charset="utf-8">
		<title>네이버 로그인</title>
		<script type="text/javascript"	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"	charset="utf-8"></script>
		<script type="text/javascript"	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	</head>

	<body>
		<%
		    String clientId = "키넣기";//애플리케이션 클라이언트 아이디값";
		    String redirectURI = URLEncoder.encode("http://127.0.0.1:8080/Naver.do", "UTF-8");
		    SecureRandom random = new SecureRandom();
		    String state = new BigInteger(130, random).toString();
		    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
		    apiURL += "&client_id=" + clientId;
		    apiURL += "&redirect_uri=" + redirectURI;
		    apiURL += "&state=" + state;
		    session.setAttribute("state", state);
		 %>
		 <a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>



	</body>
</html>
