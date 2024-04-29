package com.beans.market.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beans.market.admin.dto.AdminDTO;
import com.beans.market.admin.dto.AlarmDTO;
import com.beans.market.admin.service.AdminService;

@Controller
public class AdminController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AdminService adminService;
	
	@RequestMapping(value = "/admin/adminLogin.go", method = RequestMethod.GET)
		public String adminLoginGo(Model model) {
		return "admin/adminLogin";
	}
	
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
	
	/*========================= 이동 =================================*/
	// 로그인
	@RequestMapping(value = "/admin/adminLogin.do", method = RequestMethod.POST)
	public String adminLoginDo(HttpSession session, Model model, String id, String pw) {
		logger.info("admin login id : {}, pw : {}", id, pw);

	    String page = "admin/adminLogin";
	    String msg = "로그인에 실패하였습니다...";   
	    AdminDTO adLoginInfo = adminService.login(id, pw);
		logger.info("adinfo: {}", adLoginInfo);
		
	    if(adLoginInfo != null) {
	        page = "redirect:/admin/messageManage.go";
	        session.setAttribute("adLoginInfo", adLoginInfo);
        } else {
			model.addAttribute("msg", msg);
		}
	     
	    return page;
	}
	// 로그아웃
	@RequestMapping(value = "/admin/logout.do", method = RequestMethod.GET)
	public String logoutDo(HttpSession session, Model model) {
	    
		String msg = "이미 로그아웃 상태입니다.";   
	    
	    if (session.getAttribute("adLoginInfo") != null) {
			session.removeAttribute("adLoginInfo");
			msg = "로그아웃 되셨습니다.";
		}
		
	    model.addAttribute("msg", msg);
	     
	    return "admin/adminLogin";
	}
	 
	// 알림 리스트 가져오기
	@RequestMapping(value="/admin/adminAlarm.ajax")
	@ResponseBody
	public Map<String, Object> alarm(HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 세션은 나중에
		// 알림 리스트 가져오기
		List<AlarmDTO> list = adminService.alarm();
		
		// 문의, 신고 미처리 갯수 가져오기
		map = adminService.noComplete(); // inquiryCnt, reportCnt
		
		map.put("list", list);
		
		return map;
	}
	
	// 알림 읽음 처리
	@RequestMapping(value="/admin/adminAlarmRead.ajax")
	@ResponseBody
	public Map<String, Object> alarm(HttpSession session, String idx) {
		logger.info("{} 번 알림 읽음 처리하기", idx);
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 세션은 나중에
		int result = adminService.alarmRead(Integer.parseInt(idx));

		map.put("result", result);
		
		return map;
	}
	
	// 새로운 알림이 있는지 확인
	@RequestMapping(value="/admin/adminNewAlarm.ajax")
	@ResponseBody
	public Map<String, Object> newAlarm(HttpSession session) {
		logger.info("새로운 알림 가져오기");
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 세션은 나중에
		map = adminService.newAlarm();

		return map;
	}
	
	// 쪽지 번호를 토대로 출력
	@RequestMapping(value="/admin/messageList.ajax")
	@ResponseBody
	public Map<String, Object> messageList(HttpSession session, String searchText, String reportYN) {
		logger.info("쪽지 리스트 출력");
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 세션은 나중에
		map = adminService.newAlarm();

		return map;
	}
	
	
	
}
