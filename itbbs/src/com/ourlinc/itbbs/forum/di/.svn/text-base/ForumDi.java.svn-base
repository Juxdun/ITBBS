package com.ourlinc.itbbs.forum.di;

import java.util.List;

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
 * 论坛Di
 * @author Juxdun
 *
 */
public interface ForumDi extends BusinessDi{
	
	/**
	 * 取用户
	 * @param id 用户id
	 * @return
	 */
	User getUser(String id);

	/**
	 * 取话题
	 * @param id 话题id
	 * @return
	 */
	Topic getTopic(String id);

	/**
	 * 取话题列表
	 * @param id 标签id
	 * @param status 话题状态
	 * @return
	 */
	
	ResultPage<Topic> getTopics(Tag tag,int status);

	/**
	 * 创建评论
	 * @param content
	 * @param topic
	 * @param user
	 * @return
	 */
	Comment createComment(String content, Topic topic, User user);

	/**
	 * 取话题的评论
	 * @param topic 话题
	 * @return
	 */
	ResultPage<Comment> getComments(Topic topic);

	/**
	 * 取评论
	 * @param id 评论的id
	 * @return
	 */
	Comment getComment(String id);

	/**
	 * 创建回复
	 * @param comment 评论
	 * @param sourceUser 发表人
	 * @param targetUser 目标人
	 * @param content 内容
	 * @return 回复
	 */
	Reply createReply( Comment comment, User sourceUser, User targetUser, String content);

	/**
	 * 取回复列表
	 * @param comment 评论
	 * @return
	 */
	List<Reply> getReplies(Comment comment);

	/**
	 * 根据话题取收藏
	 * @param topic 话题
	 * @return 话题的所有收藏
	 */
	ResultPage<Favor> getFavors(Topic topic);

	/**
	 * 根据话题取赞
	 * @param topic 话题
	 * @return 话题的所有赞
	 */
	ResultPage<Praise> getPraises(Topic topic);

	/**
	 * 取标签
	 * @param id 标签id
	 * @return
	 */
	Tag getTag(String id);
	
	/**
	 * 取标签的子标签
	 * @param tag 标签对象
	 * @return
	 */
	List<Tag> getChildrenTag(Tag tag);
	
	/**
	 * 取话题搜索器
	 * @return
	 */
	Searcher getTopicSearcher();
	
	/**
	 * 取评论搜索器
	 * @return
	 */
	Searcher getCommentSearcher();
	
	/**
	 * 取回复搜索器
	 * @return
	 */
	Searcher getReplySearcher();
	
	/**
	 * 取收藏搜索器
	 * @return
	 */
	Searcher getFavorSearcher();
	
	/**
	 * 取点赞搜索器
	 * @return
	 */
	Searcher getPraiseSearcher();
	
	/**
	 * 取标签搜索器
	 * @return
	 */
	Searcher getTagSearcher();
}
