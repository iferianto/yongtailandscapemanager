package com.ecko.cms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.cms.dao.FlinkDao;
import com.ecko.cms.entity.Flink;
import com.ecko.core.entity.Page;
import com.ecko.core.service.DefaultEntityManager;
@Service
@Transactional
public class FlinkManager extends DefaultEntityManager<Flink, Long> {

	@Autowired
	private FlinkDao flinkDao;
	
	public List<Flink> list(){
		
		return this.flinkDao.list();
	}

	@SuppressWarnings("unchecked")
	public Page<Flink> list(Page<Flink> page, Map map) {
		return this.flinkDao.list(page, map);
	}
}
