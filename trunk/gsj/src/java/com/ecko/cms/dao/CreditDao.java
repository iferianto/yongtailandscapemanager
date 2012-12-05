package com.ecko.cms.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import com.ecko.cms.entity.Credit;
import com.ecko.core.dao.HibernateDao;
import com.ecko.core.entity.Page;
import com.ecko.system.entity.User;
@Repository
public class CreditDao extends HibernateDao<Credit, Long> {

	
	@SuppressWarnings("unchecked")
	public Page<Credit> list(Page page, Map map) {
	 
		String hql = " from Credit a   where 1=1";
		List ps = new ArrayList();
		 
		Object[] objs = ps.toArray();
		page = this.find(page, "select a " + hql, objs);
		Long totalCount = this.findLong("select count(a) " + hql, objs);
		page.setTotalCount(totalCount);
		return page;
	}

}
