package com.ecko.cms.web;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.cms.entity.Content;
import com.ecko.cms.entity.ContentType;
import com.ecko.cms.entity.Photo;
import com.ecko.cms.service.ContentManager;
import com.ecko.cms.service.ContentTypeManager;
import com.ecko.core.entity.Page;
import com.ecko.core.util.DateManager;
import com.ecko.core.util.FileUtil;
import com.ecko.core.util.PageUtils;
import com.ecko.core.web.BaseAction;
import com.ecko.system.entity.User;
import com.ecko.system.util.CommonConstants;

@SuppressWarnings("serial")
@Namespace("/admin")
@Results( {
		@Result(name = "auditPage", location = "/WEB-INF/content/admin/content/auditPage.jsp"),
		@Result(name = "listaudit", location = "/WEB-INF/content/admin/content/listaudit.jsp"),
		@Result(name = "list", location = "/WEB-INF/content/admin/content/contentlist.jsp"),
		@Result(name = "listjingqu", location = "/WEB-INF/content/admin/content/listjingqu.jsp"),
		@Result(name = "addPage", location = "/WEB-INF/content/admin/content/addPage.jsp"),
		@Result(name = "addPageingqu", location = "/WEB-INF/content/admin/content/addPageingqu.jsp"),
		@Result(name = "editPageingqu", location = "/WEB-INF/content/admin/content/editPageingqu.jsp"),
		@Result(name = "editPage", location = "/WEB-INF/content/admin/content/editPage.jsp") })
public class ContentAction extends BaseAction {

	@Autowired
	private ContentTypeManager typeManager;
	@Autowired
	private ContentManager contentManager;
	private Content content;
	private Long typeId;
	private String title;
	private Date startDate;
	private Date endDate;
	private Integer audit;

	private File[] file;

	private String[] fileContentType;

	private String[] fileFileName;

	@SuppressWarnings( { "deprecation", "unused" })
	private List<Photo> upload() {
		List<Photo> photos = new ArrayList<Photo>();
		if (file != null && file.length > 0) {
			for (int i = 0; i < file.length; i++) {
				File f = file[i];
				String[] desc = FileUtil.genFilePath2(request
						.getRealPath("uploads"), FileUtil
						.getExt(fileFileName[i]));
				String url = desc[0].substring(desc[0].indexOf("uploads"));
				url = url.replace(File.separator, "/");
				url = "/" + url;

				File descFile = new File(desc[0]);
				try {
					FileUtils.copyFile(f, descFile);
				} catch (IOException e) {
					e.printStackTrace();
				}
				Photo p = new Photo();
				p.setImgurl(url);
				photos.add(p);
			}

		}

		return photos;

	}
	public String auditPage() {
		content = this.contentManager.get(id);
		List photos = content.getPhotos();
		request.setAttribute("photos", photos);
		request.setAttribute("photos_size", photos.size()); 
		return "auditPage";

	}
	public String addPage() {
		content = new Content();
		content.setPpt(0);
		content.setAudit(1);
		ContentType type=this.typeManager.get(typeId);
		content.setType(type);
		content.setTypename(type.getName()	);
		List<ContentType> types = this.typeManager.findList();
		request.setAttribute("types", types);
		return "addPage";
	}

	public String editPage() {
		content = this.contentManager.get(id);
		List photos = content.getPhotos();
		request.setAttribute("photos", photos);
		request.setAttribute("photos_size", photos.size());
		List<ContentType> types = this.typeManager.findList();
		request.setAttribute("types", types);
		return "editPage";

	}

	public String addPageingqu() {
		content = new Content();
		content.setPpt(0);
		content.setAudit(0);
		ContentType type=this.typeManager.get(36L);
		content.setType(type);
		content.setTypename(type.getName());
		return "addPageingqu";
	}

	@SuppressWarnings("unchecked")
	public String editPageingqu() {
		content = this.contentManager.get(id);
		if(content.getAudit()!=null&&content.getAudit()==1){
			request.getSession().removeAttribute("SESSION_CONTENT_ADD_ID");
			request.setAttribute(GLB_MESSAGE, "该记录已经通过审核，不能更改!");
			request.setAttribute(CommonConstants.GLB_RETURN_URL, request
					.getContextPath()
					+ "/admin/content!listjingqu.action");
//			return GLB_MESSAGE_PAGE;
		}
		List photos = content.getPhotos();
		request.setAttribute("photos", photos);
		request.setAttribute("photos_size", photos.size());
		return "editPageingqu";
	}
	
	

	public String deletephoto() {
		PrintWriter out = null;
		try {
			out = response.getWriter();
			this.contentManager.deletePhoto(id);
			out.print("success");
			out.flush();
		} catch (Exception e) {

		} finally {

		}
		return null;
	}

