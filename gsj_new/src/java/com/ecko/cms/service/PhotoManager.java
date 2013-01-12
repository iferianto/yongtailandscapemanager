package com.ecko.cms.service;

import java.util.List;

import org.hibernate.envers.Audited;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.cms.dao.PhotoDao;
import com.ecko.cms.entity.Photo;
import com.ecko.core.service.DefaultEntityManager;
@Service
@Transactional
public class PhotoManager extends DefaultEntityManager<Photo, Long> {
	
	@Autowired
	private PhotoDao photoDao;
	public List<Photo>show(Long typeId){
		
		return this.photoDao.show(typeId);
	}

	public List<Photo> ppt() {
		
		return this.photoDao.ppt();
	}
}
