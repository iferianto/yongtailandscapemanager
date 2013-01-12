package com.ecko.cms.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ecko.cms.entity.Flink;
import com.ecko.cms.entity.Threads;

import com.ecko.core.dao.HibernateDao;
import com.ecko.core.entity.Page;

@Repository
public class ThreadsDao extends HibernateDao<Threads, Long> {

	@SuppressWarnings("unchecked")
	public Page<Threads> list(Page<Threads> page, Map map) {
		Long typeId=(Long)map.get("typeId");
		String title=(String)map.get("title");
		String hql = " from Threads a where 1=1 ";
		List ps = new ArrayList();
		if(typeId!=null){
			hql+=" and a.forums.id="+typeId;
		}
		if(title!=null&&!title.equals("")){
			hql+=" and a.title like ?";
			ps.add("%"+title+"%");
		}
		page = this.find(page, hql, ps.toArray());
		Long totalCount = this.findLong("select count(a) " + hql, ps.toArray());
		page.setTotalCount(totalCount);
		return page;
	}
	
	public List <Threads>list(Long typeId){
		String hql = " from Threads a where a.forums.id= "+typeId;
		return this.find(hql);
		
	}
}
