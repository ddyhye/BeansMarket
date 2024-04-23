package com.beans.market.pay.dto;

import java.sql.Date;

public class PayDTO {
	
	//나의 포인트
	private int point;
	//나의 빈즈 내역
	private int idx;
	private String email;
	private String option;
	private int price;
	private String content;
	private Date reg_date;
	//충전
	private int pay;
	
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
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
	public String getReg_date() {
		return reg_date.toString();
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getPay() {
		return pay;
	}
	public void setPay(int pay) {
		this.pay = pay;
	}

	
	
	

}
