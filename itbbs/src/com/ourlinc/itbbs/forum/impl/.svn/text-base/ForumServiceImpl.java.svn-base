package com.ourlinc.itbbs.forum.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import com.ourlinc.itbbs.forum.Comment;
import com.ourlinc.itbbs.forum.CommentReply;
import com.ourlinc.itbbs.forum.Favor;
import com.ourlinc.itbbs.forum.ForumService;
import com.ourlinc.itbbs.forum.Praise;
import com.ourlinc.itbbs.forum.Reply;
import com.ourlinc.itbbs.forum.Tag;
import com.ourlinc.itbbs.forum.Topic;
import com.ourlinc.itbbs.forum.di.ForumDi;
import com.ourlinc.itbbs.user.User;
import com.ourlinc.itbbs.user.UserService;
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

/**
 * 论坛Service实现
 * @author Juxdun
 *
 */
public class ForumServiceImpl implements ForumService {
	/**
	 * 数据源
	 */
	final DataHub m_DataHub;
	
	/**
	 * 论坛Di的实现
	 */
	final ForumDiImpl m_ForumDi;
	
	/**
	 * 话题持久器
	 */
	final Persister<Topic> m_PsTopic;
	/**
	 * 评论持久器
	 */
	final Persister<Comment> m_PsComment;
	/**
	 * 回复持久器
	 */
	final Persister<Reply> m_PsReply;
	/**
	 * 收藏持久器
	 */
	final Persister<Favor> m_PsFavor;
	/**
	 * 赞持久器
	 */
	final Persister<Praise> m_PsPraise;
	/**
	 * 标签持久器
	 */
	final Persister<Tag> m_PsTag;
	
	/**
	 * 话题搜索器
	 */
	final Searcher m_TopicSearcher;
	
	/**
	 * 评论搜索器
	 */
	final Searcher m_CommentSearcher;
	
	/**
	 * 回复搜索器
	 */
	final Searcher m_ReplySearcher;
	
	/**
	 * 收藏搜索器
	 */
	final Searcher m_FavorSearcher;
	
	/**
	 * 赞搜索器
	 */
	final Searcher m_PraiseSearcher;
	
	/**
	 * 标签搜索器
	 */
	final Searcher m_TagSearcher;
	
	/**
	 * 搜索器名称
	 */
	final String SEARCHER_TOPIC_NAME = "topic";
	final String SEARCHER_COMMENT_NAME = "comment";
	final String SEARCHER_REPLY_NAME = "reply";
	final String SEARCHER_FAVOR_NAME = "favor";
	final String SEARCHER_PRAISE_NAME = "praise";
	final String SEARCHER_TAG_NAME = "tag";
	
	/**
	 * 用户服务
	 */
	private UserService m_UserService;
	/**
	 * 配置注入Service
	 * @param userService
	 */
	public void setUserService(UserService us) {
		m_UserService = us;
	}
	
	ForumServiceImpl(DataHub hub){
		m_DataHub = hub;
		m_ForumDi = new ForumDiImpl();
		m_PsTopic = m_DataHub.createPersister(Topic.class, m_ForumDi);
		m_PsComment = m_DataHub.createPersister(Comment.class, m_ForumDi);
		m_PsReply = m_DataHub.createPersister(Reply.class, m_ForumDi);
		m_PsFavor = m_DataHub.createPersister(Favor.class, m_ForumDi);
		m_PsPraise = m_DataHub.createPersister(Praise.class, m_ForumDi);
		m_PsTag = m_DataHub.createPersister(Tag.class, m_ForumDi);
		
		m_TopicSearcher = m_DataHub.createSearcher(SEARCHER_TOPIC_NAME);
		m_CommentSearcher = m_DataHub.createSearcher(SEARCHER_COMMENT_NAME);
		m_ReplySearcher = m_DataHub.createSearcher(SEARCHER_REPLY_NAME);
		m_FavorSearcher = m_DataHub.createSearcher(SEARCHER_FAVOR_NAME);
		m_PraiseSearcher = m_DataHub.createSearcher(SEARCHER_PRAISE_NAME);
		m_TagSearcher = m_DataHub.createSearcher(SEARCHER_TAG_NAME);
	}

