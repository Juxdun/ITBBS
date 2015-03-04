<%@ page contentType="text/html; charset=UTF-8" session="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
	<title>话题管理</title>
	<script src="/js/jquery-1.8.3.min.js" type="text/javascript" ></script>
</head>
<body>
<jsp:include page="../menu.jsp" />

	<div class="container" style="width:99%">
		<!--
        	作者：1018633103@qq.com
        	时间：2014-12-31
        	描述：搜索话题
        -->
        <div class="put-div-center">
        <span style="color:red;margin-left:46px">您所在的位置：话题管理</span>
		<div class="former">
			<h3 class="title" style="margin-bottom:10px;">搜索话题</h3>
			<div class="margin-bottom-40">
			<form class="form-float" action="/user/managetopic.jspx" method="post">
				<input name="op" type="hidden" value="search" />
				<input id="tag" value="${tagId}" type="hidden"/>
				<span>用户名（邮箱）</span>
				<input id="username" class="input-height" name="username" value="${username}" type="text" />
				<span>日&nbsp;&nbsp;期</span>
				<input class="input-height" name="date" type="date" value="<fmt:formatDate value="${date}" pattern='yyyy-MM-dd' />" />
				<span>标&nbsp;&nbsp;签</span>
				<select id="tagId" name="tagId">
				<option value=""></option>
					<c:forEach items="${tags}" var="tag">
						<option value="${tag.id}">${tag.name}</option>					
					</c:forEach>
				</select>
				<input class="button" type="submit" value="搜索"/>
			</form>
			</div>
		</div>
		<!--
        	作者：1018633103@qq.com
        	时间：2014-12-31
        	描述：话题列表
        -->
		<div class="former">
			<h3 class="title">话题列表</h3>
			<table  class="tabler">
				<thead>
					<tr>
						<td>话题名</td>
						<td>用户名</td>
						<td>发表时间</td>
						<td>标签</td>
						<td>状态</td>
						<td>操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${topics }" var="t" varStatus="idx">
					<tr>
						<td class="td-height"><a href="/viewforum.jspx?id=${t.id}">${t.name}</a></td>
						<td class="td-height"><a href="/viewuser.jspx?id=${t.user.id}">${t.user.username}</a></td>
						<td class="td-height"><fmt:formatDate value="${t.publishDate}" pattern='yyyy-MM-dd hh:mm:ss' /></td>
						<td class="td-height">
							<div id="divtag${idx.index}" class="tags">
							<c:forEach items="${t.tags}" var="tag">
								<a name="selectedtag${idx.index}" href="/forums.jspx?op=tag&id=${tag.id}" >${tag.name}</a>&nbsp;&nbsp;&nbsp;
							</c:forEach>
							</div>
						</td>
						<td id="status${idx.index}" class="td-height">${t.status.name}</td>
						<td class="td-height" style="width: 204px">
							<a id="aa${idx.index}" class="button" href="javascript:showLabel('${idx.index}','${t.id}','aa${idx.index}');">调整标签</a>
							<c:if test="${t.status.id==1}">
							<a id="manage${idx.index}" class="button" href="javascript: ajaxFunction( '/user/managetopic.jspx?id=${t.id}','${idx.index}');">屏蔽</a>
							</c:if>
							
							<c:if test="${t.status.id==2}">
							<a id="manage${idx.index}" class="button" href="javascript: ajaxFunction( '/user/managetopic.jspx?id=${t.id}','${idx.index}');">恢复</a>
							</c:if>
							<a class="button" href="/user/managecomment.jspx?topicId=${t.id}" target="_blank">评论管理</a>
							<a class="button" href="/user/managereply.jspx?topicId=${t.id}" target="_blank">回复管理</a>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<c:if test="${topics!=null}">
			<div id="page" class="pager" ></div>
			</c:if>
			<c:choose>
		 		<c:when test="${topics.pageCount>0}">
		 		<input id="pagecount" type="hidden" value="${topics.pageCount}"/>			
		 		</c:when>
		 		<c:otherwise>
		 			<input id="pagecount" type="hidden" value="1"/>
		 		</c:otherwise>
		 	</c:choose>
			<input id ="pageindex"type="hidden" value="${p}"/>
			<input id ="op"type="hidden" value="${op}"/>
									  <!-- 选择标签时弹出层 -->
									<div id="labelDiv"  class="labelDiv"  style="display:none;">
										<table class="labelTable">
											<tr>
											<td colspan="8" align="left">系统将根据您的选择进行更细致的归类。
											<input id="confirm" type="hidden"/>
											<input type="button" value="确定" onclick="confirmLabel();"  id="confirmButton" class="button"  />
											<input type="button" value="关闭" onclick="hideLabel();"  class="button" />
											</td>
											</tr>
											<tr>
												<c:forEach items="${tags1}" var="tag" varStatus="idx">
													<c:if test="${idx.index%4==0}">
														</tr><tr>
													</c:if>
													<td  align="left">
													<div class="label">
													<input id="${tag.name}" name="tags" type="checkbox" value="${tag.id}"/><span>${tag.name}</span>
													</div>
												</td>
												</c:forEach>
											</tr>
										</table>
									</div>
		</div>
	</div>
  </div>
 <!--  相对位置弹出框-->
	<script>
			function CPos(x, y)
			{
			    this.x = x;
			    this.y = y;
			}
			
			function GetObjPos(ATarget)
			{
			    var target = ATarget;
			    var pos = new CPos(target.offsetLeft, target.offsetTop);
			    var target = target.offsetParent;
			     while (target)
   				 {
       			 pos.x += target.offsetLeft;
        		pos.y += target.offsetTop;
        		target = target.offsetParent
   				 }
			    return pos;
			}

		//显示标签选择框
		function showLabel(idx,id,obj){
			var parent = document.getElementById(obj);
			var pos = GetObjPos(parent.parentNode);
			l = document.getElementById("labelDiv");
			l.style.left = pos.x+"px";
			l.style.top = pos.y+"px";
			$("#labelDiv").show();
			selectedtag(idx);
			$("#confirm").val(id);
		}
		//点击确定按钮后
		function confirmLabel(){
			$("#labelDiv").hide();
			 confirm();
		}
		//隐藏标签选择框
		function hideLabel(){
			$("#labelDiv").hide();
		}
	</script>

	
	<script>
		function confirm(){
			var topicId = document.getElementById("confirm").value;
			var checkbox =  document.getElementsByName("tags");
			var tag = document.getElementById("tag").value;
			var username = document.getElementById("username").value;
			var p = document.getElementById("pageindex").value;
			var string='';
			for(var i = 0; i<checkbox.length;i++){
				if(checkbox[i].checked==true){
					string = string+"tag="+checkbox[i].value+'&';
				}
			}
			window.location.href="?op=resettag&"+string+"id="+topicId+"&tagId="+tag+"&p="+p+"&username="+username;
		};
		
	</script>
	<script>
		function selecttag(){
			var tagId = document.getElementById("tagId");
			var tag = document.getElementById("tag");
			for(var i=0;i<tagId.options.length;i++)
    		{
    			if(tag.value==tagId.options[i].value)
    				tagId.options[i].selected = true;
    		}
		};
	</script>
	<script>
		function ajaxFunction( url ,idx)
   		{
			var xmlHttp;
			var content = document.getElementById("manage"+idx).innerHTML;
			var u;
			var status;
			if(content=="屏蔽"){
				u=url+"&op=shield";
				content = "恢复";
				status = "已屏蔽";
			}else{
				u=url+"&op=recover";
				content = "屏蔽";
				status = "正常";
			}
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
					document.getElementById("manage"+idx).innerHTML=content;
					document.getElementById("status"+idx).innerHTML=status;
				}
			}
			xmlHttp.open( "POST", u, true );
			xmlHttp.send( null );
		};
		function selectedtag(idx){
			var checkbox =  document.getElementsByName("tags");
			var selectedtag =document.getElementsByName("selectedtag"+idx);
			for(var i = 0; i<checkbox.length;i++){
				checkbox[i].checked=false;
			}
			for(var i = 0; i<checkbox.length;i++){
				for(var j = 0; j<selectedtag.length;j++){
					if(checkbox[i].id==selectedtag[j].innerHTML){
						checkbox[i].checked=true;
					}
				}
			}
		};
	</script>
	<script type="text/javascript">
	//container 容器，count 总页数 pageindex 当前页数
	function setPage( count, pageindex) {
	var container = document.getElementById("page");
	var count = document.getElementById("pagecount").value;
	var pageindex = document.getElementById("pageindex").value;
	var op = document.getElementById("op").value;
	var tagid = document.getElementById("tag").value;
	var username = document.getElementById("username").value;
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
      window.location.href='/user/managetopic.jspx?op='+op+'&p='+inx+'&tagId='+tagid+'&username='+username;
      return false;
    }
    for (var i = 1; i < oAlink.length - 1; i++) { //点击页码
      oAlink[i].onclick = function() {
        inx = parseInt(this.innerHTML);
         window.location.href='/user/managetopic.jspx?op='+op+'&p='+inx+'&tagId='+tagid+'&username='+username;
        return false;
      }
    }
    oAlink[oAlink.length - 1].onclick = function() { //点击下一页
      if (inx == count) {
        return false;
      }
      inx++;
      window.location.href='/user/managetopic.jspx?op='+op+'&p='+inx+'&tagId='+tagid+'&username='+username;
      return false;
    }
  } ()
}function onloadFunction(){
	setPage();
	selecttag();
};
 window.onload = onloadFunction;
</script>
</body>
</html>