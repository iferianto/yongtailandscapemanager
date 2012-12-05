package com.ecko.cms.web;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.cms.entity.Configs;
import com.ecko.cms.service.ConfigsManager;
import com.ecko.core.web.BaseAction;

@SuppressWarnings("serial")
@Namespace("/admin")
@Results( {
		@Result(name = "configs", location = "/WEB-INF/content/configs/configs.jsp"),
		@Result(name = "success", location = "configs!configs.action", type = "redirect") })
public class ConfigsAction extends BaseAction {
	@Autowired
	private ConfigsManager configsManager;
	private Configs configs;

	public String configs() {
		configs = configsManager.get(new Long(1L));
		return "configs";
	}

	public String save() {
		this.configsManager.save(configs);
		return "success";
	}

	public Configs getConfigs() {
		return configs;
	}

	public void setConfigs(Configs configs) {
		this.configs = configs;
	}
}
