package com.ecko.system.web;

import java.util.Date;

import javax.servlet.http.Cookie;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.core.util.MD5;
import com.ecko.core.web.BaseAction;
import com.ecko.system.entity.User;
import com.ecko.system.service.UserManager;
import com.ecko.system.util.CommonConstants;
import com.ecko.system.util.UserSession;

@Namespace("/system")
@Results( {
		@Result(name = "execute", location = "index.action", type = "redirect"),
		@Result(name = "login_fail", location = "/admin/index.jsp"),
		@Result(name = "chgPwdPage", location = "/chgPwdPage.jsp"),
		@Result(name = "logout", location = "/index.jsp") })
public class LoginAction extends BaseAction {
	@Autowired
	private UserManager userManager;
	private String username;
	private String password;
	private String vcode;

	public String login() {
		if (StringUtils.isBlank(username)) {
			request.setAttribute(GLB_MESSAGE, "用户名不能为空！");
			return "login_fail";
		}
		if (StringUtils.isBlank(password)) {
			request.setAttribute(GLB_MESSAGE, "密码不能为空！");
			return "login_fail";
		}
		// if (StringUtils.isBlank(vcode)) {
		// request.setAttribute(GLB_MESSAGE, "验证码不能为空！");
		// return "login_fail";
		// }
		// String code = (String) request.getSession().getAttribute(
		// CommonConstants.SESSION_CODE_LOGIN);
		// if (StringUtils.isBlank(code)) {
		// request.setAttribute(GLB_MESSAGE, "验证码错误！");
		// return "login_fail";
		// }
		// if (!code.equals(vcode)) {
		// request.setAttribute(GLB_MESSAGE, "验证码错误！");
		// return "login_fail";
		// }
		password = MD5.toMD5(password);
		User user = this.userManager.login(username, password);
		if (user == null) {
			request.setAttribute(GLB_MESSAGE, "用户名或者密码错误！");
			return "login_fail";
		}
		user.setLastLoginTime(new Date());
		try {
			this.userManager.save(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		UserSession us = new UserSession();
		us.setUserId(user.getId());
		us.setUsername(user.getUsername());
		us.setRealname(user.getRealname());
		request.getSession().setAttribute(CommonConstants.SESSION_USER, us);
		Cookie cookie = new Cookie("cookie_username", us.getUsername());
		cookie.setPath(request.getContextPath());
		cookie.setMaxAge(180 * 86400);
		response.addCookie(cookie);

		return "execute";
	}

	public String logout() {
		request.getSession().setAttribute(CommonConstants.SESSION_USER, null);
		request.getSession().invalidate();
		request.setAttribute(GLB_MESSAGE, "保存失败!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath());
		return GLB_MESSAGE_PAGE;
		// return "logout";
	}

	public String chgPwd() {
		String password = request.getParameter("password");
		String password1 = request.getParameter("password1");
		String oldpassword = request.getParameter("oldpassword");
		if (StringUtils.isBlank(password) || StringUtils.isBlank(password1)
				|| StringUtils.isBlank(oldpassword)) {
			request.setAttribute(this.GLB_MESSAGE, "密码必填！");
			return GLB_MESSAGE_PAGE;
		}
		if (!password.equals(password1)) {
			request.setAttribute(this.GLB_MESSAGE, "两次密码输入不一致必填！");
			return GLB_MESSAGE_PAGE;
		}
		String username = this.getSessionUsername();
		User user = this.userManager.login(username, MD5.toMD5(oldpassword));
		if (user == null) {
			request.setAttribute(this.GLB_MESSAGE, "原密码错误！");
			return GLB_MESSAGE_PAGE;

		}
		user.setPassword(MD5.toMD5(password));
		this.userManager.save(user);
		return GLB_MESSAGE_PAGE;
	}

	public String chgPwdPage() {
		request.setAttribute("username", this.getSessionUsername());
		return "chgPwdPage";
	}

	public UserManager getUserManager() {
		return userManager;
	}

	public void setUserManager(UserManager userManager) {
		this.userManager = userManager;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getVcode() {
		return vcode;
	}

	public void setVcode(String vcode) {
		this.vcode = vcode;
	}
}
