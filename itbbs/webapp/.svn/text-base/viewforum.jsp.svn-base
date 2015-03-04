<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>查看话题页 </title>

<link rel="stylesheet" href="css/scroll.css" />
<link rel="stylesheet" href="css/common.css" type="text/css"/>
<link rel="stylesheet" href="css/article.css" type="text/css"/>
<link rel="stylesheet" href="css/forums.css" type="text/css"/>
<link rel="stylesheet" href="css/tag.css" type="text/css"/>
<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
</head>
<body >
<jsp:include page="menu.jsp" />

<div class="container" style="margin-top:40px;">
	<div id="view">
	            <div id="viewforum-article-list">
	            <span style="color:red;">您所在的位置：查看话题</span>
					<ul>
						<li>
							<div id="article" class="node" style="margin-top:20px;">
								<h1>
								<a >${topic.name}</a>
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
									  日期：<span><fmt:formatDate value="${topic.publishDate}" pattern='yyyy-MM-dd HH:mm:ss' /></span>   赞(<span id="praise_count">${topic.praiseCount}</span>)
									 评论(<span id="comment_count">${topic.commentCount}</span>)  浏览(<span>${topic.browseCount}</span>)  收藏(<span id="favor_count">${topic.favorCount}</span>)  
								</div>
							<div class="tags">
								<image src="images/tag.png"></image> &nbsp &nbsp 
								<c:forEach items="${topic.tags}" var="tag">
									<a class="other-tag" href="/forums.jspx?op=tag&id=${tag.id}" >${tag.name}</a>
								</c:forEach>
							</div>
							</div>
							<div class="note-content">
								
									${topic.content}
								
							</div>
							<div class="bigmore">
								<c:choose>
								<c:when test="${praise!=null}">
									<a id="praise" href="javascript:praise('${topic.id}')" class="node_read_more">取消赞</a>
								</c:when>
								<c:when test="${own.id==topic.user.id}">
									<a id="praise" href="javascript:alert('不能赞自己的话题')" class="node_read_more">赞</a>
								</c:when>
								<c:when test="${own!=null}">
									<a id="praise" href="javascript:praise('${topic.id}')" class="node_read_more">赞</a>
								</c:when>
								<c:otherwise>
									<a id="praise" href="javascript:alert('请先登录')" class="node_read_more">赞</a>
								</c:otherwise>
								</c:choose>
								 <c:choose>
								<c:when test="${favor!=null}">
									<a id="favor" href="javascript:favor('${topic.id}')" class="node_read_more">取消收藏</a>
								</c:when>
								<c:when test="${own.id==topic.user.id}">
									<a id="favor" href="javascript:alert('不能收藏自己的话题')" class="node_read_more">收藏</a>
								</c:when>
								<c:when test="${own!=null}">
									<a id="favor" href="javascript:favor('${topic.id}')" class="node_read_more">收藏</a>
								</c:when>
								<c:otherwise>
									<a id="favor" href="javascript:alert('请先登录')" class="node_read_more">收藏</a>
								</c:otherwise>
								</c:choose>
								 <a href="#comment" class="node_read_more">评论</a>   
							</div>
							</div>
						</li>					
					</ul>
        </div>
		<h3  class="fb">精彩评论</h3>
		<div id="thinking">
			<ul id="list_thinking" >
				<c:forEach items="${comments}" var="comment" varStatus="idx">
					<li> 
						<span class="txt_thinking fr " >${comment.content}</span> <br/>
				 		<div class="txt_from"> 
				 			 <span><a href="javascript:reply(${idx.index},'${comment.user.id}','${comment.user.nickname}','${comment.user.username}');">回复评论&nbsp;&nbsp;&nbsp;</a> </span>  
				 			 <span style="color:#008FB5">来自 :</span>
				 			 <a style="color:#008FB5;hover:red;" href="viewuser?id=${comment.user.id}" class="noline" target="_blank">
				 			 		<c:choose>
											<c:when test="${comment.user.nickname!=null}">
												${comment.user.nickname}
											</c:when>
											<c:otherwise>
												${comment.user.username}
											</c:otherwise>
									</c:choose>
			     			 </a>&nbsp;
			     			 时间:<span class="noline"><fmt:formatDate value="${comment.date}" pattern="yy-MM-dd HH:mm:ss" /></span> 
			     		</div> 
			   			<c:forEach items="${comment.replies}" var="reply">
			   				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			   				<li> <span class="txt_thinking fr " >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${reply.content}</span> <br/>
				     			 <div class="txt_from ">
				     			 	 <span>
				     			 		<a href="javascript:reply(${idx.index},'${reply.targetUser.id}','${reply.targetUser.nickname}','${reply.targetUser.username}');">回复&nbsp;&nbsp;&nbsp;</a> 
				     			 	</span> 
				     			 	<a style="color:#008FB5" href="/viewuser?id=${reply.sourceUser.id}" class="noline">
				     			 		<c:choose>
												<c:when test="${reply.sourceUser.nickname!=null}">
													${reply.sourceUser.nickname}
												</c:when>
												<c:otherwise>
													${reply.sourceUser.username}
												</c:otherwise>
											</c:choose>
					 			 	</a>
					 			 	<span style="color:#008FB5">To：</span>
					 			 	<a style="color:#008FB5" href="viewuser?id=${reply.targetUser.id}" class="noline" target="_blank">
					 			 		<c:choose>
												<c:when test="${reply.targetUser.nickname!=null}">
													${reply.targetUser.nickname}
												</c:when>
												<c:otherwise>
													${reply.targetUser.username}
												</c:otherwise>
										</c:choose>
				     			 	</a>&nbsp;
				     			 	时间:<span class="noline"><fmt:formatDate value="${reply.date}" pattern="yy-MM-dd HH:mm:ss"/></span>
				     			  </div>
			   				</li>
			   			</c:forEach>
		   			</li>
		   			<a name="a${idx.index}"></a>
		   			<form id="form${idx.index}" action="user/writereply.jspx" style="display: none;" method="post" onsubmit="return islogin('${own}')">
						<input name ="id" type="hidden" value="${comment.id}"/>
						<input id="targetId${idx.index}" name ="targetId" type="hidden" />
						<input name="p" type="hidden" value="${p}"/>
						回复:<div id = "reply_user_name${idx.index}"></div>
						<textarea id="editor_reply_id${idx.index}" name="content" style="width:700px;height:100px;"></textarea>
						<input style="margin: 1rem 0 1rem 1rem "  class="bigbutton" type="submit" value="回复"/>
						<input style="margin: 1rem 0 1rem 1rem " class="bigbutton" type="button" onclick="cancel('form${idx.index}')" value="取消"/>
					</form>
				</c:forEach>
			</ul>
		</div>
		<c:if test="${comments.pageCount>0}">
		     <div id="page" class="pager"></div>
		</c:if>
	</div>
	
	<c:choose>
			<c:when test="${comments.pageCount==0}">
				<input id="pagecount" type="hidden" value="1"/>
			</c:when>
			<c:otherwise>
				<input id="pagecount" type="hidden" value="${comments.pageCount}"/>
			</c:otherwise>
	</c:choose>
	<input id ="pageindex"type="hidden" value="${p}"/>
	<a name="comment"></a>
	<form action="user/writecomment.jspx" onsubmit="return islogin('${own}')" method="post" style="margin-top:40px;margin-left:14px;">
			<input id="topicId" name ="id" type="hidden" value="${topic.id}"/>
			<c:choose>	
				<c:when test="${comments.pageCount==0}">
					<input name="p" type="hidden" value="1"/>
				</c:when>
				<c:otherwise>
					<input name="p" type="hidden" value="${comments.pageCount}"/>
				</c:otherwise>
			</c:choose>
			<textarea id="editor_id" name="content" style="width:700px;height:300px;"></textarea>
			<input style="margin: 1rem 0 1rem 1rem " class="button" type="submit" value="评论"/>
	</form>
