package com.ourlinc.itbbs.forum;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import com.ourlinc.itbbs.forum.di.ForumDi;
import com.ourlinc.itbbs.user.User;
import com.ourlinc.itbbs.user.role.Role;
import com.ourlinc.tern.NameItem;
import com.ourlinc.tern.ResultPage;
import com.ourlinc.tern.search.IndexElement;
import com.ourlinc.tern.search.IndexKeyword;
import com.ourlinc.tern.search.IndexKeywords;
import com.ourlinc.tern.support.AbstractPersistent;
/**
 * 话题BO
 * @author Juxdun
 *
 */
public class Topic extends AbstractPersistent<ForumDi>{
	
	/**
	 * 话题名
	 */
	@Resource
	private String m_Name;
	
	/**
	 * 用户id
	 */
	@Resource
	private String m_UserId;
	
	/**
	 * 发表日期
	 */
	@Resource
	private Date m_PublishDate;
	
	/**
	 * 更新日期
	 */
	@Resource
	private Date m_UpdateDate;
	
	/**
	 * 标签id的集合
	 */
	@Resource
	private List<String> m_TagIdList;
	
	/**
	 * 话题内容
	 */
	@Resource
	private String m_Content;
	
	/**
	 * 浏览数
	 */
	@Resource
	private int m_BrowseCount;
	
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
	
	public Topic(ForumDi di, String name, String content, User user){
		super(di);
		m_Id = getPersister().getNewId(user.getId().getOrdinal());
		m_Name = name;
		m_Content = content;
		m_UserId = user.getId().getId();
		m_PublishDate = new Date();
		m_UpdateDate = new Date();
		m_Status = STATUS_NORMAL.id;
		markPersistenceUpdate();
		reindex();
	}
	
	protected Topic(ForumDi di){
		super(di);
	}
	
	public String getName(){
		return m_Name;
	}
	
	public void setName(String name){
		m_Name = name;
		markPersistenceUpdate();
		reindex();
	}
	
	public User getUser(){
		return getBusinessDi().getUser(m_UserId);
	}
	
	public Date getPublishDate() {
		return m_PublishDate;
	}

	public Date getUpdateDate() {
		return m_UpdateDate;
	}

	public String getContent() {
		return m_Content;
	}
	
	public void changeContent(String content){
		m_Content = content;
		m_UpdateDate = new Date();
		markPersistenceUpdate();
		reindex();
	}

	public int getBrowseCount() {
		return m_BrowseCount;
	}
	
	public void addBrowseCount(){
		m_BrowseCount ++;
		markPersistenceUpdate();
	}
	
	/**
	 * 取标签，把id转换为标签
	 * @return
	 */
	public List<Tag> getTags(){
		List<Tag> tags = new ArrayList<Tag>(); 
		 if(null==m_TagIdList){
			 return null;
		 }
		for (String id : m_TagIdList) {
			Tag tag = getBusinessDi().getTag(id);
			if(null!= tag&&tag.getStatus().equals(Tag.STATUS_NORMAL)){
				tags.add(tag);
			}
		}
		return tags;
	}
	
