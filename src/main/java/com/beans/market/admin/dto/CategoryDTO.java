package com.beans.market.admin.dto;

public class CategoryDTO {
	private String category_idx;
	private String category_name;
	private String hidden;
	
	public String getCategory_idx() {
		return category_idx;
	}
	public void setCategory_idx(String category_idx) {
		this.category_idx = category_idx;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getHidden() {
		return hidden;
	}
	public void setHidden(String hidden) {
		this.hidden = hidden;
	}
	
}
