package com.ecko.cms.dao;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.ecko.cms.entity.Photo;
import com.ecko.core.dao.HibernateDao;

@Repository
public class PhotoDao extends HibernateDao<Photo, Long> {

	public List<Photo> findByContent(Long id) {
		String hql = " from Photo p where p.content.id=" + id;
		return this.find(hql);
	}

	public List<Photo> show(Long typeId) {
//		String hql = " from ContentType t where id=" + typeId;  p.id desc
		// List types=this.getSession().group by p.content
		String hql = "from Photo p where (p.type.id=?  or p.type.parent.id=?) and p.content.audit=1   order by rand()";
		Query q = this.createQuery(hql, typeId,typeId);
		q.setMaxResults(10);
		return q.list();
	}
	
	public List<Photo>show2(Long typeId,String ids){
		if(ids==null||ids==""){
			ids="-1";
		}
		String hql = "from Photo p where (p.type.id=?  or p.type.parent.id=?) and p.content.audit=1 and p.id not in("+ids+")  group by p.content order by p.id desc";
		Query q = this.createQuery(hql, typeId,typeId);
		q.setMaxResults(10);
		return q.list();
	}

	@SuppressWarnings("unchecked")
	public List<Photo> ppt() {

		String hql = "select p  from Photo p left outer join p.content c where c.ppt=1 and c.audit=1 group by c order by p.content.id desc limit 4";
		Query q = this.createQuery(hql);
		q.setMaxResults(5);
		return q.list();
	}
}
