package com.ourlinc.itbbs.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ourlinc.itbbs.forum.Comment;
import com.ourlinc.itbbs.forum.CommentReply;
import com.ourlinc.itbbs.forum.Favor;
import com.ourlinc.itbbs.forum.ForumService;
import com.ourlinc.itbbs.forum.Reply;
import com.ourlinc.itbbs.forum.Tag;
import com.ourlinc.itbbs.forum.Topic;
import com.ourlinc.itbbs.user.User;
import com.ourlinc.itbbs.user.UserService;
import com.ourlinc.tern.ResultPage;
import com.ourlinc.tern.ext.ResultPages;
import com.ourlinc.web.util.ServletUtils;

@Controller
public class UserController {
	
	public final static Logger _Logger = LoggerFactory.getLogger(UserController.class);
	
	@Resource(name="userService")
	private UserService m_UserSerive;
	
	@Resource(name="forumService")
	private ForumService m_ForumSerive;
	/**
	 * 用户登出
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping
	String logout(HttpServletRequest request,HttpServletResponse response){
		request.getSession().setAttribute("own", null);//用null覆盖session里面原来的user对象，则为登出
		ServletUtils.sendRedirect("/index.jspx", request, response);
		return null;	
		
	}
	/**
	 * 发表话题
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping
	String writeforum(HttpServletRequest request,HttpServletResponse response) throws IOException{		
		String op = ServletUtils.inputValToString(request.getParameter("op"));
		String name = ServletUtils.inputValToString(request.getParameter("name"));
		String content = ServletUtils.inputValToString(request.getParameter("content"));
		if("write".equals(op)){//发表话题
			String [] tagsId = request.getParameterValues("tags");
			List<String> tags = null;//标签id集合
			if(null!=tagsId&&tagsId.length>0){
				tags = new ArrayList<String>();
				for(String tagId : tagsId){
					tags.add(tagId);
				}
			}
			User user = (User)request.getSession().getAttribute("own");
			Topic topic = user.createTopic(name, content, tags);//创建话题
			if(null==topic){//话题为null，则发表话题失败
				request.setAttribute("error", "用户被拉黑发表话题失败");
				response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
			}
			ServletUtils.sendRedirect("/index.jspx", request, response);
		}
		ResultPage<Tag> tags = m_ForumSerive.searchTags(Tag.STATUS_NORMAL.id);//取出所有的标签，用于发表话题时的标签选择
		if(tags.getCount()>0){
			tags.setPageSize(tags.getCount());
			tags.gotoPage(1);
			request.setAttribute("tags", tags);
		}
		return "user/writeforum";
	}
	/**
	 * 修改话题
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping
	String editforum(HttpServletRequest request,HttpServletResponse response) throws IOException{
		User own = (User)request.getSession().getAttribute("own");
		String id = ServletUtils.inputValToString(request.getParameter("id"));
		String op = ServletUtils.inputValToString(request.getParameter("op"));
		Topic topic = m_ForumSerive.getTopic(id);
		if(!topic.getUser().getId().getId().equals(own.getId().getId())){//如果标题的用户id不等于登录人的用户id，则不能修改
			request.setAttribute("error", "不能修改别人的话题");
			response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
		}else if(own.getStatus().equals(User.STATUS_BLACKLIST)){
			request.setAttribute("error", "用户被拉黑，修改话题失败");
			response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
		}
		if("edit".equals(op)){//修改话题
			String name = ServletUtils.inputValToString(request.getParameter("name"));
			String content = ServletUtils.inputValToString(request.getParameter("content"));
			String [] tagsId = request.getParameterValues("tags");
			List<String> tags = null;//标签id集合
			if(null!=tagsId&&tagsId.length>0){
				tags = new ArrayList<String>();
				for(String tagId : tagsId){
					tags.add(tagId);
				}
			}
			topic.setTags(tags);
			topic.setName(name);
			topic.changeContent(content);
			ServletUtils.sendRedirect("/viewforum.jspx?id="+topic.getId().getId(), request, response);
		}
		request.setAttribute("topic", topic);
		ResultPage<Tag> tags = m_ForumSerive.searchTags(Tag.STATUS_NORMAL.id);//取出所有的标签，用于修改话题时的标签调整
		if(tags.getCount()>0){
			tags.setPageSize(tags.getCount());
			tags.gotoPage(1);
			request.setAttribute("tags", tags);
		}
		
		return "user/editforum";
	}
	/**
	 * 我的话题
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping
	String myforum(HttpServletRequest request,HttpServletResponse response){
		User user = (User)request.getSession().getAttribute("own");
		int p = ServletUtils.inputValToInt(request.getParameter("p"), 1);
		ResultPage<Topic> topics = user.getTopics();
		topics.gotoPage(p);
		request.setAttribute("topics", topics);
		request.setAttribute("p", p);
		request.setAttribute("user", m_UserSerive.getUser(user.getId().getId()));
		return "user/myforum";
	}
	/**
	 * 发表评论
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping
	String writecomment(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String id =ServletUtils.inputValToString(request.getParameter("id"));
		String content =ServletUtils.inputValToString(request.getParameter("content"));
		int p = ServletUtils.inputValToInt(request.getParameter("p"), 1);
		User own = (User)request.getSession().getAttribute("own");
		Topic topic = m_ForumSerive.getTopic(id);
		Comment comment =topic.createComment(content, own);//发表话题
		if(null == comment){
			request.setAttribute("error", "用户被拉黑，发表评论失败");
			response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
		}
		request.setAttribute("topic", topic);
		ServletUtils.sendRedirect("/viewforum.jspx?id="+id+"&p="+p, request, response);
		return null;
	}
	/**
	 * 发表回复
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping
	String writereply(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String id =ServletUtils.inputValToString(request.getParameter("id"));
		String targetId =ServletUtils.inputValToString(request.getParameter("targetId"));
		String content =ServletUtils.inputValToString(request.getParameter("content"));
		int p = ServletUtils.inputValToInt(request.getParameter("p"), 1);
		User own = (User)request.getSession().getAttribute("own");
		Comment comment = m_ForumSerive.getComment(id);
		Reply reply =comment.createReply(own, m_UserSerive.getUser(targetId), content);//发表回复
		if(null==reply){
			request.setAttribute("error", "用户被拉黑，回复失败失败");
			response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
		}
		ServletUtils.sendRedirect("/viewforum.jspx?id="+comment.getTopic().getId().getId()+"&p="+p, request, response);
		return null;
	}
	/**
	 * 修改个人信息
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping
	String info(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String op = ServletUtils.inputValToString(request.getParameter("op"));
		User own = (User)request.getSession().getAttribute("own");
		if("edit".equals(op)){//修改信息
			String phone = ServletUtils.inputValToString(request.getParameter("phone"));
			String oldPassword = ServletUtils.inputValToString(request.getParameter("oldPassword"));
			String newPassword = ServletUtils.inputValToString(request.getParameter("newPassword"));
			String nickname = ServletUtils.inputValToString(request.getParameter("nickname"));
			String qq = ServletUtils.inputValToString(request.getParameter("qq"));
			String highestEducation = ServletUtils.inputValToString(request.getParameter("highestEducation"));
			String graduateSchool = ServletUtils.inputValToString(request.getParameter("graduateSchool"));
			String position = ServletUtils.inputValToString(request.getParameter("position"));
			String signature = ServletUtils.inputValToString(request.getParameter("signature"));
			User user = m_UserSerive.getUser(own.getId().getId());//取出用户对象
			user.setGraduateSchool(graduateSchool);
			user.setHighestEducation(highestEducation);
			user.setNickname(nickname);
			user.setPhone(phone);
			user.setPosition(position);
			user.setQQ(qq);
			user.setSignature(signature);
			if(!oldPassword.equals("")&&!newPassword.equals("")){//如果密码不为空，则修改密码
				if(!user.changePassword(null, newPassword, oldPassword)){//changePassword返回false则表示修改密码失败
					request.setAttribute("error", "密码错误");
					response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
				}
			}
		}
		//User admin = m_UserSerive.login("admin", "admin");
		request.setAttribute("user", m_UserSerive.getUser(own.getId().getId()));
		return "user/info";
	}
	/**
	 * 赞操作
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping
	String praise(HttpServletRequest request,HttpServletResponse response){
		String op = ServletUtils.inputValToString(request.getParameter("op"));
		String id = ServletUtils.inputValToString(request.getParameter("id"));
		User user = (User)request.getSession().getAttribute("own");
		if("praise".equals(op)){//点赞
			user.praise(m_ForumSerive.getTopic(id));
		}
		if("cancelpraise".equals(op)){//取消点赞
			user.cancelPraise(m_ForumSerive.getTopic(id));
		}
		return null;
	}
	/**
	 * 收藏操作
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping
	String favor(HttpServletRequest request,HttpServletResponse response){
		String op = ServletUtils.inputValToString(request.getParameter("op"));
		String id = ServletUtils.inputValToString(request.getParameter("id"));
		User user = (User)request.getSession().getAttribute("own");
		request.setAttribute("user", m_UserSerive.getUser(user.getId().getId()));
		if("favor".equals(op)){//收藏
			user.favor(m_ForumSerive.getTopic(id));
		}
		if("cancelfavor".equals(op)){//取消收藏
			user.cancelfavor(m_ForumSerive.getTopic(id));
		}
		ServletUtils.sendRedirect("/user/myfavor.jspx", request, response);
		return null;
	}
	/**
	 * 我的收藏
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping
	String myfavor(HttpServletRequest request,HttpServletResponse response){
		User user = (User)request.getSession().getAttribute("own");
		int p = ServletUtils.inputValToInt(request.getParameter("p"), 1);
		ResultPage<Favor> favors = user.getFavors();
		favors.gotoPage(p);
		request.setAttribute("favors", favors);
		request.setAttribute("p", p);
		request.setAttribute("user", m_UserSerive.getUser(user.getId().getId()));
		return "user/myfavor";
	}
	/**
	 * 我的评论
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping
	String mycomment(HttpServletRequest request,HttpServletResponse response){
		User own = (User)request.getSession().getAttribute("own");
		int p = ServletUtils.inputValToInt(request.getParameter("p"), 1);
		own = m_UserSerive.getUser(own.getId().getId());
		ResultPage<CommentReply> rp = m_ForumSerive.myComment(Comment.STATUS_NORMAL.id, own);//取我的评论列表
		rp.gotoPage(p);
		request.setAttribute("mycomment",rp );
		request.setAttribute("p", p);
		request.setAttribute("user", own);
		return "user/mycomment";
	}
	/**
	 * 我的消息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping
	String mymessage(HttpServletRequest request,HttpServletResponse response){
		User own = (User)request.getSession().getAttribute("own");
		int p = ServletUtils.inputValToInt(request.getParameter("p"), 1);
		own = m_UserSerive.getUser(own.getId().getId());
		ResultPage<CommentReply> rp = m_ForumSerive.myMessage(Comment.STATUS_NORMAL.id, own);//取我的消息列表
		rp.gotoPage(p);
		own.resetNewMsgCount();//重置消息提醒（0）
		request.setAttribute("mymessage",rp );
		request.setAttribute("p", p);
		request.setAttribute("user", own);
		return "user/mymessage";
	}
	/**
	 * 新消息提醒
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping
	String newmessage(HttpServletRequest request,HttpServletResponse response) throws IOException{
		User own = (User)request.getSession().getAttribute("own");
		own = m_UserSerive.getUser(own.getId().getId());
		PrintWriter out = response.getWriter();    
        out.println(own.getNewMsgCount());//把新消息数传到前台    
        out.flush();    
        out.close();    
		return null;
	}
	/**
	 * 修改我的评论
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping
	String editcomment(HttpServletRequest request,HttpServletResponse response){
		User own = (User)request.getSession().getAttribute("own");
		String op = ServletUtils.inputValToString(request.getParameter("op"));
		String type = ServletUtils.inputValToString(request.getParameter("type"));
		String id = ServletUtils.inputValToString(request.getParameter("id"));
		own = m_UserSerive.getUser(own.getId().getId());
		if("".equals(op)){//跳到修改页面
			if("comment".equals(type)){//type为comment，取要修改的评论对象
				Comment comment = m_ForumSerive.getComment(id);
				request.setAttribute("comment", comment);
			}else{//取要修改的回复对象
				Reply reply = m_ForumSerive.getReply(id);
				request.setAttribute("reply", reply);
			}
		}else if("edit".equals(op)){
			String content = ServletUtils.inputValToString(request.getParameter("content"));
			if("comment".equals(type)){//修改评论
				Comment comment = m_ForumSerive.getComment(id);
				comment.setContent(content);
			}else{//修改回复
				Reply reply = m_ForumSerive.getReply(id);
				reply.setContent(content);
			}
			ServletUtils.sendRedirect("/user/mycomment.jspx", request, response);
		}
		request.setAttribute("type", type);
		return "user/editcomment";
	}
	
	/**
	 * 用户管理
	 * @throws IOException 
	 */
	@RequestMapping
	String manageuser(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String op = ServletUtils.inputValToString(request.getParameter("op"));
		int p = ServletUtils.inputValToInt(request.getParameter("p"), 1);
		ResultPage<User> list;
		User admin = (User)request.getSession().getAttribute("own");
		String userId = ServletUtils.inputValToString(request.getParameter("userId"));
		User u = m_UserSerive.getUser(userId);
		if("registerUser".equals(op)){	// 注册用户
			String username = ServletUtils.inputValToString(request.getParameter("name"));
			String password = ServletUtils.inputValToString(request.getParameter("psw"));
			User user =m_UserSerive.RegisterUser(admin, username, password);
			if(null==user){
				request.setAttribute("error", "用户名已经存在");
				response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
			}
		}else if ("setTrainingDate".equals(op)) {	// 设置培训日期
			Date date = ServletUtils.inputValToDate(request.getParameter("date"));
			u.installTrainingDate(admin, date);
		}else if ("blacklist".equals(op)) {	// 拉黑用户
			u.blacklist(admin);
		}else if ("recover".equals(op)) {	// 取消拉黑
			u.recover(admin);
		}else if ("getBackPwd".equals(op)) {	// 找回密码
			String pwd = ServletUtils.inputValToString(request.getParameter("pwd"));
			u.changePassword(admin, pwd, null);
		}
		list = admin.getUsers(0);
		list.gotoPage(p);
		request.setAttribute("users", list);
		request.setAttribute("p", p);
		return "user/manageuser";
	}
	
