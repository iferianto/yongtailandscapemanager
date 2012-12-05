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

import com.ecko.core.entity.Page;
import com.ecko.core.util.PageUtils;
import com.ecko.core.web.BaseAction;
import com.ecko.system.entity.Menu;
import com.ecko.system.entity.Role;
import com.ecko.system.service.MenuManager;
import com.ecko.system.service.RoleManager;
import com.ecko.system.util.CommonConstants;

@Namespace("/system")
@Results( {
		@Result(name = "role", location = "/WEB-INF/content/system/role/role.jsp"),
		@Result(name = "list", location = "/WEB-INF/content/system/role/rolelist.jsp"),
		@Result(name = "addPage", location = "/WEB-INF/content/system/role/addPage.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/system/role/editPage.jsp") })
public class RoleAction extends BaseAction {

	private Role role = new Role();
	private String name;

	private String rightIds;
	@Autowired
	private RoleManager roleManager;

	@Autowired
	private MenuManager menuManager;

	@SuppressWarnings("unchecked")
	public String list() {
		Map map = new HashMap();
		map.put("name", name);
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		page = this.roleManager.list(page, map);
		request.setAttribute("page", page);
		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/system/role!list.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "list";
	}

	public String addPage() {

		return "addPage";
	}

	public String editPage() {
		role = this.roleManager.get(id);
		return "editPage";
	}

	public String save() {

		this.roleManager.save(role);
		request.setAttribute(GLB_MESSAGE, "保存成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/system/role!list.action");
		return GLB_MESSAGE_PAGE;
	}

	public String edit() {
		Role r = this.roleManager.get(id);
		r.setName(role.getName());
		r.setSeq(role.getSeq());
		r.setState(role.getState());
		r.setMenus(r.getMenus());
		this.roleManager.save(r);
		request.setAttribute(GLB_MESSAGE, "保存成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/system/role!list.action");
		return GLB_MESSAGE_PAGE;
	}

	public String delete() {
		this.roleManager.delete(ids);
		request.setAttribute(GLB_MESSAGE, "保存成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/system/role!list.action");
		return GLB_MESSAGE_PAGE;
	}

	public String role() {
		if (id == null) {
			request.setAttribute(GLB_MESSAGE, "请选择需要设置权限的角色");
			return GLB_MESSAGE;
		}
		
		role = this.roleManager.get(id);
		return "role";
	}

	public String roleMenu() {
		PrintWriter out = null;
		try {
			out = response.getWriter();
//			Long userId = this.getSessionUserId();
			
			String menuStr = this.menuManager.findMenuByRole1(id);
			List menus=this.menuManager.listFirstMenus();
			String genStr=this.genStr(menus, menuStr); 
			out.print(genStr);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
		return null;
	}
	private String genStr(List<Menu> menus, String menuStr) {
		String str = "[";
		for (int i = 0; i < menus.size(); i++) {
			Menu menu = menus.get(i);
			str = str + "{";
			str = str + "\"id\":\""+menu.getId()+"\", \"text\":\"" + menu.getName() + "\" ";
			String id = "," + String.valueOf(menu.getId()) + ",";
			if(menuStr.contains(id)){
				str = str + ",\"checked\":\"true\"";
			}
			List<Menu> subs=this.menuManager.listByParent(menu.getId());
			if (subs != null && subs.size() > 0) {
				str = str + ",\"state\":\"open\"";
				str = str + ", \"children\":	";
				str = str + this.genStr(subs, menuStr);				
			}
			str = str + "}\n";
			if(i<menus.size()-1){
				str=str+",";
			}
		}
		str = str + "]\n";
		return str;
	}
	public String setRole() {
//		String ids[]=StringUtils.split(this.rightIds,",");
//		rightIds=rightIds.substring(1);
		List<Menu>menus=this.menuManager.findByIds(rightIds);
		role=this.roleManager.get(role.getId());
		role.setMenus(menus);
		this.roleManager.save(role);
		request.setAttribute(GLB_MESSAGE, "权限设置成功");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/system/role!list.action");
		return GLB_MESSAGE_PAGE;
	}
	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public String getRightIds() {
		return rightIds;
	}

	public void setRightIds(String rightIds) {
		this.rightIds = rightIds;
	}
}
