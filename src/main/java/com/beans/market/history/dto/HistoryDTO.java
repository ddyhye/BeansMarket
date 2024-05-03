package com.beans.market.history.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class HistoryDTO {
	/* 공통 */
	private String option;
	private String content;
	private String admin_name;
	private String email;
	private Timestamp reg_date;
	
	/* 페널티 히스토리 */
	private int penalty_idx;
	private Date penalty_date;
	
	/* 신고 히스토리*/
	private String category_idx;
	private String category_name;
	private String perper_email;
	private int report_idx;
	
	/* 입출금 내역*/
	private int idx;
	private int price;
	
	/* 경매 입찰 히스토리 */
	private int bid_idx;
	
	/* 거래승인 추가 X*/
	
	/* 거래 내역*/
	private int deal_idx;
	private String seller_email;
	private String buyer_email;
	private String blind;
	
	/* 거래 후기 추가 */
	private String coment;
	
	/* 알림 */
	private String link;
	private char checked;
	
	public int getPenalty_idx() {
		return penalty_idx;
	}
	public void setPenalty_idx(int penalty_idx) {
		this.penalty_idx = penalty_idx;
	}
	public String getOption() {
		return option;
	}
	public void setOption(String option) {
		this.option = option;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAdmin_name() {
		return admin_name;
	}
	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getPenalty_date() {
		return penalty_date;
	}
	public void setPenalty_date(Date penalty_date) {
		this.penalty_date = penalty_date;
	}
	public String getPerper_email() {
		return perper_email;
	}
	public void setPerper_email(String perper_email) {
		this.perper_email = perper_email;
	}
	public String getCategory_idx() {
		return category_idx;
	}
	public void setCategory_idx(String category_idx) {
		this.category_idx = category_idx;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public int getReport_idx() {
		return report_idx;
	}
	public void setReport_idx(int report_idx) {
		this.report_idx = report_idx;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getBid_idx() {
		return bid_idx;
	}
	public void setBid_idx(int bid_idx) {
		this.bid_idx = bid_idx;
	}
	public int getDeal_idx() {
		return deal_idx;
	}
	public void setDeal_idx(int deal_idx) {
		this.deal_idx = deal_idx;
	}
	public String getSeller_email() {
		return seller_email;
	}
	public void setSeller_email(String seller_email) {
		this.seller_email = seller_email;
	}
	public String getBuyer_email() {
		return buyer_email;
	}
	public void setBuyer_email(String buyer_email) {
		this.buyer_email = buyer_email;
	}
	public String getBlind() {
		return blind;
	}
	public void setBlind(String blind) {
		this.blind = blind;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public char getChecked() {
		return checked;
	}
	public void setChecked(char checked) {
		this.checked = checked;
	}
	public String getComent() {
		return coment;
	}
	public void setComent(String coment) {
		this.coment = coment;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}

	
	
}
