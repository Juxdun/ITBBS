package com.ourlinc.itbbs.forum;

import java.util.Arrays;
import java.util.Comparator;
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
 * 标签BO
 * @author 陈洁民
 *
 */
public class Tag extends AbstractPersistent<ForumDi>{
	
	/**
	 * 标签名
	 */
	@Resource
	private String m_Name;
	
	/**
	 * 父标签id
	 */
	@Resource
	private String m_ParentId;
	
	/**
	 * 标签状态
	 */
	@Resource
	private int m_Status;
	
	/**
	* 标签正常
	*/	 
	public static final NameItem STATUS_NORMAL = new NameItem("标签正常", 1);
	/**
	 * 标签删除
    */
	public static final NameItem STATUS_DELETE = new NameItem("标签删除", 2);

	public static final NameItem[] ALL_STATUS = { STATUS_NORMAL, STATUS_DELETE};
	
	/**
	 * 状态索引关键字
	 */
	public static final String REINDEX_STATUS = "s:";
	
	public Tag(ForumDi di,Tag parentTag, String name) {
		super(di);
		if(null!=parentTag){
			m_Id = getPersister().getNewId(parentTag.getId().getOrdinal());
			m_ParentId = parentTag.getId().getId();
		}else{
			m_Id = getPersister().getNewId();
		}
		m_Status = STATUS_NORMAL.getId();
		m_Name = name;
		m_Status = STATUS_NORMAL.getId();
		markPersistenceUpdate();
		reindex();
	}
	
	protected Tag(ForumDi di){
		super(di);
	}
	
	public String getName() {
		return m_Name;
	}

	public void setName(String name) {
		m_Name = name;
		markPersistenceUpdate();
	}
	
	public ResultPage<Topic> getTopics(){
		return getBusinessDi().getTopics(this,Topic.STATUS_NORMAL.id);	
	}
	
	public int getTopicCount(){
		return getBusinessDi().getTopics(this,Tag.STATUS_NORMAL.id).getCount();	
	}
	
	public NameItem getStatus() {
		NameItem ni = NameItem.findById(m_Status, ALL_STATUS);
		if (null == ni) {
			return new NameItem("状态异常", m_Status);
		}
		return ni;
	}
	
	/**
	 * 取父标签
	 * @return 父标签
	 */
	public Tag getParent(){
		if(null==m_ParentId){
			return null;
		}
		return getBusinessDi().getTag(m_ParentId);
	}
	
	/**
	 * 取子标签
	 * @return 子标签
	 */
	public List<Tag> getChildrenTag(){
		return getBusinessDi().getChildrenTag(this);
	}
	
	/**
	 *删除标签
	 * @param admin 管理员对象
	 * @return true 删除成功 false 删除失败
	 */
	public boolean delete(User admin){
		if(null!=admin&&admin.isHasPermission(Role.DELETE_TAG)){//admin不为空且admin有删除标签的权限
			m_Status = STATUS_DELETE.getId();
			markPersistenceUpdate();
			reindex();
			for(Tag child :getChildrenTag()){//递归删除所有子标签
				child.delete(admin);
			}
			return true;
		}
		return false;
	}
	/**
	 * 关键词重索引
	 */
	public void reindex() {
		List<IndexKeyword> ks = Arrays.asList(
				IndexKeywords.newKeyword(REINDEX_STATUS+getStatus().id,0));
		getBusinessDi().getTagSearcher().updateElement(
				IndexElement.valueOf(getId().getOrdinal()), ks);
	}
	/**
	 * 按照名字排序
	 */
	public static Comparator<Tag> ORDER_TAG_NAME = new Comparator<Tag>() {
		@Override
		public int compare(Tag t1, Tag t2) {
			if (null == t1 || null == t2) {
				return -1;
			}
			if (null == t1.getName() || null == t2.getName()) {
				return -1;
			}
			return t1.getName().compareTo(t2.getName());
			/*
			if(t1.getName().compareTo(t2.getName())>0){
				return 0;
			}
			return 1;*/
		}

	};
}
