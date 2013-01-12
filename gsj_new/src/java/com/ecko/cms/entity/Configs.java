package com.ecko.cms.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.ecko.core.entity.IDEntity;
@Entity
@Table(name="t_configs")
public class Configs extends IDEntity {

	private String indexmemo;
	private Integer checkcount;
	private String checkusers;

	public String getIndexmemo() {
		return indexmemo;
	}

	public void setIndexmemo(String indexmemo) {
		this.indexmemo = indexmemo;
	}

	public Integer getCheckcount() {
		return checkcount;
	}

	public void setCheckcount(Integer checkcount) {
		this.checkcount = checkcount;
	}

	public String getCheckusers() {
		return checkusers;
	}

	public void setCheckusers(String checkusers) {
		this.checkusers = checkusers;
	}
}
