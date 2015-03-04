package com.ourlinc.itbbs.forum;

import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import com.ourlinc.itbbs.forum.di.ForumDi;
import com.ourlinc.itbbs.user.User;
import com.ourlinc.tern.NameItem;
import com.ourlinc.tern.search.IndexElement;
import com.ourlinc.tern.search.IndexKeyword;
import com.ourlinc.tern.search.IndexKeywords;
import com.ourlinc.tern.support.AbstractPersistent;
/**
 * 收藏BO
 * @author Juxdun
 *
 */
public class Favor extends AbstractPersistent<ForumDi>{

	/**
	 * 用户id
	 */
	@Resource
	private String m_UserId;
	
	/**
	 * 话题id
	 */
	@Resource
	private String m_TopicId;
	
	/**
	 * 收藏日期
	 */
	@Resource
	private Date m_Date;
	
	/**
	 * 状态
	 */
	@Resource
	private int m_Status;
	
	/**
	 * 状态索引关键字
	 */
	public static final String REINDEX_STATUS = "s:";
	
	public static final NameItem STATUS_NORMAL = new NameItem("正常", 1);
	public static final NameItem STATUS_DELETE = new NameItem("已删除", 2);
	public static final NameItem[] STATUS = {STATUS_NORMAL, STATUS_DELETE};
	
	public Favor(ForumDi di, User user, Topic topic) {
		super(di);
		m_Id = getPersister().getNewId(user.getId().getOrdinal());
		m_UserId = user.getId().getId();
		m_TopicId = topic.getId().getId();
		m_Date = new Date();
		m_Status = STATUS_NORMAL.id;
		markPersistenceUpdate();
		reindex();
	}
	
	protected Favor(ForumDi di) {
		super(di);
	}



	public User getUser(){
		return getBusinessDi().getUser(m_UserId);
	}
	
	public Topic getTopic(){
		return getBusinessDi().getTopic(m_TopicId);
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
	
	public void delete(){
		m_Status = STATUS_DELETE.id;
		markPersistenceUpdate();
		reindex();
	}
	
	/**
	 * 关键词重索引
	 */
	public void reindex() {
		List<IndexKeyword> ks = Arrays.asList(IndexKeywords.newKeyword(m_UserId,0),
				IndexKeywords.newKeyword(m_TopicId,0),IndexKeywords.newKeyword(REINDEX_STATUS+getStatus().id,0));
		getBusinessDi().getFavorSearcher().updateElement(
				IndexElement.valueOf(getId().getOrdinal()), ks);
	}
	
	/**
	 * 最新收藏的排在最前
	 */
	public static Comparator<Favor> ORDER_MOST_NEW = new Comparator<Favor>() {
		@Override
		public int compare(Favor f1, Favor f2) {
			if (null == f1 || null == f2) {
				return -1;
			}
			return f1.getDate().after(f2.getDate())?0:1;
		}
	};
	
}
