<%@ page contentType="text/html; charset=UTF-8" session="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>标签管理</title>
		<script src="/js/jquery-1.8.3.min.js" type="text/javascript" ></script>
	</head>
	<body>
	<jsp:include page="../menu.jsp" />
		<div class="container">
			<!--
            	描述：表单
            -->
            <div class="put-div-center">
            <span style="color:red;margin-left:46px">您所在的位置：标签管理</span>
			<div class="former">
				<h3 class="title" style="margin-bottom:10px;">添加标签</h3>	
				
				<form action="/user/managetag.jspx" method="post" onsubmit="return validateForm()">
					<input name="op" value="add" type="hidden" />
					<span>父标签</span>
					<input name="parent" id="parentId" type="hidden" readonly="readonly" />
					<input class="input-height" id="parentName" type="text" readonly="readonly"/>
					<span>标签名</span>
					<input class="input-height" id="name" name="name" type="text"/>
					<input class="button" type="submit" value="提交" />
					<input class="button" type="button" onclick="cancelParent()" value="取消父标签"/>
				</form>
			</div>
			<!--
            	作者：1018633103@qq.com
            	时间：2014-12-30
            	描述：表格
            -->
			<div class="former">
				<h3 class="title">标签列表</h3>
				<table class="tabler">
					<thead>
						<tr>
							<td>标签名</td>
							<td>父标签</td>
							<td>操作</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${tags }" var="tag">
						<tr>
							<td class="td-height"><a target="_blank" href="/forums.jspx?op=tag&id=${tag.id}">${tag.name}</a></td>
							<td class="td-height"><a target="_blank" href="/forums.jspx?op=tag&id=${tag.parent.id}">${tag.parent.name}</a></td>
							<td class="td-height">
								<input type="button" class="button buttontofloat" style="margin-right:10px" onclick="plusTag('${tag.id }', '${tag.name }')" value="添加子标签"/>
								<form action="/user/managetag.jspx" method="post">
									<input name="op" value="delete" type="hidden" />
									<input name="id" value="${tag.id }" type="hidden"/>
									<input class="button buttontofloat" type="submit" value="删除"/>
								</form>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			</div>
		</div>
		
		<script type="text/javascript">
			function plusTag(id, name){
				$("#parentId").val(id);
				$("#parentName").val(name);
			}
			
			function cancelParent(){
				$("#parentId").val("");
				$("#parentName").val("");
			}
			function validateForm () {
				var name = $("#name").val();
				var s = name.replace(/[ ]/g,"");
				if (null==s || ""==s) {
					alert("PS:标签名不能为空!");
					return false;
				}
				return true;
			}
		</script>
	</body>
</html>
