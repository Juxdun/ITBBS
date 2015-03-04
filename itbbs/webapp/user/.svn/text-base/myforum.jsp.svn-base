<%@ page contentType="text/html; charset=UTF-8" session="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>我的话题</title>
<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
</head>
<body>
<jsp:include page="../menu.jsp" />
<div class="viewuser-div">
	<!-- 用户信息 -->
	<div style="width:217px;height:600px;margin: 14px 0 14px 20px; float:left">
		<div style="width:80px;height:80px;border: 1px solid #EFEFEF"><image></image></div>
		<div style="margin:10px;">昵称：<span>${user.nickname}</span></div>
		<div style="margin:10px;">QQ：<sapn>${user.QQ}</span></div>
		<div style="margin:10px;">邮箱：<span>${user.username}</span></div>
		<div style="margin:10px;">培训日期：<span><fmt:formatDate value="${user.trainingDate}" pattern='yyyy-MM-dd' /></span></div>
	</div>     
	<!-- 话题列表 -->
	<div id="article-list" style="float:left">
		<span style="color:red;">您所在的位置：我的话题</span>
		<c:forEach items="${topics}" var="topic">
		<ul>
			<li>
				<div id="article" class="node" style="padding-top:20px;">
					<h1 property="dc:title" datatype="">
						<a href="/viewforum.jspx?id=${topic.id}">${topic.name}</a>
					</h1>
					<div class="node-header">
						<div class="submitted">
							作者：
							<a href="/viewuser.jspx?id=${topic.user.id}">
								<c:choose>
									<c:when test="${topic.user.nickname!=null}">
										${topic.user.nickname}
									</c:when>
									<c:otherwise>
										${topic.user.username}
									</c:otherwise>
								</c:choose>
								
							</a>  
							日期：<span><fmt:formatDate value="${topic.publishDate}" pattern='yyyy-MM-dd HH:mm:ss' /></span>   赞(<span>${topic.praiseCount}</span>)
							 评论(<span>${topic.commentCount}</span>)  浏览(<span>${topic.browseCount}</span>)   收藏(<span>${topic.favorCount}</span>)   
						</div>
						<div>
							<image src="../images/tag.png"></image> &nbsp &nbsp 
							<c:forEach items="${topic.tags}" var="tag" varStatus="idx">
								<c:if test="${idx.index<3}">
									<a class="other-tag" href="#" >${tag.name}</a>
								</c:if>
							</c:forEach>
							<c:if test="${fn:length(topic.tags)>3}">...</c:if>
						</div>
					</div>
					<div class="note-content">
							${topic.content}
					</div>
					<div class="bigmore">
						<a href="/viewforum.jspx?id=${topic.id}" class="node_read_more">阅读全文</a> 
						<div class="more"><a href="/user/editforum.jspx?id=${topic.id}" class="node_read_more">修改话题</a></div>  
					</div>
					</div>
				</li>					
			</ul>
		</c:forEach>
		
		 <c:if test="${topics.pageCount>0}">
			<div id="page" class="pager"></div>
		</c:if>     
	</div>
</div>
<c:choose>
 	<c:when test="${topics.pageCount==0}">
 		<input id="pagecount" type="hidden" value="1"/>
 	</c:when>
 	<c:otherwise>
 		<input id="pagecount" type="hidden" value="${topics.pageCount}"/>
 	</c:otherwise>
 </c:choose>
<input id ="pageindex"type="hidden" value="${p}"/>
	
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
      window.location.href='/user/myforum.jspx?p='+inx;
      return false;
    }
    for (var i = 1; i < oAlink.length - 1; i++) { //点击页码
      oAlink[i].onclick = function() {
        inx = parseInt(this.innerHTML);
         window.location.href='/user/myforum.jspx?p='+inx;
        return false;
      }
    }
    oAlink[oAlink.length - 1].onclick = function() { //点击下一页
      if (inx == count) {
        return false;
      }
      inx++;
      window.location.href='/user/myforum.jspx?p='+inx;
      return false;
    }
  } ()
}
 window.onload = setPage();
</script>
<script type="text/javascript">
	$(document).ready(function(){
    $(".note-content").show(function(){
        var string = $(this).text();
        string = string.replace(/\ +/g,""); 
        string = string.replace(/[ ]/g,"");
        string = string.replace(/[\r\n]/g,"");
        if(string.length>200){
        	$(this).html(string.substring(0,199)+"...");
        }else{
        	$(this).html(string);
        }
    });
})
</script>
</body>
</html>

