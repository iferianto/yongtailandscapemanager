package com.ecko.system.web;

import java.io.PrintWriter;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.core.web.BaseAction;
import com.ecko.system.entity.Menu;
import com.ecko.system.service.MenuManager;

@Namespace("/system")
@Results( {
		@Result(name = "success", location = "/WEB-INF/content/system/menu/main.jsp"),
		@Result(name = "main", location = "/WEB-INF/content/system/menu/main.jsp"),
		@Result(name = "addPage", location = "/WEB-INF/content/system/menu/addPage.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/system/menu/editPage.jsp") })
public class MenuAction extends BaseAction {

	@Autowired
	private MenuManager menuManager;
	 
	private Menu menu = new Menu();

	public String delete() {

		return "success";
	}

	public String save() {
		if(menu.getParent()!=null&&menu.getParent().getId()==null){
			menu.setParent(null);
		}
		this.menuManager.save(menu);
		this.setMessage("保存成功");
		this.setUrl(request.getContextPath()+"/system/menu!main.action");
		return GLB_MESSAGE_PAGE;
	}

	public String addPage() {
		menu.setParent(this.menuManager.get(id)); 
		return "addPage";
	}

	public String editPage() {
		if(id!=null){
			menu=this.menuManager.get(id);
		} 
		return "addPage";
	}
 

	public String main() {
		
		return "main";
	}
	/**
	 * 菜单首页树形ajax
	 * @return
	 */
	public String mtree(){
		List<Menu> list = null;
		if (id == null || id == 0) {
			list = this.menuManager.listAllTop();
		} else {
			list = this.menuManager.listByParent(id);
		}

		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.print(this.genTreeJson(list));
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
		return null;

	}
	public String genTreeJson(List<Menu> menus) {
		String str = "";
		str = "[";
		int i = 0;
		for (Menu menu : menus) {
			str = str + "{";
			str = str + "\"id\":\"" + menu.getId() + "\"";
			str = str + ",\"text\":\"" + menu.getName() + "\"";
			Long subCount = this.menuManager.subMenuCount(menu.getId());
			if (subCount > 0) {
				str = str + ",\"state\":\"closed\"";
			}
			if(!StringUtils.isBlank(menu.getUrl())){
				str=str+",\"attributes\":{";
				str=str+"\"url\":\""+request.getContextPath()+menu.getUrl()+"\"";
				str=str+"}";
			}
			str = str + "}\n";
			if (i < menus.size() - 1) {
				str += ",";
			}
			i++;
		}
		str += "]";

		return str;
	}
 

	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}
}
