package com.beans.market.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.beans.market.admin.service.AdminService;

@Controller
public class AdminController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired AdminService adminService;
	
	// 게시글 관리 페이지
	@RequestMapping(value="/admin/boardManage.go")
	public String boardManage() {
		return "admin/boardManage";
	}
	
	// 게시글 상세 페이지
	@RequestMapping(value="/admin/boardManageDetail.go")
	public String boardManageDetail() {
		return "admin/boardManageDetail";
	}
	
}
