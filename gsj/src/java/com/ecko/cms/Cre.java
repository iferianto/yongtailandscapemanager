package com.ecko.cms;

import java.util.Date;

import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.ecko.core.entity.IDEntity;
import com.ecko.system.entity.User;
 
public class Cre extends IDEntity {

	private Float base;
	private User user;
	private String name;
	private Float add;
	private Float reduce;
	private Integer pub;//1公开 0不公开
	private Date creattime; 
	private Float auto;
	private Float credits;
	private Float all;
	private String grade;
	
	public Float getBase() {
		return base;
	}
	public void setBase(Float base) {
		this.base = base;
	}

	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Float getAdd() {
		return add;
	}
	public void setAdd(Float add) {
		this.add = add;
	}
	public Float getReduce() {
		return reduce;
	}
	public void setReduce(Float reduce) {
		this.reduce = reduce;
	}
	public Integer getPub() {
		return pub;
	}
	public void setPub(Integer pub) {
		this.pub = pub;
	}
 
	public Date getCreattime() {
		return creattime;
	}
	public void setCreattime(Date creattime) {
		this.creattime = creattime;
	}
	public Float getAuto() {
		return auto;
	}
	public void setAuto(Float auto) {
		this.auto = auto;
	}
	public Float getCredits() {
		return credits;
	}
	public void setCredits(Float credits) {
		this.credits = credits;
	}
	public Float getAll() {
		return all;
	}
	public void setAll(Float all) {
		this.all = all;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
}