	public String audit(){
		
		content=this.contentManager.get(id);
		content.setAudit(audit);
		this.contentManager.save(content);
		request.getSession().removeAttribute("SESSION_CONTENT_ADD_ID");
		request.setAttribute(GLB_MESSAGE, "审核成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/content!listaudit.action");
		return GLB_MESSAGE_PAGE;
	}
	public String savejingqu() {
		if (content.getType() != null && content.getType().getId() == null) {
			content.setType(null);
		}
		if (content.getType() != null) {
			ContentType type = this.typeManager.get(content.getType().getId());
			content.setType(type);
			content.setTypename(type.getName());
		}

		if (id == null) {
			content.setPubdate(new Date());
			content.setCreatedate(content.getPubdate());
			
		}
		
		User user= new User();
		user.setId(this.getSessionUserId());
		content.setUser(user);
		List<Photo> oldPhoto = new ArrayList<Photo>();
		List<Photo> photos = this.upload();
		this.contentManager.save(content);
		for (Photo p : photos) {
			p.setContent(content);
			p.setTitle(content.getTitle());
			p.setType(content.getType());
			oldPhoto.add(p);
		}
		content.setPhotos(photos);
		this.contentManager.save(content);
		request.getSession().removeAttribute("SESSION_CONTENT_ADD_ID");
		request.setAttribute(GLB_MESSAGE, "保存成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/content!listjingqu.action");
		return GLB_MESSAGE_PAGE;
	}

	public String save() {
		if (content.getType() != null && content.getType().getId() == null) {
			content.setType(null);
		}
		if (content.getType() != null) {
			ContentType type = this.typeManager.get(content.getType().getId());
			content.setType(type);
			content.setTypename(type.getName());
		}

		if (id == null) {
			content.setPubdate(new Date());
			content.setCreatedate(content.getPubdate());

		}

		List<Photo> oldPhoto = new ArrayList<Photo>();
		List<Photo> photos = this.upload();
		this.contentManager.save(content);
		for (Photo p : photos) {
			p.setContent(content);
			p.setTitle(content.getTitle());
			p.setType(content.getType());
			oldPhoto.add(p);
		}
		content.setPhotos(photos);
		this.contentManager.save(content);
		request.getSession().removeAttribute("SESSION_CONTENT_ADD_ID");
		request.setAttribute(GLB_MESSAGE, "保存成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/content!list.action?typeId="+typeId);
		return GLB_MESSAGE_PAGE;
	}

	@SuppressWarnings("unchecked")
	public String list() {
		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		map.put("title", title);
		map.put("typeId", typeId);
		map.put("audit", 1);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		page = this.contentManager.list(page, map);
		request.setAttribute("page", page);

		map.put("startDate", DateManager.formatDate(startDate));
		map.put("endDate", DateManager.formatDate(endDate));
		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/content!list.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		List<ContentType> types = this.typeManager.findList();
		request.setAttribute("types", types);
		return "list";
	}

	@SuppressWarnings("unchecked")
	public String listjingqu() {
		typeId = 36L;
		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		if(this.getSessionUserId()!=null&&this.getSessionUserId()!=1)
			map.put("userId", this.getSessionUserId());
		map.put("title", title);
		map.put("typeId", typeId);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("audit", audit);
		page = this.contentManager.list(page, map);
		request.setAttribute("page", page);

		map.put("startDate", DateManager.formatDate(startDate));
		map.put("endDate", DateManager.formatDate(endDate));
		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/content!list.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "listjingqu";

	}
	@SuppressWarnings("unchecked")
	public String listaudit() {
		typeId = 36L;
		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		map.put("title", title);
		map.put("typeId", typeId);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("audit", 0);
		page = this.contentManager.list(page, map);
		request.setAttribute("page", page);

		map.put("startDate", DateManager.formatDate(startDate));
		map.put("endDate", DateManager.formatDate(endDate));
		String pageUtils = PageUtils.pageTag(request.getContextPath()
				+ "/admin/content!listaudit.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "listaudit";

	}

	public String deletejingqu() {
		this.contentManager.delete(ids);
		request.setAttribute(GLB_MESSAGE, "删除成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/content!listjingqu.action");
		return GLB_MESSAGE_PAGE;
	}

	public String delete() {
		this.contentManager.delete(ids);
		request.setAttribute(GLB_MESSAGE, "删除成功!");
		request.setAttribute(CommonConstants.GLB_RETURN_URL, request
				.getContextPath()
				+ "/admin/content!list.action?typeId="+typeId);
		return GLB_MESSAGE_PAGE;
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

	public ContentTypeManager getTypeManager() {
		return typeManager;
	}

	public void setTypeManager(ContentTypeManager typeManager) {
		this.typeManager = typeManager;
	}

	public ContentManager getContentManager() {
		return contentManager;
	}

	public void setContentManager(ContentManager contentManager) {
		this.contentManager = contentManager;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public File[] getFile() {
		return file;
	}

	public void setFile(File[] file) {
		this.file = file;
	}

	public String[] getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String[] fileContentType) {
		this.fileContentType = fileContentType;
	}

	public String[] getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String[] fileFileName) {
		this.fileFileName = fileFileName;
	}

	public Integer getAudit() {
		return audit;
	}

	public void setAudit(Integer audit) {
		this.audit = audit;
	}

}