	/**
	 * 标签管理
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping
	String managetag(HttpServletRequest request,HttpServletResponse response){
		String op = ServletUtils.inputValToString(request.getParameter("op"));
		ResultPage<Tag> tags;
		User admin = (User)request.getSession().getAttribute("own");
		if("add".equals(op)){	// 添加标签
			String name = ServletUtils.inputValToString(request.getParameter("name"));
			String parentId = ServletUtils.inputValToString(request.getParameter("parent"));
			admin.createTag(m_ForumSerive.getTag(parentId), name);
		}else if ("delete".equals(op)) {	// 删除标签
			String id = ServletUtils.inputValToString(request.getParameter("id"));
			m_ForumSerive.getTag(id).delete(admin);
		}
		tags =  m_ForumSerive.searchTags(Tag.STATUS_NORMAL.id);
		tags.setPageSize(tags.getCount());
		tags.gotoPage(1);
		request.setAttribute("tags", tags);
		return "user/managetag";
	}
	
	/**
	 * 话题管理
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping
	String managetopic(HttpServletRequest request,HttpServletResponse response){
		String op = ServletUtils.inputValToString(request.getParameter("op"));
		int p = ServletUtils.inputValToInt(request.getParameter("p"), 1);
		ResultPage<Topic> list =null;
		User admin = (User)request.getSession().getAttribute("own");
		String username = ServletUtils.inputValToString(request.getParameter("username"));
		String tagId = ServletUtils.inputValToString(request.getParameter("tagId"));
		Date date = ServletUtils.inputValToDate(request.getParameter("date"));
		if ("shield".equals(op)) {	// 屏蔽话题
			String id = ServletUtils.inputValToString(request.getParameter("id"));
			m_ForumSerive.getTopic(id).shield(admin);
		}
		else if ("recover".equals(op)) {	// 恢复话题
			String id = ServletUtils.inputValToString(request.getParameter("id"));
			m_ForumSerive.getTopic(id).recover(admin);
			
		}else if("search".equals(op)){//搜索话题
			User user = m_UserSerive.getUserByName(0, username);
			if("".equals(username)||null!=user){
				list = m_ForumSerive.searchTopics(0, user,date,tagId, Topic.ORDER_MOST_NEW);
				list.gotoPage(p);
				request.setAttribute("topics", list);
			}
		}else if ("resettag".equals(op)) {	// 调整标签
			String[] tagsId = request.getParameterValues("tag");
			String id = ServletUtils.inputValToString(request.getParameter("id"));
			List<String> tags = null;
			if(null!=tagsId&&tagsId.length>0){
				tags = new ArrayList<String>();
				for(String s : tagsId){
					tags.add(s);
				}
			}
			m_ForumSerive.getTopic(id).setTags(tags);
			ServletUtils.sendRedirect("/user/managetopic.jspx?op=search&tagId="+tagId+"&username="+username+"&p="+p, request, response);
		}
		ResultPage<Tag> tags = m_ForumSerive.searchTags(Tag.STATUS_NORMAL.id);
		ResultPage<Tag> tags1 = m_ForumSerive.searchTags(Tag.STATUS_NORMAL.id);
		request.setAttribute("tagId", tagId);
		request.setAttribute("username", username);
		request.setAttribute("tags", ResultPages.toList(tags, tags.getCount()));
		request.setAttribute("tags1", ResultPages.toList(tags1, tags1.getCount()));
		request.setAttribute("op", op);
		request.setAttribute("p", p);
		return "user/managetopic";
	}
	
	/**
	 * 评论管理
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping
	String managecomment(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String op = ServletUtils.inputValToString(request.getParameter("op"));
		int p = ServletUtils.inputValToInt(request.getParameter("p"), 1);
		ResultPage<Comment> list;
		User admin = (User)request.getSession().getAttribute("own");
		String username = ServletUtils.inputValToString(request.getParameter("username"));
		String topicId = ServletUtils.inputValToString(request.getParameter("topicId"));
		if ("shield".equals(op)) {	// 屏蔽评论
			String id = ServletUtils.inputValToString(request.getParameter("id"));
			m_ForumSerive.getComment(id).shield(admin);
		}
		else if ("recover".equals(op)) {	// 恢复评论
			String id = ServletUtils.inputValToString(request.getParameter("id"));
			m_ForumSerive.getComment(id).recover(admin);
			
		}
		if (null!=username && !"".equals(username)) {	// 搜索用户的评论
			User user = m_UserSerive.getUserByName(0, username);
			if(null!=user){
				list = m_ForumSerive.searchComments(0, user, null);
				list.gotoPage(p);
				request.setAttribute("comments", list);
			}
		}else if (null!=topicId && !"".equals(topicId)) {	// 搜索某个下的话题的评论
				Topic t = m_ForumSerive.getTopic(topicId);
				if(null!=t){
					list = m_ForumSerive.searchComments(0,t.getId().getOrdinal(),Comment.ORDER_MOST_NEW);
					list.gotoPage(p);
					request.setAttribute("comments", list);
				}
		}
		request.setAttribute("p", p);
		request.setAttribute("username", username);
		request.setAttribute("topicId", topicId);
		return "user/managecomment";
	}
	
	/**
	 * 回复管理
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping
	String managereply(HttpServletRequest request,HttpServletResponse response){
		String op = ServletUtils.inputValToString(request.getParameter("op"));
		int p = ServletUtils.inputValToInt(request.getParameter("p"), 1);
		ResultPage<Reply> list;
		User admin = (User)request.getSession().getAttribute("own");
		String username = ServletUtils.inputValToString(request.getParameter("username"));
		String topicId = ServletUtils.inputValToString(request.getParameter("topicId"));
		if ("shield".equals(op)) {	// 屏蔽回复
			String id = ServletUtils.inputValToString(request.getParameter("id"));
			m_ForumSerive.getReply(id).shield(admin);
		}
		else if ("recover".equals(op)) {	// 恢复回复
			String id = ServletUtils.inputValToString(request.getParameter("id"));
			m_ForumSerive.getReply(id).recover(admin);
			
		}
		if (null!=username && !"".equals(username)) {	// 搜索回复
			User user = m_UserSerive.getUserByName(0, username);
			if(null!=user){
				list = m_ForumSerive.searchReplies(0, user, null, null);
				list.gotoPage(p);
				request.setAttribute("replies", list);
			}
		}else if (null!=topicId && !"".equals(topicId)) {	// 搜索某个下的话题的评论
			Topic t = m_ForumSerive.getTopic(topicId);
			list = m_ForumSerive.searchReplies(0, t.getId().getOrdinal(), Reply.ORDER_MOST_NEW);
			list.gotoPage(p);
			request.setAttribute("replies", list);
		}
		request.setAttribute("p", p);
		request.setAttribute("username", username);
		request.setAttribute("topicId", topicId);
		return "user/managereply";
	}
}
