package com.ourlinc.itbbs.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

import com.ourlinc.itbbs.user.User;
import com.ourlinc.itbbs.user.role.Role;
/**
 * 权限filter
 * @author 陈洁民
 *
 */
public class UserFilter extends OncePerRequestFilter{

	@Override
	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
			String uri = request.getRequestURI();
			User own = (User)request.getSession().getAttribute("own");
			if(null==own){
				request.setAttribute("error", "请先登录");
				response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
				return ;
			}
			if(uri.indexOf("/managereply.jspx")!=-1){
				if(!own.isHasPermission(Role.RECVOER_REPLY)&&!own.isHasPermission(Role.SHIELD_REPLY)){//是否有回复管理的权限
					request.setAttribute("error", "请先登录");
					response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
					return ;
				}
			}
			if(uri.indexOf("/managecomment.jspx")!=-1){
				if(!own.isHasPermission(Role.RECVOER_COMMENT)&&!own.isHasPermission(Role.SHIELD_COMMENT)){//是否有评论管理的权限
					request.setAttribute("error", "你没有评论管理的权限");
					response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
					return ;
				}
			}else if(uri.indexOf("/managetopic.jspx")!=-1){
				if(!own.isHasPermission(Role.RECVOER_TOPIC)&&!own.isHasPermission(Role.SHIELD_TOPIC)){//是否有话题管理的权限
					request.setAttribute("error", "你没有话题管理的权限");
					response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
					return ;
				}
			}else if(uri.indexOf("/managetag.jspx")!=-1){
				if(!own.isHasPermission(Role.DELETE_TAG)&&!own.isHasPermission(Role.CREATE_TAG)){//是否有标签管理的权限
					request.setAttribute("error", "你没有标签管理的权限");
					response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
					return ;
				}
			}else if(uri.indexOf("/manageuser.jspx")!=-1){//是否有用户管理的权限
				if(!own.isHasPermission(Role.RECOVER_USER)&&!own.isHasPermission(Role.BALCKLIST_USER)){
					request.setAttribute("error", "你没有管理用户的权限");
					response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
					return ;
				}
			}
			filterChain.doFilter(request, response); 
		
	}

}
