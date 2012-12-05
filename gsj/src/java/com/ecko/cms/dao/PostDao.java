package com.ecko.cms.dao;

import org.springframework.stereotype.Repository;

import com.ecko.cms.entity.Post;
import com.ecko.core.dao.HibernateDao;
import com.ecko.core.entity.Page;

@Repository
public class PostDao extends HibernateDao<Post, Long> {
	@SuppressWarnings("unchecked")
	public Page<Post> list(Long threadId, Page page) {
		String hql = " from Post a where a.thread.id=" + threadId;
		page = this.find(page, hql+" order by a.id asc ");
		Long count = this.findLong("select count(a) " + hql);
		page.setTotalCount(count);
		return page;
	}
}
