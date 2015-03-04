<%@ page contentType="text/html; charset=UTF-8" session="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<link rel="stylesheet" href="/css/loginDialog.css" type="text/css"/>
<link rel="stylesheet" href="/css/common.css" type="text/css"/>
<link rel="stylesheet" href="/css/forums.css" type="text/css"/>
<link rel="stylesheet" href="/css/article.css" type="text/css"/>
<link rel="stylesheet" href="/css/tag.css" type="text/css"/>
<link rel="stylesheet" href="/css/usermanage.css" type="text/css"/>
<link rel="stylesheet" href="/css/scroll.css" type="text/css"/>
<script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
</head>
<body>
<!-- 导航栏部分 -->
<div style="position: fixed;top: 0;min-width: 1024px;width: 100%;z-index: 10000;">
		<!-- 黑色导航栏 -->
		<div id="header">
		    <div class="page-container" id="nav">
		        <div id="logo" class="logo"><a href="/index.jspx" target="_self" class="hide-text">ITBBS</a></div>
		        <ul class="nav-item l">
		        	<c:if test="${own!=null}">
		            <li><a href="/user/writeforum.jspx" target="_self">发表话题</a></li>
		            <li><a href="/user/myforum.jspx" target="_self">我的话题</a></li>
					<li><a href="/user/myfavor.jspx" target="_self">我的收藏</a></li>
					<li><a href="/user/mycomment.jspx" target="_self">我的评论</a></li>
					<li><a id="mymessage" href="/user/mymessage.jspx" target="_self">我的消息</a></li>
					<li><a href="/user/info.jspx" target="_self">修改个人信息</a></li>
					</c:if>
		        </ul>
		        <ul class="nav-item r">	
		        	<c:if test="${own!=null}">
			        	<li>
			        		<a href="/user/logout.jspx" target="_self" >注销</a>
			        	</li>
			        	<li>
				        	<a href="/user/myforum.jspx" target="_self" style="color: white;font-size: 140%;">
				        		<c:choose>
				        			<c:when test="${own.nickname!=null}">
				        				${own.nickname }
				        			</c:when>
				        			<c:otherwise>
				        				${own.username }
				        			</c:otherwise>
				        		</c:choose>
				        	</a>
			        	</li>
					</c:if>
					<c:if test="${own==null}">
						<li><a href="#" target="_self" id="example">登录</a></li>
					</c:if>
		        </ul>
			</div>
		</div>
		<!--  白色导航栏  -->
		<div class="course-nav " style="text-align: center;">
		    <ul>
		        <li><a id="a1" name="select" onclick="setClass1(this);" href="/index.jspx" >首页</a></li>
		        <li><a id="a2" name="select" onclick="setClass1(this);" href="/tags.jspx"  >标签汇</a></li>
		        <li><a id="a3" name="select" onclick="setClass1(this);" href="/forums.jspx" >所有话题</a></li>
		        <c:set var="size" value="${fn:length(own.roles)}"></c:set>
		        <c:if test="${size>1}">
		        	<li><a id="a4" name="select" onclick="setClass1(this);" href="/user/manageuser.jspx" >用户管理</a></li>
					<li><a id="a5" name="select" onclick="setClass1(this);" href="/user/managetag.jspx" >标签管理</a></li>
					<li><a id="a6" name="select" onclick="setClass1(this);" href="/user/managetopic.jspx" >话题管理</a></li>
					<li><a id="a7" name="select" onclick="setClass1(this);" href="/user/managecomment.jspx" >评论管理</a></li>
					<li><a id="a8" name="select" onclick="setClass1(this);" href="/user/managereply.jspx">回复管理</a></li>
				</c:if>
		    </ul>
		</div>
</div>
<!--  登录弹出框  -->
<div id="LoginBox">
    <form action="/login.jspx" method="post" onsubmit="return isEmpty()">
    	<input type="hidden" name="op" value="login" />
        <div class="row1">
           	 请登录<a href="javascript:void(0)" title="关闭窗口" class="close_btn" id="closeBtn">×</a>
        </div>
        <div class="row">
           	 用户名: <span class="inputBox">
            <input type="text" id="txtName" name="name" value="账号/邮箱" onfocus="if (value =='账号/邮箱'){value =''}" onBlur="if (value ==''){value='账号/邮箱'}" />
            </span><a href="javascript:void(0)" title="提示" class="warning" id="warn">*</a>
        </div>
        <div class="row">
           	 密&nbsp;&nbsp;&nbsp;码: <span class="inputBox">
            <input type="password" id="txtPwd" name="password" value="" />
            </span><a href="javascript:void(0)" title="提示" class="warning" id="warn2">*</a>
        </div>
        <div class="row">
        	<input type="submit" id="loginbtn" value="登录" />
        </div>
    </form>
