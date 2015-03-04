<%@ page contentType="text/html; charset=UTF-8" session="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
	<title>回复管理</title>
	<script src="../js/jquery-1.8.3.min.js" type="text/javascript" ></script>
</head>
<body>
<jsp:include page="../menu.jsp" />

	<div class="container">
		<!--
        	作者：1018633103@qq.com
        	时间：2014-12-31
        	描述：搜索回复
        -->
		<div class="put-div-center">
		<span style="color:red;margin-left:46px">您所在的位置：回复管理</span>
		<div class="former">
			<h3 class="title" style="margin-bottom:10px;">搜索回复</h3>
			<div class="margin-bottom-40">
			<form class="form-float">
				<span>用户名（邮箱）</span>
				<input id="username"  class="input-height" name="username" value="${username}" type="text" />
				<input class="button" type="submit" value="搜索" />
			</form>
			<form class="form-float">
				<span>话题Id</span>
				<input id="topicId"  class="input-height" name="topicId" value="${topicId}" type="text" />
				<input class="button" type="submit" value="搜索" />
			</form>
			</div>
		</div>
		<!--
        	作者：1018633103@qq.com
        	时间：2014-12-31
        	描述：回复列表
        -->
		<div class="former">
			<h3 class="title">回复列表</h3>
			<table class="tabler">
				<thead>
					<tr>
						<td>用户名</td>
						<td>回复内容</td>
						<td>话题名</td>
						<td>回复时间</td>
						<td>状态</td>
						<td>操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${replies }" var="r">
					<tr>
						<td class="td-height"><a href="/viewuser.jspx?id=${r.sourceUser.id}">${r.sourceUser.username}</a></td>
						<td class="td-height"><p>${r.content}</p></td>
						<td class="td-height"><a href="/viewforum.jspx?id=${r.comment.topic.id}">${r.comment.topic.name}</a></td>
						<td class="td-height"><fmt:formatDate value="${r.date}" pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td class="td-height">${r.status.name}</td>
						<td class="td-height">
							<c:if test="${r.status.id==1}">
							<a class="button a-margin" href="?op=shield&id=${r.id}&username=${username}&topicId=${topicId}&p=${p}">屏蔽</a>
							
							</c:if>
							<c:if test="${r.status.id==2}">
							<a class="button a-margin" href="?op=recover&id=${r.id}&username=${username}&topicId=${topicId}&p=${p}">恢复</a>
							
							</c:if>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<c:if test="${replies.pageCount>0}">
        		<div id="page" class="pager"></div>
       		</c:if>
		 	<input id="pagecount" type="hidden" value="${replies.pageCount}"/>
			<input id ="pageindex"type="hidden" value="${p}"/>
		</div>
	</div>
 </div>
 <script type="text/javascript">
	$(document).ready(function(){
    $("p").show(function(){
        var string = $(this).text();
        string = string.replace(/\ +/g,""); 
        string = string.replace(/[ ]/g,"");
        string = string.replace(/[\r\n]/g,"");
        if(string.length>20){
        	$(this).html(string.substring(0,19)+"...");
        }else{
        	$(this).html(string);
        }
    });
})
</script>
<script type="text/javascript">
	//container 容器，count 总页数 pageindex 当前页数
	function setPage( count, pageindex) {
	var container = document.getElementById("page");
	var count = document.getElementById("pagecount").value;
	var pageindex = document.getElementById("pageindex").value;
	var username = document.getElementById("username").value;
	var topicId = document.getElementById("topicId").value;
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
      window.location.href='?username='+username+'&topicId='+topicId+'&p='+inx;
      return false;
    }
    for (var i = 1; i < oAlink.length - 1; i++) { //点击页码
      oAlink[i].onclick = function() {
        inx = parseInt(this.innerHTML);
         window.location.href='?username='+username+'&topicId='+topicId+'&p='+inx;
        return false;
      }
    }
    oAlink[oAlink.length - 1].onclick = function() { //点击下一页
      if (inx == count) {
        return false;
      }
      inx++;
      window.location.href='?username='+username+'&topicId='+topicId+'&p='+inx;
      return false;
    }
  } ()
}
 window.onload = setPage();
</script>
</body>
</html>