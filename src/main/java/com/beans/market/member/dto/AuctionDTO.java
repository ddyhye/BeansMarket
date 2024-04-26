package com.beans.market.member.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class AuctionDTO {

	
	private int bid_idx;
	private String email;
	private int price;
	private Date reg_date;
	private int idx;
	
	
	/* 입찰 내역을 출력하기 위한 가상 컬럼 */
	private String new_picname;
	private String subject;
	private Timestamp close_date;
	private String bbs_state;
	
	
	
	
	
	
	
	public String getNew_picname() {
		return new_picname;
	}
	public void setNew_picname(String new_picname) {
		this.new_picname = new_picname;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public Timestamp getClose_date() {
		return close_date;
	}
	public void setClose_date(Timestamp close_date) {
		this.close_date = close_date;
	}
	public String getBbs_state() {
		return bbs_state;
	}
	public void setBbs_state(String bbs_state) {
		this.bbs_state = bbs_state;
	}
	public int getBid_idx() {
		return bid_idx;
	}
	public void setBid_idx(int bid_idx) {
		this.bid_idx = bid_idx;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
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
	
	
	
	
}
