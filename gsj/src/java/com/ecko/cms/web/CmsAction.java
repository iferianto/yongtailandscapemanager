package com.ecko.cms.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.cms.Cre;
import com.ecko.cms.entity.Content;
import com.ecko.cms.entity.ContentType;
import com.ecko.cms.entity.Question;
import com.ecko.cms.service.ContentManager;
import com.ecko.cms.service.ContentTypeManager;
import com.ecko.cms.service.CreditManager;
import com.ecko.cms.service.QuestionManager;
import com.ecko.core.entity.Page;
import com.ecko.core.util.PageUtils;
import com.ecko.core.web.BaseAction;
import com.ecko.system.util.CommonConstants;
import com.ecko.system.util.MemberSession;


@SuppressWarnings("serial")
@Namespace("/")
@Results( {
		@Result(name = "crelist", location = "/WEB-INF/content/cms/crelist.jsp"),
		@Result(name = "list", location = "/WEB-INF/content/cms/list.jsp"),
		@Result(name = "listAll", location = "/WEB-INF/content/cms/listAll.jsp"),
		@Result(name = "addquestion", location = "/WEB-INF/content/cms/addquestion.jsp"),
		@Result(name = "detail", location = "/WEB-INF/content/cms/detail.jsp"),
		@Result(name = "credit", location = "/WEB-INF/content/cms/credit.jsp"),
		@Result(name = "zxts", location = "/WEB-INF/content/cms/zxts.jsp"),
		@Result(name = "detail2", location = "/WEB-INF/content/cms/detail2.jsp"),
		@Result(name = "regsuccess", location = "/WEB-INF/content/member/regsuccess.jsp"),
		@Result(name = "list_detail", location = "/WEB-INF/content/cms/list_detail.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/cms/flink/editPage.jsp") })
public class CmsAction extends BaseAction {
	@Autowired
	private QuestionManager questionManager;
	
	private Question question;
	@Autowired
	private ContentTypeManager contentTypeManager;
	@Autowired
	private ContentManager contentManager;
	@Autowired
	private CreditManager creditManager;
	
	private Content content;
	private Long typeId;
	private Long seqs;

	private ContentType contentType;
	@SuppressWarnings("unchecked")
	public String list() {
		
		contentType=this.contentTypeManager.get(seqs);

		List<Content>newest=this.contentManager.findNewst(10);
		request.setAttribute("newest", newest);
		if(contentType.getName().contains("会员通讯录")){
			MemberSession ms=(MemberSession) request.getSession().getAttribute(CommonConstants.MEMBER_USER);
			if(ms==null){
				request.setAttribute("state", 3);
				 
				return "regsuccess";
			}
		}
		if(contentType==null){
			
			return "list";
		}
//		if(seqs==31){
//			return "zxts";
//		}
		if(contentType.getType()==null||contentType.getType()==1){
			Map map = new HashMap();
			Page page = new Page();
			page.setPageNo(pageNo);
			page.setPageSize(pageSize);
			map.put("audit", 1);
			map.put("typeId", seqs);
			page = this.contentManager.list(page, map);
			request.setAttribute("page", page);

			String pageUtils = PageUtils.cmsPageTag(request.getContextPath()
					+ "/cms!list.action", map, page);
			request.setAttribute("pageUtils", pageUtils);
			return "list";
			
		}else if(contentType.getType()==2){
			
			return "list_detail";
		}
		else {
			if(contentType.getHref()==null||contentType.getHref().equals("")){
				return "list";
			}
			try {
				if(contentType.getHref().toUpperCase().startsWith("HTTP://")){
					response.sendRedirect(contentType.getHref());
					return null;
				}else{
					response.sendRedirect(request.getContextPath()+contentType.getHref());
					return null;
				}
				
			} catch (IOException e) {
				 e.printStackTrace();
			}
		}
		 
		return "list";
	}
	
	
	public String listAll(){
		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);  
		map.put("audit", 1);
		page = this.contentManager.list(page, map);
		request.setAttribute("page", page);
		map.put("typeId", -1L);
		String pageUtils = PageUtils.cmsPageTag(request.getContextPath()
				+ "/cms!listAll.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		List<Content>newest=this.contentManager.findNewst(10);
		request.setAttribute("newest", newest);
		return "listAll";
	}

	public String detail() {
		content = this.contentManager.get(seqs);

		
		//
		List<Content>newest=this.contentManager.findNewst(10);
		request.setAttribute("newest", newest);
		
		ContentType type=content.getType();
		if(type.getName().contains("专家团队")){
			return "detail2";
		}
		return "detail";
	}
	
	public String credit(){
		Cre c=this.creditManager.find(seqs);
		request.setAttribute("cre", c);
		List<Content>newest=this.contentManager.findNewst(10);
		request.setAttribute("newest", newest);
		return "credit";
	}
	
	public String crelist(){
		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		page = this.creditManager.list(page, map);map.put("typeId", -1L);
		request.setAttribute("page", page);
		String pageUtils = PageUtils.cmsPageTag(request.getContextPath()
				+ "/cms!crelist.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "crelist";
	}
	
	public String addquestion(){
		this.questionManager.save(question);
		return "addquestion";
	}

	public Content getContent() {
		return content;
	}

	public void setContent(Content content) {
		this.content = content;
	}

	public Long getTypeId() {
		return typeId;
	}

	public void setTypeId(Long typeId) {
		this.typeId = typeId;
	}

	public Long getSeqs() {
		return seqs;
	}

	public void setSeqs(Long seqs) {
		this.seqs = seqs;
	}

	public ContentType getContentType() {
		return contentType;
	}

	public void setContentType(ContentType contentType) {
		this.contentType = contentType;
	}


	public Question getQuestion() {
		return question;
	}


	public void setQuestion(Question question) {
		this.question = question;
	}
}
