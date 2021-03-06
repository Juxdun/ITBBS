<%@ page contentType="text/html; charset=UTF-8" session="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>修改话题页 </title>
<script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
<style>
	.entry{
			margin: 3px;
			padding: 3px 21px;
			border-radius: 0.325em 0.325em 0.325em 0.325em;
			color: #4D8796;
			background-color: #E6F4F9;
			border: 1px solid #CFDBE0;
			float: left;
			width:108px;
		}
</style>
</head>
<body>
<jsp:include page="../menu.jsp" />
<div class="menu">
	<div style="width:900px;margin: auto">
		<span style="color:red;">您所在的位置：修改话题</span>
		<form action="/user/editforum.jspx" id="forum" method="post" onsubmit="return isEmpty()">
			<input type="hidden" name="op" value="edit" />
			<input type="hidden" name="id" value="${topic.id}" />
			<div style="padding-top: 14px;color:#52A954">
			标题：<input id="topicName" maxlength="60" size=45 type="text" name="name" id="subject" value="${topic.name}" />&nbsp;&nbsp;&nbsp;&nbsp;
			<span style="color:#CCCCCC">60个字以内</span>
			</div>
			<div style="padding: 14px 0;color:#A95252">
			标签：<a href="javascript:showTag();">选择</a>&nbsp;<span style="color:#CCCCCC">系统将根据您的选择进行更细致的归类。</span><br/>
			<span id="show_label">
					<c:forEach items="${topic.tags}" var="tag">
						<a href="${tag.id}" name="selectedtag" class="entry">${tag.name}</a>
					</c:forEach>
				</span>
			<br/>
			<div id="tagdiv" style="display:none">
				<br/>
				<c:forEach items="${tags}" var="tag">
					${tag.name}<input id="${tag.name}" name="tags" type="checkbox" value="${tag.id}"/>&nbsp;
				</c:forEach>
				<input type="button" value="确定"  onclick="confirm()" id="confirmButton" class="button"  />
			</div>
			
			</div>
			<div id="preview_div" style="display: none;">
			</div>
			<div id="edit_div">
			<textarea id="editor_id" name="content" style="width:900px;height:400px;">${topic.content}</textarea>
			</div>
			<input style="margin: 1rem 0" type="submit" name="send" class="button" value="发表话题" />
			<input id="preview" style="margin: 1rem 0 1rem 1rem " type="button" class="button" name="preview" value="预 览" />
			<div id="overlayInLabel" class="overlay"></div>	
		</form>	
	</div>
</div>
	

<!-- 选择标签时弹出层 -->
<div id="labelDiv"  class="labelDiv"  style="display:none;">
	<table class="labelTable">
		<tr>
		<td colspan="8" align="left" style="width:600px">系统将根据您的选择进行更细致的归类。
		<input type="button" value="确定"  id="confirmButton" class="button"  />
		<input type="button" value="关闭" onclick="hideLabel();"  class="button" />
		</td>
		</tr>
		<tr>
		<td  align="left">
		<div class="label"> 
			<input type="checkbox" name="label" value="" id="" /><span>前端</span>
		</div>
		</td>
		<td  align="left">
		<div class="label"> 
			<input type="checkbox" name="label" value="" id="" /><span>设计与规划</span>
		</div>
		</td>
		</tr>
	</table>
</div>

<div class="w" id="footer" style="margin:auto">
    <div class="rt"><span class="Copyright">Copyright © ITBBs学习与交流分享平台</span><br/>
	</div>
</div>
<script charset="utf-8" src="../kindeditor/kindeditor.js"></script>
<script charset="utf-8" src="../kindeditor/lang/zh_CN.js"></script>
<script charset="utf-8" src="../js/selectlabel.js"></script>
<script><!--
var editor;
KindEditor.ready(function(K) {
	var editor = K.create('textarea[name="content"]', {
		cssPath : '../kindeditor/plugins/code/prettify.css',
		uploadJson : 'upload_photo.jspx',
		fileManagerJson : '../kindeditor/jsp/file_manager_json.jsp',
		allowFileManager : true,
		afterCreate : function() {
			var self = this;
			K.ctrl(document, 13, function() {
				self.sync();
				document.forms['example'].submit();
			});
			K.ctrl(self.edit.doc, 13, function() {
				self.sync();
				document.forms['example'].submit();
			});
		}
	});
	K('input[name=send]').click(function(e) {
		checkInput(editor.html());
	});
	K('input[name=preview]').click(function(e) {
		preview(editor.html());
	});
	editor.focus();
});