</div>

<script charset="utf-8" src="kindeditor/kindeditor.js"></script>
<script charset="utf-8" src="kindeditor/lang/zh_CN.js"></script>
<script>
        KindEditor.ready(function(K) {
                window.editor = K.create('#editor_id', {
		resizeType : 1,
		allowPreviewEmoticons : false,
		allowImageUpload : false,
		items : [
			'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
			'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
			'insertunorderedlist', '|', 'emoticons', 'image', 'link']
	});
        });
        
        function reply(idx,id,nickname,username){
        	var from = document.getElementById("form"+idx);
        	var div = document.getElementById("reply_user_name"+idx);
        	var target = document.getElementById("targetId"+idx);
        	target.value=id;
        	if(nickname!=''){
        		div.innerHTML = nickname;
        	}else{
        		div.innerHTML = username;
        	}
        	from.style.display="inline";
        	 KindEditor.ready(function(K) {
                window.editor = K.create('#editor_reply_id'+idx,{
				resizeType : 1,
				allowPreviewEmoticons : false,
				allowImageUpload : false,
				items : [
				'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
				'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
				'insertunorderedlist', '|', 'emoticons', 'image', 'link']
				});
       		});
       		window.location.hash = 'a'+idx; 
        };
        function cancel(id){
        	var from = document.getElementById(id);
        	from.style.display="none";
        };
        function islogin(user){
			if(user==""){
				alert('请先登录');
				return false;
			}
			return true;			
    	}
