<?php
error_reporting(E_ALL);
ini_set("display_errors", true);




$secretKey = 'test_ak_ZORzdMaqN3wQd5k6ygr5AkYXQGwy'; 

$url = 'https://api.tosspayments.com/v1/promotions/card';

$credential = base64_encode($secretKey . ':');

$curlHandle = curl_init($url);


curl_setopt_array($curlHandle, [

    CURLOPT_RETURNTRANSFER => TRUE,
    CURLOPT_HTTPHEADER => [
        'Authorization: Basic ' . $credential
    ]
]);





$response = curl_exec($curlHandle);

$httpCode = curl_getinfo($curlHandle, CURLINFO_HTTP_CODE);
echo $httpCode;
$isSuccess = $httpCode == 200;
$responseJson = json_decode($response, true);





?>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>조회 성공</title>
    <meta http-equiv="x-ua-compatible" content="ie=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
</head>
<body>
<section>
    <?php
    if ($isSuccess) { ?>
        <h1>조회 성공</h1>
        <p>결과 데이터 : <?php echo json_encode($responseJson, JSON_UNESCAPED_UNICODE); ?></p>
        
        <p>
        <?php
            echo "<p>discountCards</p>";
            foreach($responseJson["discountCards"] as $discountCard) {
                echo "cardCompany : " . $discountCard["cardCompany"] . "<br>";
                echo "discountAmount : " . $discountCard["discountAmount"] . "<br>";
                echo "dueDate : " . $discountCard["dueDate"] . "<br>";
            }
        
            echo "<p>interestFreeCards</p>";
            foreach($responseJson["interestFreeCards"] as $interestFreeCards) {
                echo "cardCompany : " . $interestFreeCards["cardCompany"] . "<br>";
                echo "minimumPaymentAmount : " . $interestFreeCards["minimumPaymentAmount"] . "<br>";
                echo "dueDate : " . $interestFreeCards["dueDate"] . "<br>";
            }
        ?>
       
           
        </p>
        <?php
    } else { ?>
        <h1>조회 실패</h1>

        <p>에러메시지 : <?php echo $responseJson->message ?></p>
        <span>에러코드: <?php echo $responseJson->code ?></span>
        <?php
    }
    ?>

</section>
</body>
</html>
