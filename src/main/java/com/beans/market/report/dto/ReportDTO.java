package com.beans.market.report.dto;

import java.sql.Timestamp;

public class ReportDTO {
	private int report_idx;
	private String option_idx;
	private int idx;
	private String category_idx;
	private String content;
	private String report_complete;
	private Timestamp reg_date;
	private String reporter_email	;
	private String perpet_email;
	
	private String category_name;
	private String option_name;
	private String admin_name;
	
	
	
	public int getReport_idx() {
		return report_idx;
	}
	public void setReport_idx(int report_idx) {
		this.report_idx = report_idx;
	}
	public String getOption_idx() {
		return option_idx;
	}
	public void setOption_idx(String option_idx) {
		this.option_idx = option_idx;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getCategory_idx() {
		return category_idx;
	}
	public void setCategory_idx(String category_idx) {
		this.category_idx = category_idx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReport_complete() {
		return report_complete;
	}
	public void setReport_complete(String report_complete) {
		this.report_complete = report_complete;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public String getReporter_email() {
		return reporter_email;
	}
	public void setReporter_email(String reporter_email) {
		this.reporter_email = reporter_email;
	}
	public String getPerpet_email() {
		return perpet_email;
	}
	public void setPerpet_email(String perpet_email) {
		this.perpet_email = perpet_email;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getOption_name() {
		return option_name;
	}
	public void setOption_name(String option_name) {
		this.option_name = option_name;
	}
	public String getAdmin_name() {
		return admin_name;
	}
	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}
	
}
