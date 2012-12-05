package com.ecko.core.service;

import java.io.Serializable;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.core.dao.HibernateDao;
import com.ecko.core.entity.Page;
import com.ecko.core.util.ReflectionUtils;

@Transactional
public abstract class EntityManager<T, PK extends Serializable> {
	protected Logger logger = LoggerFactory.getLogger(super.getClass());
	protected Class<T> entityClass;

	@SuppressWarnings("unchecked")
	public EntityManager() {
		this.entityClass = ReflectionUtils.getSuperClassGenricType(super
				.getClass());
	}

	protected abstract HibernateDao<T, PK> getEntityDao();

	@Transactional(readOnly = true)
	public T get(PK id) {
		return getEntityDao().get(id);
	}

	@Transactional(readOnly = true)
	public Page<T> getAll(Page<T> page) {
		return getEntityDao().getAll(page);
	}

	// @Transactional(readOnly = true)
	// public Page<T> search(Page<T> page, List<PropertyFilter> filters) {
	// return getEntityDao().findByFilters(page, filters);
	// }

	@Transactional(readOnly = true)
	public List<T> getAll() {
		return getEntityDao().getAll();
	}

	public void save(T entity) {
		getEntityDao().save(entity);
	}

	public void delete(PK id) {
		getEntityDao().delete(id);
	}

	public void delete(T entity) {
		getEntityDao().delete(entity);
	}

	public void delete(PK[] ids) {
		for (PK id : ids) {
			this.delete(id);
		}
	}
}