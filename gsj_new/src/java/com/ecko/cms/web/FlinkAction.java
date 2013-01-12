/**
 * 
 */
package com.ecko.cms.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.cms.entity.ContentType;
import com.ecko.cms.entity.Flink;
import com.ecko.cms.service.FlinkManager;
import com.ecko.core.entity.Page;
import com.ecko.core.util.DateManager;
import com.ecko.core.util.PageUtils;
import com.ecko.core.web.BaseAction;
import com.ecko.system.util.CommonConstants;

/**
 * @author Owner
 * 
 */

@SuppressWarnings("serial")
@Namespace("/admin")
@Results( {
		@Result(name = "list", location = "/WEB-INF/content/admin/flink/flinklist.jsp"),
		@Result(name = "addPage", location = "/WEB-INF/content/admin/flink/addPage.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/admin/flink/editPage.jsp") })
public class FlinkAction extends BaseAction {

	@Autowired
	private FlinkManager flinkManager;

	private Flink flink;

	public String addPage() {

		return "addPage";
	}

	public String editPage() {
		flink = this.flinkManager.get(id);
		return "addPage";
	}

	public String save() {
		this.flinkManager.save(flink);
		request.setAttribute(GLB_MESSAGE, "保存成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/flink!list.action");
		return GLB_MESSAGE_PAGE;
	}

	@SuppressWarnings("unchecked")
	public String list() {

		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		page = this.flinkManager.list(page, map);
		request.setAttribute("page", page);

		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/flink!list.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "list";
	}

	public String delete() {
		this.flinkManager.delete(ids);
		request.setAttribute(GLB_MESSAGE, "删除成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/flink!list.action");
		return GLB_MESSAGE_PAGE;
	}

	public Flink getFlink() {
		return flink;
	}

	public void setFlink(Flink flink) {
		this.flink = flink;
	}
}
