package com.ecko.cms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.cms.dao.BbsForumsDao;
import com.ecko.cms.entity.BbsForums;
import com.ecko.cms.entity.Flink;
import com.ecko.core.entity.Page;
import com.ecko.core.service.DefaultEntityManager;

@Service
@Transactional
public class BbsForumsManager extends DefaultEntityManager<BbsForums, Long> {

	@Autowired
	private BbsForumsDao bbsDao;

	@SuppressWarnings("unchecked")
	public Page<BbsForums> list(Page<BbsForums> page, Map map) {

		return this.bbsDao.list(page, map);
	}
	
	public void delete(Long[] ids){
		
		for(Long id:ids){
			BbsForums bbs=bbsDao.get(id);
			bbs.setState(0);
			this.bbsDao.save(bbs);
		}
	}
	

	@SuppressWarnings("unchecked")
	public List list4Index(){
		
		return this.bbsDao.list4Index();
	}

}
