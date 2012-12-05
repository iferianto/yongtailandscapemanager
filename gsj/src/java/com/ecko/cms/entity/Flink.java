package com.ecko.cms.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.ecko.core.entity.IDEntity;

@Entity
@Table(name="t_flink")
public class Flink extends IDEntity {

	private String name;
	private String url;
	private String img;
	private Integer type;// 1图片 0文字
	private Integer seq;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

}
