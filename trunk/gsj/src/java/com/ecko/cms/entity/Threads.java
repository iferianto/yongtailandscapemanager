package com.ecko.cms.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.ecko.core.entity.IDEntity;

@Entity
@Table(name="t_thread")
public class Threads extends IDEntity {

	private String title;
	private String content;
	private Date createdate;
	private String forumsname;
	private Member creator;
	private String creatorname;
	private BbsForums forums;//对应版块
	private Integer views;//查看数
	private Integer replys=0;//回复数
	private Date lastdate;//最后回复日期
	private List<Post> posts;
	public Integer getViews() {
		return views;
	}
	public void setViews(Integer views) {
		this.views = views;
	}
	public Integer getReplys() {
		return replys;
	}
	public void setReplys(Integer replys) {
		this.replys = replys;
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

	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "forums_id")
	public BbsForums getForums() {
		return forums;
	}
	public void setForums(BbsForums forums) {
		this.forums = forums;
	}
	public String getForumsname() {
		return forumsname;
	}
	public void setForumsname(String forumsname) {
		this.forumsname = forumsname;
	}
	public Date getLastdate() {
		return lastdate;
	}
	public void setLastdate(Date lastdate) {
		this.lastdate = lastdate;
	}
	@OneToMany(cascade=CascadeType.PERSIST,mappedBy="thread")
	public List<Post> getPosts() {
		return posts;
	}
	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}
	
}