//检查表单的数据合法性
function checkInput(v){
	var title=$.trim($("#title").val());
	var content=$.trim(v);
	if(title.length==0){
		showMsg("请输入标题");
		return false;
	}else if($("#title").val().length>60){
		showMsg("标题过长");
		return false;
	}else if(content.length==0){
		showMsg("请输入内容");
		return false;
	}else{
		return true;
	}
}

function selLabels(the){
	var xy = new Object();
	xy.x = $(the).offset().left;
	xy.y = $(the).offset().top;
	//GetControlPos(the);
	selectLabel = new SelectLabel($("#labels").val(),TYPE_INPUT_CHECKBOX,xy,refreshLabel);
	selectLabel.show();
}

function refreshLabel(list){
	$("#labels").val("");
	$("#show_label").html("");
	for(i=0;i<list.length;i++){
		$("#labels").val($("#labels").val()+list[i].id+",");
		$("#show_label").html($("#show_label").html()+'<a target="_blank" href="/forums.jspx?labelid='+EscapeURI(list[i].id)+'" class="labelentry">'+list[i].name+'</a>');
	}
}
//预览内容
function preview(html){
	if("取 消"==$("#preview").val()){
		$("#preview_div").css('display','none');
		$("#edit_div").css('display','');
		$("#preview").val("预 览");
	}else{
		$("#preview_div").html(html);
		$("#preview_div").css('display','');
		$("#edit_div").css('display','none');
		$("#preview").val("取 消");
	}

}
//显示标签选择框
function showLabel(){
	$("#overlayInLabel").show();
	$("#labelDiv").show();
}
//隐藏标签选择框
function hideLabel(){
	$("#overlayInLabel").hide();
	$("#labelDiv").hide();
}
$(function(){
//选择标签后的确定事件
$("#confirmButton").click(function(){
	$("#show").html("");
	$(".label").each(function(){
		if($(this).find("input[name=label]").attr("checked")){
			var name=$(this).children("span").html();
			var a=Math.ceil(Math.round(Math.random()*5));
			var color="color"+a;//随机样式
			$("#show_label").append("<a href='#' class='"+color+"'>"+name+"</a>&nbsp;&nbsp;&nbsp;&nbsp;")
		};
	});
	hideLabel();
});
});
--></script>
<script>
	function isEmpty(){
		var topicName = document.getElementById("topicName").value;
		if(topicName==""){
			alert("话题名不能为空");
			return false;		
		}else{
			if(topicName.length>60){
				alert("标题过长");
				return false;
			}
		}
		return true;
	};
	function showTag(){
		var div = document.getElementById("tagdiv");
		div.style.display ='inline';
	}
	function confirm(){
		var span = document.getElementById("show_label");
		var checkbox =  document.getElementsByName("tags");
		var div = document.getElementById("tagdiv");
		span.innerHTML="";
		for(var i = 0; i<checkbox.length;i++){
			if(checkbox[i].checked){
				span.innerHTML=span.innerHTML+"<a href='/forums.jspx?op=tag&id="+checkbox[i].value+"' target='_blank' class='entry'>"+checkbox[i].id+"</a>"+"&nbsp;&nbsp;&nbsp;&nbsp;";
			}
		}
		div.style.display ='none';
	}
	function selectedtag(){
		var checkbox =  document.getElementsByName("tags");
		var selectedtag =document.getElementsByName("selectedtag");
		for(var i = 0; i<checkbox.length;i++){
			for(var j = 0; j<selectedtag.length;j++){
				if(checkbox[i].id==selectedtag[j].innerHTML){
					checkbox[i].checked=true;
				}
			}
		}
	}
	window.onload=selectedtag;
</script>
</body>
</html>

