package com.ecko.core.dao;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.impl.CriteriaImpl;
import org.hibernate.transform.ResultTransformer;
import org.springframework.util.Assert;

import com.ecko.core.entity.Page;
import com.ecko.core.util.ReflectionUtils;

@SuppressWarnings("unchecked")
public class HibernateDao<T, PK extends Serializable> extends
		SimpleHibernateDao<T, PK> {
	public HibernateDao() {
	}

	public HibernateDao(SessionFactory sessionFactory, Class<T> entityClass) {
		super(sessionFactory, entityClass);
	}

	public Page<T> getAll(Page<T> page) {
		return findByCriteria(page, new Criterion[0]);
	}

	public Page<T> find(Page<T> page, String hql, Object ... values) {
		Assert.notNull(page);

		Query q = createQuery(hql, values);
		setPageParameter(q, page);
		List result = q.list();
		page.setResult(result);
		return page;
	}
	
	public List<T> find(String hql,Object ... values){
		Query q = createQuery(hql, values);
		List result = q.list();
		return result;
	}
	
	public List query(String hql,Object ...values){
		Query q=this.getSession().createQuery(hql);
		 if (values != null)
		      for (int i = 0; i < values.length; ++i)
		        q.setParameter(i, values[i]);
		 return q.list();
	}

	public Page<T> findByCriteria(Page<T> page, Criterion[] criterions) {
		Assert.notNull(page);

		Criteria c = createCriteria(criterions);
		
		if (page.isAutoCount()) {
			int totalCount = countCriteriaResult(c, page);
			page.setTotalCount(totalCount);
		}

		setPageParameter(c, page);
		List result = c.list();
		page.setResult(result);
		return page;
	}

	protected Query setPageParameter(Query q, Page<T> page) {
		q.setFirstResult(page.getFirst());
		q.setMaxResults(page.getPageSize());
		return q;
	}

	protected Criteria setPageParameter(Criteria c, Page<T> page) {
		c.setFirstResult(page.getFirst());
		c.setMaxResults(page.getPageSize());

		if (page.isOrderBySetted()) {
			String[] orderByArray = StringUtils.split(page.getOrderBy(), ',');
			String[] orderArray = StringUtils.split(page.getOrder(), ',');

			Assert.isTrue(orderByArray.length == orderArray.length,
					"分页多重排序参数中,排序字段与排序方向的个数不相等");

			for (int i = 0; i < orderByArray.length; ++i)
				if ("asc".equals(orderArray[i]))
					c.addOrder(Order.asc(orderByArray[i]));
				else
					c.addOrder(Order.desc(orderByArray[i]));

		}

		return c;
	}

	/**
	 * 执行count查询获得本次Criteria查询所能获得的对象总数.
	 */
	protected int countCriteriaResult(final Criteria c, final Page<T> page) {
		CriteriaImpl impl = (CriteriaImpl) c;

		// 先把Projection、ResultTransformer、OrderBy取出来,清空三者后再执行Count操作
		Projection projection = impl.getProjection();
		ResultTransformer transformer = impl.getResultTransformer();

		List<CriteriaImpl.OrderEntry> orderEntries = null;
		try {
			orderEntries = (List) ReflectionUtils.getFieldValue(impl,
					"orderEntries");
			ReflectionUtils
					.setFieldValue(impl, "orderEntries", new ArrayList());
		} catch (Exception e) {
			logger.error("不可能抛出的异常:{}", e.getMessage());
		}

		// 执行Count查询
		int totalCount = (Integer) c.setProjection(Projections.rowCount())
				.uniqueResult();

		// 将之前的Projection,ResultTransformer和OrderBy条件重新设回去
		c.setProjection(projection);

		if (projection == null) {
			c.setResultTransformer(CriteriaSpecification.ROOT_ENTITY);
		}
		if (transformer != null) {
			c.setResultTransformer(transformer);
		}
		try {
			ReflectionUtils.setFieldValue(impl, "orderEntries", orderEntries);
		} catch (Exception e) {
			logger.error("不可能抛出的异常:{}", e.getMessage());
		}

		return totalCount;
	}
}
