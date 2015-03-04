<%@ page contentType="text/html; charset=UTF-8" session="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>
修改个人信息页
</title>
<link rel="stylesheet" href="../css/common.css" type="text/css"/>
<link rel="stylesheet" href="../css/article.css" type="text/css"/>
<link rel="stylesheet" href="../css/loginDialog.css" type="text/css"/>
<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>

</head>
<body>
	 <jsp:include page="../menu.jsp" />
	 <div id="menus">
		<form action="/user/info.jspx" onsubmit="return isSamePwd()" method="post" >
			<input name="op" type="hidden" value="edit"/>
		    <div class="myInfo">
		    		<span style="color:red;">您所在的位置：修改个人信息</span>
					<h3 class="title"id="alltitle" style="margin-top:20px;">账号信息</h3>
					<div>
						<table class="infotable">
							<tr>
								<td  class="tdl">邮箱：</td><td class="tdr" style="width: 50px;">${user.username}</td>
								<td  class="tdl">手机：</td><td class="tdr" style="width: 50px;"><input  style=" width: 100px;border:1px solid #00A3CF " class="input"  type="text" id="phone"  maxlength="15"  name="phone"  value="${user.phone}"/></td>
								<td  class="tdl">旧密码：</td><td class="tdr" style="width: 50px;"><input  style="width: 100px;border:1px solid #00A3CF" class="input"  type="password" id="oldPassword"  maxlength="15"  name="oldPassword"  /></td>
								<td  class="tdl">新密码：</td><td class="tdr" style="width: 50px;"><input  style="width: 100px;border:1px solid #00A3CF" class="input"  type="password" id="newPassword"  maxlength="15"  name="newPassword"  /></td>
								<td  class="tdl">确认密码：</td><td class="tdr" style="width: 50px;"><input  style="width: 100px;border:1px solid #00A3CF" class="input"  type="password" id="againPassword"  maxlength="15"  name="againPassword"  /></td>
							</tr>
						</table>
					</div>
			</div>
			<div class=" myInfo">
					<h3 class="title"id="alltitle" >个人信息</h3>
					<div>
						<table class="infotable">
							<tr>
								<td class="tdl">昵称：</td><td class="tdr" ><input style="border:1px solid #00A3CF" class="input"  maxlength="15"  id="nickname" type="text" name="nickname" value="${user.nickname}" /><span class="red">&nbsp;*&nbsp;</span></td>
							</tr>
							<tr>
								<td class="tdl">QQ号：</td><td class="tdr" ><input style="border:1px solid #00A3CF" class="input"   maxlength="15" id="QQ" type="text" name="qq" value="${user.QQ}"/></td>
							</tr>
							<tr>
								<td class="tdl">毕业院校：</td><td class="tdr"><input style="border:1px solid #00A3CF" class="input"  type="text" maxlength="30"  name="graduateSchool" value="${user.graduateSchool}"/></td>
							</tr>
							<tr>
								<td class="tdl">工作职位：</td><td class="tdr"><input  style="border:1px solid #00A3CF" class="input"  type="text" maxlength="20" name="position" value="${user.position}"/></td>
							</tr>
							<tr>
								<td  class="tdl">最高学历：</td><td class="tdr"  ><input style="border:1px solid #00A3CF" class="input"  maxlength="15"  type="text" name="highestEducation" value="${user.highestEducation}"/></td>
							</tr>
							<tr>
								<td class="tdl signature">个性签名：</td>
								<td class="signature" colspan=5 ><textarea class="textarea tarea" style="border:1px solid #00A3CF" id="signature"  rows="5" cols="60" name="signature">${user.signature}</textarea></td>
							</tr>
						</table>
					</div>
					<div class="submit">
						<input type="submit" value="提交" class="bigbutton"/>
					</div>	
			</div>
		</form>
	 </div>
	 <div class="w" id="footer" style="margin:auto">
		    <div class="rt"><span class="Copyright">Copyright © ITBBs学习与交流分享平台</span><br/></div>
	 </div>
	 
	<script type="text/javascript">
			function isSamePwd(){
				var newPassword= document.getElementById("newPassword");
				var againPassword= document.getElementById("againPassword");
				if(!newPassword.value==''&&newPassword.value!=againPassword.value){
					alert('密码不一致');
					return false;
				}
				return true;
			}
	</script>
</body>
</html>