</div>

<!-- 弹出登录框的js代码 -->
<script type="text/javascript">
	$(function ($) {
		//弹出登录
		$("#example").hover(function () {
			$(this).stop().animate({
				opacity: '1'
			}, 600);
		}, function () {
			$(this).stop().animate({
				opacity: '0.6'
			}, 1000);
		}).on('click', function () {
			$("body").append("<div id='mask'></div>");
			$("#mask").addClass("mask").fadeIn("slow");
			$("#LoginBox").fadeIn("slow");
		});
		//
		//按钮的透明度
		$("#loginbtn").hover(function () {
			$(this).stop().animate({
				opacity: '1'
			}, 600);
		}, function () {
			$(this).stop().animate({
				opacity: '0.8'
			}, 1000);
		});
		//文本框不允许为空---按钮触发
		$("#loginbtn").on('click', function () {
			var txtName = $("#txtName").val();
			var txtPwd = $("#txtPwd").val();
			if (txtName == "" || txtName == undefined || txtName == null) {
				if (txtPwd == "" || txtPwd == undefined || txtPwd == null) {
					$(".warning").css({ display: 'block' });
				}
				else {
					$("#warn").css({ display: 'block' });
					$("#warn2").css({ display: 'none' });
				}
			}
			else {
				if (txtPwd == "" || txtPwd == undefined || txtPwd == null) {
					$("#warn").css({ display: 'none' });
					$(".warn2").css({ display: 'block' });
				}
				else {
					$(".warning").css({ display: 'none' });
				}
			}
		});
		//文本框不允许为空---单个文本触发
		$("#txtName").on('blur', function () {
			var txtName = $("#txtName").val();
			if (txtName == "" || txtName == undefined || txtName == null) {
				$("#warn").css({ display: 'block' });
			}
			else {
				$("#warn").css({ display: 'none' });
			}
		});
		$("#txtName").on('focus', function () {
			$("#warn").css({ display: 'none' });
		});
		//
		$("#txtPwd").on('blur', function () {
			var txtName = $("#txtPwd").val();
			if (txtName == "" || txtName == undefined || txtName == null) {
				$("#warn2").css({ display: 'block' });
			}
			else {
				$("#warn2").css({ display: 'none' });
			}
		});
		$("#txtPwd").on('focus', function () {
			$("#warn2").css({ display: 'none' });
		});
		//关闭
		$(".close_btn").hover(function () { $(this).css({ color: 'black' }) }, function () { $(this).css({ color: '#999' }) }).on('click', function () {
			$("#LoginBox").fadeOut("fast");
			$("#mask").css({ display: 'none' });
		});
	});
</script>

<!-- 新消息提醒 -->	
<script type="text/javascript">
		function ajax( url )
   		{
			var xmlHttp;
			try
			{
				// Firefox, Opera 8.0+, Safari
				xmlHttp = new XMLHttpRequest();    // 实例化对象
			}
			catch( e )
			{
				// Internet Explorer
				try
				{
				xmlHttp = new ActiveXObject( "Msxml2.XMLHTTP" );
				}
				catch ( e )
				{
					try
					{
						xmlHttp = new ActiveXObject( "Microsoft.XMLHTTP" );
					}
					catch( e )
					{
						alert("您的浏览器不支持AJAX！");
						return false;
					}
 				}
   	 		}
			xmlHttp.onreadystatechange = function()
    		{
				if( xmlHttp.readyState == 4  && xmlHttp.status == 200 )
				{
					var text = xmlHttp.responseText;
					if(text!=0){ 
						var mymessage = document.getElementById("mymessage");
						mymessage.innerHTML = mymessage.innerHTML+"("+text+")";
					}
				}
			}
			xmlHttp.open( "POST", url, true );
			xmlHttp.send( null );
		};
		 window.onload = ajax("/user/newmessage.jspx");
</script>

<!-- 区分a标签选中时与其他未选中的标签 -->
<script> 
	function setClass1(obj){ 
		var lab = document.getElementsByName("select"); 
		for (var i = 0; i < lab.length; i++) 
		{ 
			lab[i].className="";
		} 
		obj.className="curr"; 
	} 
</script>

<!-- 登录时的一些判断 -->
<script type="text/javascript">
   		function isEmpty(){
   			var pwd = document.getElementById("txtPwd").value;
   			var username = document.getElementById("txtName").value;
   			if(pwd==""){
   				alert("密码不能空");
   				return false;
   			}
   			if(username=="账号/邮箱"){
   				alert("用户名不能为空");
   				return false;
   			}
   			return true;
   		}
</script>
</body>
</html>