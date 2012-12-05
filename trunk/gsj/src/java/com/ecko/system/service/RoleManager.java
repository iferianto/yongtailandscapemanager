package com.ecko.system.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.core.entity.Page;
import com.ecko.core.service.DefaultEntityManager;
import com.ecko.system.dao.RoleDao;
import com.ecko.system.dao.RoleJdbcDao;
import com.ecko.system.entity.Role;
import com.ecko.system.entity.User;
@Service
@Transactional
public class RoleManager extends DefaultEntityManager<Role, Long> {

	@Autowired
	private RoleDao roleDao;
	
	@Autowired
	private RoleJdbcDao jdbcDao;
	
	 public List<Role> findByUser(Long userId){
		 return this.roleDao.findByUser(userId);
	 }
	 public List<Role>listRoles(String roleIds){
		 
		 return this.roleDao.listRoles(roleIds);
	 }
	 
	 public List<Role>findValid(){
		 return this.roleDao.findValid();
	 }
	 
	 public Page list(Page page,Map map){
		 
		 return roleDao.list(page, map);
	 }
	 
	 public void delete(Long[]ids){
		 for(Long id:ids){
			 if(id==1)
				 continue;
//			 Role role=this.get(id);
			 this.jdbcDao.deleteRoleUser(id);
			 this.delete(id);
		 }
		 
	 }
}
