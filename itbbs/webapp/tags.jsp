<%@ page contentType="text/html; charset=UTF-8" session="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
	<head>
		<title>标签汇</title>
	</head>
	<body>
	<jsp:include page="menu.jsp" />
	<div id="main-tags" style="background:#fff;min-height:720px;">
		<div class="container" style="margin-top:80px;">
			<!-- 列出所有标签 -->
			<div class="bodycontent">
					<div class="showarea">
						<span style="color:red;">您所在的位置：标签汇</span>
						<div style="color: rgb(220, 176, 55); margin: 20px 0px 5px 5px;">全部标签</div>
						<c:forEach items="${tags}" var="tag" >
							<a href="/forums.jspx?op=tag&id=${tag.id}" class="entry">${tag.name}<font size="1px">（${tag.topicCount }）</font></a>
						</c:forEach>
					</div>
			</div>
			<!-- 树状显示标签 -->
			<div class="tag">
				<div style="color:#DCB037;margin-left: 33px;padding-top:14px;">标签结构</div>
				<c:forEach  items="${rootTags}" var="tag" >
					<div class="background">
						<!-- 第一层标签 -->
						<a href="/forums.jspx?op=tag&id=${tag.id}" class="entity css0">${tag.name}<font size="1px">（${tag.topicCount }）</font></a>
						<!-- 第二层子标签 -->
						<c:forEach  items="${tag.childrenTag }" var="tag2" >
							<div class="branch">&nbsp;-&nbsp;<a href="/forums.jspx?op=tag&id=${tag2.id}" class="entity css0">${tag2.name}<font size="1px">（${tag2.topicCount }）</font></a>						
								<!-- 第三层子标签 -->
								<c:forEach  items="${tag2.childrenTag}" var="tag3" >
									<div class="branch">&nbsp;-&nbsp;<a href="/forums.jspx?op=tag&id=${tag3.id}" class="entity css0">${tag3.name}<font size="1px">（${tag3.topicCount }）</font></a></div>						
								</c:forEach>
							</div>
						</c:forEach>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	</body>
</html>
