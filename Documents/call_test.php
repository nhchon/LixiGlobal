<?php
echo 'My text';
//(Configure account)
define('API_USER', 'test_only');  //API USER
define('API_PWD', '1234');       //API PASSWORD
define('PRIVATE_KEY_BAOKIM','');
define('BAOKIM_API_URI','/promotion/list-products');

//$domain = 'https://www.baokim.vn';
$domain = 'http://kiemthu.baokim.vn';
$uri = BAOKIM_API_URI;
$url = $domain.$uri;

$curl = curl_init($url);

//	Form
curl_setopt_array($curl, array(
	CURLOPT_HEADER=>false,
	CURLINFO_HEADER_OUT=>true,
	CURLOPT_TIMEOUT=>5,
	CURLOPT_RETURNTRANSFER=>true,
	CURLOPT_HTTPAUTH=>CURLAUTH_DIGEST|CURLAUTH_BASIC,
	CURLOPT_USERPWD=>API_USER.':'.API_PWD,
	CURLOPT_SSL_VERIFYPEER=>false,
));

$data = curl_exec($curl);

if ($data == false) {
	$errCode = curl_errno($curl);
	$message = curl_error($curl);
	header('Content-Type: text/html; charset=utf-8');
	echo 'Code:' . $errCode . '<hr >';
	echo 'Message:' . $message . '<hr >';
	exit();
}else{

	$code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
	echo 'Code:' . $code . '<hr >';
	header('Content-Type: text/html; charset=utf-8');
	echo '<pre>'.print_r(json_decode($data), true).'</pre>';
	die();
}

?>
