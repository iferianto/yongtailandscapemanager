package com.ecko.core.dao;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.hibernate.metadata.ClassMetadata;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;

import com.ecko.core.util.ReflectionUtils;

@SuppressWarnings("unchecked")
public class SimpleHibernateDao<T, PK extends Serializable> {
	protected Logger logger = LoggerFactory.getLogger(super.getClass());
	  protected SessionFactory sessionFactory;
	  protected Class<T> entityClass;

	  public SimpleHibernateDao()
	  {
	    this.entityClass = ReflectionUtils.getSuperClassGenricType(super.getClass());
	  }

	  public SimpleHibernateDao(SessionFactory sessionFactory, Class<T> entityClass)
	  {
	    this.sessionFactory = sessionFactory;
	    this.entityClass = entityClass;
	  }

	  public SessionFactory getSessionFactory() {
	    return this.sessionFactory;
	  }

	  @Autowired
	  public void setSessionFactory(SessionFactory sessionFactory)
	  {
	    this.sessionFactory = sessionFactory;
	  }

	  public Session getSession() {
	    return this.sessionFactory.getCurrentSession();
	  }

	  public void save(T entity)
	  {
	    Assert.notNull(entity);
	    getSession().saveOrUpdate(entity);
	    this.logger.debug("save entity: {}", entity);
	  }

	  public void delete(T entity)
	  {
	    Assert.notNull(entity);
	    getSession().delete(entity);
	    this.logger.debug("delete entity: {}", entity);
	  }

	  public void delete(PK id)
	  {
	    Assert.notNull(id);
	    delete(get(id));
	    this.logger.debug("delete entity {},id is {}", this.entityClass.getSimpleName(), id);
	  }

	  public T get(PK id)
	  {
	    Assert.notNull(id);
	    return (T) getSession().load(this.entityClass, id);
	  }

	  public List<T> getAll()
	  {
	    return findByCriteria(new Criterion[0]);
	  }

	  public List<T> findByProperty(String propertyName, Object value)
	  {
	    Assert.hasText(propertyName);
	    Criterion criterion = Restrictions.eq(propertyName, value);
	    return findByCriteria(new Criterion[] { criterion });
	  }

	public T findUniqueByProperty(String propertyName, Object value)
	  {
	    Assert.hasText(propertyName);
	    Criterion criterion = Restrictions.eq(propertyName, value);
	    return (T) createCriteria(new Criterion[] { criterion }).uniqueResult();
	  }

	  public List<T> find(String hql, Object[] values)
	  {
	    return createQuery(hql, values).list();
	  }

	  public Object findUnique(String hql, Object... values)
	  {
	    return createQuery(hql, values).uniqueResult();
	  }

	  public Integer findInt(String hql, Object[] values)
	  {
	    return ((Integer)findUnique(hql, values));
	  }

	  public Long findLong(String hql, Object... values)
	  {
	    return ((Long)findUnique(hql, values));
	  }

	  public Query createQuery(String queryString, Object... values)
	  {
	    Assert.hasText(queryString);
	    Query query = getSession().createQuery(queryString);
	    if (values != null)
	      for (int i = 0; i < values.length; ++i)
	        query.setParameter(i, values[i]);


	    return query;
	  }

	  public List<T> findByCriteria(Criterion[] criterions)
	  {
	    return createCriteria(criterions).list();
	  }

	  public Criteria createCriteria(Criterion[] criterions)
	  {
	    Criteria criteria = getSession().createCriteria(this.entityClass);
	    Criterion[] arr$ = criterions; int len$ = arr$.length; for (int i$ = 0; i$ < len$; ++i$) { Criterion c = arr$[i$];
	      criteria.add(c);
	    }
	    return criteria;
	  }

	  public boolean isPropertyUnique(String propertyName, Object newValue, Object orgValue)
	  {
	    if ((newValue == null) || (newValue.equals(orgValue)))
	      return true;
	    Object object = findUniqueByProperty(propertyName, newValue);
	    return (object == null);
	  }

	  public String getIdName()
	  {
	    ClassMetadata meta = getSessionFactory().getClassMetadata(this.entityClass);
	    Assert.notNull(meta, "Class " + this.entityClass.getSimpleName() + " not define in HibernateSessionFactory.");
	    return meta.getIdentifierPropertyName();
	  }
}
