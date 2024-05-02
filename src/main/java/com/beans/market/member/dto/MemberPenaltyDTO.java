package com.beans.market.member.dto;

import java.sql.Date;

public class MemberPenaltyDTO {
	private int penalty_idx;
	private String option;
	private String content;
	private java.sql.Date penalty_date;
	private String admin_name;
	public int getPenalty_idx() {
		return penalty_idx;
	}
	public String getOption() {
		return option;
	}
	public String getContent() {
		return content;
	}
	public java.sql.Date getPenalty_date() {
		return penalty_date;
	}
	public String getAdmin_name() {
		return admin_name;
	}
	public void setPenalty_idx(int penalty_idx) {
		this.penalty_idx = penalty_idx;
	}
	public void setOption(String option) {
		this.option = option;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setPenalty_date(java.sql.Date penalty_date) {
		this.penalty_date = penalty_date;
	}
	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}
	
	
}
