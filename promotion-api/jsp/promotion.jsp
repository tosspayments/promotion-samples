<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Base64"%>
<%@ page import="java.util.Base64.Encoder"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.Reader" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.util.Iterator" %>

<%

  String secretKey = "test_ak_ZORzdMaqN3wQd5k6ygr5AkYXQGwy:";
  
  Encoder encoder = Base64.getEncoder(); 
  byte[] encodedBytes = encoder.encode(secretKey.getBytes("UTF-8"));
  String authorizations = "Basic "+ new String(encodedBytes, 0, encodedBytes.length);
  
  URL url = new URL("https://api.tosspayments.com/v1/promotions/card");
  
  HttpURLConnection connection = (HttpURLConnection) url.openConnection();
  connection.setRequestProperty("Authorization", authorizations);
  
  connection.setRequestMethod("GET");

 
  int code = connection.getResponseCode();
  boolean isSuccess = code == 200 ? true : false;
  
  InputStream responseStream = isSuccess? connection.getInputStream(): connection.getErrorStream();
  
  Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
  JSONParser parser = new JSONParser();
  JSONObject jsonObject = (JSONObject) parser.parse(reader);
  responseStream.close();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>조회 성공</title>
    <meta http-equiv="x-ua-compatible" content="ie=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
</head>
<body>
<section>
    <%
    if (isSuccess) { %>
        <h1>조회 성공</h1>
        <p>결과 데이터 : <%= jsonObject.toJSONString() %></p>
        
        <p>
        <%
            out.println("<p>discountCards</p>");

            JSONArray discountCards = (JSONArray) jsonObject.get("discountCards");

            Iterator i = discountCards.iterator();

            while (i.hasNext()) {
                JSONObject discountCard = (JSONObject) i.next();
                out.println("cardCompany : " + discountCard.get("cardCompany") + "<br>");
                out.println("discountAmount : " + discountCard.get("discountAmount") + "<br>");
                out.println("dueDate : " + discountCard.get("dueDate") + "<br>");
            }

            out.println("<p>interestFreeCards</p>");

            JSONArray interestFreeCards = (JSONArray) jsonObject.get("interestFreeCards");

            Iterator j = interestFreeCards.iterator();

            while (j.hasNext()) {
                JSONObject interestFreeCard = (JSONObject) j.next();
                out.println("cardCompany : " + interestFreeCard.get("cardCompany") + "<br>");
                out.println("minimumPaymentAmount : " + interestFreeCard.get("minimumPaymentAmount") + "<br>");
                out.println("dueDate : " + interestFreeCard.get("dueDate") + "<br>");
            }
            
        
        %>
        
        
    <%} else { %>
        <h1>조회 실패</h1>
        <p><%= jsonObject.get("message") %></p>
        <span>에러코드: <%= jsonObject.get("code") %></span>
        <%
    }
    %>

</section>
</body>
</html>

