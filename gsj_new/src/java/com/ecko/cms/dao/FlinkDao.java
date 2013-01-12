package com.ecko.cms.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ecko.cms.entity.Content;
import com.ecko.cms.entity.Flink;
import com.ecko.core.dao.HibernateDao;
import com.ecko.core.entity.Page;
import com.ecko.core.util.DateManager;

@Repository
public class FlinkDao extends HibernateDao<Flink, Long> {

	@SuppressWarnings("unchecked")
	public Page<Flink> list(Page<Flink> page, Map map) {
		String hql = " from Flink a where 1=1 ";
		List ps = new ArrayList();

		page = this.find(page, hql+" order by seq asc", ps.toArray());
		Long totalCount = this.findLong("select count(a) " + hql, ps.toArray());
		page.setTotalCount(totalCount);

		return page;
	}

	public List<Flink> list() {
		String hql = " from Flink a  order by seq asc";
		return this.find(hql);
	}
}
