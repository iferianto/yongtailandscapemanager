package com.ecko.cms.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.ecko.core.entity.IDEntity;

@Entity
@Table(name="t_credit_detail")
public class CreditDetail extends IDEntity {

	private Credit credit;
	private Integer type;//1add 0 reduce;
	private String reason;
	private Float score;
	private Date occerdate;
	

	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "credit_id")
	public Credit getCredit() {
		return credit;
	}
	public void setCredit(Credit credit) {
		this.credit = credit;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public Float getScore() {
		return score;
	}
	public void setScore(Float score) {
		this.score = score;
	}
	public Date getOccerdate() {
		return occerdate;
	}
	public void setOccerdate(Date occerdate) {
		this.occerdate = occerdate;
	}
}
