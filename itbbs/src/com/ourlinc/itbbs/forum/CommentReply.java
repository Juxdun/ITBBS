package com.ourlinc.itbbs.forum;

import java.util.Comparator;
import java.util.Date;

import com.ourlinc.tern.NameItem;
/**
 * 评论回复对象
 * @author 陈洁民
 *
 */
public class CommentReply {
	/**
	 * 评论或者回复的时间
	 */
	private Date m_Date;
	/**
	 * 类型（评论或者回复）
	 */
	private int m_Type;
	public static final NameItem  TYPE_COMMENT= new NameItem("评论", 1);
	public static final NameItem  TYPE_REPLY= new NameItem("回复", 2);
	/**
	 * 评论对象
	 */
	private Comment m_Comment;
	/**
	 * 回复对象
	 */
	private Reply m_Reply;
	public Date getDate() {
		return m_Date;
	}
	public void setDate(Date mDate) {
		m_Date = mDate;
	}
	public int getType() {
		return m_Type;
	}
	public void setType(int mType) {
		m_Type = mType;
	}
	public Comment getComment() {
		return m_Comment;
	}
	public void setComment(Comment mComment) {
		m_Comment = mComment;
	}
	public Reply getReply() {
		return m_Reply;
	}
	public void setReply(Reply mReply) {
		m_Reply = mReply;
	}
	/**
	 * 最新发表的排在最前
	 */
	public static Comparator<CommentReply> ORDER_MOST_NEW = new Comparator<CommentReply>() {
		@Override
		public int compare(CommentReply o1, CommentReply o2) {
			if (null == o1 || null == o2) {
				return -1;
			}
			return o1.getDate().after(o2.getDate())?0:1;
		}
	};
}
