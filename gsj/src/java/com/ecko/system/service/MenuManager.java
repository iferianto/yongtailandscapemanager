package com.ecko.system.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.core.service.DefaultEntityManager;
import com.ecko.system.dao.MenuDao;
import com.ecko.system.entity.Menu;

@Service
@Transactional
public class MenuManager extends DefaultEntityManager<Menu, Long> {
	@Autowired
	private MenuDao menuDao;

	public List<Menu> listAllTop() {

		return this.menuDao.listAllTop();
	}

	public List<Menu> listTopForRight(Long userId) {
		return this.menuDao.listTopForRight(userId);
	}

	public List<Menu> listByParent(Long menuId) {
		return menuDao.listByParent(menuId);
	}

	public Long menuCount(Map map) {
		return this.menuDao.menuCount(map);
	}

	public List<Menu> listByMap(Map map) {
		return menuDao.listByMap(map);
	}

	public Long subMenuCount(Long parentId) {
		return this.menuDao.subMenuCount(parentId);
	}

	public List<Menu> listButton(Map map) {
		return this.menuDao.listButton(map);
	}

	public List<Menu> findByIds(String ids) {
		return this.menuDao.findByIds(ids);
	}

	public List<Menu> findMenuByRole(Long roleId) {

		return this.menuDao.findMenuByRole(roleId);
	}

	public String findMenuByRole1(Long roleId) {
		List<Menu> menus = this.menuDao.findByRoleId(roleId);
		String str = ",";
		for (Menu menu : menus) {
			str = str + menu.getId() + ",";
		}
		return str;
	}

	public List listFirstMenus() {

		return menuDao.listFirstMenus();
	}
}
