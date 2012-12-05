package com.ecko.system.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.core.web.BaseAction;
import com.ecko.system.entity.Menu;
import com.ecko.system.entity.User;
import com.ecko.system.service.MenuManager;
import com.ecko.system.service.UserManager;
import com.ecko.system.util.CommonConstants;

@Namespace("/system")
@Results( { @Result(name = IndexAction.SUCCESS, location = "/main.jsp"),
		@Result(name = "portal", location = "/portal.jsp"),
		@Result(name = "logout", location = "/index!index.action" ,type="redirect"),
		@Result(name = "top", location = "/top.jsp"),
		@Result(name = "left", location = "/left.jsp") })
public class IndexAction extends BaseAction {

	@Autowired
	private MenuManager menuManager;
	@Autowired
	private UserManager userManager;

	private Long upMenuId;

	public String execute() {

		return SUCCESS;
	} 
	
	public String logout(){
		request.getSession().setAttribute(CommonConstants.SESSION_USER, null);
		request.getSession().invalidate();
		request.setAttribute(GLB_MESSAGE, "保存失败!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath());
		return GLB_MESSAGE_PAGE;
	}

	public String top() {
		Long userId = this.getSessionUserId();
		User user = this.userManager.get(userId);
		return "top";
	}

	public String left() {
		Map map = new HashMap();
		Long userId = this.getSessionUserId();
		List<Menu> menus = this.menuManager.listTopForRight(userId);
		// request.setAttribute("menus", menus);
		String str = this.genDtree(menus);
		request.setAttribute("str", str);
		return "left";
	}

	@SuppressWarnings( { "unused", "unchecked" })
	private String genDtree(List<Menu> menus) {
		Map map = new HashMap();
		Long userId = this.getSessionUserId();
		String str = "";
		for (int i = 0; i < menus.size(); i++) {
			Menu menu = menus.get(i);
			map.put("menuId", menu.getId());
			map.put("userId", userId);
			Long c = this.menuManager.menuCount(map);
			if (c == 0) {
				String url = request.getContextPath() + menu.getUrl();
				if (url.contains("?")) {
					url = url + "&parent_menu_id=" + menu.getId();
				} else {
					url = url + "?parent_menu_id=" + menu.getId();
				}
				Long pid = menu.getParent() == null ? 0L : menu.getParent()
						.getId();
				str = str + "d.add(" + menu.getId() + "," + pid + ",'"
						+ menu.getName() + "','" + url + "','" + menu.getName()
						+ "','frmright');\n";
			} else {
				Long pid = menu.getParent() == null ? 0L : menu.getParent()
						.getId();
				str = str + "d.add(" + menu.getId() + "," + pid + ",'"
						+ menu.getName() + "',null,'','');";
				List ms = this.menuManager.listByMap(map);
				str = str + this.genDtree(ms);
			}

		}
		return str;
	}

	public String portal() {

		return "portal";
	}

	/**
	 * 列表页中获取新增按钮的那个权限的ajax
	 * 
	 * @return
	 */
	public String ajaxMulti() {
		Map map = new HashMap();
		Long userId = this.getSessionUserId();
		Long menuId = Long.valueOf( (String)request.getSession().getAttribute(
				CommonConstants.SESSION_PARENT_MENU_ID));
		if (menuId == null)
			return null;

		map.put("userId", userId);
		map.put("menuId", menuId);
		List<Menu> menus = this.menuManager.listButton(map);
		PrintWriter out = null;
		try {
			out = response.getWriter();
			String str = "";
			str = this.genBtnMulti(menus);
			out.print(str);
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null)
				out.close();
		}
		return null;
	}

	public String genBtnMulti(List<Menu> menus) {

		String str = "";
		for (int i = 0; i < menus.size(); i++) {
			Menu menu = menus.get(i);
			
			str = str + "<button>\n";
			String css = "icon_page";
			if (StringUtils.isNotBlank(menu.getCss())) {
				css = menu.getCss();
			}
			str = str + "<span class='" + css + "'>\n";
			str=str+"<a href='#nogo' >"+menu.getName()+"</a>";
			str = str + "</span>\n</button>";
		}
		return str;
	}

	public Long getUpMenuId() {
		return upMenuId;
	}

	public void setUpMenuId(Long upMenuId) {
		this.upMenuId = upMenuId;
	}

}
