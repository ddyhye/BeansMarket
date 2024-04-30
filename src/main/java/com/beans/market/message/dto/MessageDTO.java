package com.beans.market.message.dto;

import java.sql.Timestamp;

public class MessageDTO {
	private int message_idx;
	private String content;
	private Timestamp reg_date;
	private String receive_email;
	private String receive_del;
	private String sender_email;
	private String sender_del;
	private String read_check;
	private int idx;
	private String new_picname;
	
	// 쪽지 관리에 제목 출력 용
	private String subject;
	
	public int getMessage_idx() {
		return message_idx;
	}
	public void setMessage_idx(int message_idx) {
		this.message_idx = message_idx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public String getReceive_email() {
		return receive_email;
	}
	public void setReceive_email(String receive_email) {
		this.receive_email = receive_email;
	}
	public String getReceive_del() {
		return receive_del;
	}
	public void setReceive_del(String receive_del) {
		this.receive_del = receive_del;
	}
	public String getSender_email() {
		return sender_email;
	}
	public void setSender_email(String sender_email) {
		this.sender_email = sender_email;
	}
	public String getSender_del() {
		return sender_del;
	}
	public void setSender_del(String sender_del) {
		this.sender_del = sender_del;
	}
	public String getRead_check() {
		return read_check;
	}
	public void setRead_check(String read_check) {
		this.read_check = read_check;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
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
	
}
