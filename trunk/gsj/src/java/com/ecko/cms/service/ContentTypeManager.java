package com.ecko.cms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.cms.dao.ContentTypeDao;
import com.ecko.cms.entity.ContentType;
import com.ecko.core.entity.Page;
import com.ecko.core.service.DefaultEntityManager;
@Service
@Transactional
public class ContentTypeManager extends DefaultEntityManager<ContentType, Long> {

	@Autowired
	private ContentTypeDao contentTypeDao;
	 
	@SuppressWarnings("rawtypes")
	public Page<ContentType> list(Page<ContentType> page,Map map){
		return this.contentTypeDao.list(page, map);
	}
	public void delete(Long[] ids){
		if(ids!=null){
			for(Long id:ids){
				ContentType  ct=this.contentTypeDao.get(id);
				ct.setState(0);
				this.contentTypeDao.save(ct);
			}
		}
	}
	
	public List<ContentType> findByValid(){
		
		return this.contentTypeDao.findByValid();
	}

	public List<ContentType>findList(){
		return this.contentTypeDao.findList();
	}
}
