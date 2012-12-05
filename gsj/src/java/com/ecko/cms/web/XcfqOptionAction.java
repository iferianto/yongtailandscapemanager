package com.ecko.cms.web;

import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.cms.entity.XcfqOption;
import com.ecko.cms.service.XcfqOptionManager;
import com.ecko.core.entity.Page;
import com.ecko.core.util.PageUtils;
import com.ecko.core.web.BaseAction;
import com.ecko.system.util.CommonConstants;

@Namespace("/admin")
@Results( {
		@Result(name = "list", location = "/WEB-INF/content/admin/option/optionlist.jsp"),
		@Result(name = "addPage", location = "/WEB-INF/content/admin/option/addPage.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/admin/option/editPage.jsp") })
public class XcfqOptionAction extends BaseAction {

	@Autowired
	private XcfqOptionManager optionManager;
	private XcfqOption option;
	
	public String addPage() {

		return "addPage";
	}

	public String editPage() {
		option = this.optionManager.get(id);
		return "addPage";
	}

	public String save() {
		this.optionManager.save(option);
		request.setAttribute(GLB_MESSAGE, "保存成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/xcfq-option!list.action");
		return GLB_MESSAGE_PAGE;
	}

	@SuppressWarnings("unchecked")
	public String list() {

		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		page = this.optionManager.list(page, map);
		request.setAttribute("page", page);

		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/xcfq-option!list.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "list";
	}

	public String delete() {
		this.optionManager.delete(ids);
		request.setAttribute(GLB_MESSAGE, "删除成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/xcfq-option!list.action");
		return GLB_MESSAGE_PAGE;
	}
	public XcfqOption getOption() {
		return option;
	}
	public void setOption(XcfqOption option) {
		this.option = option;
	}
}
