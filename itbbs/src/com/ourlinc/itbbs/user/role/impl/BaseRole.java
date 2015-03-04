package com.ourlinc.itbbs.user.role.impl;

import javax.annotation.Resource;

import com.ourlinc.itbbs.user.role.Role;
import com.ourlinc.tern.NameItem;
import com.ourlinc.tern.annotation.Inherited;
/**
 * 角色基类
 * @author 陈洁民
 *
 */
@Inherited
public  class BaseRole implements Role {
	@Resource
	private int m_Name;
	public BaseRole(){
		
	}
	
	public BaseRole(int name){
		m_Name=name;
	}
	
	@Override
	public NameItem getName() {
		return NameItem.findById(m_Name,Role.ALL_ROLE);
	}
	
	@Override
	public NameItem[] getPermissionList() {
		if(Role.USER_ROLE.id==m_Name){
			return Role.USER_PERMISSIOM_LIST;
		}
		return Role.AMIN_PERMISSIOM_LIST;
	}

}
