package com.ourlinc.itbbs.user;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ourlinc.itbbs.forum.Comment;
import com.ourlinc.itbbs.forum.Favor;
import com.ourlinc.itbbs.forum.Praise;
import com.ourlinc.itbbs.forum.Reply;
import com.ourlinc.itbbs.forum.Tag;
import com.ourlinc.itbbs.forum.Topic;
import com.ourlinc.itbbs.user.di.UserDi;
import com.ourlinc.itbbs.user.role.Role;
import com.ourlinc.itbbs.user.role.impl.BaseRole;
import com.ourlinc.itbbs.util.Encrypt;
import com.ourlinc.tern.NameItem;
import com.ourlinc.tern.ResultPage;
import com.ourlinc.tern.annotation.ResourceExt;
import com.ourlinc.tern.search.IndexElement;
import com.ourlinc.tern.search.IndexKeyword;
import com.ourlinc.tern.search.IndexKeywords;
import com.ourlinc.tern.support.AbstractPersistent;
/**
 * User业务对象
 * @author 陈洁民
 */
public class User extends AbstractPersistent<UserDi>{
	
	/**
	 * 日志记录器
	 */
	public final static Logger _Logger = LoggerFactory.getLogger(User.class);
	/**
	 * 用户名
	 */
	@Resource
	private String m_Username;
	
	/**
	 * 密码
	 */
	@Resource
	private String m_Password;
	
	/**
	 * 用户的QQ
	 */
	@Resource
	private String m_QQ;
	
	/**
	 * 昵称
	 */
	@Resource
	private String m_Nickname;
	
	/**
	 * 手机
	 */
	@Resource
	private String m_Phone;
	
	/**
	 * 毕业学校
	 */
	@Resource
	private String m_GraduateSchool;
	
	/**
	 * 最高学历 
	 */
	@Resource
	private String m_HighestEducation;
	
	/**
	 * 工作职位
	 */
	@Resource
	private String m_Position;
	
	/**
	 * 个人签名
	 */
	@Resource
	private String m_Signature;
	
	/**
	 * 培训时间
	 */
	@Resource
	private Date m_TrainingDate;
	
	/**
	 * 用户状态
	 */
	@Resource
	private int m_Status;
	
	/**
	 * 用户角色列表
	 */
	@ResourceExt(component = BaseRole.class)
	private List<Role> m_Roles;
	
	/**
	 * 最新消息数
	 */
	@Resource
	private int m_NewMsgCount;
	
	/**
	* 用户正常
	*/	 
	public static final NameItem STATUS_NORMAL = new NameItem("用户正常", 1);
	/**
	 * 用户拉黑
    */
	public static final NameItem STATUS_BLACKLIST = new NameItem("用户拉黑", 2);

	public static final NameItem[] ALL_STATUS = { STATUS_NORMAL, STATUS_BLACKLIST };
	
	/**
	 * 状态索引关键字
	 */
	public static final String REINDEX_STATUS = "s:";
	
	public User(UserDi di,String username,String password) {
		super(di);
		m_Id =  getPersister().getNewId();
		m_Status = STATUS_NORMAL.getId();
		m_Username = username;
		m_Password = Encrypt.md5(password);
		ArrayList<Role> list = new ArrayList<Role>();
		list.add( new BaseRole(Role.USER_ROLE.id));
		m_Roles = list;
		markPersistenceUpdate();
		reindex();
	}
	
	protected User(UserDi di) {
		super(di);
	}
	
	public String getUsername() {
		return m_Username;
	}
	
	public String getQQ() {
		return m_QQ;
	}
	
	public void setQQ(String QQ) {
		m_QQ = QQ;
		markPersistenceUpdate();
	}
	
	/**
	 * 取昵称
	 * @return 昵称
	 */
	public String getNickname() {
		return m_Nickname;
	}
	
	/**
	 * 设昵称
	 * @param nickname 昵称
	 */
	public void setNickname(String nickname) {
		m_Nickname = nickname;
		markPersistenceUpdate();
	}
	
	public String getPhone() {
		return m_Phone;
	}
	
	public void setPhone(String phone) {
		m_Phone = phone;
		markPersistenceUpdate();
	}
	
	/**
	 * 取毕业学校
	 * @return	毕业学校
	 */
	public String getGraduateSchool() {
		return m_GraduateSchool;
	}
	
