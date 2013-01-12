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
import com.ecko.system.entity.User;

@Entity
@Table(name="t_content")
public class Content extends IDEntity {

	private String title;
	private String content;
	private ContentType type;
	private String typename; 
	private Date createdate;
	private Date pubdate;
	private String keyword;
	private String description;//摘要
	private Integer click;//点击次数
	private Integer top;//是否置顶 1是 0否
	private String creator;
	private Integer state ;//1有效 0删除掉了无效 2表示草稿
	private String imgurl;
	private Integer ppt;//是否首页幻灯片 1是 0否
	private Integer command;//是否推荐 1是 0否
	private Integer audit;
	private User user;
	
	private List<Photo>photos;
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
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

	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "type_id")
	public ContentType getType() {
		return type;
	}
	public void setType(ContentType type) {
		this.type = type;
	}
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Date getPubdate() {
		return pubdate;
	}
	public void setPubdate(Date pubdate) {
		this.pubdate = pubdate;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getClick() {
		return click;
	}
	public void setClick(Integer click) {
		this.click = click;
	}
	public Integer getTop() {
		return top;
	}
	public void setTop(Integer top) {
		this.top = top;
	}
	public String getImgurl() {
		return imgurl;
	}
	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}
	@OneToMany(mappedBy="content",cascade=CascadeType.ALL)
	public List<Photo> getPhotos() {
		return photos;
	}
	public void setPhotos(List<Photo> photos) {
		this.photos = photos;
	}
	public Integer getPpt() {
		return ppt;
	}
	public void setPpt(Integer ppt) {
		this.ppt = ppt;
	}
	public Integer getCommand() {
		return command;
	}
	public void setCommand(Integer command) {
		this.command = command;
	}
	public Integer getAudit() {
		return audit;
	}
	public void setAudit(Integer audit) {
		this.audit = audit;
	}
	@ManyToOne
	@JoinColumn(name="user_id")
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
}
