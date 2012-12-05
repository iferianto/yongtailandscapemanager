package com.ecko.cms.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.ecko.core.entity.IDEntity;

@Entity
@Table(name="t_question")
public class Question extends IDEntity {

	private String title;
	private String content;
	private String tel;
	private String email;
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
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
}
