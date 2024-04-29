package com.beans.market.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value = "/admin/userManage.go", method = RequestMethod.GET)
	public String userManageGo(Model model) {
		return "admin/userManage";
	}
	
	@RequestMapping(value = "/admin/boardManage.go", method = RequestMethod.GET)
	public String boardManageGO() {
		return "admin/boardManage";
	}
	
	@RequestMapping(value = "/admin/boardManageDetail.go", method = RequestMethod.GET)
	public String boardManageDetailGO() {
		return "admin/boardManageDetail";
	}
	
	@RequestMapping(value = "/admin/messageManage.go", method = RequestMethod.GET)
	public String messageManageGO(Model model) {
		model.addAttribute("pageName", "쪽지 관리");
		return "admin/messageManage";
	}
	
	@RequestMapping(value = "/admin/inquiryManage.go", method = RequestMethod.GET)
	public String inquiryManageGO() {
		return "admin/inquiryManage";
	}
	
	@RequestMapping(value = "/admin/report.go", method = RequestMethod.GET)
	public String reportManageGO() {
		return "admin/report";
	}
	
	@RequestMapping(value = "/admin/notice.go", method = RequestMethod.GET)
	public String noticeManageGO() {
		return "admin/notice";
	}
	
	@RequestMapping(value = "/admin/category.go", method = RequestMethod.GET)
	public String categoryManageGO() {
		return "admin/category";
	}
	
	@RequestMapping(value = "/admin/question.go", method = RequestMethod.GET)
	public String questionManageGO() {
		return "admin/question";
	}
	
	@RequestMapping(value = "/admin/panaltyHistory.go", method = RequestMethod.GET)
	public String panaltyHistoryGO() {
		return "admin/panaltyHistory";
	}
	
	@RequestMapping(value = "/admin/reportHistory.go", method = RequestMethod.GET)
	public String reportHistoryGO() {
		return "admin/reportHistory";
	}
	
	@RequestMapping(value = "/admin/payHistory.go", method = RequestMethod.GET)
	public String payHistoryGO() {
		return "admin/payHistory";
	}
	
	@RequestMapping(value = "/admin/bidHistory.go", method = RequestMethod.GET)
	public String bidHistoryGO() {
		return "admin/bidHistory";
	}
	
	@RequestMapping(value = "/admin/approHistory.go", method = RequestMethod.GET)
	public String approHistoryGO() {
		return "admin/approHistory";
	}
	
	@RequestMapping(value = "/admin/dealHistory.go", method = RequestMethod.GET)
	public String dealHistoryGO() {
		return "admin/dealHistory";
	}
	
	@RequestMapping(value = "/admin/comentHistory.go", method = RequestMethod.GET)
	public String comentHistoryGO() {
		return "admin/comentHistory";
	}
	
	@RequestMapping(value = "/admin/alarmHistory.go", method = RequestMethod.GET)
	public String alarmHistoryGO() {
		return "admin/alarmHistory";
	}
}
