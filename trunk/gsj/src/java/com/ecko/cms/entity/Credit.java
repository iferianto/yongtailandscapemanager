package com.ecko.cms.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.ecko.core.entity.IDEntity;
import com.ecko.system.entity.User;

@Entity
@Table(name="t_credit")
public class Credit extends IDEntity {

	private Float base;
	private User user;
	private String name;
	private Float add;
	private Float reduce;
	private Integer pub;//1公开 0不公开
	private Date creattime;
	private List<CreditDetail	>details; 
	
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
	@Column(name="add1")
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
	@OneToMany(mappedBy="credit",cascade=CascadeType.REMOVE)
	public List<CreditDetail> getDetails() {
		return details;
	}
	public void setDetails(List<CreditDetail> details) {
		this.details = details;
	}
	public Date getCreattime() {
		return creattime;
	}
	public void setCreattime(Date creattime) {
		this.creattime = creattime;
	}
}
