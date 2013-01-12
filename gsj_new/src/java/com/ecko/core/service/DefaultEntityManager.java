package com.ecko.core.service;

import java.io.Serializable;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.core.dao.HibernateDao;

@SuppressWarnings("unchecked")
@Transactional
public class DefaultEntityManager<T, PK extends Serializable> extends
		EntityManager<T, PK> {
	protected HibernateDao<T, PK> entityDao;

	protected HibernateDao<T, PK> getEntityDao() {
		return this.entityDao;
	}

	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.entityDao = new HibernateDao(sessionFactory, this.entityClass);
	}
}