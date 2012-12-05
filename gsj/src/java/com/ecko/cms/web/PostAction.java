package com.ecko.cms.web;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.cms.entity.Post;
import com.ecko.cms.service.PostManager;
import com.ecko.core.web.BaseAction;

@Namespace("/admin")
@Results( { 
		@Result(name = "list", location = "/WEB-INF/content/admin/post/postlist.jsp"),
		@Result(name = "addPage", location = "/WEB-INF/content/admin/post/addPage.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/admin/post/editPage.jsp") })
public class PostAction extends BaseAction {

	@Autowired
	private PostManager postManager;
	 
	
	private Post post;
	
	
	
}
