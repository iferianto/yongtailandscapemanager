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
@Table(name="t_xcfq")
public class Xcfq extends IDEntity {

	 
	private Float zf;
	private Float pjf;
	private String name; 
	private User user;
	private String checker;
	private Date occerdate;
	private String result;
	private Integer fqjg;//反馈结果 1为整改  2已整改反馈
	private String fq;
	
	private List<XcfqDetail>details;
	public Float getZf() {
		return zf;
	}
	public void setZf(Float zf) {
		this.zf = zf;
	}
	public Float getPjf() {
		return pjf;
	}
	public void setPjf(Float pjf) {
		this.pjf = pjf;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="user_id")
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	@OneToMany(cascade=CascadeType.REMOVE,mappedBy="xcfq")
	public List<XcfqDetail> getDetails() {
		return details;
	}
	public void setDetails(List<XcfqDetail> details) {
		this.details = details;
	}
	public String getChecker() {
		return checker;
	}
	public void setChecker(String checker) {
		this.checker = checker;
	}
	public Date getOccerdate() {
		return occerdate;
	}
	public void setOccerdate(Date occerdate) {
		this.occerdate = occerdate;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public Integer getFqjg() {
		return fqjg;
	}
	public void setFqjg(Integer fqjg) {
		this.fqjg = fqjg;
	}
	public String getFq() {
		return fq;
	}
	public void setFq(String fq) {
		this.fq = fq;
	}
	
 
}
