<%@ page contentType="text/html; charset=UTF-8" session="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
	<title>用户管理</title>
	<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
</head>
<body>
<jsp:include page="../menu.jsp" />
		<div class="container">
			<!--
            	作者：1018633103@qq.com
            	时间：2014-12-31
            	描述：添加用户
            -->
			<div class="put-div-center">
			<span style="color:red;margin-left:46px">您所在的位置：用户管理</span>
			<div class="former">
				<h3 class="title" style="margin-bottom:10px;">添加用户</h3>
				<form method="post" onsubmit="return isEmpty()">
					<input name="op" value="registerUser" type="hidden"/>
					<span>邮箱：</span>
					<input id="username" class="input-height" name="name" type="email" />
					<span>密码</span>
					<input id="pwd" class="input-height" name="psw" type="password" />
					<input class="button" type="submit" value="提交" />
				</form>
			</div>
			<!--
            	作者：1018633103@qq.com
            	时间：2014-12-31
            	描述：用户列表
            -->
			<div class="former">
				<h3 class="title">标签列表</h3>
				<table class="tabler">
					<thead>
						<tr>
							<td>用户名</td>
							<td>培训日期</td>
							<td>用户状态</td>
							<td>找回密码</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${users }" var="user" varStatus="idx">
						<tr>
							<td class="td-height"><a href="/viewuser.jspx?id=${user.id}">${user.username }</a></td>
							<td class="td-height">
								<form>
									<input name="p" value="${p}" type="hidden" />
									<input name="op" value="setTrainingDate" type="hidden" />
									<input name="userId" value="${user.id}" type="hidden"/>
									<input class="input-height" name="date" type="date" value="<fmt:formatDate value="${user.trainingDate }" pattern='yyyy-MM-dd' />" />
									<button class="button" >设置培训日期</button>
								</form>
							</td>
							<td class="td-height">
								<form>${user.status.name }
									<input name="p" value="${p}" type="hidden" />
									<c:if test="${user.status.id==1}">
									<input name="op" value="blacklist" type="hidden" />
									<input name="userId" value="${user.id}" type="hidden"/>
									<button class="button" >拉黑用户</button>
									</c:if>
									
									<c:if test="${user.status.id==2}">
									<input name="op" value="recover" type="hidden" />
									<input name="userId" value="${user.id}" type="hidden"/>
									<button class="button" >恢复用户</button>
									</c:if>
								</form>
							</td>
							<td class="td-height">
								<form onsubmit="return isPwdEmpty()">
									<input name="op" value="getBackPwd" type="hidden" />
									<input name="p" value="${p}" type="hidden" />
									<input name="userId" value="${user.id}" type="hidden"/>
									<input id="resetPwd${idx.index}" class="input-height" name="pwd" type="password" />
									<button class="button" >找回密码</button>
								</form>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<c:if test="${users.pageCount>0}">
        		<div id="page" class="pager"></div>
       		</c:if>
		 	<input id="pagecount" type="hidden" value="${users.pageCount}"/>
			<input id ="pageindex"type="hidden" value="${p}"/>
			</div>
		</div>
   </div>

   <script type="text/javascript">
	//container 容器，count 总页数 pageindex 当前页数
	function setPage( count, pageindex) {
	var container = document.getElementById("page");
	var count = document.getElementById("pagecount").value;
	var pageindex = document.getElementById("pageindex").value;
	var a = [];
	if(container==null){
		return;
	}
  	//总页数少于10 全部显示,大于10 显示前3 后3 中间3 其余....
  	if (pageindex == 1) {
  		a[a.length] = "<a href=\"#\" class=\"prev unclick\">prev</a>";
  	} else {
    	a[a.length] = "<a href=\"#\" class=\"prev\">prev</a>";
  	}
  	function setPageList() {
    	if (pageindex == i) {
      		a[a.length] = "<a href=\"#\" class=\"on\">" + i + "</a>";
    	} else {
      		a[a.length] = "<a href=\"#\">" + i + "</a>";
    	}
  	}
  	//总页数小于10
  	if (count <= 10) {
    	for (var i = 1; i <= count; i++) {
      		setPageList();
    	}
  	}
  	//总页数大于10页
  	else {
    	if (pageindex <= 4) {
      		for (var i = 1; i <= 5; i++) {
        		setPageList();
      		}
      		a[a.length] = "...<a href=\"#\">" + count + "</a>";
    	} else if (pageindex >= count - 3) {
      		a[a.length] = "<a href=\"#\">1</a>...";
      		for (var i = count - 4; i <= count; i++) {
        		setPageList();
      	}
    }
    else { //当前页在中间部分
      a[a.length] = "<a href=\"#\">1</a>...";
      for (var i = pageindex - 2; i <= pageindex + 2; i++) {
        setPageList();
      }
      a[a.length] = "...<a href=\"#\">" + count + "</a>";
    }
  }
  if (pageindex == count) {
    a[a.length] = "<a href=\"#\" class=\"next unclick\">next</a>";
  } else {
    a[a.length] = "<a href=\"#\" class=\"next\">next</a>";
  }
  container.innerHTML = a.join("");
  //事件点击
  var pageClick = function() {
    var oAlink = container.getElementsByTagName("a");
    var inx = pageindex; //初始的页码
    oAlink[0].onclick = function() { //点击上一页
      if (inx == 1) {
        return false;
      }
      inx--;
      window.location.href='/user/manageuser.jspx'+'&p='+inx;
      return false;
    }
    for (var i = 1; i < oAlink.length - 1; i++) { //点击页码
      oAlink[i].onclick = function() {
        inx = parseInt(this.innerHTML);
         window.location.href='/user/manageuser.jspx'+'?p='+inx;
        return false;
      }
    }
    oAlink[oAlink.length - 1].onclick = function() { //点击下一页
      if (inx == count) {
        return false;
      }
      inx++;
      window.location.href='/user/manageuser.jspx'+'&p='+inx;
      return false;
    }
  } ()
}
 window.onload = setPage();
</script>
   <script type="text/javascript">
   		function isPwdEmpty(id){
   			var pwd = document.getElementById("id").value;
   			if(pwd==""){
   				alert("重置密码不能空");
   				return false;
   			}
   			return true;
   		}
   		function isEmpty(){
   			var pwd = document.getElementById("pwd").value;
   			var username = document.getElementById("username").value;
   			if(pwd==""){
   				alert("密码不能空");
   				return false;
   			}
   			if(username==""){
   				alert("用户名不能为空");
   				return false;
   			}
   			return true;
   		}
   </script>
	</body>
</html>