</script>
<!-- 赞和取消赞，收藏与取消收藏 -->
<script type="text/javascript">
		function praise(id){
		var p = document.getElementById("praise");
		var s = document.getElementById("praise_count");
			if(p.innerHTML=="赞"){
    			ajaxFunction("/user/praise.jspx?op=praise&id="+id);
    			p.innerHTML="取消赞";
    			s.innerHTML = parseInt(s.innerHTML)+1;
    			
    		}else{
    			ajaxFunction("/user/praise.jspx?op=cancelpraise&id="+id);
    			p.innerHTML="赞";
    			s.innerHTML = parseInt(s.innerHTML)-1;
    		}
    	}
    	function favor(id){
		var p = document.getElementById("favor");
		var s = document.getElementById("favor_count");
			if(p.innerHTML=="收藏"){
    			ajaxFunction("/user/favor.jspx?op=favor&id="+id);
    			p.innerHTML="取消收藏";
    			s.innerHTML = parseInt(s.innerHTML)+1;
    			
    		}else{
    			ajaxFunction("/user/favor.jspx?op=cancelfavor&id="+id);
    			p.innerHTML="收藏";
    			s.innerHTML = parseInt(s.innerHTML)-1;
    		}
    	}
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

<!-- 分页 -->
<script type="text/javascript">
	//container 容器，count 总页数 pageindex 当前页数
	function setPage( count, pageindex) {
	var container = document.getElementById("page");
	var count = document.getElementById("pagecount").value;
	var pageindex = document.getElementById("pageindex").value;
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
      window.location.href='/viewforum.jspx?id='+topicId+'&p='+inx;
      return false;
    }
    for (var i = 1; i < oAlink.length - 1; i++) { //点击页码
      oAlink[i].onclick = function() {
        inx = parseInt(this.innerHTML);
         window.location.href='/viewforum.jspx?id='+topicId+'&p='+inx;
        return false;
      }
    }
    oAlink[oAlink.length - 1].onclick = function() { //点击下一页
      if (inx == count) {
        return false;
      }
      inx++;
      window.location.href='/viewforum.jspx?id='+topicId+'&p='+inx;
      return false;
    }
  } ()
}
 window.onload = setPage();
</script>
</body>
</html>