package com.ecko.cms.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.cms.entity.ContentType;
import com.ecko.cms.service.ContentTypeManager;
import com.ecko.core.entity.Page;
import com.ecko.core.util.PageUtils;
import com.ecko.core.web.BaseAction;
import com.ecko.system.util.CommonConstants;

@SuppressWarnings("serial")
@Namespace("/admin")
@Results({
		@Result(name = "list", location = "/WEB-INF/content/admin/contenttype/contenttypelist.jsp"),
		@Result(name = "addPage", location = "/WEB-INF/content/admin/contenttype/addPage.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/admin/contenttype/editPage.jsp") })
public class ContentTypeAction extends BaseAction {

	@Autowired
	private ContentTypeManager contentTypeManager;

	private ContentType contentType;
	private String name;

	@SuppressWarnings({  "unchecked" })
	public String list() {
		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		map.put("name", name);
		page = this.contentTypeManager.list(page, map);
		request.setAttribute("page", page);
		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/content-type!list.action", map, page);
		request.setAttribute("pageUtils", pageUtils);

		return "list";
	}

	public String addPage() {
		contentType=new ContentType();
		contentType.setType(1);
		List<ContentType> types=this.contentTypeManager.findByValid();
		request.setAttribute("types", types);
		return "addPage";
	}

	public String editPage() {
		contentType = this.contentTypeManager.get(id);		
		List<ContentType> types=this.contentTypeManager.findByValid();
		request.setAttribute("types", types);
		return "editPage";
	}

	public String save() {
		if(contentType.getParent()!=null&&contentType.getParent().getId()==null){
			contentType.setParent(null);
		}
		if(this.contentType.getParent()!=null&&this.contentType.getParent().getId()!=null){

			ContentType parent=this.contentTypeManager.get(this.contentType.getParent().getId());
			contentType.setParent(parent);
			contentType.setParentname(parent.getName());
		}
		this.contentTypeManager.save(contentType);
		request.setAttribute(GLB_MESSAGE, "保存成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL,
				request.getContextPath() + "/admin/content-type!list.action");
		return GLB_MESSAGE_PAGE;
	}

	public String delete() {
		this.contentTypeManager.delete(ids);
		request.setAttribute(GLB_MESSAGE, "删除成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL,
				request.getContextPath() + "/admin/content-type!list.action");
		return GLB_MESSAGE_PAGE;
	}

	public ContentType getContentType() {
		return contentType;
	}

	public void setContentType(ContentType contentType) {
		this.contentType = contentType;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