	@Override
	public Topic createTopic(String name, String content, User user) {
		if (user.getStatus().equals(User.STATUS_NORMAL)) {//用户是否为正确用户
			return new Topic(m_ForumDi, name, content, user);
		}
		return null;
	}

	@Override
	public Topic getTopic(String id) {
		return m_PsTopic.get(id);
	}
	
	@Override
	public Reply getReply(String id){
		return m_PsReply.get(id);
	}
	
	@Override
	public Comment getComment(String id){
		return m_PsComment.get(id);
	}
	
	@Override
	public ResultPage<Topic> searchTopics(int status, User user,Date date,String tagId,
			Comparator<Topic> comparator) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<IndexKeyword> ks = new ArrayList<IndexKeyword>();
		ResultPage<Topic> topics =null;
		if(0<status){
			ks.add(IndexKeywords.newKeyword(Topic.REINDEX_STATUS+status, 0));
		}
		if(null!=date){
			ks.add(IndexKeywords.newKeyword(sdf.format(date), 0));
		}
		if(null!=user){
			ks.add(IndexKeywords.newKeyword(user.getId().getId(), 0));
		}
		// 没查询条件则作全部查询
		if(0==ks.size()){
			topics = ResultPages.toSortResultPage(m_PsTopic.startsWith(null), comparator, ResultPage.LIMIT_NONE);
		}else{
			IndexResults ir = m_TopicSearcher.search(ks,Searcher.OPTION_NONE);
			topics = ResultPages.toSortResultPage(ResultPageWrap.wrap(ir, m_PsTopic), comparator, ResultPage.LIMIT_NONE);
		}
		if(null!=tagId&&!"".equals(tagId)){
			if(topics.getCount()>0){
				topics.setPageSize(topics.getCount());
				topics.gotoPage(1);
				List<Topic> tagTopics = new ArrayList<Topic>();
				for(Topic topic : topics){
					if(null!=topic&&null!=topic.getTags()){
						int flag = 0;
						for(Tag t :topic.getTags()){
							if(t.getId().getId().equals(tagId)){//判断话题的标签列表中是否有该标签
								flag = 1;
							}
						}
						if(1==flag){
							tagTopics.add(topic);
						}
					}
				}
				return ResultPages.toResultPage(tagTopics,comparator);
			}
		}
		return topics;
	}
	
	@Override
	public ResultPage<Topic> searchTopics(int status, User user) {
			ResultPage<Topic> rp = m_PsTopic.startsWith(user.getId().getOrdinal());
			List<Topic> list = new ArrayList<Topic>();
			rp.setPageSize(rp.getCount());//设置每页的条数为集合的大小，这样就只有一页，不用写for循环页数
			rp.gotoPage(1);
			for(Topic topic : rp){//for循环是为了排除状态为屏蔽的话题
				if(topic.getStatus().equals(Topic.STATUS_NORMAL)){
					list.add(topic);
				}
			}
			return ResultPages.toResultPage(list, Topic.ORDER_MOST_NEW);
			
	}

	@Override
	public ResultPage<Comment> searchComments(int status, User user,User topicUser) {
		List<IndexKeyword> ks = new ArrayList<IndexKeyword>();
		if(0<status){
			ks.add(IndexKeywords.newKeyword(Comment.REINDEX_STATUS+status, 0));
		}
		if(null!=user){
			ks.add(IndexKeywords.newKeyword(Comment.REINDEX_USER+user.getId().getId(), 0));
		}
		if(null!=topicUser){
			ks.add(IndexKeywords.newKeyword(Comment.REINDEX_TOPIC_USER+topicUser.getId().getId(), 0));
		}
		// 没查询条件则作全部查询
		if(0==ks.size()){
			return ResultPages.toSortResultPage(m_PsComment.startsWith(null), Comment.ORDER_MOST_NEW, ResultPage.LIMIT_NONE);
		}
		IndexResults ir = m_CommentSearcher.search(ks,Searcher.OPTION_NONE);
		return ResultPages.toSortResultPage(ResultPageWrap.wrap(ir, m_PsComment), Comment.ORDER_MOST_NEW, ResultPage.LIMIT_NONE);
	}
	
	@Override
	public ResultPage<Comment> searchComments(int status,String id,Comparator<Comment> comparator){
		ResultPage<Comment> rp = m_PsComment.startsWith(id);
		List<Comment> list = new ArrayList<Comment>();
		rp.setPageSize(rp.getCount());//设置每页的条数为集合的大小，这样就只有一页，不用写for循环页数
		rp.gotoPage(1);
		for(Comment comment :rp){
			if(status==0||comment.getStatus().id==status){
				list.add(comment);
			}
		}
		return ResultPages.toResultPage(list, comparator);	
	}
	
	@Override
	public ResultPage<Reply> searchReplies(int status, User user,User target,User topicUser) {
		List<IndexKeyword> ks = new ArrayList<IndexKeyword>();
		if(0<status){
			ks.add(IndexKeywords.newKeyword(Reply.REINDEX_STATUS+status, 0));
		}
		if(null!=user){
			ks.add(IndexKeywords.newKeyword(Reply.REINDEX_USER+user.getId().getId(), 0));
		}
		if(null!=target){
			ks.add(IndexKeywords.newKeyword(Reply.REINDEX_TARGET+target.getId().getId(), 0));
		}
		if(null!=topicUser){
			ks.add(IndexKeywords.newKeyword(Reply.REINDEX_TOPIC_USER+topicUser.getId().getId(), 0));
		}
		// 没查询条件则作全部查询
		if(0==ks.size()){
			return ResultPages.toSortResultPage(m_PsReply.startsWith(null), Reply.ORDER_MOST_NEW, ResultPage.LIMIT_NONE);
		}
		IndexResults ir = m_ReplySearcher.search(ks,Searcher.OPTION_NONE);
		return ResultPages.toSortResultPage(ResultPageWrap.wrap(ir, m_PsReply), Reply.ORDER_MOST_NEW, ResultPage.LIMIT_NONE);
	}
	
	@Override
	public ResultPage<Reply> searchReplies(int status,String id,Comparator<Reply> comparator){
		ResultPage<Reply> rp = m_PsReply.startsWith(id);
		List<Reply> list = new ArrayList<Reply>();
		rp.setPageSize(rp.getCount());//设置每页的条数为集合的大小，这样就只有一页，不用写for循环页数
		rp.gotoPage(1);
		for(Reply reply : rp){//for循环是为了排除状态为屏蔽的回复
			if(status==0||reply.getStatus().id==status){
				list.add(reply);
			}
		}
		return ResultPages.toResultPage(list, comparator);
		
	}
	@Override
	public ResultPage<CommentReply> myComment(int status,User user){
		
		ResultPage<Comment> comments =user.getComments();
		ResultPage<Reply> replies = user.getReplies();
		List<CommentReply> crs = new ArrayList<CommentReply>();
		if(comments.getCount()>0){
			comments.setPageSize(comments.getCount());
			comments.gotoPage(1);
			for(Comment comment : comments){
				CommentReply cr = new CommentReply();
				cr.setComment(comment);
				cr.setDate(comment.getDate());
				cr.setType(CommentReply.TYPE_COMMENT.id);
				crs.add(cr);
			}
		}
		if(replies.getCount()>0){
			replies.setPageSize(replies.getCount());
			replies.gotoPage(1);
			for(Reply reply : replies){
				CommentReply cr = new CommentReply();
				cr.setReply(reply);
				cr.setDate(reply.getDate());
				cr.setType(CommentReply.TYPE_REPLY.id);
				crs.add(cr);
			}
		}
		return ResultPages.toResultPage(crs, CommentReply.ORDER_MOST_NEW);
		
	}
	
	@Override
	public ResultPage<CommentReply> myMessage(int status,User user){
		ResultPage<Comment> comments =searchComments(Comment.STATUS_NORMAL.id, null,user);//拿到评论我的话题所有评论
		ResultPage<Reply> repliesComment = searchReplies(Reply.STATUS_NORMAL.id, null,user,null);//拿到回复我的所有回复
		ResultPage<Reply> repliesTopic = searchReplies(Reply.STATUS_NORMAL.id, null,null,user);//拿到我的话题的所有回复
		List<CommentReply> crs = new ArrayList<CommentReply>();
		if(comments.getCount()>0){
			comments.setPageSize(comments.getCount());
			comments.gotoPage(1);
			for(Comment comment : comments){
				if(!comment.getUser().getId().getId().equals(user.getId().getId())){//排除自己发表的评论
					CommentReply cr = new CommentReply();
					cr.setComment(comment);
					cr.setDate(comment.getDate());
					cr.setType(CommentReply.TYPE_COMMENT.id);
					crs.add(cr);
				}
			}
		}
		if(repliesComment.getCount()>0){
			repliesComment.setPageSize(repliesComment.getCount());
			repliesComment.gotoPage(1);
			for(Reply reply : repliesComment){
				if(!reply.getSourceUser().getId().getId().equals(user.getId().getId())){//排除自己发表的评论
					CommentReply cr = new CommentReply();
					cr.setReply(reply);
					cr.setDate(reply.getDate());
					cr.setType(CommentReply.TYPE_REPLY.id);
					crs.add(cr);
				}
			}
		}
		if(repliesTopic.getCount()>0){
			repliesTopic.setPageSize(repliesTopic.getCount());
			repliesTopic.gotoPage(1);
			for(Reply reply : repliesTopic){
				if(!reply.getSourceUser().getId().getId().equals(user.getId().getId())){//排除自己发表的回复
					CommentReply cr = new CommentReply();
					cr.setReply(reply);
					cr.setDate(reply.getDate());
					cr.setType(CommentReply.TYPE_REPLY.id);
					crs.add(cr);
				}
			}
		}
		return ResultPages.toResultPage(crs, CommentReply.ORDER_MOST_NEW);
	}
	
	@Override
	public Favor createFavor(User user, Topic topic) {
		if(!topic.getUser().getId().getId().equals(user.getId().getId())//话题作者id不等于user的id
				&&0==searchFavors(Favor.STATUS_NORMAL.id, user, topic).getCount()){//用户没有收藏过这个话题
			return new Favor(m_ForumDi, user, topic);
		}
		return null;
	}

	@Override
	public ResultPage<Favor> searchFavors(int status, User user, Topic topic) {
		List<IndexKeyword> ks = new ArrayList<IndexKeyword>();
		if(0<status){
			ks.add(IndexKeywords.newKeyword(Favor.REINDEX_STATUS+status, 0));
		}
		if(null!=user){
			ks.add(IndexKeywords.newKeyword(user.getId().getId(), 0));
		}
		if(null!=topic){
			ks.add(IndexKeywords.newKeyword(topic.getId().getId(), 0));
		}
		// 没查询条件则作全部查询
		if(0==ks.size()){
			return ResultPages.toSortResultPage(m_PsFavor.startsWith(null), Favor.ORDER_MOST_NEW, ResultPage.LIMIT_NONE);
		}
		IndexResults ir = m_FavorSearcher.search(ks,Searcher.OPTION_NONE);
		return ResultPages.toSortResultPage(ResultPageWrap.wrap(ir, m_PsFavor), Favor.ORDER_MOST_NEW, ResultPage.LIMIT_NONE);
	}
	
	@Override
	public Favor getFavor(User user, Topic topic) {
		ResultPage<Favor> list = searchFavors(Favor.STATUS_NORMAL.getId(), user,topic);
		list.gotoPage(1);
		if(list.hasNext()){
			return list.next();
		}
		return null;
	}
	
	@Override
	public Praise createPraise(User user, Topic topic) {
		if(!topic.getUser().getId().getId().equals(user.getId().getId())&&//话题作者id不等于user的id
				0==searchPraises(Praise.STATUS_NORMAL.id, user, topic).getCount()){//用户没有点赞过这个话题
			return new Praise(m_ForumDi, user, topic);
		}
		return null;
	}

	@Override
	public ResultPage<Praise> searchPraises(int status, User user, Topic topic) {
		List<IndexKeyword> ks = new ArrayList<IndexKeyword>();
		if(0<status){
			ks.add(IndexKeywords.newKeyword(Praise.REINDEX_STATUS+status, 0));
		}
		if(null!=user){
			ks.add(IndexKeywords.newKeyword(user.getId().getId(), 0));
		}
		if(null!=topic){
			ks.add(IndexKeywords.newKeyword(topic.getId().getId(), 0));
		}
		// 没查询条件则作全部查询
		if(0==ks.size()){
			return ResultPages.toSortResultPage(m_PsPraise.startsWith(null), Praise.ORDER_MOST_NEW, ResultPage.LIMIT_NONE);
		}
		IndexResults ir = m_PraiseSearcher.search(ks,Searcher.OPTION_NONE);
		return ResultPages.toSortResultPage(ResultPageWrap.wrap(ir, m_PsPraise), Praise.ORDER_MOST_NEW, ResultPage.LIMIT_NONE);
	}

	@Override
	public Praise getPraise(User user, Topic topic) {
		ResultPage<Praise> list = searchPraises(Praise.STATUS_NORMAL.getId(), user, topic);
		list.gotoPage(1);
		if(list.hasNext()){
			return list.next();
		}
		return null;
	}
	
	@Override
	public Tag createTag(Tag parentTag, String name,User user) {
		if(user.isHasPermission(Role.CREATE_TAG)){//user是否有创建标签的权限
			return new Tag(m_ForumDi, parentTag, name);
		}
		return null;
	}

	@Override
	public Tag getTag(String id) {
		return m_PsTag.get(id);
	}

	@Override
	public ResultPage<Tag> searchTags(int status) {
		List<IndexKeyword> ks = new ArrayList<IndexKeyword>();
		if(0<status){
			ks.add(IndexKeywords.newKeyword(Tag.REINDEX_STATUS+status, 0));
		}
		if(0==ks.size()){
			return ResultPages.toSortResultPage(m_PsTag.startsWith(null), Tag.ORDER_TAG_NAME, ResultPage.LIMIT_NONE);
		}
		IndexResults ir = m_TagSearcher.search(ks,Searcher.OPTION_NONE);
		return ResultPages.toSortResultPage(ResultPageWrap.wrap(ir, m_PsTag), Tag.ORDER_TAG_NAME, ResultPage.LIMIT_NONE);
	}
	
	@Override
	public List<Tag> searchRootTags(int status) {
		ResultPage<Tag> tags = searchTags(status);
		List<Tag> rootTags = new ArrayList<Tag>();
		tags.setPageSize(tags.getCount());
		tags.gotoPage(1);
		for(Tag tag : tags){
			if(null==tag.getParent()){
				rootTags.add(tag);
			}
		}
		return rootTags;
	}

	//==================分割线================================================//
	class ForumDiImpl implements ForumDi{

		@Override
		public User getUser(String id) {
			return m_UserService.getUser(id);
		}

		@Override
		public Topic getTopic(String id) {
			return m_PsTopic.get(id);
		}

		@Override
		public ResultPage<Topic> getTopics(Tag tag,int status) {
			/*ResultPage<Topic> rp = searchTopics(status,null,null,null,Topic.ORDER_MOST_NEW);
			List<Topic> topics = new ArrayList<Topic>();
			rp.setPageSize(rp.getCount());
			rp.gotoPage(1);
			for(Topic topic : rp){
				if(null!=topic&&null!=topic.getTags()){
					int flag = 0;
					for(Tag t :topic.getTags()){
						if(t.getId().getId().equals(tag.getId().getId())){//判断话题的标签列表中是否有该标签
							flag = 1;
						}
					}
					if(1==flag){
						topics.add(topic);
					}
				}
			}
			return ResultPages.toResultPage(topics,Topic.ORDER_MOST_NEW);*/
			return searchTopics(status,null,null,tag.getId().getId(),Topic.ORDER_MOST_NEW);
		}

		@Override
		public Comment createComment(String content, Topic topic, User user) {
			return new Comment(m_ForumDi, content, topic, user);
		}

		@Override
		public Comment getComment(String id) {
			return m_PsComment.get(id);
		}

		@Override
		public ResultPage<Comment> getComments(Topic topic) {
			/*ResultPage<Comment> rp = m_PsComment.startsWith(topic.getId().getOrdinal());
			List<Comment> list = new ArrayList<Comment>();
			rp.setPageSize(rp.getCount());//设置每页的条数为集合的大小，这样就只有一页，不用写for循环页数
			rp.gotoPage(1);
			for(Comment comment :rp){//for循环是为了排除状态为屏蔽的评论
				if(comment.getStatus().equals(Comment.STATUS_NORMAL)){
					list.add(comment);
				}
			}
			return ResultPages.toResultPage(list, Comment.ORDER_MOST_OLD);*/
			return searchComments(Comment.STATUS_NORMAL.id,topic.getId().getOrdinal(),Comment.ORDER_MOST_OLD);
		}

		@Override
		public Reply createReply(Comment comment, User sourceUser,
				User targetUser, String content) {
			return new Reply(m_ForumDi, comment, sourceUser, targetUser, content);
		}

		@Override
		public List<Reply> getReplies(Comment comment) {
			/*ResultPage<Reply> rp = m_PsReply.startsWith(comment.getId().getOrdinal());
			List<Reply> list = new ArrayList<Reply>();
			rp.setPageSize(rp.getCount());//设置每页的条数为集合的大小，这样就只有一页，不用写for循环页数
			rp.gotoPage(1);
			for(Reply reply : rp){//for循环是为了排除状态为屏蔽的回复
				if(reply.getStatus().equals(Reply.STATUS_NORMAL)){
					list.add(reply);
				}
			}
			return list;*/
			ResultPage<Reply> rp = searchReplies(Comment.STATUS_NORMAL.id,comment.getId().getOrdinal(),Reply.ORDER_MOST_OLD);
			return ResultPages.toList(rp, rp.getCount());
		}
		
		@Override
		public ResultPage<Favor> getFavors(Topic topic) {
			return searchFavors(Favor.STATUS_NORMAL.id, null, topic);
		}

		@Override
		public ResultPage<Praise> getPraises(Topic topic) {
			ResultPage<Praise> rp =  m_PsPraise.startsWith(topic.getId().getOrdinal());
			List<Praise> list = new ArrayList<Praise>();
			rp.setPageSize(rp.getCount());//设置每页的条数为集合的大小，这样就只有一页，不用写for循环页数
			rp.gotoPage(1);
			for(Praise praise : rp){ //for循环是为了排除状态为删除的赞
				if(Praise.STATUS_NORMAL.equals(praise.getStatus())){
					list.add(praise);
				}
			}
			return ResultPages.toResultPage(list,Praise.ORDER_MOST_NEW);
		}

		@Override
		public Tag getTag(String id) {
			return m_PsTag.get(id);
		}

		@Override
		public List<Tag> getChildrenTag(Tag tag) {
			ResultPage<Tag> rp = m_PsTag.startsWith(tag.getId().getOrdinal());
			List<Tag> list = new ArrayList<Tag>();
			rp.setPageSize(rp.getCount());//设置每页的条数为集合的大小，这样就只有一页，不用写for循环页数
			rp.gotoPage(1);
			for(Tag child : rp){
				if(child.getId().getId()!=tag.getId().getId()//排除自己
						&&child.getParent().getId().getId().equals(tag.getId().getId())//父标签等于自己，排除子标签的子标签
						&&child.getStatus().getId()==Tag.STATUS_NORMAL.getId()){
					list.add(child);
				}
			}
			return list;
		}

		@Override
		public <E extends Persistent> Persister<E> getPersister(Class<E> clazz) {
			return m_DataHub.getPersister(clazz);
		}

		@Override
		public Searcher getTopicSearcher() {
			return m_TopicSearcher;
		}

		@Override
		public Searcher getCommentSearcher() {
			return m_CommentSearcher;
		}

		@Override
		public Searcher getReplySearcher() {
			return m_ReplySearcher;
		}

		@Override
		public Searcher getFavorSearcher() {
			return m_FavorSearcher;
		}

		@Override
		public Searcher getPraiseSearcher() {
			return m_PraiseSearcher;
		}

		@Override
		public Searcher getTagSearcher() {
			return m_TagSearcher;
		}

	}

}
