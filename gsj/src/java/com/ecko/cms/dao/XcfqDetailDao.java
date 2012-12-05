package com.ecko.cms.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.ecko.cms.entity.XcfqDetail;
import com.ecko.core.dao.HibernateDao;

@Repository
public class XcfqDetailDao extends HibernateDao<XcfqDetail, Long> {
	public List<XcfqDetail> findDetails(Long id) {
		String hql = " from XcfqDetail a where a.xcfq.id=?";
		return this.find(hql, id);
	}
}