	/**
	 * 设毕业学校
	 * @param graduateSchool 毕业学校
	 */
	public void setGraduateSchool(String graduateSchool) {
		m_GraduateSchool = graduateSchool;
		markPersistenceUpdate();
	}
	
	/**
	 * 取最高学历
	 * @return 最高学历
	 */
	public String getHighestEducation() {
		return m_HighestEducation;
	}
	
	/**
	 * 设最高学历
	 * @param highestEducation 最高学历
	 */
	public void setHighestEducation(String highestEducation) {
		m_HighestEducation = highestEducation;
		markPersistenceUpdate();
	}
	
	/**
	 * 取工作职位
	 * @return 工作职位
	 */
	public String getPosition() {
		return m_Position;
	}
	
	/**
	 * 设工作职位
	 * @param position 工作职位
	 */
	public void setPosition(String position) {
		m_Position = position;
		markPersistenceUpdate();
	}
	
	/**
	 * 取个人签名
	 * @return 个人签名
	 */
	public String getSignature() {
		return m_Signature;
	}
	
	/**
	 * 设个人签名
	 * @param signature 个人签名
	 */
	public void setSignature(String signature) {
		m_Signature = signature;
		markPersistenceUpdate();
	}
	
	/**
	 * 取培训时间
	 * @return 培训时间
	 */
	public Date getTrainingDate() {
		return m_TrainingDate;
	}
	
	public NameItem getStatus() {
		NameItem ni = NameItem.findById(m_Status, ALL_STATUS);
		if (null == ni) {
			return new NameItem("状态异常", m_Status);
		}
		return ni;
	}
	
	/**
	 * 取角色列表
	 * @return 角色列表
	 */
	public List<Role> getRoles() {
		return m_Roles;
	}
	
	/**
	 * 取最新消息数
	 * @return 最新消息数
	 */
	public int getNewMsgCount() {
		return m_NewMsgCount;
	}
	
	/**
	 * 最新消息数加一
	 * @return 最新消息数
	 */
	public int addNewMsgCount(){
		m_NewMsgCount++;
		markPersistenceUpdate();
		return m_NewMsgCount;
	}
	/**
	 * 重置最新消息数(0)
	 * @return 最新消息数
	 */
	public  int resetNewMsgCount() {
		m_NewMsgCount = 0;
		markPersistenceUpdate();
		return m_NewMsgCount;
	}
	
	/**
	 * 检查密码
	 * @param password 密码
	 * @return true 密码相同  false 密码不同
	 */
	public boolean checkPassword(String password){
		if(null!=password&&password.length()>0&&m_Password.equals(Encrypt.md5(password))){
			return true;
		}
		return false;
	}
	
	/**
	 * 修改密码
	 * @param admin 管理员
	 * @param newPassword 新密码
	 * @param oldPassword 旧密码
	 * @return
	 */
	public boolean changePassword(User admin, String newPassword,String oldPassword) {
		if((null==oldPassword&&null!=admin&&admin.isHasPermission(Role.RESET_PASSWORD))||//旧密码为null且admin不为null且admin拥有重置密码的权限
			(null!=oldPassword&&oldPassword.equals(m_Password))){//旧密码不为null而且旧密码正确
			m_Password = Encrypt.md5(newPassword);
			markPersistenceUpdate();
			return true;
		}
		return false;
	}
	
	/**
	 * 
	 * @param admin 管理员
	 * @param trainingDate 培训时间
	 * @return true 设置成功 false 设置失败
	 */
	public boolean installTrainingDate(User admin,Date trainingDate) {
		if(null!=admin&&admin.isHasPermission(Role.INSTALL_TRAINING_DATE)){//判断admin是否有设置培训时间的权限
			m_TrainingDate = trainingDate;
			markPersistenceUpdate();
			return true;
		}
		return false;
	}
	/**
	 * 用户是否拥有某项权限
	 * @param permission 权限
	 * @return true 有 false 没有
	 */
	public boolean isHasPermission(NameItem permission){
		boolean flag = false;
		for(Role role : m_Roles){
			for(NameItem ni : role.getPermissionList()){
				if(permission.id==ni.id){
					flag = true;
				}
			}
		}
		return flag;
	}
	
