package com.ourlinc.itbbs.user.role;

import com.ourlinc.tern.NameItem;
/**
 * 角色接口
 * @author 陈洁民
 *
 */
public interface Role {
	
	public static final NameItem CREATE_USER = new NameItem("创建用户", 1); 
	
	public static final NameItem BALCKLIST_USER = new NameItem("拉黑用户", 2);
	
	public static final NameItem RECOVER_USER = new NameItem("恢复用户", 3);
	
	public static final NameItem RESET_PASSWORD = new NameItem("重置密码", 4);
	
	public static final NameItem INSTALL_TRAINING_DATE = new NameItem("设置培训时间", 5);
	
	public static final NameItem SHIELD_TOPIC = new NameItem("屏蔽话题", 6);
	
	public static final NameItem RECVOER_TOPIC = new NameItem("恢复话题", 7);
	
	public static final NameItem SHIELD_COMMENT = new NameItem("屏蔽评论", 8);
	
	public static final NameItem RECVOER_COMMENT = new NameItem("恢复评论", 9);
	
	public static final NameItem SHIELD_REPLY = new NameItem("屏蔽回复", 10);
	
	public static final NameItem RECVOER_REPLY = new NameItem("恢复回复", 11);
	
	public static final NameItem CREATE_TAG = new NameItem("创建标签", 12);
	
	public static final NameItem DELETE_TAG = new NameItem("删除标签", 13); 
	
	public static final NameItem USER_ROLE = new NameItem("普通用户", 1);
	
	public static final NameItem ADMINSTRATOR_ROLE = new NameItem("管理员", 2);
	
	public static final NameItem[] ALL_ROLE = {USER_ROLE,ADMINSTRATOR_ROLE};
	
	public static final NameItem[] USER_PERMISSIOM_LIST ={};
	
	public static final NameItem[] AMIN_PERMISSIOM_LIST = {Role.CREATE_USER,Role.BALCKLIST_USER,Role.RECOVER_USER,Role.RESET_PASSWORD,
			Role.INSTALL_TRAINING_DATE,Role.SHIELD_TOPIC,Role.RECVOER_TOPIC,Role.SHIELD_COMMENT,Role.RECVOER_COMMENT,
			Role.SHIELD_REPLY,Role.RECVOER_REPLY,Role.CREATE_TAG,Role.DELETE_TAG};
	
	/**
	 * 取得角色名字
	 * @return
	 */
	public NameItem getName();
	/**
	 *取得权限列表 
	 * @return
	 */
	public NameItem[] getPermissionList();
}
