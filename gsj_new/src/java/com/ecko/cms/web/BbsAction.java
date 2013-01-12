package com.ecko.cms.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.ecko.cms.entity.BbsForums;
import com.ecko.cms.entity.Content;
import com.ecko.cms.entity.Member;
import com.ecko.cms.entity.Post;
import com.ecko.cms.entity.Threads;
import com.ecko.cms.service.BbsForumsManager;
import com.ecko.cms.service.ContentManager;
import com.ecko.cms.service.MemberManager;
import com.ecko.cms.service.PostManager;
import com.ecko.cms.service.ThreadsManager;
import com.ecko.core.entity.Page;
import com.ecko.core.util.PageUtils;
import com.ecko.core.web.BaseAction;
import com.ecko.system.util.CommonConstants;
import com.ecko.system.util.MemberSession;

@SuppressWarnings("serial")
@Namespace("/")
@Results( {
		@Result(name = "list", location = "/WEB-INF/content/bbs/list.jsp"),
		@Result(name = "detail", location = "/WEB-INF/content/bbs/detail.jsp"),
		@Result(name = "pub_success", location = "bbs!detail.action?seqs=${seqs}",type="redirect"),
		@Result(name = "index", location = "/WEB-INF/content/bbs/index.jsp"),
		@Result(name = "regsuccess", location = "/WEB-INF/content/member/regsuccess.jsp"),
		@Result(name = "addPage", location = "/WEB-INF/content/bbs/addPage.jsp") })
public class BbsAction extends BaseAction {

	@Autowired
	private PostManager postManager;
	@Autowired
	private MemberManager memberManager;
	@Autowired
	private BbsForumsManager bbsForumsManager;
	private String title;
	private String content;
	private Long userid;
	private String username;
	private Long seqs;
	@Autowired
	private ThreadsManager threadsManager;
	@Autowired
	private ContentManager contentManager;
	@SuppressWarnings("unchecked")
	public String index() {
		MemberSession ms=(MemberSession) request.getSession().getAttribute(CommonConstants.MEMBER_USER);
		if(ms==null){
			request.setAttribute("state", 3);
			List<Content>newest=this.contentManager.findNewst(10);
			request.setAttribute("newest", newest);
			return "regsuccess";
		}
		
		List<BbsForums> bbs = this.bbsForumsManager.list4Index();
		request.setAttribute("bbs", bbs);
		
		for(int i=0;i<bbs.size();i++){
			BbsForums b=bbs.get(i);
			List ls=this.threadsManager.list(b.getId());
//			request.setAttribute("bbs"+i, b);
			request.setAttribute("threads"+i, ls);
		}

//		BbsForums bbs1 = this.bbsForumsManager.get(1L);
//		request.setAttribute("bbs1", bbs1);
//
//		BbsForums bbs2 = this.bbsForumsManager.get(2L);
//		request.setAttribute("bbs2", bbs2);
//		BbsForums bbs3 = this.bbsForumsManager.get(3L);
//		request.setAttribute("bbs3", bbs3);
//
//		List threads1 = this.threadsManager.list(1L);
//		request.setAttribute("threads1", threads1);
//		List threads2 = this.threadsManager.list(2L);
//		request.setAttribute("threads2", threads2);
//		List threads3 = this.threadsManager.list(3L);
//		request.setAttribute("threads3", threads3);
		return "index";
	}

