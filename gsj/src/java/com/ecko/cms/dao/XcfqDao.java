package com.ecko.cms.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import com.ecko.cms.entity.Xcfq;
import com.ecko.core.dao.HibernateDao;
import com.ecko.core.entity.Page;
@Repository
public class XcfqDao extends HibernateDao<Xcfq, Long> {
	@SuppressWarnings("unchecked")
	public Page list(Page page, Map map) {

		String name = (String) map.get("name");
		Long userId=(Long)map.get("userId");
		String hql = " from Xcfq a where 1=1";
		
		List ps = new ArrayList();
		if(userId!=null){
			hql+=" and a.user.id=?";
			ps.add(userId);
		}
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
