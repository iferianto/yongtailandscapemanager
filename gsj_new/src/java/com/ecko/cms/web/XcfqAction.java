package com.ecko.cms.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.cms.entity.Xcfq;
import com.ecko.cms.entity.XcfqDetail;
import com.ecko.cms.entity.XcfqOption;
import com.ecko.cms.service.XcfqManager;
import com.ecko.cms.service.XcfqOptionManager;
import com.ecko.core.entity.Page;
import com.ecko.core.util.PageUtils;
import com.ecko.core.web.BaseAction;
import com.ecko.system.entity.User;
import com.ecko.system.service.UserManager;
import com.ecko.system.util.CommonConstants;

@SuppressWarnings("serial")
@Namespace("/admin")
@Results( {
		@Result(name = "list", location = "/WEB-INF/content/admin/xcfq/list.jsp"),
		@Result(name = "listMy", location = "/WEB-INF/content/admin/xcfq/listMy.jsp"),
		@Result(name = "replyPage", location = "/WEB-INF/content/admin/xcfq/replyPage.jsp"),
		@Result(name = "view", location = "/WEB-INF/content/admin/xcfq/view.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/admin/xcfq/editPage.jsp"),
		@Result(name = "addPage", location = "/WEB-INF/content/admin/xcfq/addPage.jsp") })
public class XcfqAction extends BaseAction {

	@Autowired
	private XcfqManager xcfqManager;
	@Autowired
	private UserManager userManager;
	@Autowired
	private XcfqOptionManager optionManager;
	private Integer fgjg;
	private Xcfq xcfq;
	private String name;
	private Long userId;
	private String fq;

	@SuppressWarnings("unchecked")
	public String list() {
		Map map = new HashMap();
		map.put("name", name);
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		page = this.xcfqManager.list(page, map);
		request.setAttribute("page", page);
		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/xcfq!list.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "list";
	}

	@SuppressWarnings("unchecked")
	public String listMy() {
		Map map = new HashMap();
		map.put("name", name);
		map.put("fgjg", fgjg);
		map.put("userId", this.getSessionUserId());
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		page = this.xcfqManager.list(page, map);
		request.setAttribute("page", page);
		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/xcfq!listMy.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "list";
	}
	
	public String replyPage(){
		xcfq = this.xcfqManager.get(id);
		List<XcfqDetail> details = xcfq.getDetails();
		request.setAttribute("details", details);
		return "replyPage";
	}
	
	public String  reply(){

		xcfq = this.xcfqManager.get(id);
		xcfq.setFq(fq);
		xcfq.setFqjg(2);
		this.xcfqManager.save(xcfq);
		request.setAttribute(GLB_MESSAGE, "反馈成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/xcfq!list.action");
		return GLB_MESSAGE_PAGE;
	}

	public String delete() {
		this.xcfqManager.delete(ids);
		request.setAttribute(GLB_MESSAGE, "删除成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/xcfq!list.action");
		return GLB_MESSAGE_PAGE;
	}

	public String addPage() {
		List<XcfqOption> options = this.optionManager.findValid();
		request.setAttribute("options", options);
		List<User> users = this.userManager.findjq(this.getSessionUserId());
		request.setAttribute("users", users);
		return "addPage";
	}

	public String editPage() {
		// List<XcfqOption> options = this.optionManager.findValid();
		// request.setAttribute("options", options);
		List<User> users = this.userManager.findjq(this.getSessionUserId());
		request.setAttribute("users", users);
		xcfq = this.xcfqManager.get(id);
		List<XcfqDetail> details = xcfq.getDetails();
		request.setAttribute("details", details);
		return "editPage";
	}

	public String view() {
		xcfq = this.xcfqManager.get(id);
		List<XcfqDetail> details = xcfq.getDetails();
		request.setAttribute("details", details);
		return "view";
	}

	public String save() {
		List<XcfqOption> options = this.optionManager.findValid();
		List<XcfqDetail> details = new ArrayList<XcfqDetail>();
		Float all = 0f;
		for (int i = 0; i < options.size(); i++) {
			XcfqOption o = options.get(i);
			String score = request.getParameter("option_" + o.getId());
			XcfqDetail detail = new XcfqDetail();
			detail.setOption(o);
			detail.setName(o.getName());
			Float s = 0f;
			try {
				s = Float.valueOf(score);
			} catch (Exception e) {

			}
			detail.setScore(s);
			// detail.setXcfq()
			details.add(detail);
			all = all + s;
		}
		xcfq.setZf(all);
		xcfq.setPjf(all / options.size());
		User user = this.userManager.get(userId);
		xcfq.setUser(user);
		xcfq.setName(user.getRealname());
		this.xcfqManager.save(xcfq, details);
		request.setAttribute(GLB_MESSAGE, "保存成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/xcfq!list.action");
		return GLB_MESSAGE_PAGE;
	}

	public String edit() {
		// List<XcfqOption> options=this.optionManager.findValid();
		List<XcfqDetail> details = this.xcfqManager.findDetails(id);
		List <XcfqDetail> ds=new ArrayList();
		Float all = 0f;
		Xcfq x = null;
		for (int i = 0; i < details.size(); i++) {
			XcfqDetail o = details.get(i);
			if (x == null) {
				x = o.getXcfq();
			}
			String score = request.getParameter("option_" + o.getId());
//			XcfqDetail detail = new XcfqDetail();
//			 detail.setOption(o.getOption());
//			 detail.setName(o.getName());
//			 detail.setXcfq(x);
//			 detail.setId(o.getId());
			Float s = 0f;
			try {
				s = Float.valueOf(score);
			} catch (Exception e) {

			}
//			detail.setScore(s);
			o.setScore(s);
			// detail.setXcfq()
			// details.add(detail);
			all = all + s;
//			ds.add(detail);
		}
		x.setChecker(xcfq.getChecker());
		x.setOccerdate(xcfq.getOccerdate());
		x.setResult(xcfq.getResult());
		x.setZf(all);
		x.setFqjg(xcfq.getFqjg());
		x.setPjf(all / details.size());
		User user = this.userManager.get(userId);
		xcfq.setName(user.getRealname());
		this.xcfqManager.save(x, details);
		request.setAttribute(GLB_MESSAGE, "保存成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/xcfq!list.action");
		return GLB_MESSAGE_PAGE;
	}

	public Xcfq getXcfq() {
		return xcfq;
	}

	public void setXcfq(Xcfq xcfq) {
		this.xcfq = xcfq;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Integer getFgjg() {
		return fgjg;
	}

	public void setFgjg(Integer fgjg) {
		this.fgjg = fgjg;
	}

	public String getFq() {
		return fq;
	}

	public void setFq(String fq) {
		this.fq = fq;
	}
}
