package com.beans.market.admin.dto;

import java.sql.Date;

public class NoticeDTO {
	private int notice_idx;
	private String notice_title;
	private String notice_content;
	private String id;
	private Date notice_date;
	private int nHit;
    private String notice_option; 
    private String admin_name;
    
	
	
	
	public String getNotice_option() {
		return notice_option;
	}
	public void setNotice_option(String notice_option) {
		this.notice_option = notice_option;
	}
	public String getAdmin_name() {
		return admin_name;
	}
	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}
	public int getNotice_idx() {
		return notice_idx;
	}
	public void setNotice_idx(int notice_idx) {
		this.notice_idx = notice_idx;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getNotice_date() {
		return notice_date;
	}
	public void setNotice_date(Date notice_date) {
		this.notice_date = notice_date;
	}
	public int getnHit() {
		return nHit;
	}
	public void setnHit(int nHit) {
		this.nHit = nHit;
	}
	
	

}
