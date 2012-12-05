package com.ecko.cms.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.ecko.core.entity.IDEntity;

@Entity
@Table(name="t_bbs_forums")
public class BbsForums extends IDEntity {

	private String name;
	private BbsForums parent;//父id
	private Integer seq;
	private Integer state;
	private Integer posts;//帖子数
	private Date lastdate;//最后发布日期
	private Integer threads;//主题数
	private String img;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PARENT_ID")
	public BbsForums getParent() {
		return parent;
	}
	public void setParent(BbsForums parent) {
		this.parent = parent;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	 
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Integer getPosts() {
		return posts;
	}
	public void setPosts(Integer posts) {
		this.posts = posts;
	}
	public Date getLastdate() {
		return lastdate;
	}
	public void setLastdate(Date lastdate) {
		this.lastdate = lastdate;
	}
	public Integer getThreads() {
		return threads;
	}
	public void setThreads(Integer threads) {
		this.threads = threads;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
}
