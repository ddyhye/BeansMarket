package com.beans.market.photo.dto;

import java.sql.Date;

public class ProfilePicDTO {
	private String new_filename;
	private Date reg_date;
	private String email;
	private String confirmed;
	
	public String getNew_filename() {
		return new_filename;
	}
	public void setNew_filename(String new_filename) {
		this.new_filename = new_filename;
	}
	public String getReg_date() {
		return reg_date.toString();
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getConfirmed() {
		return confirmed;
	}
	public void setConfirmed(String confirmed) {
		this.confirmed = confirmed;
	}
	
}
