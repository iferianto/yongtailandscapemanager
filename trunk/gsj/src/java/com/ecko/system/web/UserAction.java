package com.ecko.system.web;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.core.entity.Page;
import com.ecko.core.util.MD5;
import com.ecko.core.util.PageUtils;
import com.ecko.core.web.BaseAction;
import com.ecko.system.entity.Role;
import com.ecko.system.entity.User;
import com.ecko.system.service.RoleManager;
import com.ecko.system.service.UserManager;
import com.ecko.system.util.CommonConstants;
import org.apache.commons.beanutils.BeanUtils;

@Namespace("/system")
@Results( {
		@Result(name = "success", location = "/WEB-INF/content/system/user/main.jsp"),
		@Result(name = "list", location = "/WEB-INF/content/system/user/userlist.jsp"),
		@Result(name = "listjingqu", location = "/WEB-INF/content/system/user/listjingqu.jsp"),
		@Result(name = "addPage", location = "/WEB-INF/content/system/user/addPage.jsp"),
		@Result(name = "addPageJinqu", location = "/WEB-INF/content/system/user/addPageJinqu.jsp"),
		@Result(name = "editPageJinqu", location = "/WEB-INF/content/system/user/editPageJinqu.jsp"),
		@Result(name = "getMultiUser", location = "/WEB-INF/content/system/user/getMultiUser.jsp"),
		@Result(name = "getSingleUser", location = "/WEB-INF/content/system/user/getSingleUser.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/system/user/editPage.jsp") })
public class UserAction extends BaseAction {

	private User user = new User();
	@Autowired
	private RoleManager roleManager;

	private String roleIds;
	private Integer type;
	private String password;
	private String username;
	private Long deptId;
	private String users;
	private Long groupId;
	@Autowired
	private UserManager userManager;

	// @Autowired
	// private RoleManager roleManager;

	public String addPageJinqu() {

		return "addPageJinqu";
	}

	public String addPage() {
		List allroles = this.roleManager.findValid();
		request.setAttribute("all", allroles);
		return "addPage";
	}

	public String editPage() {
		user = this.userManager.get(id);
		if (user.getType() == 4) {
			return "editPageJinqu";
		}
		List<Role> allroles = this.roleManager.findValid();
		List<Role> myroles = user.getRoles();
		request.setAttribute("myroles", myroles);
		List noroles = new ArrayList();
		for (int i = 0; i < allroles.size(); i++) {
			Role r = allroles.get(i);
			if (!myroles.contains(r)) {
				noroles.add(r);
			}
		}
		request.setAttribute("noroles", noroles);
		return "editPage";
	}

	public String edit() throws IllegalAccessException,
			InvocationTargetException {

		User u = this.userManager.get(user.getId());
		String pwd = request.getParameter("pwd");
		if (StringUtils.isNotBlank(user.getPassword())) {
			user.setPassword(MD5.toMD5(pwd));
		} else {
			user.setPassword(u.getPassword());

		}

		if (user.getType() == null) {
			request.setAttribute(GLB_MESSAGE, "保存失败!");
			request.setAttribute(CommonConstants.GLB_RETURN_URL, request
					.getContextPath()
					+ "/system/user!list.action");
			return GLB_MESSAGE_PAGE;
		}
		// c4ca4238a0b923820dcc509a6f75849b
		roleIds = user.getType().toString();
		User p = u.getUser();
		// List<Role> roles=u.getRoles();
		List<Role> roles = this.roleManager.listRoles(roleIds);
		BeanUtils.copyProperties(u, user);
		// u.setPassword(pwd);
		u.setUser(p);
		u.setRoles(roles);
		this.userManager.save(u);
		request.setAttribute(GLB_MESSAGE, "保存成功!");
		String fromUrl=request.getParameter("fromUrl");
		if(fromUrl!=null&&!fromUrl.equals("")){
			request.setAttribute(CommonConstants.GLB_RETURN_URL, request
					.getContextPath()
					+ "/system/user!listjingqu.action?fromUrl");
		}else{
			request.setAttribute(CommonConstants.GLB_RETURN_URL, request
					.getContextPath()
					+ "/system/user!list.action?fromUrl");
		}
		
		return GLB_MESSAGE_PAGE;
	}

