package com.beans.market.message.dto;

import java.sql.Timestamp;

public class RoomDTO {
	private String other_email;
	private int idx;
	private String content;
	private Timestamp reg_date;
	private String new_picname;
	
	public String getOther_email() {
		return other_email;
	}
	public void setOther_email(String other_email) {
		this.other_email = other_email;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public String getNew_picname() {
		return new_picname;
	}
	public void setNew_picname(String new_picname) {
		this.new_picname = new_picname;
	}
	
	
}