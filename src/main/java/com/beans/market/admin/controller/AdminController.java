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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beans.market.admin.dto.AdminDTO;
import com.beans.market.admin.dto.AlarmDTO;
import com.beans.market.admin.service.AdminService;
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.member.dto.MemberPenaltyDTO;
import com.beans.market.pay.dto.PayDTO;
import com.beans.market.photo.dto.ProfilePicDTO;

@Controller
public class AdminController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AdminService adminService;
	
	@RequestMapping(value = "/admin/", method = RequestMethod.GET)
		public String adminLoginGo(Model model) {
		return "admin/adminLogin";
	}
	
	@RequestMapping(value = "/admin/userManage.go", method = RequestMethod.GET)
	public String userManageGo(Model model) {
		model.addAttribute("pageName", "회원 관리");
		return "admin/userManage";
	}
	
	@RequestMapping(value = "/admin/boardManage.go", method = RequestMethod.GET)
	public String boardManageGO(Model model) {
		model.addAttribute("pageName", "게시글 관리");
		return "admin/boardManage";
	}
	
	@RequestMapping(value = "/admin/boardManageDetail.go", method = RequestMethod.GET)
	public String boardManageDetailGO(Model model) {
		model.addAttribute("pageName", "게시글 관리");
		return "admin/boardManageDetail";
	}
	
	@RequestMapping(value = "/admin/messageManage.go", method = RequestMethod.GET)
	public String messageManageGO(Model model) {
		model.addAttribute("pageName", "쪽지 관리");
		return "admin/messageManage";
	}
	
	@RequestMapping(value = "/admin/inquiryManage.go", method = RequestMethod.GET)
	public String inquiryManageGO(Model model) {
		model.addAttribute("pageName", "1:1 문의 관리");
		return "admin/inquiryManage";
	}
	
	@RequestMapping(value = "/admin/report.go", method = RequestMethod.GET)
	public String reportManageGO(Model model) {
		model.addAttribute("pageName", "신고 내역 관리");
		return "admin/report";
	}
	
	@RequestMapping(value = "/admin/notice.go", method = RequestMethod.GET)
	public String noticeManageGO(Model model) {
		model.addAttribute("pageName", "공지사항 관리");
		return "admin/notice";
	}
	
	@RequestMapping(value = "/admin/category.go", method = RequestMethod.GET)
	public String categoryManageGO(Model model) {
		model.addAttribute("pageName", "카테고리 관리");
		return "admin/category";
	}
	
	@RequestMapping(value = "/admin/question.go", method = RequestMethod.GET)
	public String questionManageGO(Model model) {
		model.addAttribute("pageName", "자주 묻는 질문 관리");
		return "admin/question";
	}
	
	@RequestMapping(value = "/admin/panaltyHistory.go", method = RequestMethod.GET)
	public String panaltyHistoryGO(Model model) {
		model.addAttribute("pageName", "경고 및 제재 히스토리");
		return "admin/panaltyHistory";
	}
	
	@RequestMapping(value = "/admin/reportHistory.go", method = RequestMethod.GET)
	public String reportHistoryGO(Model model) {
		model.addAttribute("pageName", "신고처리 히스토리");
		return "admin/reportHistory";
	}
	
	@RequestMapping(value = "/admin/payHistory.go", method = RequestMethod.GET)
	public String payHistoryGO(Model model) {
		model.addAttribute("pageName", "입출금 내역 히스토리");
		return "admin/payHistory";
	}
	
	@RequestMapping(value = "/admin/bidHistory.go", method = RequestMethod.GET)
	public String bidHistoryGO(Model model) {
		model.addAttribute("pageName", "경매 입찰 히스토리");
		return "admin/bidHistory";
	}
	
	@RequestMapping(value = "/admin/approHistory.go", method = RequestMethod.GET)
	public String approHistoryGO(Model model) {
		model.addAttribute("pageName", "거래 승인 히스토리");
		return "admin/approHistory";
	}
	
	@RequestMapping(value = "/admin/dealHistory.go", method = RequestMethod.GET)
	public String dealHistoryGO(Model model) {
		model.addAttribute("pageName", "거래 내역 히스토리");
		return "admin/dealHistory";
	}
	
	@RequestMapping(value = "/admin/comentHistory.go", method = RequestMethod.GET)
	public String comentHistoryGO(Model model) {
		model.addAttribute("pageName", "거래 후기 히스토리");
		return "admin/comentHistory";
	}
	
	@RequestMapping(value = "/admin/alarmHistory.go", method = RequestMethod.GET)
	public String alarmHistoryGO(Model model) {
		model.addAttribute("pageName", "알림 히스토리");
		return "admin/alarmHistory";
	}
	
	/*========================= 이동 =================================*/
	// 로그인 - 성영
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
	        session.setAttribute("adminID", adLoginInfo.getId());
        } else {
			model.addAttribute("msg", msg);
		}
	     
	    return page;
	}
	// 로그아웃 - 성영
	@RequestMapping(value = "/admin/logout.do", method = RequestMethod.GET)
	public String logoutDo(HttpSession session, Model model) {
	    
		String msg = "이미 로그아웃 상태입니다.";   
	    
	    if (session.getAttribute("adLoginInfo") != null) {
			session.removeAttribute("adLoginInfo");
			session.removeAttribute("adminID");
			msg = "로그아웃 되셨습니다.";
		}
		
	    model.addAttribute("msg", msg);
	     
	    return "admin/adminLogin";
	}
	 
	// 알림 리스트 가져오기 - 성영
	@RequestMapping(value="/admin/adminAlarm.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> alarm(HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		if (session.getAttribute("adLoginInfo") != null) {
			// 알림 리스트 가져오기
			List<AlarmDTO> list = adminService.alarm();
			
			// 문의, 신고 미처리 갯수 가져오기
			map = adminService.noComplete(); // inquiryCnt, reportCnt
			
			map.put("list", list);
		}
		
		return map;
	}
	
	// 알림 읽음 처리 - 성영
	@RequestMapping(value="/admin/adminAlarmRead.ajax", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> alarm(HttpSession session, String idx) {
		logger.info("{} 번 알림 읽음 처리하기", idx);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if (session.getAttribute("adLoginInfo") != null) {
			int result = adminService.alarmRead(Integer.parseInt(idx));
			map.put("result", result);			
		}
		
		return map;
	}
	
	// 새로운 알림이 있는지 확인 - 성영
	@RequestMapping(value="/admin/adminNewAlarm.ajax", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> newAlarm(HttpSession session) {
		logger.info("새로운 알림 가져오기");
		Map<String, Object> map = new HashMap<String, Object>();
		
		if (session.getAttribute("adLoginInfo") != null) {
			map = adminService.newAlarm();			
		}

		return map;
	}
	
	// 쪽지 번호를 토대로 출력 - 성영
	@RequestMapping(value="/admin/messageList.ajax", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> messageList(HttpSession session, String searchText, String reportYN) {
		logger.info("쪽지 리스트 출력");
		Map<String, Object> map = new HashMap<String, Object>();
		
		logger.info("text : {}, YN : {}", searchText, reportYN);
		if (session.getAttribute("adLoginInfo") != null) {
			int intSearchText; 
			try {
				intSearchText = searchText.equals("") ? 0 : Integer.parseInt(searchText); // 숫자가 아닐때라고 유효성 검사를 주는게 좋아보임
			} catch (Exception e) {
				intSearchText = 0;
			}
			
			map = adminService.messageList(intSearchText , reportYN);			
		}

		return map;
	}
	
	// 게시글을 토대로 출력 - 성영
	@RequestMapping(value="/admin/roomList.ajax", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> roomList(HttpSession session, String searchText, String reportYN) {
		logger.info("게시글에 연결될 쪽지방 리스트 출력");
		Map<String, Object> map = new HashMap<String, Object>();
		
		if (session.getAttribute("adLoginInfo") != null) {
			map = adminService.roomList(searchText, reportYN);			
		}
		

		return map;
	}

	// 게시글을 토대로 출력 - 성영
	@RequestMapping(value="/admin/roomDetailCall.ajax", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> roomDetailCall(HttpSession session, String idx, String seller, String buyer) {
		logger.info(idx+"번 구매자 : {}, 판매자 {} - 쪽지방 상세보기", seller, buyer);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if (session.getAttribute("adLoginInfo") != null) {
			map = adminService.roomDetailCall(idx, seller, buyer);			
		}
	
		return map;
	}
	
	// 게시글을 토대로 출력 - 성영
	@RequestMapping(value="/admin/categoryCall.ajax", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> categoryCall(HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map = adminService.categoryCall();			
		
		return map;
	}

	// 카테고리 변경사항 저장하기
	@RequestMapping(value="/admin/categorySave.do", method = RequestMethod.POST)
	public String categorySave(HttpSession session, Model model, String idx, String name, String hidden) {
		logger.info(idx+" name : {}, hidden : {}", name, hidden);
		
		adminService.categorySave(model, idx, name, hidden);
		
		return "admin/category";
	}

	// 카테고리 추가하기
	@RequestMapping(value="/admin/categoryInsert.do", method = RequestMethod.POST)
	public String categoryInsert(HttpSession session, Model model, String idx, String name) {
		logger.info(" idx : {}, name : {}", idx, name);
		
		adminService.categoryInsert(model, idx, name);
		
		return "admin/category";
	}








	
	
	
	
	
	
	
	/*                     도혜                       */
	// 회원 리스트 불러오기
	@RequestMapping(value="/admin/memberList.ajax")
	@ResponseBody
	public Map<String, Object> memberListAjax(String memberSearch, String warningOption, String memberStateOption) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		adminService.memberList(map, memberSearch, warningOption, memberStateOption);

		return map;
	}
	
	// 회원 관리 (제제)
	@RequestMapping(value="/admin/userManage.do", method=RequestMethod.POST)
	public String userManage_do(Model model, HttpSession session, @RequestParam Map<String, String> param) {
		
		String adminID = (String) session.getAttribute("adminID");
		param.put("adminID", adminID);
		
		if (adminService.userManageDo(param) > 0) {
			model.addAttribute("msg", param.get("memberEmail")+" 제제 완료");
		} else {
			model.addAttribute("msg", param.get("memberEmail")+" 제제 실패");
		}
		
		return "admin/userManage";
	}
	// 회원 상세보기
	@RequestMapping(value="/admin/userManageDetail.go")
	public String userManageDetail_go(Model model, HttpSession session, String memberEmail) {
		String adminID = (String) session.getAttribute("adminID");
		
		MemberDTO dto = adminService.getMemberProfile(memberEmail);
		String new_filename = adminService.getmemberProfilePic(memberEmail);
		
		model.addAttribute("new_filename", new_filename);
		model.addAttribute("email", dto.getEmail());
		model.addAttribute("name", dto.getName());
		model.addAttribute("location", dto.getLocation());
		model.addAttribute("scope", dto.getScope());
		model.addAttribute("gender", dto.getGender());
		model.addAttribute("birth_date", dto.getBirth_date());
		model.addAttribute("last_login", dto.getLast_login());
		// 정보 약관 동의 X
		model.addAttribute("dormant", dto.getDormant());
		model.addAttribute("secession", dto.getSecession());
		model.addAttribute("point", dto.getPoint());
		model.addAttribute("warn_count", dto.getWarn_count());
		model.addAttribute("login_banstr", dto.getLogin_banstr());
		model.addAttribute("login_banend", dto.getLogin_banend());
		
		return "admin/userManageDetail";
	}
	// 회원 빈즈페이 수정
	@RequestMapping(value="/admin/userManageDetailAdd.go")
	public String userManageDetailAdd_go(Model model, HttpSession session, String memberEmail, String inputPoint) {
		String adminID = (String) session.getAttribute("adminID");
		
		int point = Integer.parseInt(inputPoint);
		adminService.userPointUpdate1(memberEmail, point);
		
		MemberDTO dto = adminService.getMemberProfile(memberEmail);
		String new_filename = adminService.getmemberProfilePic(memberEmail);
		
		model.addAttribute("new_filename", new_filename);
		model.addAttribute("email", dto.getEmail());
		model.addAttribute("name", dto.getName());
		model.addAttribute("location", dto.getLocation());
		model.addAttribute("scope", dto.getScope());
		model.addAttribute("gender", dto.getGender());
		model.addAttribute("birth_date", dto.getBirth_date());
		model.addAttribute("last_login", dto.getLast_login());
		// 정보 약관 동의 X
		model.addAttribute("dormant", dto.getDormant());
		model.addAttribute("secession", dto.getSecession());
		model.addAttribute("point", dto.getPoint());
		model.addAttribute("warn_count", dto.getWarn_count());
		model.addAttribute("login_banstr", dto.getLogin_banstr());
		model.addAttribute("login_banend", dto.getLogin_banend());
		
		return "admin/userManageDetail";
	}
	@RequestMapping(value="/admin/userManageDetailMinus.go")
	public String userManageDetailMinus_go(Model model, HttpSession session, String memberEmail, String inputPoint) {
		String adminID = (String) session.getAttribute("adminID");
		
		int point = Integer.parseInt(inputPoint);
		adminService.userPointUpdate2(memberEmail, point);
		
		MemberDTO dto = adminService.getMemberProfile(memberEmail);
		String new_filename = adminService.getmemberProfilePic(memberEmail);
		
		model.addAttribute("new_filename", new_filename);
		model.addAttribute("email", dto.getEmail());
		model.addAttribute("name", dto.getName());
		model.addAttribute("location", dto.getLocation());
		model.addAttribute("scope", dto.getScope());
		model.addAttribute("gender", dto.getGender());
		model.addAttribute("birth_date", dto.getBirth_date());
		model.addAttribute("last_login", dto.getLast_login());
		// 정보 약관 동의 X
		model.addAttribute("dormant", dto.getDormant());
		model.addAttribute("secession", dto.getSecession());
		model.addAttribute("point", dto.getPoint());
		model.addAttribute("warn_count", dto.getWarn_count());
		model.addAttribute("login_banstr", dto.getLogin_banstr());
		model.addAttribute("login_banend", dto.getLogin_banend());
		
		return "admin/userManageDetail";
	}
	
	// 회원 상세보기 - 페이내역
	@RequestMapping(value="/admin/userManagePayHistory.ajax")
	@ResponseBody
	public Map<String, Object> userManagePayHistoryAjax(String memberEmail) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<PayDTO> list = adminService.memberPayHistory(memberEmail);
		
		map.put("list", list);

		return map;
	}
	// 회원 상세보기 - 제제 내역
	@RequestMapping(value="/admin/userManageDisciplineHistory.ajax")
	@ResponseBody
	public Map<String, Object> userManageDisciplineHistoryAjax(String memberEmail) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<MemberPenaltyDTO> list = adminService.memberDisciplineHistory(memberEmail);
		
		map.put("list", list);

		return map;
	}
	


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*                     정언                       */
	@RequestMapping(value="/admin/bbsList.ajax")
	@ResponseBody
	public Map<String,Object> bbsListAjax(String textVal, String selectedCategory,String selectedState, String selectedRadio) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		adminService.bbsList(map, textVal, selectedCategory, selectedState, selectedRadio);
		
		return map;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

