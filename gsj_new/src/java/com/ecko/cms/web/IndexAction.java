package com.ecko.cms.web;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.cms.entity.Content;
import com.ecko.cms.entity.Flink;
import com.ecko.cms.entity.Photo;
import com.ecko.cms.service.ConfigsManager;
import com.ecko.cms.service.ContentManager;
import com.ecko.cms.service.FlinkManager;
import com.ecko.cms.service.PhotoManager;
import com.ecko.core.util.MD5;
import com.ecko.core.web.BaseAction;
import com.ecko.system.entity.User;
import com.ecko.system.service.UserManager;
import com.ecko.system.util.CommonConstants;
import com.ecko.system.util.MemberSession;
import com.ecko.system.util.UserSession;

@Namespace("/")
@Results( {
		@Result(name = "logout", location = "/common/logout.jsp"),
		@Result(name = "list", location = "/WEB-INF/content/idx/index.jsp"),
		@Result(name = "login", location = "index!index.action", type = "redirect"),
		@Result(name = "login_fail", location = "index!index.action?err=1", type = "redirect"),
		@Result(name = "addPage", location = "/WEB-INF/content/idx/addPage.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/idxk/editPage.jsp") })
public class IndexAction extends BaseAction {

	@Autowired
	private FlinkManager flinkManager;
	@Autowired
	private ContentManager contentManager;
	private String err;
	@Autowired
	PhotoManager photoManager;
	private String username;
	private String password;

	@Autowired
	private ConfigsManager configsManager;
	@Autowired
	private UserManager userManager;
//	private MemberManager memberManager;

	public String login() {

		if (StringUtils.isBlank(username)) {
			request.setAttribute(GLB_MESSAGE, "用户名不能为空！");
			return "login_fail";
		}
		if (StringUtils.isBlank(password)) {
			request.setAttribute(GLB_MESSAGE, "密码不能为空！");
			return "login_fail";
		}
		password = MD5.toMD5(password);
		User user=(User)userManager.login(username, password);
		if(user==null){
			request.setAttribute(GLB_MESSAGE, "用户名或密码错误！");
			return "login_fail";
		}
		UserSession us = new UserSession();
		us.setUserId(user.getId());
		us.setUsername(user.getUsername());
		request.getSession().setAttribute(CommonConstants.SESSION_USER, us);
//		 

		return "login";
	}

	public String logout() {
//		request.getSession().setAttribute(CommonConstants.MEMBER_USER, null);
		request.getSession().setAttribute(CommonConstants.SESSION_USER, null);
		request.getSession().invalidate();
		request.setAttribute(GLB_MESSAGE, "您已成功退出!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath());
		return "logout";
	}

	public String index() {
		
		// 景区介绍
		List<Photo> jqjsPhotos = this.photoManager.show(35L);
		request.setAttribute("jqjsPhotos", jqjsPhotos);

//		// 会员推荐
//		List<Photo> hytjPhotos = this.photoManager.show(19L);
//		request.setAttribute("hytjPhotos", hytjPhotos);
//
		// 政府文件
		List<Content> zfwjnews = this.contentManager.listByType(25L, 6);
		request.setAttribute("zfwjnews", zfwjnews);
//
		// 工商政策
		List<Content> gszcnews = this.contentManager.listByType(24L, 6);
		request.setAttribute("gszcnews", gszcnews);
		// 法律法规
		List<Content> fvfgnews = this.contentManager.listByType(23L, 6);
		request.setAttribute("fvfgnews", fvfgnews);
//
		// 巡查监管
		List<Content> xcjgnews = this.contentManager.listByType(26L, 6);
		request.setAttribute("xcjgnews", xcjgnews);
//
		// 消费维权
		List<Content> xfwqnews = this.contentManager.listByType(30L, 6);
		request.setAttribute("xfwqnews", xfwqnews);
//// 提示指南
		List<Content> tsznnews = this.contentManager.listByType(40L, 6);
		request.setAttribute("tsznnews", tsznnews);
		// 景区介绍
		List<Content> jqjsnews = this.contentManager.listByType(35L, 6);
		request.setAttribute("jqjsnews", jqjsnews);

		List<Content> newest = this.contentManager.findNewst(7);
		request.setAttribute("newest", newest);
		// 友情链接
		List<Flink> flinks = this.flinkManager.list();
		request.setAttribute("flinks", flinks);

		List<Photo> ppt = this.photoManager.ppt();
		request.setAttribute("ppt", ppt);
		
//		//协会动态
//		List<Content>xhdt=this.contentManager.listByType(5l, 6);
//		request.setAttribute("xhdt", xhdt);

//		Configs c = this.configsManager.get(new Long(1l));
//		request.setAttribute("configs", c);
		return "list";
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

	public String getErr() {
		return err;
	}

	public void setErr(String err) {
		this.err = err;
	}
}
