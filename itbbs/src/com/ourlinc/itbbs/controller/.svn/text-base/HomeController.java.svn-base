package com.ourlinc.itbbs.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ourlinc.itbbs.forum.Comment;
import com.ourlinc.itbbs.forum.Favor;
import com.ourlinc.itbbs.forum.ForumService;
import com.ourlinc.itbbs.forum.Praise;
import com.ourlinc.itbbs.forum.Tag;
import com.ourlinc.itbbs.forum.Topic;
import com.ourlinc.itbbs.user.User;
import com.ourlinc.itbbs.user.UserService;
import com.ourlinc.tern.ResultPage;
import com.ourlinc.web.util.ServletUtils;
/**
 * 通用controller
 * @author 陈洁民
 *
 */
@Controller
public class HomeController {
	
	public final static Logger _Logger = LoggerFactory.getLogger(HomeController.class);
	
	@Resource(name="userService")
	private UserService m_UserSerive;
	
	@Resource(name="forumService")
	private ForumService m_ForumSerive;
	/**主页
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping
	String index(HttpServletRequest request,HttpServletResponse response){
		ResultPage<Topic> topics = m_ForumSerive.searchTopics(Topic.STATUS_NORMAL.id, null,null,null, Topic.ORDER_MOST_NEW);//拿到最新的10条话题
		topics.gotoPage(1);
		request.setAttribute("topics", topics);
		return "index";
	}
	/**
	 * 标签汇
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping
	String tags(HttpServletRequest request,HttpServletResponse response){
		ResultPage<Tag> tags =  m_ForumSerive.searchTags(Tag.STATUS_NORMAL.id);//拿到所有标签
		List<Tag> rootTags =  m_ForumSerive.searchRootTags(Tag.STATUS_NORMAL.id);//拿到根标签，也就是父标签为空的标签
		tags.setPageSize(tags.getCount());
		tags.gotoPage(1);
		request.setAttribute("tags", tags);
		request.setAttribute("rootTags", rootTags);
		return "tags";
		
	}
	/**
	 * 用户登录
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping
	String login(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String username = ServletUtils.inputValToString(request.getParameter("name"));
		String password = ServletUtils.inputValToString(request.getParameter("password"));
		User user = m_UserSerive.login(username, password);
		if(null==user){//user 为 null 表示登录失败
			request.setAttribute("error", "账号或者密码错误");
			response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
		}
		request.getSession().setAttribute("own", user);//登录成功后，把user对象放在session里面
		ServletUtils.sendRedirect("index.jspx", request, response);
		return null;
	}
	/**
	 * 所有话题
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping
	String forums(HttpServletRequest request,HttpServletResponse response){
		String op = ServletUtils.inputValToString(request.getParameter("op"));
		int p = ServletUtils.inputValToInt(request.getParameter("p"), 1);
		ResultPage<Tag> tags = m_ForumSerive.searchTags(Tag.STATUS_NORMAL.id);//标签集合，用于forums.jsp页面左边栏显示出标签
		String title = null;
		ResultPage<Topic> topics = null;
		if("".equals(op)||"newest".equals(op)){//最新话题
			topics = m_ForumSerive.searchTopics(Topic.STATUS_NORMAL.id, null,null, null,Topic.ORDER_MOST_NEW);
			title="最新话题";
		}else if("browerest".equals(op)){//最多人浏览
			topics = m_ForumSerive.searchTopics(Topic.STATUS_NORMAL.id, null,null, null,Topic.ORDER_MOST_BROWSE);
			title="最多人浏览";
		}else if("commentest".equals(op)){//最多人评论
			topics = m_ForumSerive.searchTopics(Topic.STATUS_NORMAL.id, null, null,null,Topic.ORDER_MOST_COMMENT);
			title="最多人评论";
		}else if("favorest".equals(op)){//最多人收藏
			topics = m_ForumSerive.searchTopics(Topic.STATUS_NORMAL.id, null,null, null,Topic.ORDER_MOST_FAVOR);
			title="最多人收藏";
		}else if("praisest".equals(op)){//最多人赞
			topics = m_ForumSerive.searchTopics(Topic.STATUS_NORMAL.id, null,null, null,Topic.ORDER_MOST_PRAISE);
			title="最多人赞";
		}else if("tag".equals(op)){//某个标签下的话题
			String id = ServletUtils.inputValToString(request.getParameter("id"));
			Tag tag = m_ForumSerive.getTag(id);
			request.setAttribute("tag", tag);
			topics = tag.getTopics();
			title=tag.getName();
		}
		if(null!=topics){
			topics.gotoPage(p);
		}
		if(null!=tags&&tags.getCount()>0){
			tags.setPageSize(tags.getCount());
			tags.gotoPage(1);
		}
		request.setAttribute("p", p);
		request.setAttribute("op", op);
		request.setAttribute("title", title);
		request.setAttribute("tags", tags);
		request.setAttribute("topics", topics);
		return "forums";		
	}
	/**
	 * 查看某个用户的主页
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping
	String viewuser(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String userId =  ServletUtils.inputValToString(request.getParameter("id"));
		int p = ServletUtils.inputValToInt(request.getParameter("p"), 1);
		User user  = m_UserSerive.getUser(userId);
		if(null!=user){//user不为空，则找到该用户
			request.setAttribute("user", user);
			ResultPage<Topic> topics = user.getTopics();
			topics.gotoPage(p);
			request.setAttribute("topics", topics);
		}else{
			request.setAttribute("error", "找不到该用户");
			response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
		}
		return "viewuser";		
	}
	/**
	 * 查看某条话题
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping
	String viewforum(HttpServletRequest request,HttpServletResponse response){
		String userId =  ServletUtils.inputValToString(request.getParameter("id"));
		int p = ServletUtils.inputValToInt(request.getParameter("p"), 1);
		Topic topic = m_ForumSerive.getTopic(userId);
		if(null!=topic){
			topic.addBrowseCount();//话题的浏览数+1
			ResultPage<Comment> comments = topic.getComments();
			comments.gotoPage(p);
			User user = (User)request.getSession().getAttribute("own");
			if(null!=user){
				Praise praise = m_ForumSerive.getPraise(user, topic);
				request.setAttribute("praise", praise);
				Favor favor = m_ForumSerive.getFavor(user, topic);
				request.setAttribute("favor", favor);
			}
			request.setAttribute("topic", topic);
			request.setAttribute("p", p);
			request.setAttribute("comments", comments);
		}
		return "viewforum";		
	}
}
