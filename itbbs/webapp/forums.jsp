﻿<%@ page contentType="text/html; charset=UTF-8" session="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>所有话题</title>
</head>
<body id="List_courseId" onload="setPage('${topics.pageCount}','${p}')">
<jsp:include page="menu.jsp" />
<div>
	<!-- 左边导航栏 -->
    <div class="course-sidebar" style="margin-top:100px">
        <div class="course-sidebar-type">
          	<ul>
                <li class="course-category course-category-more hover ">
                	<a name="select" class="course-category-link" href="/forums.jspx?op=newest" >最新话题</a><i></i>
                </li>
                <li class="course-category course-category-more hover ">
                    <a  name="select" class="course-category-link" href="/forums.jspx?op=browerest" >最多人浏览</a><i></i>
                 </li>
                <li class="course-category course-category-more hover ">
                    <a name="select" class="course-category-link" href="/forums.jspx?op=commentest" >最多人评论</a><i></i>
                </li>
                <li class="course-category course-category-more hover ">
                    <a name="select"  class="course-category-link" href="/forums.jspx?op=favorest" >最多人收藏</a><i></i>
                </li>
                <li class="course-category course-category-more hover ">
                    <a name="select" class="course-category-link" href="/forums.jspx?op=praisest" >最多人赞</a><i></i>
                </li>
                <c:forEach items="${tags}" var="tag">
                	<li class="course-category course-category-more hover ">
                    	<a name="select" class="course-category-link" href="/forums.jspx?op=tag&id=${tag.id}" >${tag.name}</a><i></i>
                	</li>
                </c:forEach>
          	</ul>
        </div>
    </div>
    
    <!-- 右边内容 -->
    <div class="course-content" style="margin-top:100px">
        <div class="course-tools">
            <h2><span><strong style="color:red;font-size:16px" id="title">${title}</strong></span></h2>
        </div>
        <div id="viewforum-article-list">
			<ul>
	    		<c:forEach items="${topics}" var="topic">
					<li>
						<div id="article" class="node">
							<h1>
								<a href="viewforum.jspx?id=${topic.id}">${topic.name}</a>
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
									日期：<span><fmt:formatDate value="${topic.publishDate}" pattern='yyyy-MM-dd HH:mm:ss' /></span>  
									 赞(<span>${topic.praiseCount}</span>)
								 	评论(<span>${topic.commentCount}</span>)  
								 	浏览(<span>${topic.browseCount}</span>)   收藏(<span>${topic.favorCount}</span>)      
								</div>
								<div>
									<image src="images/tag.png"></image> &nbsp &nbsp 
									<c:forEach items="${topic.tags}" var="tag" varStatus="idx">
										<c:if test="${idx.index<3}">
											<a class="other-tag" href="/forums.jspx?op=tag&id=${tag.id}" >${tag.name}</a>
										</c:if>
									</c:forEach>
									<c:if test="${fn:length(topic.tags)>3}">...</c:if>
								</div>
							</div>
							<div class="note-content">
								${topic.content}
							</div>
							<div class="bigmore">
								<a href="viewforum.jspx?id=${topic.id}" class="node_read_more">阅读全文</a>   
							</div>
						</div>
					</li>					
				</c:forEach>
			</ul>
    	</div>
	    <c:if test="${topics.pageCount>0}">
	    	<div id="page" class="pager"></div>
	    </c:if>
		<c:choose>
		<c:when test="${topics.pageCount==0}">
			<input id="pagecount" type="hidden" value="1"/>
		</c:when>
		<c:otherwise>
			<input id="pagecount" type="hidden" value="${topics.pageCount}"/>
		</c:otherwise>
		</c:choose>
		<input id ="pageindex"type="hidden" value="${p}"/>
		<input id ="op"type="hidden" value="${op}"/>
		<input id ="tag"type="hidden" value="${tag.id}"/> 
	 </div>	
</div>

<!-- 调节侧边栏样式 -->
<script>
	function show(){
		var a = document.getElementsByName("select");
		var title = document.getElementById("title");
		for(var i = 0 ; i<a.length;i++){
			if(a[i].innerHTML==title.innerHTML){
				a[i].parentNode.className ='course-category course-category-more hover curr';
			}
		}     	
	};
	 
	function onloadFunction(){
		setPage();
		show();
	}
	window.onload= onloadFunction;
</script>

<!-- 页数 -->
<script type="text/javascript">
	//container 容器，count 总页数 pageindex 当前页数
	function setPage( count, pageindex) {
	var container = document.getElementById("page");
	var count = document.getElementById("pagecount").value;
	var pageindex = document.getElementById("pageindex").value;
	var op = document.getElementById("op").value;
	var tagid = document.getElementById("tag").value;
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
      window.location.href='/forums.jspx?op='+op+'&p='+inx+'&id='+tagid;
      return false;
    }
    for (var i = 1; i < oAlink.length - 1; i++) { //点击页码
      oAlink[i].onclick = function() {
        inx = parseInt(this.innerHTML);
         window.location.href='/forums.jspx?op='+op+'&p='+inx+'&id='+tagid;
        return false;
      }
    }
    oAlink[oAlink.length - 1].onclick = function() { //点击下一页
      if (inx == count) {
        return false;
      }
      inx++;
      window.location.href='/forums.jspx?op='+op+'&p='+inx+'&id='+tagid;
      return false;
    }
  } ()
}

</script>

<!-- substring -->
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
</body></html>