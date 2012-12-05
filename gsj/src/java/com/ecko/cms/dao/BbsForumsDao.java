package com.ecko.cms.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.ecko.cms.entity.BbsForums;
import com.ecko.core.dao.HibernateDao;
import com.ecko.core.entity.Page;

@Repository
public class BbsForumsDao extends HibernateDao<BbsForums, Long> {
	@SuppressWarnings("unchecked")
	public Page<BbsForums> list(Page<BbsForums> page, Map map) {

		String hql = " from BbsForums a where  a.state=1  ";
		List ps = new ArrayList();

		page = this.find(page, hql, ps.toArray());
		Long totalCount = this.findLong("select count(a) " + hql, ps.toArray());
		page.setTotalCount(totalCount);
		return page;
	}
	
	@SuppressWarnings("unchecked")
	public List list4Index(){

		String hql = " from BbsForums a  where a.state=1 order by a.seq asc ";
		Query q=this.createQuery(hql	);
//		q.setMaxResults(3);
		return q.list();
	}
}
