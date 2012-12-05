package com.ecko.cms.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ecko.cms.entity.ContentType;
import com.ecko.core.dao.HibernateDao;
import com.ecko.core.entity.Page;

@Repository
public class ContentTypeDao extends HibernateDao<ContentType, Long> {
	@SuppressWarnings("unchecked")
	public Page<ContentType> list(Page<ContentType> page, Map map) {
		String name = (String) map.get("name");
		String hql = " from ContentType a where a.state=1 ";
		List ps = new ArrayList();
		if (name != null && !name.equals("")) {
			hql += " and a.name like ?";
			ps.add("%" + name + "%");
		}
		page = this.find(page, hql, ps.toArray());
		Long totalCount = this.findLong("select count(a) " + hql, ps.toArray());
		page.setTotalCount(totalCount);
		return page;
	}

	public List<ContentType> findByValid() {
		String hql = " from ContentType a where a.state=1 ";
		return this.find(hql);
	}
	
	public List<ContentType>findList(){
		String hql=" from ContentType a where a.state=1 and a.type=1";
		return this.find(hql);
	}
}
