package com.beans.market.report.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import com.beans.market.member.dto.MemberDTO;
import com.beans.market.report.service.ReportService;

@Controller
public class ReportController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired ReportService reportService;
	
	// report
	@RequestMapping(value="/report/report.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> reportDo(Model model, @RequestParam Map<String, String> map, HttpSession session) {
		logger.info("신고 정보 : {}", map);
		
		Map<String, Object> reportMap = new HashMap<String, Object>();
		MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		
		if (loginInfo != null) {
			map.put("reporter_email", loginInfo.getEmail()); // 로그인 완료되면 세션에서 받아올 예정 + 회원만 신고처리가 되도록
			reportMap.put("msg", reportService.reportDo(map)); 			
		} else {
			reportMap.put("msg", "신고에 실패했습니다."); 	
		}
		
		return reportMap;
	}
	
	//차단기능
	@RequestMapping(value="/report/ban.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> ban(@RequestParam("email") String email){
	    logger.info("email {}"+ email);
	    
	    Map<String, Object> ban= new HashMap<String, Object>();
	    
	    
	    return ban;
	    
	}
	
}
