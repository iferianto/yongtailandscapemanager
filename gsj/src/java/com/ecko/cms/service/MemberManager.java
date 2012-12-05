package com.ecko.cms.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.cms.dao.MemberDao;
import com.ecko.cms.entity.Member;
import com.ecko.core.entity.Page;
import com.ecko.core.service.DefaultEntityManager;
@Service
@Transactional
public class MemberManager extends DefaultEntityManager<Member, Long> {

	@Autowired
	private MemberDao memberDao;
	
	public Member findByName(String username){
		return this.memberDao.findByName(username);
	}
	
	@SuppressWarnings("unchecked")
	public Page<Member> list(Page<Member> page, Map map) {
		
		return memberDao.list(page, map);
	}
	
	public Member login(String username,String password){
		
		return this.memberDao.login(username, password);
	}
}
