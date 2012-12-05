package com.ecko.cms.entity;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.ecko.core.entity.IDEntity;

@Entity
@Table(name = "t_xcfq_detail")
public class XcfqDetail extends IDEntity {

	private Xcfq xcfq;
	private XcfqOption option;
	private String name;
	private Float score;

	@ManyToOne
	@JoinColumn(name="xcfq_id")
	public Xcfq getXcfq() {
		return xcfq;
	}

	public void setXcfq(Xcfq xcfq) {
		this.xcfq = xcfq;
	}

	@ManyToOne
	@JoinColumn(name="option_id")
	public XcfqOption getOption() {
		return option;
	}

	public void setOption(XcfqOption option) {
		this.option = option;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Float getScore() {
		return score;
	}

	public void setScore(Float score) {
		this.score = score;
	}
}
