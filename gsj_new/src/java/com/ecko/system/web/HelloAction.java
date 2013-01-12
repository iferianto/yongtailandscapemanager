package com.ecko.system.web;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.core.web.BaseAction;
import com.ecko.system.service.UserManager;

@Namespace("/system")
@Results( { @Result(name = "list", location = "/WEB-INF/fail.jsp") })
public class HelloAction extends BaseAction {
	@Autowired
	private UserManager userManager;

	public String list() {

		return "list";
	}
}
