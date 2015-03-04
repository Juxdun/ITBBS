package com.ourlinc.itbbs.user.impl;

import java.util.ArrayList;
import java.util.List;

import com.ourlinc.itbbs.forum.Comment;
import com.ourlinc.itbbs.forum.Favor;
import com.ourlinc.itbbs.forum.ForumService;
import com.ourlinc.itbbs.forum.Praise;
import com.ourlinc.itbbs.forum.Reply;
import com.ourlinc.itbbs.forum.Tag;
import com.ourlinc.itbbs.forum.Topic;
import com.ourlinc.itbbs.user.User;
import com.ourlinc.itbbs.user.UserService;
import com.ourlinc.itbbs.user.di.UserDi;
import com.ourlinc.itbbs.user.role.Role;
import com.ourlinc.tern.Persistent;
import com.ourlinc.tern.Persister;
import com.ourlinc.tern.ResultPage;
import com.ourlinc.tern.ext.ResultPages;
import com.ourlinc.tern.search.IndexKeyword;
import com.ourlinc.tern.search.IndexKeywords;
import com.ourlinc.tern.search.IndexResults;
import com.ourlinc.tern.search.ResultPageWrap;
import com.ourlinc.tern.search.Searcher;
import com.ourlinc.tern.support.DataHub;

public class UserServiceImpl implements UserService{
	
	/**
	 * 数据源
	 */
	final DataHub m_DataHub;
	/**
	 * 依赖项实现
	 */
	final UserDiImpl m_UserDi;
	/**
	 * 话题持久器
	 */
	final Persister<User> m_PsUser;
	
	/**
	 * 订单搜索器
	 */
	final Searcher m_UserSearcher;
	
	/**
	 * 用户搜索器名称
	 */
	final String SEARCHER_USER_NAME = "user";
	
	/**
	 * 论坛服务
	 */
	private ForumService m_forumService;
	
	public void setForumService(ForumService forumService){
		m_forumService = forumService;
	}
	
	public UserServiceImpl(DataHub hub){
		m_DataHub = hub;
		m_UserDi = new UserDiImpl();
		m_PsUser = m_DataHub.createPersister(User.class, m_UserDi);
		m_UserSearcher  = m_DataHub.createSearcher(SEARCHER_USER_NAME);
	}
	
	@Override
	public User RegisterUser(User admin,String username, String password) {
		if(null!=username&&null!=password&&null!=admin
				&&admin.isHasPermission(Role.CREATE_USER)&&!isUserExist(username)){//user、password和admin不为null且admin拥有注册用户的权限且用户名不存在
			return new User(m_UserDi, username, password);
		}
		return null;
	}

	@Override
	public User getUser(String id) {
		return m_PsUser.get(id);
	}
	
	@Override
	public User getUserByName(int status,String username){
		List<IndexKeyword> ks = new ArrayList<IndexKeyword>();
		User user =null;
		ResultPage<User> users =null;
		if(null!=username){
			ks.add(IndexKeywords.newKeyword(username, 0));
		}else{
			return null;
		}
		if(0<status){
			ks.add(IndexKeywords.newKeyword(User.REINDEX_STATUS+status, 0));
		}
		// 没查询条件则作全部查询
		if(0==ks.size()){
			users = ResultPages.toSortResultPage(m_PsUser.startsWith(null), User.ORDER_USER_NAME, ResultPage.LIMIT_NONE);
		}else{
			IndexResults ir = m_UserSearcher.search(ks,Searcher.OPTION_NONE);
			 users= ResultPages.toSortResultPage(ResultPageWrap.wrap(ir, m_PsUser), User.ORDER_USER_NAME, ResultPage.LIMIT_NONE);
		}
		if(null!=users&&users.getCount()>0){
			users.gotoPage(1);
			user = users.next();
		}
		return user;
	}
	
	@Override
	public boolean isUserExist(String username) {
		if(null==username){
			return true;
		}
		if(null!=getUserByName(0, username)){
			return true;
		}

		return false;
	}

	@Override
	public User login(String username, String password) {
		if(null!=username&&null!=password){
			User user = getUserByName(0, username);
			if(null!=user){//用户不等于null证明用户名没有错
				if(user.checkPassword(password)){//检查密码是否正确
					return user;
				}
			}
		}
		return null;
	}
	
	class UserDiImpl implements UserDi{
		
		
		@Override
		public Favor createFavor(User user, Topic topic) {
			return m_forumService.createFavor(user, topic);
		}
		
		@Override
		public Praise createPraise(User user, Topic topic) {
			return m_forumService.createPraise(user, topic);
		}
		
		@Override
		public Tag createTag(Tag parentTag, String name,User user) {
			return m_forumService.createTag(parentTag, name,user);
		}
		
		@Override
		public Topic createTopic(String name, String content,User user) {
			return m_forumService.createTopic(name, content, user);
		}
		
		@Override
		public ResultPage<Comment> getComments(User user) {
			return m_forumService.searchComments(Comment.STATUS_NORMAL.getId(), user,null);
		}
		
		@Override
		public ResultPage<Favor> getFavors(User user, Topic topic) {
			return m_forumService.searchFavors(Favor.STATUS_NORMAL.getId(), user,topic);
		}
		
		@Override
		public Favor getFavor(User user, Topic topic) {
			return m_forumService.getFavor(user,topic);
		}
		
		@Override
		public Praise getPraise(User user, Topic topic) {
			return m_forumService.getPraise(user,topic);
		}
		
		@Override
		public ResultPage<Reply> getReplies(User user) {
			return m_forumService.searchReplies(Reply.STATUS_NORMAL.getId(), user,null,null);
		}
		
		@Override
		public ResultPage<Topic> getTopics(User user) {
			return m_forumService.searchTopics(Topic.STATUS_NORMAL.getId(), user);
		}

		@Override
		public Searcher getUserSearcher() {
			return m_UserSearcher;
		}

		@Override
		public ResultPage<User> getUsers(int status) {
			ResultPage<User> rp = m_PsUser.startsWith(null);
			List<User> list = new ArrayList<User>();
			rp.setPageSize(rp.getCount());
			rp.gotoPage(1);
			for(User user : rp){
				if((status==0||status == user.getStatus().id)&&!user.isHasRole(Role.ADMINSTRATOR_ROLE.getId())){//(状态为0或者状态等于status)且user有获得用户列表的权限
					list.add(user);
				}
			}
			return ResultPages.toResultPage(list, User.ORDER_USER_NAME);
		}

		@Override
		public <E extends Persistent> Persister<E> getPersister(Class<E> clazz) {
			return m_DataHub.getPersister(clazz);
		}
		
	}
	
}