	/**
	 * 用户是否拥有某个角色
	 * @param name 角色名
	 * @return true 有 false 没有
	 */
	public boolean isHasRole(int name){
		boolean flag = false;
		for(Role role : m_Roles){
			if(name==role.getName().getId()){
				flag = true;
			}
		}
		return flag;
	}
	
	
	/**
	 * 拉黑用户
	 * @param admin 管理员
	 * @return true 拉黑成功 false 拉黑失败
	 */
	public boolean blacklist(User admin){
		if(null!=admin&&admin.isHasPermission(Role.BALCKLIST_USER)){//判断admin是否有拉黑用户的权限
			m_Status=STATUS_BLACKLIST.getId();
			markPersistenceUpdate();
			reindex();
			return true;
		}
		return false;
	}
	
	/**
	 * 恢复用户
	 * @param admin 管理员
	 * @return true 恢复成功 false 恢复失败
	 */
	public boolean recover(User admin){
		if(null!=admin&&admin.isHasPermission(Role.RECOVER_USER)){//判断admin是否有回复用户的权限
			m_Status=STATUS_NORMAL.getId();
			markPersistenceUpdate();
			reindex();
			return true;
		}
		return false;
	}
	
	/**
	 * 取用户列表
	 * @param status 状态
	 * @return 用户列表
	 */
	public ResultPage<User> getUsers(int status){
		return getBusinessDi().getUsers(status);
		
	}
	
	/**
	 * 取用户发表的话题列表
	 * @return 话题列表
	 */
	public ResultPage<Topic> getTopics(){
		return getBusinessDi().getTopics(this);
		
	}
	
	/**
	 * 取用户发表的评论列表
	 * @return 评论列表
	 */
	public ResultPage<Comment> getComments(){
		return getBusinessDi().getComments(this);
	}
	
	/**
	 * 取用户的回复列表
	 * @return 回复列表
	 */
	public ResultPage<Reply> getReplies(){
		return getBusinessDi().getReplies(this);
	}
	
	/**
	 * 取用户的收藏列表
	 * @return 收藏列表
	 */
	public ResultPage<Favor> getFavors(){
		return getBusinessDi().getFavors(this,null);
	}
	
	/**
	 * 新建话题
	 * @param name 话题名
	 * @param content 内容
	 * @param tags 标签列表
	 * @return 话题
	 */
	public Topic createTopic(String name, String content,List<String> tagsId){
		
		Topic topic = getBusinessDi().createTopic(name, content, this); 
		if(null!=topic){
			topic.setTags(tagsId);
		}
		 return topic;
	}
	
	/**
	 * 创建标签
	 * @param parent 父标签
	 * @param name 标签名
	 * @return 标签
	 */
	public Tag createTag(Tag parent, String name){
		if(isHasPermission(Role.CREATE_TAG)){//判断是否有创建标签的权限
			return getBusinessDi().createTag(parent,name,this);
		}
		return null;
	}
	
	/**
	 * 收藏
	 * @param topic 话题
	 * @return
	 */
	public Favor favor(Topic topic){
		return getBusinessDi().createFavor(this, topic);
	}
	
	/**
	 * 取消收藏
	 * @param topic 话题
	 * @return true 成功 false 失败
	 */
	public boolean cancelfavor(Topic topic){
		Favor favor = getBusinessDi().getFavor(this,topic);
		if(null != favor){
			favor.delete();
			return true;
		}
		return false;
	}
	
	/**
	 * 点赞
	 * @param topic 话题
	 * @return
	 */
	public Praise praise(Topic topic){
		return getBusinessDi().createPraise(this, topic);
	}
	
	/**
	 * 取消点赞
	 * @param topic 话题
	 * @return true 成功 false 失败
	 */
	public boolean cancelPraise(Topic topic){
		Praise praise = getBusinessDi().getPraise(this,topic);
		if(null!=praise){
			praise.delete();
			return true;
		}
		return false;
		
	}
	/**
	 * 关键词重索引
	 */
	public void reindex() {
		List<IndexKeyword> ks = Arrays.asList(IndexKeywords.newKeyword(REINDEX_STATUS+getStatus().id,0),
				IndexKeywords.newKeyword(getUsername(),0));
		getBusinessDi().getUserSearcher().updateElement(
				IndexElement.valueOf(getId().getOrdinal()), ks);
	}
	
	/**
	 * 按照名字排序
	 */
	public static Comparator<User> ORDER_USER_NAME = new Comparator<User>() {
		@Override
		public int compare(User u1, User u2) {
			if (null == u1 || null == u2) {
				return -1;
			}
			if(u1.getUsername().compareTo(u2.getUsername())>0){
				return 0;
			}
			return 1;
		}

	};

}
