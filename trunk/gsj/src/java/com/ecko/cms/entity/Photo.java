package com.ecko.cms.entity;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.ecko.core.entity.IDEntity;

@Entity
@Table(name = "t_photo")
public class Photo extends IDEntity {

	private ContentType type;
	private String imgurl;
	private Content content;
	private String title;


	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "type_id")
	public ContentType getType() {
		return type;
	}

	public void setType(ContentType type) {
		this.type = type;
	}

	public String getImgurl() {
		return imgurl;
	}

	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}


	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "content_id")
	public Content getContent() {
		return content;
	}

	public void setContent(Content content) {
		this.content = content;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
}
