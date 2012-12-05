package com.ecko.cms.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.cms.dao.QuestionDao;
import com.ecko.cms.entity.Question;
import com.ecko.core.entity.Page;
import com.ecko.core.service.DefaultEntityManager;

@Service
@Transactional
public class QuestionManager extends DefaultEntityManager<Question, Long> {

	@Autowired
	private QuestionDao questioDao;
	
	@SuppressWarnings("unchecked")
	public Page<Question> list(Page<Question> page, Map map) {
		
		return this.questioDao.list(page, map);
	}
}
