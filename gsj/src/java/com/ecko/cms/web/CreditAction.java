package com.ecko.cms.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.cms.entity.Credit;
import com.ecko.cms.entity.CreditDetail;
import com.ecko.cms.service.CreditManager;
import com.ecko.core.entity.Page;
import com.ecko.core.util.PageUtils;
import com.ecko.core.web.BaseAction;
import com.ecko.system.util.CommonConstants;

@SuppressWarnings("serial")
@Namespace("/admin")
@Results( {
		@Result(name = "list", location = "/WEB-INF/content/admin/credit/creditlist.jsp"),
		@Result(name = "addPage", location = "/WEB-INF/content/admin/credit/addPage.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/admin/credit/editPage.jsp") })
public class CreditAction extends BaseAction {

	@Autowired
	private CreditManager creditManager;
	private Credit credit;
	private String[] reasons;
	private Float[] scores;
	private Integer[] types;
	private Date[] dates;

	public String addPage() {

		return "addPage";
	}

	public String editPage() {
		credit = this.creditManager.get(id);
		return "editPage";
	}

	public String save() {
		List<CreditDetail> details = new ArrayList<CreditDetail>();
		if (scores != null) {
			for (int i = 0; i < scores.length; i++) {
				CreditDetail cd = new CreditDetail();
				if(ids!=null)
					cd.setId(ids[i]);
				cd.setReason(reasons[i]);
				cd.setScore(scores[i]);
				cd.setType(types[i]);
				cd.setOccerdate(dates[i]);
				details.add(cd);
			}
		}
		credit.setDetails(details);
		this.creditManager.save(credit);
		request.setAttribute(GLB_MESSAGE, "保存成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/credit!list.action");
		return GLB_MESSAGE_PAGE;
	}

	@SuppressWarnings("unchecked")
	public String list() {
		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		page = this.creditManager.list(page, map);
		request.setAttribute("page", page);
		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/credit!list.action", map, page);
		request.setAttribute("pageUtils", pageUtils);

		return "list";
	}

	public String delete() {
		this.creditManager.delete(ids);
		request.setAttribute(GLB_MESSAGE, "删除成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/credit!list.action");
		return GLB_MESSAGE_PAGE;
	}

	public Credit getCredit() {
		return credit;
	}

	public void setCredit(Credit credit) {
		this.credit = credit;
	}

	public CreditManager getCreditManager() {
		return creditManager;
	}

	public void setCreditManager(CreditManager creditManager) {
		this.creditManager = creditManager;
	}

	public String[] getReasons() {
		return reasons;
	}

	public void setReasons(String[] reasons) {
		this.reasons = reasons;
	}

	public Float[] getScores() {
		return scores;
	}

	public void setScores(Float[] scores) {
		this.scores = scores;
	}

	public Integer[] getTypes() {
		return types;
	}

	public void setTypes(Integer[] types) {
		this.types = types;
	}

	public Date[] getDates() {
		return dates;
	}

	public void setDates(Date[] dates) {
		this.dates = dates;
	}
}
