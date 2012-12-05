package com.ecko.cms.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.ecko.core.entity.IDEntity;
import com.ecko.system.entity.User;

@Entity
@Table(name="t_post")
public class Post extends IDEntity {

	private String title;
	private String content ;
	private Threads  thread;
	private String   threadname;
	private BbsForums bbsForums;
	private String forumsname;
	private Date createdate; 
	private Member creator;
	private String creatorname;
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

	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "thread_id")
	public Threads getThread() {
		return thread;
	}
	public void setThread(Threads thread) {
		this.thread = thread;
	}
	public String getThreadname() {
		return threadname;
	}
	public void setThreadname(String threadname) {
		this.threadname = threadname;
	}

	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bbsforums_id")
	public BbsForums getBbsForums() {
		return bbsForums;
	}
	public void setBbsForums(BbsForums bbsForums) {
		this.bbsForums = bbsForums;
	}
	public String getForumsname() {
		return forumsname;
	}
	public void setForumsname(String forumsname) {
		this.forumsname = forumsname;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "creator_id")
	public Member getCreator() {
		return creator;
	}
	public void setCreator(Member creator) {
		this.creator = creator;
	}
	public String getCreatorname() {
		return creatorname;
	}
	public void setCreatorname(String creatorname) {
		this.creatorname = creatorname;
	}
}
