package com.ecko.system.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ecko.core.entity.Page;
import com.ecko.core.service.DefaultEntityManager;
import com.ecko.system.dao.UserDao;
import com.ecko.system.entity.Menu;
import com.ecko.system.entity.User;

@Service(value = "userManager")
@Transactional
public class UserManager extends DefaultEntityManager<User, Long> {

	@Autowired
	private UserDao userDao;

	public List<User> findjq(Long userId) {

		return this.userDao.findjq(userId);

	}

	public User login(String username, String password) {

		return this.userDao.login(username, password);
	}

	public Page<User> list(Page page, Map map) {
		return this.userDao.list(page, map);
	}

	public List<User> findAll() {
		return this.userDao.findAll();

	}

	public List<User> findByIds(String ids) {

		return userDao.findByIds(ids);
	}

	public void delete(Long[] ids) {
		for (Long id : ids) {
			if (id == 1)
				continue;
			User user = this.get(id);
			user.setState(0);
			this.save(user);
		}
	}

}
