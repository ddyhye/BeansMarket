package com.beans.market.pay.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beans.market.member.dto.MemberDTO;
import com.beans.market.pay.dto.PayDTO;
import com.beans.market.pay.service.PayService;

@Controller
public class PayController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired PayService payService;
	
	@RequestMapping(value="/pay/mybeans")
	public String mybeans(Model model, HttpSession session) {
		logger.info("나의 빈즈 내역 요청");
		//빈즈페이 금액
		String email = "zxz0608@naver.com";  //테스트용 이메일 //테스트 끝나고 매개변수로 email받기
//		String logEmail = "";
//		if (session.getAttribute("logEmail") != null) {
//			logEmail = (String) session.getAttribute("logEmail");
//		}
		int amount = payService.getMyAmount(email);
		model.addAttribute("my_amount", amount);
		//빈즈내역
		List<PayDTO> mybeansHist = payService.list(email);
		model.addAttribute("beans", mybeansHist);
		// 유저 이름 가져오기
	    String userName = payService.getUsernameByEmail(email); 
	    model.addAttribute("userName", userName);
		
		return "pay/myBeansPay";
		
	}
	
	@RequestMapping(value = "/pay/getPoint.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getPointAjax(String email){
		logger.info("{} point 요청", email);
		Map<String, Object> map = new HashMap<String, Object>();
		int point = payService.getMyAmount(email);
		map.put("point", point);
		return map;
	}
	
}
