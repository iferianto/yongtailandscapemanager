package com.ecko.core.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.ecko.system.util.CommonConstants;
import com.ecko.system.util.UserSession;
import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport implements ServletRequestAware,
		ServletResponseAware {
	protected int pageNo = 1;// 当前页码

	protected int pageSize = 10;// 每页数量
	protected Long id;
	protected Long[] ids;
	

	protected String GLB_MESSAGE_PAGE = "glb_message_page";
	protected String GLB_MESSAGE="glb_message";
	protected String Glb_RELOAD="glb_reload";
	
	protected HttpServletRequest request;

	protected HttpServletResponse response;
	
	public void setMessage(String message){
		request.setAttribute(GLB_MESSAGE, message);
	}
	public void setUrl(String url){
		request.setAttribute(CommonConstants.GLB_RETURN_URL, url);
	}
	
	public UserSession getUserSession(){
		
		return (UserSession) request.getSession().getAttribute(
				CommonConstants.SESSION_USER);
	}
	
	public Long getSessionUserId(){
		UserSession us=this.getUserSession();
		if(us==null)
			return null;
		return us.getUserId();
	}
	public String getSessionUsername(){
		UserSession us=this.getUserSession();
		if(us==null)
			return null;
		return us.getUsername();
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;

	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	} 
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getGLB_MESSAGE() {
		return GLB_MESSAGE;
	}

	public void setGLB_MESSAGE(String gLBMESSAGE) {
		GLB_MESSAGE = gLBMESSAGE;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public Long[] getIds() {
		return ids;
	}

	public void setIds(Long[] ids) {
		this.ids = ids;
	}
}
