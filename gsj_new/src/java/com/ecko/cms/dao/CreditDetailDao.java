package com.ecko.cms.dao;

import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.ecko.cms.entity.CreditDetail;
import com.ecko.core.dao.HibernateDao;
@Repository
public class CreditDetailDao extends HibernateDao<CreditDetail, Long> {

	
	public CreditDetail findLast(Long creditId){
		String hql=" from CreditDetail a where a.credit.id="+creditId+" and a.type=0 order by occerdate desc  ";
		Query query=this.getSession().createQuery(hql);
		query.setMaxResults(1);
		List ls=query.list();
		Iterator iter = ls.iterator();
		if(iter.hasNext())
			return (CreditDetail) iter.next();
		else
			return null;
	}
}
