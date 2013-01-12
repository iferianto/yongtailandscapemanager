package com.ecko.system.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.ecko.core.dao.HibernateDao;
import com.ecko.core.entity.Page;
import com.ecko.system.entity.User;

@Repository
public class UserDao extends HibernateDao<User, Long> {
	public List<User> findjq(Long userId) {
		String hql = " from User a where a.state=1 and a.type=4 and a.user.id="+userId;
		return this.find(hql);
	}
	
	public List<User>listByType(Integer type){
		
		String hql=" from User a where a.state=1 and a.type="+type;
		return this.find(hql);
	}

	public User login(String username, String password) {
		Criteria c = this.getSession().createCriteria(User.class);
		c.add(Restrictions.eq("username", username));// eq是等于，gt是大于，lt是小于,or是或
		c.add(Restrictions.eq("password", password));

		List<User> list = c.list();
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public Page<User> list(Page page, Map map) {
		String username = (String) map.get("username");
		Long userId=(Long)map.get("userId");
		Integer type=(Integer)map.get("type");
		String hql = " from User a   where a.state=1";
		List ps = new ArrayList();
		if(userId!=null){
			hql+=" and a.user.id=?";
			ps.add(userId);
		}
		if(type!=null){
			hql+=" and a.type=?";
			ps.add(type);
		}
		if (StringUtils.isNotBlank(username)) {
			hql += " and a.username like ?";
			ps.add("%" + username + "%");

		}
		Object[] objs = ps.toArray();
		page = this.find(page, "select a " + hql, objs);
		Long totalCount = this.findLong("select count(a) " + hql, objs);
		page.setTotalCount(totalCount);
		return page;
	}

	public List<User> findUser(String ids, String deptIds) {
		if (ids.startsWith(",")) {
			ids = ids.substring(1);
		}
		if (ids.endsWith(",")) {
			ids = ids.substring(0, ids.length() - 1);
		}
		if (deptIds.startsWith(",")) {
			deptIds = deptIds.substring(1);
		}
		if (deptIds.endsWith(",")) {
			deptIds = deptIds.substring(0, deptIds.length() - 1);
		}
		if (ids == null || ids.equals("")) {
			ids = "-1";
		}
		if (deptIds == null || deptIds.equals("")) {
			deptIds = "-1";
		}
		String hql = " from User a where a.id in (" + ids
				+ ") or a.dept.id in (" + deptIds + ")";

		return this.find(hql);

	}

	public List<User> findAll() {
		String hql = " from User a where a.state=1";
		return this.find(hql);
	}

	public List<User> findByIds(String ids) {
		String hql = " from User a where a.id in (" + ids + ") ";
		return this.find(hql);
	}
}
