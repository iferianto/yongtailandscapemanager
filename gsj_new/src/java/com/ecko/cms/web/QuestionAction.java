package com.ecko.cms.web;

import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.cms.entity.Question;
import com.ecko.cms.service.QuestionManager;
import com.ecko.core.entity.Page;
import com.ecko.core.util.PageUtils;
import com.ecko.core.web.BaseAction;
import com.ecko.system.util.CommonConstants;


@SuppressWarnings("serial")
@Namespace("/admin")
@Results( {
		@Result(name = "list", location = "/WEB-INF/content/admin/question/questionlist.jsp"),
		@Result(name = "addPage", location = "/WEB-INF/content/admin/question/addPage.jsp"),
		@Result(name = "view", location = "/WEB-INF/content/admin/question/view.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/admin/question/editPage.jsp") })
public class QuestionAction extends BaseAction {

	@Autowired
	private QuestionManager questionManager;
	
	private Question question;
	public String view(){
		question=this.questionManager.get(id);
		return "view";
	}
	@SuppressWarnings("unchecked")
	public String list() {

		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		page = this.questionManager.list(page, map);
		request.setAttribute("page", page);

		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/question!list.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "list";
	}

	public String delete() {
		this.questionManager.delete(ids);
		request.setAttribute(GLB_MESSAGE, "删除成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/question!list.action");
		return GLB_MESSAGE_PAGE;
	}

	public Question getQuestion() {
		return question;
	}

	public void setQuestion(Question question) {
		this.question = question;
	}
}
