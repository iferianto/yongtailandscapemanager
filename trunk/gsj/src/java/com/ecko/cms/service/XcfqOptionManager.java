package com.ecko.cms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.cms.dao.XcfqOptionDao;
import com.ecko.cms.entity.XcfqOption;
import com.ecko.core.entity.Page;
import com.ecko.core.service.DefaultEntityManager;
@Service
@Transactional
public class XcfqOptionManager extends DefaultEntityManager<XcfqOption, Long> {

	@Autowired
	private XcfqOptionDao optionDao;
	
	public List<XcfqOption> findValid(){
		
		return this.optionDao.findValid();
	}
	
	public void delete(Long[] ids){
		for(Long id:ids){
			XcfqOption o=this.get(id);
			o.setState(0);
			this.save(o);
		}
	}
	@SuppressWarnings("unchecked")
	public Page list(Page page, Map map) {
		
		return this.optionDao.list(page, map);
	}
}
