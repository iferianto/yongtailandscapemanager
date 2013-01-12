package com.ecko.system.dao;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.ecko.core.dao.HibernateDao;
import com.ecko.system.entity.Menu;

@Repository
public class MenuDao extends HibernateDao<Menu, Long> {
	public List<Menu> listAllTop() {

		Criteria c = this.getSession().createCriteria(Menu.class);
		c.add(Restrictions.isNull("parent"));

		return c.list();
	}

	public List<Menu> listByParent(Long menuId) {
		Criteria c = this.getSession().createCriteria(Menu.class);
		c.add(Restrictions.eq("parent.id", menuId));
		List ls= c.list();
		return ls;
	}

	public List<Menu> listTopForRight(Long userId) {
		String hql = "select distinct m from Menu m left join m.roles as r left join r.users as u ";
		hql += " where u.id=? and m.state=1 and m.parent is null and m.type=1  order by m.seq asc";

		return this.find(hql, userId);
	}

	public Long menuCount(Map map) {
		String hql = "select count( m )from Menu m left join m.roles as r left join r.users as u ";
		hql += " where u.id=? and m.state=1 and m.parent.id=? and m.type=1  order by m.seq asc";

		Long userId = (Long) map.get("userId");
		Long menuId = (Long) map.get("menuId");
		List<Long> ls = this.query(hql, userId, menuId);
		if (ls == null || ls.size() == 0)
			return 0L;
		return ls.get(0);
	}

	public List<Menu> listByMap(Map map) {
		String hql = "select distinct m from Menu m left join m.roles as r left join r.users as u ";
		hql += " where u.id=? and m.state=1 and m.parent.id=? and m.type=1  order by m.seq asc";

		Long userId = (Long) map.get("userId");
		Long menuId = (Long) map.get("menuId");
		List ls= this.find(hql, userId, menuId);
		return ls;
	}

	public Long subMenuCount(Long parentId) {
		String hql = "select count(a) from Menu a where a.parent.id=? and a.state=1   order by a.seq asc";
		List<Long> ls = this.query(hql, parentId);
		if (ls == null || ls.size() == 0) {
			return 0L;
		} else {
			return ls.get(0);
		}

	}

	@SuppressWarnings("unchecked")
	public List<Menu> listButton(Map map) {

		String hql = "select distinct m from Menu m left join m.roles as r left join r.users as u ";
		hql += " where u.id=? and m.state=1 and m.parent.id=? and m.type=2  order by m.seq asc";

		Long userId = (Long) map.get("userId");
		Long menuId = (Long) map.get("menuId");
		return this.find(hql, userId, menuId);
	}

	public List<Menu> findByIds(String ids) {
		String hql = " from Menu where id in(" + ids + ") and state=1";
		return this.find(hql);
	}

	public List<Menu> findMenuByRole(Long roleId) {
		String hql = " select m from Menu m left outer join m.roles r where m.state=1 and  r.id="
				+ roleId;

		return this.find(hql);
	}

	public List<Menu> findByRoleId(Long roleId) {

		String hql = "select m from Menu m left join m.roles as r where m.state=1 and  r.id=?";
		return this.find(hql, roleId);
	}

	public List listFirstMenus() {
		String hql = " from Menu a where a.parent.id is null and a.state=1 and a.type=1 order by a.seq asc";
		return this.find(hql);
	}
}
