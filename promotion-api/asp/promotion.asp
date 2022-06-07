<%@ Language="VBScript" CODEPAGE="65001"%>


<!DOCTYPE html>

<!--#include file="json2.asp"--> 
<!--#include file="base64.asp"--> 

<%
	
call initCodecs

secretkey = "test_ak_ZORzdMaqN3wQd5k6ygr5AkYXQGwy:"

url = "https://api.tosspayments.com/v1/promotions/card"


authorization = "Basic " & base64Encode(secretkey)

set req = Server.CreateObject("MSXML2.ServerXMLHTTP")
req.open "GET", url, false
req.setRequestHeader "Authorization", authorization
req.send ""

set myJSON = JSON.parse(req.responseText)

httpCode = req.status

%>

<html lang="ko">
<head>
    <title>조회 성공</title>
    <meta charset="UTF-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
</head>
<body>
<section>
    <%
        if httpCode=200  then %>
        <h1>조회 성공</h1>
        <p>결과 데이터 : <%= req.responseText %></p>
        <p>
            <% 
            response.write "<p>discountCards</p>"
            

            For i=0 to myJSON.discountCards.length -1 
            
                response.write "cardCompany : " & myJSON.discountCards.get(i).cardCompany & "<br>"
                response.write "discountAmount : " & myJSON.discountCards.get(i).discountAmount & "<br>"
                response.write "dueDate : " &  myJSON.discountCards.get(i).dueDate & "<br>"

            Next

            response.write "<p>interestFreeCards</p>"

            For i=0 to myJSON.interestFreeCards.length -1
            
                response.write "cardCompany : " & myJSON.interestFreeCards.get(i).cardCompany & "<br>"
                response.write "minimumPaymentAmount : " & myJSON.interestFreeCards.get(i).minimumPaymentAmount & "<br>"
                response.write "dueDate : " & myJSON.interestFreeCards.get(i).dueDate & "<br>"

            Next %>

        </p>
       <%
     else  %>
        <h1>조회 실패</h1>
        <p>에러메시지 :  <%= myJSON.message%></p>
        <span>에러코드:  <%= myJSON.code%></span>
       <%
    end if
    %>

</section>
</body>
</html>