	public String save() {
		if (StringUtils.isBlank(user.getUsername())) {
			request.setAttribute(GLB_MESSAGE, "您没有输入用户名!");
			return GLB_MESSAGE_PAGE;
		}
		if (StringUtils.isBlank(user.getPassword())) {
			request.setAttribute(GLB_MESSAGE, "您没有输入密码!");
			return GLB_MESSAGE_PAGE;
		}
		user.setPassword(MD5.toMD5(user.getPassword()));
		// User u=this.userManager.get(user.getId());
		if (user.getType() == null) {
			request.setAttribute(GLB_MESSAGE, "保存失败!");
			request.setAttribute(CommonConstants.GLB_RETURN_URL, request
					.getContextPath()
					+ "/system/user!list.action");
			return GLB_MESSAGE_PAGE;
		}
		User u = this.userManager.get(this.getSessionUserId());
		user.setUser(u);
		roleIds = user.getType().toString();
		List<Role> roles = this.roleManager.listRoles(roleIds);
		user.setRoles(roles);
		this.userManager.save(user);
		request.setAttribute(GLB_MESSAGE, "保存成功!");
		String fromUrl=request.getParameter("fromUrl");
		if(fromUrl!=null&&!fromUrl.equals("")){
			request.setAttribute(CommonConstants.GLB_RETURN_URL, request
					.getContextPath()
					+ "/system/user!listjingqu.action?fromUrl");
		}else{
			request.setAttribute(CommonConstants.GLB_RETURN_URL, request
					.getContextPath()
					+ "/system/user!list.action?fromUrl");
		}
		return GLB_MESSAGE_PAGE;
	}

	public String delete() {
		this.userManager.delete(ids);
		request.setAttribute(GLB_MESSAGE, "删除成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/system/user!list.action");
		return GLB_MESSAGE_PAGE;
	}

	public String deletejingqu() {
		this.userManager.delete(ids);
		request.setAttribute(GLB_MESSAGE, "删除成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/system/user!listjingqu.action");
		return GLB_MESSAGE_PAGE;
	}

	@SuppressWarnings("unchecked")
	public String list() {
		Map map = new HashMap();
		map.put("username", username);
		map.put("type", type);
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		page = this.userManager.list(page, map);
		request.setAttribute("page", page);
		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/system/user!list.action", map, page);
		request.setAttribute("pageUtils", pageUtils);

		return "list";
	}

	@SuppressWarnings("unchecked")
	public String listjingqu() {
		Map map = new HashMap();
		map.put("username", username);
		map.put("type", 4);
		map.put("userId", this.getSessionUserId());
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		page = this.userManager.list(page, map);
		request.setAttribute("page", page);
		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/system/user!listjingqu.action", map, page);
		request.setAttribute("pageUtils", pageUtils);

		return "listjingqu";
	}

	@SuppressWarnings("unchecked")
	public String getSingleUser() {
		Map map = new HashMap();
		map.put("username", username);
		map.put("deptId", deptId);
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		page = this.userManager.list(page, map);
		request.setAttribute("page", page);
		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/system/user!getSingleUser.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "getSingleUser";
	}

	@SuppressWarnings("unchecked")
	public String getMultiUser() {
		Map map = new HashMap();
		map.put("username", username);
		map.put("deptId", deptId);
		map.put("groupId", groupId);
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(50);
		page = this.userManager.list(page, map);
		request.setAttribute("page", page);
		String us = request.getParameter("us");
		if (us != null && !us.equals("")) {
			users = us;
		}
		if (users == null || users.equals("")) {
			users = ",";
		}
		map.put("users", users);
		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/system/user!getMultiUser.action", map, page);
		request.setAttribute("pageUtils", pageUtils);

		return "getMultiUser";
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Long getDeptId() {
		return deptId;
	}

	public void setDeptId(Long deptId) {
		this.deptId = deptId;
	}

	public String getUsers() {
		return users;
	}

	public void setUsers(String users) {
		this.users = users;
	}

	public Long getGroupId() {
		return groupId;
	}

	public void setGroupId(Long groupId) {
		this.groupId = groupId;
	}

	public String getRoleIds() {
		return roleIds;
	}

	public void setRoleIds(String roleIds) {
		this.roleIds = roleIds;
	}
}
