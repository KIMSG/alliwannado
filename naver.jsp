
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@page import="com.google.gson.JsonObject"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript"	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"	charset="utf-8"></script>
<script type="text/javascript"	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
<%
    String clientId = "키입력";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "시크릿값";//애플리케이션 클라이언트 시크릿값";
    String code = request.getParameter("code");  //네이버 아이디로 로그인 인증에 성공하면 반환받는 인증 코드, 접근 토큰(access token) 발급에 사용
    String state = request.getParameter("state");
    String redirectURI = URLEncoder.encode("http://127.0.0.1:8080/main/Main.do", "UTF-8");
    String apiURL;
    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
    apiURL += "client_id=" + clientId;
    apiURL += "&client_secret=" + clientSecret;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&code=" + code;
    apiURL += "&state=" + state;
    String access_token = "";
    String refresh_token = "";

    try {
       URL url = new URL(apiURL);
       HttpURLConnection con = (HttpURLConnection)url.openConnection();
       con.setRequestMethod("GET");
       int responseCode = con.getResponseCode();
       BufferedReader br;
       if(responseCode==200) { // 정상 호출
         br = new BufferedReader(new InputStreamReader(con.getInputStream()));
       } else {  // 에러 발생
         br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
       }
       String inputLine;
       StringBuffer res = new StringBuffer();
       int temp = 0;
       while ((inputLine = br.readLine()) != null) {
         res.append(inputLine);
         if(temp == 1){
	         access_token = inputLine;
         }
       	 temp++;
       }
       br.close();
       if(responseCode==200) {
         /* out.println(res.toString()); */

       }
     } catch (Exception e) {
       System.out.println(e);
     }

    String str = access_token.replace("access_token", "");
    access_token = str.replace(":", "");
    str = access_token.replace("\"", "");
    access_token = str.replace(",", "");

	String token = access_token;// 네이버 로그인 접근 토큰;
    String header = "Bearer " + token; // Bearer 다음에 공백 추가
    try {
        apiURL = "https://openapi.naver.com/v1/nid/me";
        URL url = new URL(apiURL);
        HttpURLConnection con = (HttpURLConnection)url.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Authorization", header);
        int responseCode = con.getResponseCode();
        BufferedReader br;
        if(responseCode==200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        String inputLine;
        String resStr = "[";
        while ((inputLine = br.readLine()) != null) {
            resStr += inputLine;
        }
        resStr += "]";

        String temp = resStr.replace("responseCode=200", "");
        br.close();

        JSONArray json = JSONArray.fromObject(temp);
        JSONObject jObj = json.getJSONObject(0);
        String respon = "["+jObj.getString("response")+"]";
		JSONArray responjson = JSONArray.fromObject(respon);
        JSONObject responjsonObj = responjson.getJSONObject(0);
        String nickname 		= responjsonObj.getString("nickname");
        String enc_id 			= responjsonObj.getString("enc_id");
        String profile_image 	= responjsonObj.getString("profile_image");
        String age 				= responjsonObj.getString("age");
        String gender 			= responjsonObj.getString("gender");
        String id 				= responjsonObj.getString("id");
        String name 			= responjsonObj.getString("name");
        String email 			= responjsonObj.getString("email");
        String birthday 		= responjsonObj.getString("birthday");
        String loginId 			= email.replace("@naver.com", "");
		/* 값
		nickname, enc_id, profile_image, age, gender, id, name, email, birthday
		*/
        System.out.println("===========");
        System.out.println("nickname 	:"+nickname 	);
        System.out.println("enc_id 		:"+enc_id 		);
        System.out.println("profile_image:"+profile_image);
        System.out.println("age 			:"+age 			);
        System.out.println("gender 		:"+gender 		);
        System.out.println("id 			:"+id 			);
        System.out.println("name 		:"+name 		);
        System.out.println("email 		:"+email 		);
        System.out.println("birthday 	:"+birthday 	);
        System.out.println("loginId 		:"+loginId 		);
        out.println(json);

    } catch (Exception e) {
        System.out.println(e);
    }
  %>

</body>
</html>
