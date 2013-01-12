package com.ecko.cms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.cms.dao.ConfigsDao;
import com.ecko.cms.entity.Configs;
import com.ecko.core.service.DefaultEntityManager;
@Service
@Transactional
public class ConfigsManager extends DefaultEntityManager<Configs, Long> {

	@Autowired
	private ConfigsDao configsDao;
}
