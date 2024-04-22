package com.beans.market.history.dto;

import java.sql.Timestamp;

public class BidHistoryDTO {
	private int bid_idx;
	private String email;
	private int price;
	private Timestamp reg_date;
	private int idx;
	
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
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	
	
}
