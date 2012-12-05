package com.ecko.cms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.cms.dao.ContentDao;
import com.ecko.cms.dao.PhotoDao;
import com.ecko.cms.entity.Content;
import com.ecko.cms.entity.Photo;
import com.ecko.core.entity.Page;
import com.ecko.core.service.DefaultEntityManager;
@Service
@Transactional
public class ContentManager extends DefaultEntityManager<Content, Long> {

	@Autowired
	private ContentDao contentDao;
	@Autowired
	private PhotoDao photoDao;
	
	public List<Content> findNewst(Integer length){
		
		return this.contentDao.findNewst(  length);
	}
	
	
	public void deletePhoto(Long id){
		
		  this.photoDao.delete(id);
	}
	
	@SuppressWarnings("unchecked")
	public Page<Content> list(Page<Content> page, Map map) {
		return this.contentDao.list(page, map);
	}
	
	public List<Content>listByType(Long typeId,Integer counts){
		
		return this.contentDao.listByType(typeId,  counts);
	}
	
	public void save(Content content){
		this.contentDao.save(content);
		
		List<Photo> photos=photoDao.findByContent(content.getId());
		if(photos==null)
			return ;
		for(Photo p:photos	){
			p.setType(content.getType());
			this.photoDao.save(p);
		}
		
	}
}
