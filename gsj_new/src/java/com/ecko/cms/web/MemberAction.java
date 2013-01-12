package com.ecko.cms.web;

import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.cms.entity.Configs;
import com.ecko.cms.entity.Member;
import com.ecko.cms.entity.MemberCheck;
import com.ecko.cms.service.ConfigsManager;
import com.ecko.cms.service.MemberCheckManager;
import com.ecko.cms.service.MemberManager;
import com.ecko.core.entity.Page;
import com.ecko.core.util.PageUtils;
import com.ecko.core.web.BaseAction;
import com.ecko.system.entity.User;
import com.ecko.system.service.UserManager;
import com.ecko.system.util.CommonConstants;
import com.ecko.system.util.UserSession;

@SuppressWarnings("serial")
@Namespace("/admin")
@Results( {
		@Result(name = "list4Check1", location = "/WEB-INF/content/admin/member/list4Check1.jsp"),
		@Result(name = "listUnPassed1", location = "/WEB-INF/content/admin/member/listUnPassed1.jsp"),
		@Result(name = "listPassed1", location = "/WEB-INF/content/admin/member/listPassed1.jsp"),
		@Result(name = "list4Check2", location = "/WEB-INF/content/admin/member/list4Check2.jsp"),
		@Result(name = "listUnPassed2", location = "/WEB-INF/content/admin/member/listUnPassed2.jsp"),
		@Result(name = "listPassed2", location = "/WEB-INF/content/admin/member/listPassed2.jsp"),
		@Result(name = "checkPage1", location = "/WEB-INF/content/admin/member/checkPage1.jsp"),
		@Result(name = "checkPage2", location = "/WEB-INF/content/admin/member/checkPage2.jsp"),
		@Result(name = "reCheckPage1", location = "/WEB-INF/content/admin/member/reCheckPage1.jsp"),
		@Result(name = "reCheckPage2", location = "/WEB-INF/content/admin/member/reCheckPage2.jsp"),
		@Result(name = "view1", location = "/WEB-INF/content/admin/member/view1.jsp"),
		@Result(name = "view2", location = "/WEB-INF/content/admin/member/view2.jsp"),
		@Result(name = "listAll1", location = "/WEB-INF/content/admin/member/listAll1.jsp"),
		@Result(name = "listAll2", location = "/WEB-INF/content/admin/member/listAll2.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/admin/member/editPage.jsp") })
public class MemberAction extends BaseAction {
	@Autowired
	private ConfigsManager configsManager;
	@Autowired
	private MemberManager memberManager;
	@Autowired
	private UserManager userManager;
	@Autowired
	private MemberCheckManager checkManager;
	private String opion;
	private Member member;
	private Integer type;
	private Integer state;
	private String username;

	@SuppressWarnings("unchecked")
	public String list4Check1() {
		UserSession us=this.getUserSession();
		Configs configs = configsManager.get(new Long(1L));
		if(configs.getCheckusers()!=null&&!configs.getCheckusers().equals("")){
			if(!configs.getCheckusers().contains(us.getUsername())){
				request.setAttribute(GLB_MESSAGE, "您没有权限审核!"); 
				return GLB_MESSAGE_PAGE;
			}
		}
		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		map.put("type", 1);
		map.put("checkuser", us.getUserId());
		map.put("state", 1);
		page = this.memberManager.list(page, map);
		request.setAttribute("page", page);

		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/member!list4Check1.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "list4Check1";
	}

	@SuppressWarnings("unchecked")
	public String list4Check2() {
		UserSession us=this.getUserSession();
		Configs configs = configsManager.get(new Long(1L));
		if(configs.getCheckusers()!=null&&!configs.getCheckusers().equals("")){
			if(!configs.getCheckusers().contains(us.getUsername())){
				request.setAttribute(GLB_MESSAGE, "您没有权限审核!"); 
				return GLB_MESSAGE_PAGE;
			}
		}
		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		map.put("checkuser", us.getUserId());
		map.put("type", 2);
		map.put("state", 1);
		map.put("checkuser", us.getUserId());
		page = this.memberManager.list(page, map);
		request.setAttribute("page", page);

		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/member!list4Check2.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "list4Check2";
	}

	@SuppressWarnings("unchecked")
	public String listPassed1() {
		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		map.put("type", 1);
		map.put("state", 2);
		page = this.memberManager.list(page, map);
		request.setAttribute("page", page);

		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/member!listPassed1.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "listPassed1";
	}

	@SuppressWarnings("unchecked")
	public String listPassed2() {
		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		map.put("type", 2);
		map.put("state", 2);
		page = this.memberManager.list(page, map);
		request.setAttribute("page", page);

		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/member!listPassed2.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "listPassed2";
	}

