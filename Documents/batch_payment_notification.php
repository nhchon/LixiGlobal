<?php
$data = array(
	'data[0]'=> array(
		'order_id'=>13,
		'amount'=>228000,
		'date_transfer'=>'2016-02-15 12:43:27'
	),
	'data[1]'=>array(
		'order_id'=>12,
		'amount'=>240000,
		'date_transfer'=>'2016-02-15 12:26:19'
	),
	'data[2]'=>array(
		'order_id'=>11,
		'amount'=>420000,
		'date_transfer'=>'2016-02-15 11:50:22'
	)
);
ksort($data);
$url="http://kiemthu.baokim.vn/promotion/payment/notification";

$ch = curl_init($url);
curl_setopt_array($ch, array(
	CURLOPT_HEADER=>false,
	CURLINFO_HEADER_OUT=>true,
	CURLOPT_TIMEOUT=>60,
	CURLOPT_RETURNTRANSFER=>true,
	CURLOPT_HTTPAUTH=>CURLAUTH_DIGEST|CURLAUTH_BASIC,
	CURLOPT_USERPWD=>'test_only:1234',
	CURLOPT_POST=>true,
	CURLOPT_POSTFIELDS=>http_build_query($data),
	CURLOPT_SSL_VERIFYPEER=>false,
));
$result = curl_exec($ch);
$http_code = curl_getinfo($ch,CURLINFO_HTTP_CODE);
$error = curl_error($ch);
curl_close($ch);

echo "Result: ";
echo '<pre>'.print_r($result, true).'</pre>';
var_dump($http_code);
var_dump($error);
die;

?>