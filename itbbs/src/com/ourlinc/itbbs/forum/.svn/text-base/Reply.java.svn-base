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
 * 回复BO
 * @author Juxdun
 *
 */
public class Reply extends AbstractPersistent<ForumDi>{
	
	/**
	 * 评论id
	 */
	@Resource
	private String m_CommentId;
	
	/**
	 * 回复者id
	 */
	@Resource
	private String m_SourceUserId;
	
	/**
	 * 回复对象id
	 */
	@Resource
	private String m_TargetUserId;
	
	/**
	 * 回复内容
	 */
	@Resource
	private String m_Content;
	
	/**
	 * 回复时间
	 */
	@Resource
	private Date m_Date;
	
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
	 * 回复者索引关键字
	 */
	public static final String REINDEX_USER = "user:";
	
	/**
	 * 回复目标索引关键字
	 */
	public static final String REINDEX_TARGET = "target:";
	
	/**
	 * 话题作者索引关键字
	 */
	public static final String REINDEX_TOPIC_USER = "topicuser:";
	
	public Reply(ForumDi di, Comment comment, User sourceUser, User targetUser, String content){
		super(di);
		m_Id = getPersister().getNewId(comment.getId().getOrdinal());
		m_CommentId = comment.getId().getId();
		m_SourceUserId = sourceUser.getId().getId();
		m_TargetUserId = targetUser.getId().getId();
		m_Content = content;
		m_Date = new Date();
		m_Status = STATUS_NORMAL.id;
		markPersistenceUpdate();
		reindex();
	}
	
	protected Reply(ForumDi di) {
		super(di);
	}


	public Comment getComment(){
		return getBusinessDi().getComment(m_CommentId);
	}
	
	public User getSourceUser(){
		return getBusinessDi().getUser(m_SourceUserId);
	}
	
	public User getTargetUser(){
		return getBusinessDi().getUser(m_TargetUserId);
	}

	public String getContent() {
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
	 * 屏蔽
	 * @param admin 管理员用户
	 * @return	true 修改成功，false 失败
	 */
	public boolean shield(User admin){
		if (admin.isHasPermission(Role.SHIELD_REPLY)) {//admin是否有屏蔽回复的权限
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
		if (admin.isHasPermission(Role.RECVOER_REPLY)) {//admin是否有恢复回复的权限
			m_Status = STATUS_NORMAL.id;
			markPersistenceUpdate();
			reindex();
			return true;
		}
		return false;
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
	 * 关键词重索引
	 */
	public void reindex() {
		List<IndexKeyword> ks = Arrays.asList(IndexKeywords.newKeyword(REINDEX_USER+m_SourceUserId), 
				IndexKeywords.newKeyword(REINDEX_TARGET+m_TargetUserId),
				IndexKeywords.newKeyword(REINDEX_TOPIC_USER+getComment().getTopic().getUser().getId().getId()), 
				IndexKeywords.newKeyword(REINDEX_STATUS+getStatus().id, 0));
		getBusinessDi().getReplySearcher().updateElement(
				IndexElement.valueOf(getId().getOrdinal()), ks);
	}
	
	/**
	 * 最新发表的排在最前
	 */
	public static Comparator<Reply> ORDER_MOST_NEW = new Comparator<Reply>() {
		@Override
		public int compare(Reply o1, Reply o2) {
			if (null == o1 || null == o2) {
				return -1;
			}
			return o1.getDate().after(o2.getDate())?0:1;
		}
	};
	
	/**
	 * 最老发表的排在最前
	 */
	public static Comparator<Reply> ORDER_MOST_OLD = new Comparator<Reply>() {
		@Override
		public int compare(Reply o1, Reply o2) {
			if (null == o1 || null == o2) {
				return -1;
			}
			return o1.getDate().before(o2.getDate())?0:1;
		}
	};
}
