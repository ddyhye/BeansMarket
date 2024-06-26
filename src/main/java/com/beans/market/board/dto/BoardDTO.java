package com.beans.market.board.dto;

import java.sql.Timestamp;

public class BoardDTO {
	private int idx;
	private String email;
	private String option;
	private String category_idx;
	private String subject;
	private String location;
	private int price;
	private String content;
	private String place;
	private Timestamp reg_date;
	private int bHit;
	private String blind;
	private String bbs_state;
	private String reserve_email;
	private String draft;
	private String hidden;
	/* 경매 컬럼 */
	private int start_price;
	private int successful_bid;
	private int auction_period;
	private Timestamp close_date;
	private int bid_count;
	//private int idx;
	
	/* 대표 사진 경로 (url 저장용) */
	private String new_picname;
	
	private String category_name;
	
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getNew_picname() {
		return new_picname;
	}
	public void setNew_picname(String new_picname) {
		this.new_picname = new_picname;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getOption() {
		return option;
	}
	public void setOption(String option) {
		this.option = option;
	}
	public String getCategory_idx() {
		return category_idx;
	}
	public void setCategory_idx(String category_idx) {
		this.category_idx = category_idx;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public int getbHit() {
		return bHit;
	}
	public void setbHit(int bHit) {
		this.bHit = bHit;
	}
	public String getBlind() {
		return blind;
	}
	public void setBlind(String blind) {
		this.blind = blind;
	}
	public String getBbs_state() {
		return bbs_state;
	}
	public void setBbs_state(String bbs_state) {
		this.bbs_state = bbs_state;
	}
	public String getReserve_email() {
		return reserve_email;
	}
	public void setReserve_email(String reserve_email) {
		this.reserve_email = reserve_email;
	}
	public String getDraft() {
		return draft;
	}
	public void setDraft(String draft) {
		this.draft = draft;
	}
	public int getStart_price() {
		return start_price;
	}
	public void setStart_price(int start_price) {
		this.start_price = start_price;
	}
	public int getSuccessful_bid() {
		return successful_bid;
	}
	public void setSuccessful_bid(int successful_bid) {
		this.successful_bid = successful_bid;
	}
	public int getAuction_period() {
		return auction_period;
	}
	public void setAuction_period(int auction_period) {
		this.auction_period = auction_period;
	}
	public Timestamp getClose_date() {
		return close_date;
	}
	public void setClose_date(Timestamp close_date) {
		this.close_date = close_date;
	}
	public int getBid_count() {
		return bid_count;
	}
	public void setBid_count(int bid_count) {
		this.bid_count = bid_count;
	}
	public String getHidden() {
		return hidden;
	}
	public void setHidden(String hidden) {
		this.hidden = hidden;
	}
	
}
