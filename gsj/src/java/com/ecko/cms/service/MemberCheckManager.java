package com.ecko.cms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.cms.dao.MemberCheckDao;
import com.ecko.cms.entity.MemberCheck;
import com.ecko.core.service.DefaultEntityManager;
@Service
@Transactional
public class MemberCheckManager extends DefaultEntityManager<MemberCheck, Long> {

	@Autowired
	private MemberCheckDao checkDao;
}
