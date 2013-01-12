package com.ecko.cms.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.ecko.cms.entity.Content;
import com.ecko.core.dao.HibernateDao;
import com.ecko.core.entity.Page;
import com.ecko.core.util.DateManager;

@Repository
public class ContentDao extends HibernateDao<Content, Long> {

	@SuppressWarnings("unchecked")
	public Page<Content> list(Page<Content> page, Map map) {
		String title = (String) map.get("title");
		Long typeId = (Long) map.get("typeId");
		Date startDate = (Date) map.get("startDate");
		Date endDate = (Date) map.get("endDate");
		Integer audit = (Integer) map.get("audit");
		Long userId = (Long) map.get("userId");
		String hql = " from Content a where a.state=1  ";

		List ps = new ArrayList();
		if (audit != null) {
			hql += " and( a.audit =?)";
			// hql+=" a";
			ps.add(audit);
		}
		if (userId != null) {

			hql += " and( a.user.id=?)";
			// hql+=" a";
			ps.add(userId);
		}
		if (typeId != null) {

			hql += " and( a.type.id=" + typeId + " or a.type.parent.id=?)";
			// hql+=" a";
			ps.add(typeId);
		}
		if (startDate != null) {
			hql += " and a.createdate>?";
			ps.add(startDate);
		}
		if (endDate != null) {
			hql += " and a.createdate<?";
			ps.add(DateManager.nextDate(endDate));
		}
		if (title != null && !title.equals("")) {
			hql += " and a.title like ?";
			ps.add("%" + title + "%");
		}
		page = this.find(page, hql + " order by a.pubdate desc", ps.toArray());
		Long totalCount = this.findLong("select count(a) " + hql, ps.toArray());
		page.setTotalCount(totalCount);
		return page;
	}

	public List<Content> listByType(Long typeId, Integer counts) {

		String hql = " from Content a where a.state=1 and a.audit=1 and  a.type.id="
				+ typeId
				+ " or a.type.parent.id="
				+ typeId
				+ " order by pubdate desc";
		Query q = this.createQuery(hql);
		q.setMaxResults(counts);
		List ls= q.list();
		return ls;
	}

	public List<Content> findNewst(Integer length) {

		String hql = " from Content a where a.state=1  and a.audit=1 and a.type.id not in(35,36) order by pubdate desc";
		Query q = this.createQuery(hql);
		q.setMaxResults(length);
		return q.list();

	}
}