	@SuppressWarnings("unchecked")
	public String listUnPassed1() {
		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		map.put("type", 1);
		map.put("state", 3);
		page = this.memberManager.list(page, map);
		request.setAttribute("page", page);

		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/member!listUnPassed1.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "listUnPassed1";
	}

	@SuppressWarnings("unchecked")
	public String listUnPassed2() {
		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		map.put("type", 2);
		map.put("state", 3);
		page = this.memberManager.list(page, map);
		request.setAttribute("page", page);

		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/member!listUnPassed2.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "listUnPassed2";
	}

	public String checkPage1() {
		member = this.memberManager.get(id);
		return "checkPage1";
	}

	public String checkPage2() {
		member = this.memberManager.get(id);
		return "checkPage2";
	}

	public String check1() {
		member = this.memberManager.get(id);
		if(state==2){
			MemberCheck check=new MemberCheck();
			check.setMember(member);
			User user=this.userManager.get(this.getSessionUserId());
			check.setUser(user);
			check.setUsername(user.getUsername());
			check.setOpinion(opion);
			check.setState(2);
			this.checkManager.save(check); 
			Configs configs = configsManager.get(new Long(1L));
			if(configs.getCheckcount()!=null){
				if(member.getChecks().size()>=configs.getCheckcount()){
					member.setState(state);
				}
			}			
			
		}else{
			MemberCheck check=new MemberCheck();
			check.setMember(member);
			User user=this.userManager.get(this.getSessionUserId());
			check.setUser(user);
			check.setUsername(user.getUsername());
			check.setOpinion(opion);
			check.setState(3);
			this.checkManager.save(check);
			member.setState(state);
		}
		
		this.memberManager.save(member);
		request.setAttribute(GLB_MESSAGE, "审核成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/member!list4Check1.action");
		return GLB_MESSAGE_PAGE;
	}

	public String check2() {
		member = this.memberManager.get(id);
		if(state==2){
			MemberCheck check=new MemberCheck();
			check.setMember(member);
			User user=this.userManager.get(this.getSessionUserId());
			check.setUser(user);
			check.setUsername(user.getUsername());
			check.setOpinion(opion);
			check.setState(2);
			this.checkManager.save(check); 
			Configs configs = configsManager.get(new Long(1L));
			if(configs.getCheckcount()!=null){
				if(member.getChecks().size()>=configs.getCheckcount()){
					member.setState(state);
				}
			}			
			
		}else{
			MemberCheck check=new MemberCheck();
			check.setMember(member);
			User user=this.userManager.get(this.getSessionUserId());
			check.setUser(user);
			check.setUsername(user.getUsername());
			check.setOpinion(opion);
			check.setState(3);
			this.checkManager.save(check);
			member.setState(state);
		}
		
		this.memberManager.save(member);
		request.setAttribute(GLB_MESSAGE, "审核成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/member!list4Check2.action");
		return GLB_MESSAGE_PAGE;
	}

	public String reCheckPage1() {
		member = this.memberManager.get(id);
		state=member.getState();
		return "checkPage1";
	}
 
	public String reCheckPage2() {
		member = this.memberManager.get(id);
		state=member.getState();
		return "checkPage2";
	}

	public String reCheck1() {
		member = this.memberManager.get(id);
		member.setState(state);
		this.memberManager.save(member);
		request.setAttribute(GLB_MESSAGE, "审核成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/member!listUnPassed1.action");
		return GLB_MESSAGE_PAGE;
	}

	public String reCheck2() {
		member = this.memberManager.get(id);
		member.setState(state);
		this.memberManager.save(member);
		request.setAttribute(GLB_MESSAGE, "审核成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/member!listUnPassed2.action");
		return GLB_MESSAGE_PAGE;
	}

	public String delete() {

		this.memberManager.delete(ids);
		request.setAttribute(GLB_MESSAGE, "删除成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/member!listUnPassed.action");
		return GLB_MESSAGE_PAGE;
	}
	
	@SuppressWarnings("unchecked")
	public String listAll1(){
		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		map.put("state", state);
		map.put("username", username);
		map.put("type", 1); 
		page = this.memberManager.list(page, map);
		request.setAttribute("page", page);

		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/member!listAll1.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "listAll1";
		
	}
	@SuppressWarnings("unchecked")
	public String listAll2(){
		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		map.put("type", 2); map.put("state", state);
		map.put("username", username);
		page = this.memberManager.list(page, map);
		request.setAttribute("page", page);

		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/member!listAll2.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "listAll2";
		
	}
	public String view1(){
		member = this.memberManager.get(id);
		return "view1";
	}
	public String view2(){
		member = this.memberManager.get(id);
		return "view2";
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public String getOpion() {
		return opion;
	}

	public void setOpion(String opion) {
		this.opion = opion;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

}
