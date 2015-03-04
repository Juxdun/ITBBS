<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>修改评论 </title>
	<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
</head>
<body >
<jsp:include page="../menu.jsp" />
<div id="view">
    <div id="article-list" style="border-left-width: 0px;">
            	<span style="color:red;">您所在的位置：修改评论/回复</span>
				<ul>
					<li>
						<div id="article" class="node" style="padding-top:10px;">
							<h1>
							<a >
								<c:if test="${type=='comment'}">${comment.topic.name}</c:if>
								<c:if test="${type=='reply'}">${reply.comment.topic.name}</c:if>
							</a>
							</h1>
						<div class="node-header">
							<div class="submitted">
								作者：
								<a href="/viewuser.jspx?id=${comment.topic.user.id}">
									<c:if test="${type=='comment'}">
									<c:choose>
										<c:when test="${comment.topic.user.nickname!=null}">
											${comment.topic.user.nickname}
										</c:when>
										<c:otherwise>
											${comment.topic.user.username}
										</c:otherwise>
									</c:choose>
									</c:if>
									<c:if test="${type=='reply'}">
									<c:choose>
										<c:when test="${reply.comment.topic.user.nickname!=null}">
											${reply.comment.topic.user.nickname}
										</c:when>
										<c:otherwise>
											${reply.comment.topic.user.username}
										</c:otherwise>
									</c:choose>
									</c:if>
								</a> 
								<c:if test="${type=='comment'}"> 
								  日期：<span><fmt:formatDate value="${comment.topic.publishDate}" pattern='yyyy-MM-dd HH:mm:ss' /></span>   赞(<span id="praise_count">${comment.topic.praiseCount}</span>)
								 评论(<span id="comment_count">${comment.topic.commentCount}</span>)  浏览(<span>${comment.topic.browseCount}</span>)  收藏(<span id="favor_count">${comment.topic.favorCount}</span>)  
								</c:if>
								<c:if test="${type=='reply'}"> 
								  日期：<span><fmt:formatDate value="${reply.comment.topic.publishDate}" pattern='yyyy-MM-dd HH:mm:ss' /></span>   赞(<span id="praise_count">${reply.comment.topic.praiseCount}</span>)
								 评论(<span id="comment_count">${reply.comment.topic.commentCount}</span>)  浏览(<span>${reply.comment.topic.browseCount}</span>)  收藏(<span id="favor_count">${reply.comment.topic.favorCount}</span>)  
								</c:if>
							</div>
						<div class="tags">
								<c:if test="${type=='comment'}">  
									<image src="/images/tag.png"></image> &nbsp &nbsp 
									<c:forEach items="${comment.topic.tags}" var="tag">
										<a class="other-tag" href="#" >${tag.name}</a>
									</c:forEach>
								</c:if>
								<c:if test="${type=='reply'}"> 
									<image src="/images/tag.png"></image> &nbsp &nbsp 
									<c:forEach items="${reply.comment.topic.tags}" var="tag">
										<a class="other-tag" href="#" >${tag.name}</a>
									</c:forEach>
								</c:if>
						</div>
						</div>
						<input type="button" value="显示内容..."  onclick="show()" id="showButton" class="bigbutton"  />
						<div id="content" class="note-content" style="display:none;">
							<p>
								<c:if test="${type=='comment'}"> 
									${comment.topic.content} 
								</c:if>
								<c:if test="${type=='reply'}">
									${reply.comment.topic.content} 
								</c:if>
							</p>
						</div>
						
						</div>
					</li>					
				</ul>
    </div>
    <c:if test="${type=='reply'}">
    	<h3  class="fb">其它人的评论</h3>
    <div id="thinking">
		<ul id="list_thinking" >
 			<li> <span class="txt_thinking fr " >${reply.comment.content}</span> <br/>
 				 <div class="txt_from">
 			 		<span style="color:#008FB5">来自 :</span><a style="color:#008FB5" href="/viewuser?id=${reply.comment.user.id}" class="noline" target="_blank">
 			 				<c:choose>
								<c:when test="${reply.comment.user.nickname!=null}">
									${reply.comment.user.nickname}
								</c:when>
								<c:otherwise>
									${reply.comment.user.username}
								</c:otherwise>
							</c:choose>
 			 			</a>&nbsp;
 			 		时间<a class="noline" target="_blank"><fmt:formatDate value="${reply.comment.date}"/></a> 
 			 	</div>
 			</li>
 		</ul>
	</div>
	</c:if>
	<form action="/user/editcomment.jspx" onsubmit="return islogin(${own})" method="post" style="margin-left:30px;clear: both;">
		<input name ="op" type="hidden" value="edit"/>
		<c:if test="${type=='comment'}"> 
				<input name ="id" type="hidden" value="${comment.id}"/>
				<input name ="type" type="hidden" value="comment"/>
			</c:if>
			<c:if test="${type=='reply'}">
				<input name ="id" type="hidden" value="${reply.id}"/>
				<input name ="type" type="hidden" value="reply"/>
			</c:if>
		<textarea id="editor_id" name="content" style="width:700px;height:300px;">
			<c:if test="${type=='comment'}"> 
				${comment.content} 
			</c:if>
			<c:if test="${type=='reply'}">
				${reply.content} 
			</c:if>
		</textarea>
		<input class="bigbutton" type="submit" value="修改评论"/>
	</form>
</div>
<script charset="utf-8" src="../kindeditor/kindeditor.js"></script>
<script charset="utf-8" src="../kindeditor/lang/zh_CN.js"></script>
<script>
    KindEditor.ready(function(K) {
            window.editor = K.create('#editor_id');
    });
    
   
    function show(){
    	var div = document.getElementById("content");
    	var btn = document.getElementById("showButton");
    	div.style.display="inline";
    	btn.style.display="none";
    	
    }
    function islogin(user){
		if(user==null){
			alert('请先登录');
			return false;
		}
		return true;			
	}
</script>
<script type="text/javascript">
	function ajaxFunction( url )
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
				
			}
		}
		xmlHttp.open( "POST", url, true );
		xmlHttp.send( null );
	}
</script>
</body>
</html>