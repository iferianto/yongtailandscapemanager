package com.ecko.cms.web;

import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.cms.entity.Threads;
import com.ecko.cms.service.PostManager;
import com.ecko.cms.service.ThreadsManager;
import com.ecko.core.entity.Page;
import com.ecko.core.util.PageUtils;
import com.ecko.core.web.BaseAction;
import com.ecko.system.util.CommonConstants;


@SuppressWarnings("serial")
@Namespace("/admin")
@Results( {
		@Result(name = "list", location = "/WEB-INF/content/admin/threads/threadslist.jsp"),
		@Result(name = "view", location = "/WEB-INF/content/admin/threads/view.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/admin/threads/editPage.jsp") })
public class ThreadsAction extends BaseAction {

	@Autowired
	private PostManager postManager;
	@Autowired
	private ThreadsManager threadsManager;
	private String title;
	private Threads threads;
	private Long postId;
	private Long typeId;

	@SuppressWarnings("unchecked")
	public String list() {
		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		map.put("title", title);

		page = this.threadsManager.list(page, map);
		request.setAttribute("page", page);
		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/threads!list.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "list";
	}
	
	public String delete(){
		this.threadsManager.delete(ids);
		request.setAttribute(GLB_MESSAGE, "删除成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/threads!list.action");

		return GLB_MESSAGE_PAGE;
	}
 
	@SuppressWarnings("unchecked")
	public String view(){
		threads=this.threadsManager.get(id);
		Page page=new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		page=this.postManager.list(threads.getId(), page);
		request.setAttribute("page", page);
		Map map=new HashMap();
		map.put("typeId", id);
		String pageUtils=PageUtils.viewthreads(request.getContextPath()+"/admin/threads!view.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "view";
	}
	
	public String deletePosts(){
		this.postManager.delete(postId);

		request.setAttribute(GLB_MESSAGE, "删除成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/threads!list.action");
		return view();
	}

	public Threads getThreads() {
		return threads;
	}

	public void setThreads(Threads threads) {
		this.threads = threads;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public Long getTypeId() {
		return typeId;
	}


	public void setTypeId(Long typeId) {
		this.typeId = typeId;
	}

	public Long getPostId() {
		return postId;
	}

	public void setPostId(Long postId) {
		this.postId = postId;
	}
}
