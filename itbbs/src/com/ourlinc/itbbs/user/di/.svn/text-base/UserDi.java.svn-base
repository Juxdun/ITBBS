package com.ourlinc.itbbs.user.di;

import com.ourlinc.itbbs.forum.Comment;
import com.ourlinc.itbbs.forum.Favor;
import com.ourlinc.itbbs.forum.Praise;
import com.ourlinc.itbbs.forum.Reply;
import com.ourlinc.itbbs.forum.Tag;
import com.ourlinc.itbbs.forum.Topic;
import com.ourlinc.itbbs.user.User;
import com.ourlinc.tern.ResultPage;
import com.ourlinc.tern.search.Searcher;
import com.ourlinc.tern.support.BusinessDi;
/**
 * 用户模块di
 * @author 陈洁民
 */
public interface UserDi extends BusinessDi{
	
	/**
	 * 
	 * @return 用户列表
	 */
	public ResultPage<User> getUsers(int status);
	
	/**
	 * @param user 用户
	 * @return 用户发表的话题列表
	 */
	public ResultPage<Topic> getTopics(User user);
	
	/**
	 * @param user 用户
	 * @return 用户的所有评论
	 */
	public ResultPage<Comment> getComments(User user);
	
	/**
	 * @param user 用户
	 * @return 用户的所有回复
	 */
	public ResultPage<Reply> getReplies(User user);
	
	/**取某一条收藏
	 * @param user 用户
	 * @param topic 话题
	 * @return 用户的收藏列表
	 */
	public Favor getFavor(User user, Topic topic);
	
	/**取得收藏列表
	 * @param user 用户
	 * @param topic 话题
	 * @return 用户的收藏列表
	 */
	public ResultPage<Favor> getFavors(User user, Topic topic);
	
	/**
	 * 取一条点赞
	 * @param user 用户
	 * @param topic 话题 
	 * @return
	 */
	public Praise getPraise(User user, Topic topic);
	
	/**
	 * 创建话题
	 *@param name 话题名
	 *@param content 话题内容 
	 *@param user 用户 
	 *@return 
	 */
	public Topic createTopic(String name,String content,User user);
	
	/**
	 * 创建标签
	 * @param parentTag 父标签
	 * @param name标签名
	 * @return
	 */
	public Tag createTag(Tag parentTag,String name,User user);
	
	/**
	 * 收藏
	 * @param user 用户
	 * @param topic 话题
	 * @return 
	 */
	public Favor createFavor(User user , Topic topic);
	
	/**
	 * 点赞
	 * @param user 用户
	 * @param topic 话题
	 * @return 
	 */
	public Praise createPraise(User user, Topic topic);
	
	/**
	 * 取用户搜索器
	 * @return
	 */
	public Searcher getUserSearcher();
}
