<%@ page contentType="text/html; charset=UTF-8" session="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>${user.username}的主页</title>
<link rel="stylesheet" href="../css/common.css" type="text/css"/>
<link rel="stylesheet" href="../css/article.css" type="text/css"/>
<link rel="stylesheet" href="../css/loginDialog.css" type="text/css"/>
<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
</head>
<body>
<jsp:include page="./menu.jsp" />
	<div class="viewuser-div">
				<div class="viewuser-left-div">
					<div style="width:80px;height:80px;border: 1px solid #EFEFEF"><image></image></div>
					<div style="margin:10px;">昵称：<span>${user.nickname}</span></div>
					<div style="margin:10px;">QQ：<sapn>${user.QQ}</span></div>
					<div style="margin:10px;">邮箱：<span>${user.username}</span></div>
					<div style="margin:10px;">培训日期：<span><fmt:formatDate value="${user.trainingDate}" pattern='yyyy-MM-dd' /></span></div>
				</div>     
	            <div id="article-list" style="float:left">
	            		<span style="color:red;">您所在的位置：${user.username}的主页</span>
						<c:forEach items="${topics}" var="topic">
							<ul>
								<li>
									<div id="article" class="node" style="margin-top:20px;">
										<h1 >
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
												<div class="tags">
													<c:forEach items="${topic.tags}" var="tag" varStatus="idx">
														<c:if test="${idx.index<3}">
															<image src="/images/tag.png"></image> &nbsp &nbsp <a href="/forums.jspx?op=tag&id=${tag.id}" >${tag.name}</a>
														</c:if>
													</c:forEach>
													<c:if test="${fn:length(topic.tags)>3}"><image src="/images/tag.png"></image>...</c:if>
												</div>
										</div>
										<div class="note-content">
												${topic.content}
										</div>
										<div class="more">
											<a href="viewforum.jspx?id=${topic.id}" class="node_read_more">阅读全文</a>   
										</div>
									</div>
								</li>					
							</ul>
					</c:forEach>        
				</div>			
	</div>
	<!-- 截取文章内容只能200字 -->
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

