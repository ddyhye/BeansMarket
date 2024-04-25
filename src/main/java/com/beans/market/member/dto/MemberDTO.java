package com.beans.market.member.dto;

import java.sql.Date;

public class MemberDTO {

	
	private int idx;
	private String email;
	private String option;
	private int price;
	private String content;
	private Date reg_date;
	
	private String pw;
	private String location;
	private String scope;
	private String name;
	private Date birth_date;
	private String gender;
	private int point;
	private Date last_login;
	private String dormant;
	private int login_count;
	private int warn_count;
	private Date login_banstr;
	private Date login_banend;
	
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getOption() {
		return option;
	}
	public void setOption(String option) {
		this.option = option;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReg_date() {
		return reg_date.toString();
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getScope() {
		return scope;
	}
	public void setScope(String scope) {
		this.scope = scope;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth_date() {
		return birth_date.toString();
	}
	public void setBirth_date(Date birth_date) {
		this.birth_date = birth_date;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getLast_login() {
		return last_login.toString();
	}
	public void setLast_login(Date last_login) {
		this.last_login = last_login;
	}
	public String getDormant() {
		return dormant;
	}
	public void setDormant(String dormant) {
		this.dormant = dormant;
	}
	public int getLogin_count() {
		return login_count;
	}
	public void setLogin_count(int login_count) {
		this.login_count = login_count;
	}
	public int getWarn_count() {
		return warn_count;
	}
	public void setWarn_count(int warn_count) {
		this.warn_count = warn_count;
	}
	public String getLogin_banstr() {
		return login_banstr.toString();
	}
	public void setLogin_banstr(Date login_banstr) {
		this.login_banstr = login_banstr;
	}
	public String getLogin_banend() {
		return login_banend.toString();
	}
	public void setLogin_banend(Date login_banend) {
		this.login_banend = login_banend;
	}
	
	
}
