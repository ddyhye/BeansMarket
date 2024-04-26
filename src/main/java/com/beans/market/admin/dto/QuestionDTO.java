package com.beans.market.admin.dto;

import java.sql.Date;

public class QuestionDTO {

	private int inquiry_idx;
	private String inquiry_pw;
	private String inquiry_title;
	private String inquiry_account;
	private Date reg_date;
	private String enquirer;
	private String category_idx;
	
	//검색
	private String type;
	private String keyword;
	
	public int getInquiry_idx() {
		return inquiry_idx;
	}
	public void setInquiry_idx(int inquiry_idx) {
		this.inquiry_idx = inquiry_idx;
	}
	public String getInquiry_pw() {
		return inquiry_pw;
	}
	public void setInquiry_pw(String inquiry_pw) {
		this.inquiry_pw = inquiry_pw;
	}
	public String getInquiry_title() {
		return inquiry_title;
	}
	public void setInquiry_title(String inquiry_title) {
		this.inquiry_title = inquiry_title;
	}
	public String getInquiry_account() {
		return inquiry_account;
	}
	public void setInquiry_account(String inquiry_account) {
		this.inquiry_account = inquiry_account;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public String getEnquirer() {
		return enquirer;
	}
	public void setEnquirer(String enquirer) {
		this.enquirer = enquirer;
	}
	public String getCategory_idx() {
		return category_idx;
	}
	public void setCategory_idx(String category_idx) {
		this.category_idx = category_idx;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	
}
