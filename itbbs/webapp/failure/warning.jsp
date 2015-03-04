<%@ page contentType="text/html; charset=UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>itbbs - 错误警告</title>
<link rel="stylesheet" href="../css/common.css" type="text/css"/>
<link rel="stylesheet" href="../css/article.css" type="text/css"/>
<link rel="stylesheet" href="../css/loginDialog.css" type="text/css"/>
<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
<meta name="author" content="ourlinc"/>
<meta name="copyright" content="Copyright 2013 Ourlinc,Co.,Ltd"/>
<body>
<jsp:include page="/menu.jsp" />
<div>
	<p style="margin: 15% auto 20%;line-height: 25px;text-align: center;">错误：${error }</p>
</div>
</body>
</html>