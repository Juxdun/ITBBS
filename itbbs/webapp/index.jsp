<%@ page contentType="text/html; charset=UTF-8" session="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>首页</title>
</head>
<body id="List_courseId">
<jsp:include page="menu.jsp" />
<div id="main">
<div class="container" style="margin-top:80px;" >
	<span style="color:red;">您所在的位置：首页</span>
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
								日期：<span><fmt:formatDate value="${topic.publishDate}" pattern='yyyy-MM-dd HH:mm:ss' /></span>   赞(<span>${topic.praiseCount}</span>)
								 评论(<span>${topic.commentCount}</span>)  浏览(<span>${topic.browseCount}</span>)   收藏(<span>${topic.favorCount}</span>)   
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
						<div  class="note-content" style="overflow: auto;">
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
</div>
</div>

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