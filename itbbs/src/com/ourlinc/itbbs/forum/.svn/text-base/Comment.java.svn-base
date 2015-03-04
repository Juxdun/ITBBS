package com.ourlinc.itbbs.forum;

import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import com.ourlinc.itbbs.forum.di.ForumDi;
import com.ourlinc.itbbs.user.User;
import com.ourlinc.itbbs.user.role.Role;
import com.ourlinc.tern.NameItem;
import com.ourlinc.tern.search.IndexElement;
import com.ourlinc.tern.search.IndexKeyword;
import com.ourlinc.tern.search.IndexKeywords;
import com.ourlinc.tern.support.AbstractPersistent;
/**
 * 评论BO
 * @author Juxdun
 *
 */
public class Comment extends AbstractPersistent<ForumDi>{
	
	/**
	 * 评论内容
	 */
	@Resource
	private String m_Content;
	
	/**
	 * 评论时间
	 */
	@Resource
	private Date m_Date;
	
	/**
	 * 话题id
	 */
	@Resource
	private String m_TopicId;
	
	/**
	 * 评论者id
	 */
	@Resource
	private String m_UserId;
	
	/**
	 * 状态
	 */
	@Resource
	private int m_Status;
	
	public static final NameItem STATUS_NORMAL = new NameItem("正常", 1);
	public static final NameItem STATUS_SHIELD = new NameItem("已屏蔽", 2);
	public static final NameItem[] STATUS = {STATUS_NORMAL, STATUS_SHIELD};
	
	/**
	 * 状态索引关键字
	 */
	public static final String REINDEX_STATUS = "s:";
	
	/**
	 * 评论者索引关键字
	 */
	public static final String REINDEX_USER = "user:";
	
	/**
	 * 话题作者索引关键字
	 */
	public static final String REINDEX_TOPIC_USER = "topicuser:";
	
	public Comment(ForumDi di, String content, Topic topic, User user){
		super(di);
		m_Id = getPersister().getNewId(topic.getId().getOrdinal());
		m_Content = content;
		m_TopicId = topic.getId().getId();
		m_UserId = user.getId().getId();
		m_Date = new Date();
		m_Status = STATUS_NORMAL.id;
		markPersistenceUpdate();
		reindex();
	}
	
	protected Comment(ForumDi di){
		super(di);
	}
	
	public String getContent(){
		return m_Content;
	}
	
	public void setContent(String content){
		m_Content = content;
		markPersistenceUpdate();
	}

	public Date getDate() {
		return m_Date;
	}
	
	/**
	 * 取状态
	 * @return 状态NameItem
	 */
	public NameItem getStatus(){
		NameItem ni = NameItem.findById(m_Status, STATUS);
		if (null == ni) {
			return new NameItem("状态异常", m_Status);
		}
		return ni;
	}
	
	/**
	 * 屏蔽
	 * @param admin 管理员用户
	 * @return	true 修改成功，false 失败
	 */
	public boolean shield(User admin){
		if (admin.isHasPermission(Role.SHIELD_COMMENT)) {//admin是否有屏蔽评论的权限
			m_Status = STATUS_SHIELD.id;
			markPersistenceUpdate();
			reindex();
			return true;
		}
		return false;
	}
	
	/**
	 * 恢复
	 * @param admin 管理员用户
	 * @return true 修改成功，false 失败
	 */
	public boolean recover(User admin){
		if (admin.isHasPermission(Role.RECVOER_COMMENT)) {//admin是否有恢复评论的权限
			m_Status = STATUS_NORMAL.id;
			markPersistenceUpdate();
			reindex();
			return true;
		}
		return false;
	}
	
	public Topic getTopic(){
		return getBusinessDi().getTopic(m_TopicId);
	}
	
	public User getUser(){
		return getBusinessDi().getUser(m_UserId);
	}
	
	public Reply createReply(User sourceUser, User targetUser, String content){
		if (sourceUser.getStatus().equals(User.STATUS_NORMAL)) {
			Reply reply =  getBusinessDi().createReply(this, sourceUser, targetUser, content);
			if(null!=reply){
				targetUser.addNewMsgCount();//回复对象的新消息+1
				if(!targetUser.getId().getId().equals(reply.getComment().getUser().getId().getId())//评论作者的id不等于回复对象的Id
						&&!sourceUser.getId().getId().equals(reply.getComment().getUser().getId().getId())){//评论作者的id不等于回复作者的id
					reply.getComment().getUser().addNewMsgCount();//评论作者的新消息+1
				}
				if(!targetUser.getId().getId().equals(reply.getComment().getTopic().getUser().getId().getId())//回复对象的id不等于话题作者的Id
						&&!sourceUser.getId().getId().equals(reply.getComment().getTopic().getUser().getId().getId())//回复作者的id不等于话题作者的Id
						&&!reply.getComment().getUser().getId().getId().equals(reply.getComment().getTopic().getUser().getId().getId())){//评论作者的id不等于话题作者的Id
					reply.getComment().getTopic().getUser().addNewMsgCount();//话题作者的新消息+1
				}
				return reply;
			}
		}
		return null;
	}
	
	public List<Reply> getReplies(){
		return getBusinessDi().getReplies(this);
	}
	
	/**
	 * 关键词重索引
	 */
	public void reindex() {
		List<IndexKeyword> ks = Arrays.asList(IndexKeywords.newKeyword(REINDEX_USER+m_UserId, 0),
				IndexKeywords.newKeyword(REINDEX_TOPIC_USER+getTopic().getUser().getId().getId(), 0),
				IndexKeywords.newKeyword(REINDEX_STATUS+getStatus().getId(), 0));
		getBusinessDi().getCommentSearcher().updateElement(
				IndexElement.valueOf(getId().getOrdinal()), ks);
	}
	
	/**
	 * 最新发表的排在最前
	 */
	public static Comparator<Comment> ORDER_MOST_NEW = new Comparator<Comment>() {
		@Override
		public int compare(Comment o1, Comment o2) {
			if (null == o1 || null == o2) {
				return -1;
			}
			return o1.getDate().after(o2.getDate())?0:1;
		}
	};
	
	/**
	 * 最老发表的排在最前
	 */
	public static Comparator<Comment> ORDER_MOST_OLD = new Comparator<Comment>() {
		@Override
		public int compare(Comment o1, Comment o2) {
			if (null == o1 || null == o2) {
				return -1;
			}
			return o1.getDate().before(o2.getDate())?0:1;
		}
	};
}
