package com.ecko.system.tag;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ecko.system.entity.Menu;
import com.ecko.system.service.MenuManager;
import com.ecko.system.util.CommonConstants;
import com.ecko.system.util.UserSession;

public class BtnMultiTag extends TagSupport {
	@SuppressWarnings("unchecked")
	public int doStartTag() throws JspException {
		JspWriter out = null;
		try {
			Map map = new HashMap();
			out = this.pageContext.getOut();
			ApplicationContext ctx = WebApplicationContextUtils
					.getWebApplicationContext(this.pageContext.getSession()
							.getServletContext());
			HttpServletRequest request = (HttpServletRequest) pageContext
					.getRequest();
			MenuManager menuManager = (MenuManager) ctx.getBean("menuManager");
			UserSession us = (UserSession) request.getSession().getAttribute(
					CommonConstants.SESSION_USER);
			Long userId = us.getUserId();
			Long menuId = Long.valueOf((String) request.getSession()
					.getAttribute(CommonConstants.SESSION_PARENT_MENU_ID));
			map.put("userId", userId);
			map.put("menuId", menuId);
			List<Menu> menus = menuManager.listButton(map);

			String str = "";
			str = this.genBtnMulti(menus);
			out.print(str);
			out.flush();
		} catch (Exception e) {
		}
		return SKIP_BODY;
	}

	public String genBtnMulti(List<Menu> menus) {

		String str = "";
		for (int i = 0; i < menus.size(); i++) {
			Menu menu = menus.get(i);

			str = str + "<input type='button' ";
			String css = "icon_page";
			if (StringUtils.isNotBlank(menu.getCss())) {
				css = menu.getCss();
			}
			String config = "{";
			config+="'url':'"+menu.getUrl()+"',";
			config+="'opeCount':'"+menu.getOpeCount()+"',";
			config+="'msgBoxType':'"+menu.getMsgBoxType()+"'";
			config = config + "}"; 
			str=str+"value='"+menu.getName()+"'";
			str=str+"onclick=\"doPermission("+config+")\"/>";
		}
		return str;
	}
}
