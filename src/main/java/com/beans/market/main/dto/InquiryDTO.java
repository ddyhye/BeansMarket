package com.beans.market.main.dto;

import java.sql.Timestamp;

public class InquiryDTO {
	
	private int inquiry_idx;
	private String inquiry_pw;
	private String inquiry_title;
	private String inquiry_account;
	private Timestamp reg_date;
	private String enquirer;
	private String category_idx;
	private String success;
	
	
	// 관리자 답변 (inq_reply 테이블)
	// inquire_idx
	private String reply;
	private Timestamp reply_date;
	private String id;
	
	
	// 카테고리명 (category 테이블)
	private String category_name;
	
	
	// 관리자명 (admin 테이블)
	private String admin_name;
	
	
	
	
	
	public String getAdmin_name() {
		return admin_name;
	}
	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getReply() {
		return reply;
	}
	public Timestamp getReply_date() {
		return reply_date;
	}
	public String getId() {
		return id;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public void setReply_date(Timestamp reply_date) {
		this.reply_date = reply_date;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSuccess() {
		return success;
	}
	public void setSuccess(String success) {
		this.success = success;
	}
	public int getInquiry_idx() {
		return inquiry_idx;
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
	public String getEnquirer() {
		return enquirer;
	}
	public void setEnquirer(String enquirer) {
		this.enquirer = enquirer;
	}
	public String getCategory_idx() {
		return category_idx;
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
