<%@ page contentType="text/html; charset=UTF-8" session="false"
	isErrorPage="true"%>
<%
	StringBuilder sb = new StringBuilder(1024);
	String uri = (String) request.getAttribute("javax.servlet.forward.request_uri");
	if (null == uri || 0 == uri.length()) {
		uri = request.getRequestURI();
	}
	sb.append("出错了(500)：").append(uri);
	String q = request.getQueryString();
	if (null != q && q.length() > 0) {
		sb.append('?').append(q);
	}
	sb.append('\n');
	Throwable ex = (Throwable) request.getAttribute("exception");
	if (null == ex) {
		ex = exception;
	}
	if (null != ex) {
		//sb.append(ex.toString()).append('\n');
		Misc.printStackTrace(ex, sb);
	}
	sb.append("\n---headers---\n");
	Enumeration<String> e = request.getHeaderNames();
	if (null != e) {
		while (e.hasMoreElements()) {
			String s = e.nextElement();
			sb.append(s).append('=').append(request.getHeader(s)).append('\n');
		}
	}
	if (null != ex
			&& ("org.eclipse.jetty.util.Utf8Appendable$NotUtf8Exception".equals(ex
					.getClass().getName())
					|| "java.lang.IllegalArgumentException".equals(ex.getClass().getName())
					|| "org.eclipse.jetty.util.Utf8Appendable$NotUtf8Exception".equals(ex
							.getClass().getName()) || "org.eclipse.jetty.io.EofException"
					.equals(ex.getClass().getName()))) {
		//这部分错误，暂时只警告，避免太多错误信息
		Misc._Logger.warn(sb.toString());
	} else {
		Misc._Logger.error(sb.toString());
	}
	try {
		response.getWriter();
	} catch (IllegalStateException isex) {
		//已用流的方式（response.getOutputStream()）输出过，无谓再试啦
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.ourlinc.tern.util.Misc"%>
<%@page import="java.util.Enumeration"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>itbbs - 出错啦(500)</title>
<meta name="author" content="ourlinc"/>
<meta name="copyright" content="Copyright 2009 Ourlinc,Co.,Ltd"/>
<script>
</script>
</head>
<body>
<jsp:include page="/menu.jsp" />
<div class="bodycontent">
	<p style="margin: 42px 0 0 42px;line-height: 25px"><b>很抱歉，系统出错了</b>
	<div style="margin-left: 42px;">
		<%
			if (null != ex) {
				//若当前登录用户是管理员，直接显示详细错误
				/*UserSession us = Authorizer.getSessionDefault(request);
				if (null != us && us.getUser().checkRole(Role.ADMINSTRATOR)) {*/
					out.print("<PRE style=\"width: 920;color:#CCCCCC\" id=detail>");
					out.println(sb.toString());
					/*
					out.println("");
					CharArrayWriter write = new CharArrayWriter();
					ex.printStackTrace(new PrintWriter(write));
					String trace = write.toString();
					write = null;
					ex = null;
					out.println(trace);
					*/
					out.print("</PRE>");
				//}
			}
		%>
	</div>
</div>
</body>
</html>