package com.beans.market.message.dto;

import java.sql.Timestamp;

public class ApproveDTO {
	private Timestamp reg_date;
	private String email;
	private int idx;
	
	
	/* 거래 미승인 출력을 위한 임시 컬럼 (bbs 테이블, photo 테이블) */
	private String subject;
	private String option;
	private String new_picname;
	public Timestamp getReg_date() {
		return reg_date;
	}
	public String getEmail() {
		return email;
	}
	public int getIdx() {
		return idx;
	}
	public String getSubject() {
		return subject;
	}
	public String getOption() {
		return option;
	}
	public String getNew_picname() {
		return new_picname;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public void setOption(String option) {
		this.option = option;
	}
	public void setNew_picname(String new_picname) {
		this.new_picname = new_picname;
	}
}
