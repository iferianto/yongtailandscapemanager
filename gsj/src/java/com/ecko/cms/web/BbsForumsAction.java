package com.ecko.cms.web;

import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.cms.entity.BbsForums;
import com.ecko.cms.service.BbsForumsManager;
import com.ecko.core.entity.Page;
import com.ecko.core.util.PageUtils;
import com.ecko.core.web.BaseAction;
import com.ecko.system.util.CommonConstants;

@SuppressWarnings("serial")
@Namespace("/admin")
@Results( {
		@Result(name = "list", location = "/WEB-INF/content/admin/bbsForums/bbsForumslist.jsp"),
		@Result(name = "addPage", location = "/WEB-INF/content/admin/bbsForums/addPage.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/admin/bbsForums/editPage.jsp") })
public class BbsForumsAction extends BaseAction {

	@Autowired
	private BbsForumsManager bbsForumsManager;

	private BbsForums bbs;

	public String addPage() {
		bbs = new BbsForums();
		bbs.setPosts(0);
		bbs.setThreads(0);
		return "addPage";
	}

	public String editPage() {
		bbs = this.bbsForumsManager.get(id);
		return "addPage";

	}

	public String save() {
		this.bbsForumsManager.save(bbs);
		request.setAttribute(GLB_MESSAGE, "保存成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/bbs-forums!list.action");

		return GLB_MESSAGE_PAGE;
	}

	@SuppressWarnings("unchecked")
	public String list() {

		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);

		page = this.bbsForumsManager.list(page, map);
		request.setAttribute("page", page);
		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/bbs-forums!list.action", map, page);
		request.setAttribute("pageUtils", pageUtils);

		return "list";
	}

	public String delete() {
		this.bbsForumsManager.delete(ids);
		request.setAttribute(GLB_MESSAGE, "删除成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/bbs-forums!list.action");
		return GLB_MESSAGE_PAGE;
	}

	public BbsForums getBbs() {
		return bbs;
	}

	public void setBbs(BbsForums bbs) {
		this.bbs = bbs;
	}

}
