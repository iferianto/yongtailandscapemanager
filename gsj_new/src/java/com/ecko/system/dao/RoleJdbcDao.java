package com.ecko.system.dao;

import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.stereotype.Repository;
@Repository
public class RoleJdbcDao extends JdbcDaoSupport {

	public void deleteRoleUser(Long roleId){
		
		String sql=" delete from t_role_user where role_id ="+roleId;
		this.getJdbcTemplate().execute(sql);
	}
}
