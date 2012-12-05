package com.ecko.system.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import com.ecko.core.dao.HibernateDao;
import com.ecko.core.entity.Page;
import com.ecko.core.service.DefaultEntityManager;
import com.ecko.system.entity.Role;

@Repository
public class RoleDao extends HibernateDao<Role, Long> {

	public List<Role> findByUser(Long userId) {

		String hql = " select r from Role r left outer join r.users u where u.id="
				+ userId;
		return this.find(hql);
	}
	
	public List<Role>listRoles(String roleIds){
		String hql = " from Role a where  a.id in("+roleIds+")";
		return this.find(hql);
		
	}

	public List<Role> findValid() {
		String hql = " from Role a where a.state=1";
		return this.find(hql);
	}

	@SuppressWarnings("unchecked")
	public Page list(Page page, Map map) {

		String name = (String) map.get("name");
		String hql = " from Role a where 1=1";

		List ps = new ArrayList();

		if (StringUtils.isNotBlank(name)) {
			hql += "  a.name like ?";
			ps.add("%" + name + "%");
		}

		Object[] objs = ps.toArray();
		page = this.find(page, hql, objs);
		Long totalCount = this.findLong("select count(a) " + hql, objs);
		page.setTotalCount(totalCount);
		return page;
	}

}
