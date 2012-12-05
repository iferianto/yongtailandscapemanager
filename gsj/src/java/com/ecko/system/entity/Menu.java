package com.ecko.system.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.ecko.core.entity.IDEntity;
@Entity
@Table(name = "T_MENU")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Menu extends IDEntity {

	private String name;
	private String url;
	private Integer type=1;//1菜单2按钮
	private Integer state=1;//1有效 0无效
	private List<Role> roles;
	private Menu parent;
	private Integer seq=1;
	/**
     *  0不操作任何数据，1操作一条数据 2操作多条数据
     * 当type=2时用
     */
    private Integer opeCount=0;
    /**
     * 1 不做任何操作 2弹出confirm框
     * 当type=2时可用
     */
    private Integer msgBoxType=1;
    /**
     * css样式名称　当　ｔｙｐｅ＝２时可用
     */
    private String css;
    
	private Integer width;
	private Integer height; 
	
	private List<Menu>subs;
	public Integer getWidth() {
		return width;
	}

	public void setWidth(Integer width) {
		this.width = width;
	}

	public Integer getHeight() {
		return height;
	}

	public void setHeight(Integer height) {
		this.height = height;
	}

	public String getCss() {
		return css;
	}

	public void setCss(String css) {
		this.css = css;
	}

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

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}
	@ManyToMany(mappedBy = "menus")
	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PARENT_ID")
	public Menu getParent() {
		return parent;
	}

	public void setParent(Menu parent) {
		this.parent = parent;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	@Column(name="ope_count")
	public Integer getOpeCount() {
		return opeCount;
	}

	public void setOpeCount(Integer opeCount) {
		this.opeCount = opeCount;
	}
	@Column(name="msg_box_type")
	public Integer getMsgBoxType() {
		return msgBoxType;
	}

	public void setMsgBoxType(Integer msgBoxType) {
		this.msgBoxType = msgBoxType;
	}

	@OneToMany( fetch = FetchType.LAZY, mappedBy = "parent")
	public List<Menu> getSubs() {
		return subs;
	}

	public void setSubs(List<Menu> subs) {
		this.subs = subs;
	}

	 
}
