package com.ourlinc.itbbs.user;


/**
 *user模块的service 
 * @author 陈洁民
 *
 */
public interface UserService {
	
	/**
	 * 登录
	 * @param username 用户名
	 * @param password 密码
	 * @return 用户
	 */
	public User login(String username,String password);
	
	/**
	 * 取用户对象
	 * @param id
	 * @return
	 */
	public User getUser(String id);
	
	/**
	 * 
	 * @param status 状态
	 * @param username 用户名
	 * @return 用户集合
	 */
	public User getUserByName(int status,String username);
	
	/**
	 * 
	 * @param username 用户名
	 * @param password 密码
	 * @return 用户
	 */
	public User RegisterUser(User admin,String username,String password);
	
	/**
	 * 用户是否存在
	 * @param username 用户名
	 * @return true 存在 false 不存在
	 */
	public boolean isUserExist(String username);
}
