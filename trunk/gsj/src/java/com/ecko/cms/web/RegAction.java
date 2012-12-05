package com.ecko.cms.web;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.cms.entity.Content;
import com.ecko.cms.entity.Member;
import com.ecko.cms.service.ContentManager;
import com.ecko.cms.service.MemberManager;
import com.ecko.core.util.MD5;
import com.ecko.core.web.BaseAction;

@SuppressWarnings("serial")
@Namespace("/")
@Results( {
		@Result(name = "regPage1", location = "/WEB-INF/content/member/regPage1.jsp"),
		@Result(name = "regPage2", location = "/WEB-INF/content/member/regPage2.jsp"),
		@Result(name = "regsuccess", location = "/WEB-INF/content/member/regsuccess.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/member/flink/editPage.jsp") })
public class RegAction extends BaseAction {

	private Integer type;
	private Member member;

	private String password1;
	private String password2;
	@Autowired
	private ContentManager contentManager;

	@Autowired
	private MemberManager memberManager;
	public String regPage(){
		List<Content>newest=this.contentManager.findNewst(10);
		request.setAttribute("newest", newest);
		
		if(type!=null&&type==1){
			return "regPage1";
		}
		
		return "regPage2";
	}
	
	public String reg(){
		if(StringUtils.isBlank(password1)){
			request.setAttribute("error", "您没有输入密码!");
			request.setAttribute("state", 2);
			return "regsuccess";
		}
		if(StringUtils.isBlank(password2)){
			request.setAttribute("error", "您没有输入确认密码!");
			request.setAttribute("state", 2);
			return "regsuccess";
		}
		if(!password1.equals(password2)){
			request.setAttribute("error", "两次密码输入错误!");
			request.setAttribute("state", 2);
			return "regsuccess";
		}
		Member m =this.memberManager.findByName(member.getUsername());
		if(m!=null){
			request.setAttribute("error", "用户名已经存在，请重新输入!");
			request.setAttribute("state", 2);
			return "regsuccess";
		}
		member.setPassword(MD5.toMD5(password1));
		member.setState(1);
		memberManager.save(member);
		request.setAttribute("state", 1);
		return "regsuccess";
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public String getPassword1() {
		return password1;
	}

	public void setPassword1(String password1) {
		this.password1 = password1;
	}

	public String getPassword2() {
		return password2;
	}

	public void setPassword2(String password2) {
		this.password2 = password2;
	}
}
