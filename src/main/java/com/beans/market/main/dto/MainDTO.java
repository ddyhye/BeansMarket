package com.beans.market.main.dto;

import java.sql.Timestamp;

public class MainDTO {
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
	
	/* 판매자 닉네임 */
	private String sellerName;
	
	/* 경매 컬럼 */
	private int start_price;
	private int successful_bid;
	private int auction_period;
	//private String close_date;
	private int bid_count;
	//private int idx;  위에 있음
	
	/* 대표 사진 경로 (url 저장용) */
	private String new_picname;
	/* 관심목록 개수 */
	private int heartCnt;
	/* 로그인 기능 : 관심 목록 */
	private int mine;
	
	/* 알람 기능 : 알람 읽음 여부, 내용, 날짜 */
	//private String email;  위에있음
	private String checked;
	//private String content; 위에 있음
	private String link;
	//private Timestamp reg_date;  위에 있음
	
	
	/* 반환된 값이 아무 것도 없을 경우도 MainDTO list 객체에 담기 위하여 */
	public static MainDTO emptyDTO() {
		MainDTO empty = new MainDTO();
		
		empty.setIdx(0);
		// idx, option, email, subject, price, reg_date, bbs_state, 
		// 판매자 닉네임, 대표사진, 관심개수, 로그인사용자의 찜 확인, 즉구가(낙찰), 입찰 횟수(낙찰) 의 경우,
		
		return empty;
	}
	
	
	
	
	public String getHidden() {
		return hidden;
	}
	public void setHidden(String hidden) {
		this.hidden = hidden;
	}
	public int getMine() {
		return mine;
	}
	public String getChecked() {
		return checked;
	}
	public String getLink() {
		return link;
	}
	public void setChecked(String checked) {
		this.checked = checked;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public void setMine(int mine) {
		this.mine = mine;
	}
	public int getHeartCnt() {
		return heartCnt;
	}
	public void setHeartCnt(int heartCnt) {
		this.heartCnt = heartCnt;
	}
	public String getSellerName() {
		return sellerName;
	}
	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
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
//	public String getClose_date() {
//		return close_date.toString();
//	}
//	public void setClose_date(String close_date) {
//		this.close_date = close_date;
//	}
	public int getBid_count() {
		return bid_count;
	}
	public void setBid_count(int bid_count) {
		this.bid_count = bid_count;
	}
	
	

}
