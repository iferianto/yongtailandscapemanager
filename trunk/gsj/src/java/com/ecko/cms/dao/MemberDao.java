package com.ecko.cms.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ecko.cms.entity.Member;
import com.ecko.core.dao.HibernateDao;
import com.ecko.core.entity.Page;

@Repository
public class MemberDao extends HibernateDao<Member, Long> {

	public Member findByName(String username) {
			return (Member) this.findUnique(" from Member m where m.username =?", username);
	}

	@SuppressWarnings("unchecked")
	public Page<Member> list(Page<Member> page, Map map) {
		Integer state = (Integer) map.get("state");
		Integer type = (Integer) map.get("type"); 
		Long checkuser=(Long)map.get("checkuser");
		String username=(String)map.get("username");
		String hql = " from Member a   where a.state>0";
		if (state != null) {
			hql += " and a.state=" + state;
		}
		if (type != null) {
			hql += " and a.type=" + type;
		}
		if(checkuser!=null){
			hql+=" and a.id not in (select b.member.id from MemberCheck b where b.user.id= "+checkuser+")";
		}
		if(username!=null&&!username.equals("")){
			hql+=" and a.username like '%"+username+"%'";
		}
		page = this.find(page, "select a"+hql);
		Long totalCount = this.findLong("select count(a) " + hql);
		page.setTotalCount(totalCount);
		return page;
	}

	public Member login(String username, String password) {
		String hql = " from Member a where a.state=2 and a.username =? and a.password=?";
		Member m = (Member) this.findUnique(hql,username,password);
		return m;
	}
}
