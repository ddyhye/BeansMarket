package com.beans.market.main.dto;

import java.sql.Timestamp;

public class InquiryDTO {
	
	private int inquiry_idx;
	private String pw;
	private String inquiry_title;
	private String inquiry_account;
	private Timestamp reg_date;
	private String inquirer;
	private String category_idx;
	private String success;
	
	
	public String getSuccess() {
		return success;
	}
	public void setSuccess(String success) {
		this.success = success;
	}
	public int getInquiry_idx() {
		return inquiry_idx;
	}
	public String getPw() {
		return pw;
	}
	public String getInquiry_title() {
		return inquiry_title;
	}
	public String getInquiry_account() {
		return inquiry_account;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public String getInquirer() {
		return inquirer;
	}
	public void setInquirer(String inquirer) {
		this.inquirer = inquirer;
	}
	public String getCategory_idx() {
		return category_idx;
	}
	public void setInquiry_idx(int inquiry_idx) {
		this.inquiry_idx = inquiry_idx;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public void setInquiry_title(String inquiry_title) {
		this.inquiry_title = inquiry_title;
	}
	public void setInquiry_account(String inquiry_account) {
		this.inquiry_account = inquiry_account;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public void setCategory_idx(String category_idx) {
		this.category_idx = category_idx;
	}
	
}