	/**
	 * 设置标签列表
	 * @param tagsId
	 */
	public void setTags(List<String> tagsId){
		
		if(null!=tagsId){
			for(int i = 0 ; i < tagsId.size();i++){
				Tag tag = getBusinessDi().getTag(tagsId.get(i));
				Tag parent = tag.getParent();//取得父标签
				if(null!=parent){
					String parentId = parent.getId().getId();
					if (!tagsId.contains(parentId)) {//父标签id不存在list中
						tagsId.add(parentId);
					}
				}
			}
		}
		m_TagIdList = tagsId;
		markPersistenceUpdate();
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
	 * 屏蔽本话题
	 * @param admin 管理员用户
	 * @return	true 修改成功，false 失败
	 */
	public boolean shield(User admin){
		if (admin.isHasPermission(Role.SHIELD_TOPIC)) {
			m_Status = STATUS_SHIELD.id;
			markPersistenceUpdate();
			reindex();
			return true;
		}
		return false;
	}
	
	/**
	 * 恢复话题
	 * @param admin 管理员用户
	 * @return true 修改成功，false 失败
	 */
	public boolean recover(User admin){
		if (admin.isHasPermission(Role.RECVOER_TOPIC)) {
			m_Status = STATUS_NORMAL.id;
			markPersistenceUpdate();
			reindex();
			return true;
		}
		return false;
	}
	
	/**
	 * 创建评论
	 * @param content 评论的内容
	 * @param user 评论者
	 * @return 评论
	 */
	public Comment createComment(String content, User user){
		if (user.getStatus().equals(User.STATUS_NORMAL)) {	// 判断用户是否为正常用户
			Comment comment = getBusinessDi().createComment(content, this, user);
			if(null!=comment){
				getUser().addNewMsgCount();//话题的新消息+1
				return comment;
			}
		}
		return null;
	}
	
	/**
	 * 取该话题的评论
	 * @return
	 */
	public ResultPage<Comment> getComments(){
		return getBusinessDi().getComments(this);
	}
	
	/**
	 * 取该话题的评论数
	 * @return
	 */
	public int getCommentCount(){
		ResultPage<Comment> comments = getBusinessDi().getComments(this);
		int count = comments.getCount();//评论数
		if(count>0){
			comments.setPageSize(count);
			comments.gotoPage(1);
			for(Comment comment : comments){
				if(null!=comment.getReplies()){//评论数+回复数
					count += comment.getReplies().size();
				}
			}
		}
		return count;
	}
	
	/**
	 * 取该话题的收藏
	 * @return
	 */
	public ResultPage<Favor> getFavors(){
		return getBusinessDi().getFavors(this);
	}
	
	/**
	 * 取该话题的收藏数
	 * @return
	 */
	public int getFavorCount(){
		return getBusinessDi().getFavors(this).getCount();
	}
	
	/**
	 * 取该话题的赞
	 * @return
	 */
	public ResultPage<Praise> getPraises(){
		return getBusinessDi().getPraises(this);
	}
	
	/**
	 * 取该话题的赞数目
	 * @return
	 */
	public int getPraiseCount(){
		return getBusinessDi().getPraises(this).getCount();
	}
	
	/**
	 * 关键词重索引
	 */
	public void reindex() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<IndexKeyword> ks = Arrays.asList(IndexKeywords.newKeyword(sdf.format(m_PublishDate), 0),
				IndexKeywords.newKeyword(m_UserId, 0),
				IndexKeywords.newKeyword(REINDEX_STATUS+getStatus().id, 0));
		getBusinessDi().getTopicSearcher().updateElement(
				IndexElement.valueOf(getId().getOrdinal()), ks);
	}
	
	/**
	 * 最新发表的排在最前
	 */
	public static Comparator<Topic> ORDER_MOST_NEW = new Comparator<Topic>() {
		@Override
		public int compare(Topic o1, Topic o2) {
			if (null == o1 || null == o2) {
				return -1;
			}
			return o1.getPublishDate().after(o2.getPublishDate())?0:1;
		}
	};

	/**
	 * 最多浏览的排在最前
	 */
	public static Comparator<Topic> ORDER_MOST_BROWSE = new Comparator<Topic>() {
		@Override
		public int compare(Topic o1, Topic o2) {
			if (null == o1 || null == o2) {
				return -1;
			}
			return o1.getBrowseCount() > o2.getBrowseCount()?0:1;
		}
	};
	
	/**
	 * 最多评论的排在最前
	 */
	public static Comparator<Topic> ORDER_MOST_COMMENT = new Comparator<Topic>() {
		@Override
		public int compare(Topic o1, Topic o2) {
			if (null == o1 || null == o2) {
				return -1;
			}
			return o1.getCommentCount() > o2.getCommentCount()?0:1;
		}
	};
	
	/**
	 * 最多收藏的排在最前
	 */
	public static Comparator<Topic> ORDER_MOST_FAVOR = new Comparator<Topic>() {
		@Override
		public int compare(Topic o1, Topic o2) {
			if (null == o1 || null == o2) {
				return -1;
			}
			return o1.getFavorCount() > o2.getFavorCount()?0:1;
		}
	};
	
	/**
	 * 最多赞的排在最前
	 */
	public static Comparator<Topic> ORDER_MOST_PRAISE = new Comparator<Topic>() {
		@Override
		public int compare(Topic o1, Topic o2) {
			if (null == o1 || null == o2) {
				return -1;
			}
			return o1.getPraiseCount() > o2.getPraiseCount()?0:1;
		}
	};
}
