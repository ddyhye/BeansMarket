package com.beans.market.photo.dto;

import java.sql.Date;

public class PhotoDTO {
	private int pic_idx;
	private String main;
	private String new_picname;
	private Date reg_date;
	private int idx;
	private int option_idx; // 게시글인지 쪽지인지 등등에 대한 분류
	
	public int getPic_idx() {
		return pic_idx;
	}
	public void setPic_idx(int pic_idx) {
		this.pic_idx = pic_idx;
	}
	public String getMain() {
		return main;
	}
	public void setMain(String main) {
		this.main = main;
	}
	public String getNew_picname() {
		return new_picname;
	}
	public void setNew_picname(String new_picname) {
		this.new_picname = new_picname;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getOption_idx() {
		return option_idx;
	}
	public void setOption_idx(int option_idx) {
		this.option_idx = option_idx;
	}
	
}
