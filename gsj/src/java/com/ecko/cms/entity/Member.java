package com.ecko.cms.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.ecko.core.entity.IDEntity;
@Entity
@Table(name="t_member")
public class Member extends IDEntity {

	private Integer type;//1个人 2企业
	private String username;
	private String password;
	private String question;
	private String answer;
	private String email;
	private String connector;
	private String mobile;
	private String phone;
	private String fax;
	private Integer sex;
	
	private String companyname;
	private String url;
	private String address;
	private Integer kind;
	private String code;
	private String scope;
	private String faren;
	private String farenphone;
	private String farenmobile;
	private Integer state;//1刚注册 2审批通过  3 审批不通过 0删除
	private String opion;//审批意见
	private String name;
	private String idcard;  
	private Integer checknum;//通过数
	private List<MemberCheck>checks;
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getConnector() {
		return connector;
	}
	public void setConnector(String connector) {
		this.connector = connector;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getCompanyname() {
		return companyname;
	}
	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Integer getKind() {
		return kind;
	}
	public void setKind(Integer kind) {
		this.kind = kind;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getScope() {
		return scope;
	}
	public void setScope(String scope) {
		this.scope = scope;
	}
	public String getFaren() {
		return faren;
	}
	public void setFaren(String faren) {
		this.faren = faren;
	}
	public String getFarenphone() {
		return farenphone;
	}
	public void setFarenphone(String farenphone) {
		this.farenphone = farenphone;
	}
	public String getFarenmobile() {
		return farenmobile;
	}
	public void setFarenmobile(String farenmobile) {
		this.farenmobile = farenmobile;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public String getOpion() {
		return opion;
	}
	public void setOpion(String opion) {
		this.opion = opion;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public Integer getChecknum() {
		return checknum;
	}
	public void setChecknum(Integer checknum) {
		this.checknum = checknum;
	}

	@OneToMany(mappedBy="member",cascade=CascadeType.ALL)
	public List<MemberCheck> getChecks() {
		return checks;
	}
	public void setChecks(List<MemberCheck> checks) {
		this.checks = checks;
	}
 
	 
}