	@SuppressWarnings("unchecked")
	public String list() {
		List bbs = this.bbsForumsManager.list4Index();
		request.setAttribute("bbs", bbs);
		BbsForums f = this.bbsForumsManager.get(seqs);
		request.setAttribute("forum", f);

		Map map = new HashMap();
		Page page = new Page();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		map.put("typeId", seqs);
		page = this.threadsManager.list(page, map);
		request.setAttribute("page", page);

		String pageUtils = PageUtils.bbsPageTag(request.getContextPath()
				+ "/bbs!list.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
		return "list";
	}

	@SuppressWarnings("unchecked")
	public String detail() {
		Threads thread=this.threadsManager.get(seqs);
		request.setAttribute("thread", thread);
		Page page=new Page();
		page.setPageNo(pageNo);
		page.setPageSize(5);
		page=this.postManager.list(thread.getId(), page);
		request.setAttribute("page", page);
		Map map=new HashMap();
		map.put("typeId", seqs);
		String pageUtils=PageUtils.bbsPageTag(request.getContextPath()+"/bbs!detail.action", map, page);
		request.setAttribute("pageUtils", pageUtils);
//		List bbs = this.bbsForumsManager.list4Index();
//		request.setAttribute("bbs", bbs);
		return "detail";
	}

	public String addPage() {
		MemberSession ms = (MemberSession) request.getSession().getAttribute(
				CommonConstants.MEMBER_USER);
		if (ms == null) {
			request.setAttribute(this.GLB_MESSAGE, "您尚未登录，请先<a href='"
					+ request.getContextPath() + "'>登录</a>");
			return "bbs_error";
		}
		if (seqs != null) {

			BbsForums f = this.bbsForumsManager.get(seqs);
			request.setAttribute("forum", f);
		}
		List bbs = this.bbsForumsManager.list4Index();
		request.setAttribute("bbs", bbs);
		return "addPage";
	}

	public String add() {
		MemberSession ms = (MemberSession) request.getSession().getAttribute(
				CommonConstants.MEMBER_USER);
		if (ms == null) {
			request.setAttribute(this.GLB_MESSAGE, "您尚未登录，请先<a href='"
					+ request.getContextPath() + "'>登录</a>");
			return "bbs_error";
		}
		Threads ts = new Threads();
		ts.setTitle(title);
		ts.setContent(content);
		ts.setCreatedate(new Date());
		ts.setCreatorname(ms.getUsername());
		BbsForums f = this.bbsForumsManager.get(seqs);
		request.setAttribute("forum", f);
		ts.setForums(f);
		ts.setForumsname(f.getName());
		ts.setLastdate(ts.getCreatedate());
		ts.setReplys(0);
		ts.setViews(9);
		Member m = this.memberManager.get(ms.getId());

		ts.setCreator(m);
		ts.setCreatorname(m.getUsername());
		f.setThreads(f.getThreads()+1);
		this.threadsManager.save(ts);
		this.bbsForumsManager.save(f);
		seqs=ts.getId();
//		request.setAttribute(this.GLB_MESSAGE, "发表成功点此查看");
//		return detail();
//		List bbs = this.bbsForumsManager.list4Index();
//		request.setAttribute("bbs", bbs);
		return "pub_success";
	}

	public String replyPage() {

		return null;
	}

	public String reply() {
		MemberSession ms = (MemberSession) request.getSession().getAttribute(
				CommonConstants.MEMBER_USER);
		if (ms == null) {
			request.setAttribute(this.GLB_MESSAGE, "您尚未登录，请先<a href='"
					+ request.getContextPath() + "'>登录</a>");
			return "bbs_error";
		}
		if (seqs == null) {
			request.setAttribute(this.GLB_MESSAGE, "错误的请求");
			return "bbs_error";
		}
		Threads ts=this.threadsManager.get(seqs);
		Member m = this.memberManager.get(ms.getId());
		BbsForums bbs=ts.getForums();
		bbs.setPosts(bbs.getPosts()+1);
		Post post=new Post();
		post.setBbsForums(ts.getForums());
		post.setContent(content);
		post.setCreatedate(new Date());
		post.setCreator(m);
		post.setCreatorname(m.getUsername());
		post.setForumsname(ts.getForumsname());
		post.setThread(ts);
		ts.setReplys(ts.getReplys()+1);
		this.postManager.save(post);
		this.threadsManager.save(ts);
		this.bbsForumsManager.save(bbs);
		
//		post.setThreadname(ts.getTitle())
//		post.set
		return "pub_success";
//		return detail();
	}

	public BbsForumsManager getBbsForumsManager() {
		return bbsForumsManager;
	}

	public void setBbsForumsManager(BbsForumsManager bbsForumsManager) {
		this.bbsForumsManager = bbsForumsManager;
	}

	public Long getSeqs() {
		return seqs;
	}

	public void setSeqs(Long seqs) {
		this.seqs = seqs;
	}

	public ThreadsManager getThreadsManager() {
		return threadsManager;
	}

	public void setThreadsManager(ThreadsManager threadsManager) {
		this.threadsManager = threadsManager;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Long getUserid() {
		return userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
}
