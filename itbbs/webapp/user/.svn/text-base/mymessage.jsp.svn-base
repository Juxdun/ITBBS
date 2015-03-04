<%@ page contentType="text/html; charset=UTF-8" session="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>我的消息</title>
<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
</head>
<body>
<jsp:include page="../menu.jsp" />
<div class="viewuser-div">
	<div style="width:217px;height:600px;border-right: 1px solid #CCCCCC;margin: 14px 0 14px 20px; float:left">
		<div style="width:80px;height:80px;border: 1px solid #EFEFEF"><image></image></div>
		<div style="margin:10px;">昵称：<span>${user.nickname}</span></div>
		<div style="margin:10px;">QQ：<sapn>${user.QQ}</span></div>
		<div style="margin:10px;">邮箱：<span>${user.username}</span></div>
		<div style="margin:10px;">培训日期：<span><fmt:formatDate value="${user.trainingDate}" pattern='yyyy-MM-dd' /></span></div>
	</div>
    <div id="commentTo" style="float:left">
		<span style="color:red;">您所在的位置：我的消息</span>
		<c:forEach items="${mymessage}" var="cr">
			<!-- 第一行：您 回复谁在 XX话题 发表的评论；您评了谁的话题 -->
			<c:if test="${cr.type==1}">
				<div class="head_info" style="margin:10px;">	
					<span ><a href="/viewuser.jspx?id=${cr.comment.user.id}" style="color:#00B7E9">
						<c:choose>
							<c:when test="${cr.comment.user.nickname!=null}">
								${cr.comment.user.nickname}
							</c:when>
							<c:otherwise>
								${cr.comment.user.username}
							</c:otherwise>
						</c:choose>
					</a></span>
					<span >对您</span>
					<span>发表话题</span>
					<span><a href="/viewforum.jspx?id=${cr.comment.topic.id}" style="color:#00B7E9">${cr.comment.topic.name}</a></span>
					<span>的评论</span>
				</div>
				<!-- 第二行：内容，被屏蔽则不显示 -->
				<div class="body_content" style="color:#00B7E9; margin:10px; margin-left:16px">
					<p>${cr.comment.content}</p>
				</div>
				<!-- 第二行：发表时间 -->
				<div class="footer_info" style="margin:10px;" >
					<div style="float: left;"><span>评论时间：<fmt:formatDate value="${cr.date}" pattern='yyyy-MM-dd HH:mm:ss' /></span></div>
					<div class="bigmore"><a href="/viewforum.jspx?id=${cr.comment.topic.id}" class="node_read_more">查看</a></div>
				</div>
			</c:if>
			<c:if test="${cr.type==2}">
				<div class="head_info" style="margin:10px;">
					<c:choose>
						<c:when test="${cr.reply.targetUser.id==user.id}">
							<span ><a href="/viewuser.jspx?id=${cr.reply.sourceUser.id}" style="color:#00B7E9">${cr.reply.sourceUser.nickname}</a></span>
							<span >对您</span>
							<span>在话题</span>
							<span><a href="/viewforum.jspx?id=${cr.reply.comment.topic.id}" style="color:#00B7E9">${cr.reply.comment.topic.name}</a></span>
							<span>发表评论的回复</span>
						</c:when>
						<c:otherwise>
							<span ><a href="/viewuser.jspx?id=${cr.reply.sourceUser.id}" style="color:#00B7E9">
								<c:choose>
									<c:when test="${cr.reply.sourceUser.nickname!=null}">
										${cr.reply.sourceUser.nickname}
									</c:when>
									<c:otherwise>
										${cr.reply.sourceUser.username}
									</c:otherwise>
								</c:choose>
							</a></span>
							<span>在您的话题</span>
							<span><a href="/viewforum.jspx?id=${cr.reply.comment.topic.id}" style="color:#00B7E9">${cr.reply.comment.topic.name}</a></span>
							<span>对</span>
							<span><a href="/viewuser.jspx?id=${cr.reply.comment.user.id}" style="color:#00B7E9">
								<c:choose>
									<c:when test="${cr.reply.targetUser.nickname!=null}">
										${cr.reply.targetUser.nickname}
									</c:when>
									<c:otherwise>
										${cr.reply.targetUser.username}
									</c:otherwise>
								</c:choose>
							</a></span>
							<span>发表评论的回复</span>
						</c:otherwise>
					</c:choose>	
				</div>
				<!-- 第二行：内容，被屏蔽则不显示 -->
				<div class="body_content" style="color:#00B7E9; margin:10px; margin-left:16px">
					<p>${cr.reply.content}</p>
				</div>
				<!-- 第二行：发表时间 -->
				<div class="footer_info" style="margin:10px;" >
					<div style="float: left;"><span>回复时间：<fmt:formatDate value="${cr.date}" pattern='yyyy-MM-dd HH:mm:ss' /></span></div>
					<div class="bigmore"><a href="/viewforum.jspx?id=${cr.reply.comment.topic.id}" class="node_read_more">查看</a></div>
				</div>
			</c:if>	
		</c:forEach>
		<c:if test="${mymessage.pageCount>0}">
			<div id="page" class="pager"></div>
		</c:if>
	</div>
	<c:choose>
 		<c:when test="${mymessage.pageCount==0}">
 			<input id="pagecount" type="hidden" value="1"/>
 		</c:when>
 		<c:otherwise>
 			<input id="pagecount" type="hidden" value="${mymessage.pageCount}"/>
 		</c:otherwise>
 	</c:choose>

	<input id ="pageindex"type="hidden" value="${p}"/>
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
      window.location.href='/user/mymessage.jspx?p='+inx;
      return false;
    }
    for (var i = 1; i < oAlink.length - 1; i++) { //点击页码
      oAlink[i].onclick = function() {
        inx = parseInt(this.innerHTML);
         window.location.href='/user/mymessage.jspx?p='+inx;
        return false;
      }
    }
    oAlink[oAlink.length - 1].onclick = function() { //点击下一页
      if (inx == count) {
        return false;
      }
      inx++;
      window.location.href='/user/mymessage.jspx?p='+inx;
      return false;
    }
  } ()
}
 window.onload = setPage();
</script>
</body>
</html>

