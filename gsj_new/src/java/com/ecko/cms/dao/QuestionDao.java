package com.ecko.cms.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ecko.cms.entity.Flink;
import com.ecko.cms.entity.Question;
import com.ecko.core.dao.HibernateDao;
import com.ecko.core.entity.Page;

@Repository
public class QuestionDao extends HibernateDao<Question, Long> {
	@SuppressWarnings("unchecked")
	public Page<Question> list(Page<Question> page, Map map) {
		String hql = " from Question a where 1=1 ";
		List ps = new ArrayList();

		page = this.find(page, hql   , ps.toArray());
		Long totalCount = this.findLong("select count(a) " + hql, ps.toArray());
		page.setTotalCount(totalCount);

		return page;
	}
}
