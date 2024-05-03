package com.beans.market.pay.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.beans.market.member.dto.MemberDTO;
import com.beans.market.pay.dao.PayDAO;
import com.beans.market.pay.dto.PayDTO;
import com.beans.market.pay.service.PayService;

@Controller
public class PayController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired PayService payService;
	
	@RequestMapping(value="/pay/mybeans.go")
	public String mybeans(Model model, HttpSession session) {
		logger.info("나의 빈즈 내역 요청");
		String page = "redirect:/member/login.go";
		
		MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		if (loginInfo != null) {
			String email = loginInfo.getEmail();
			page = "pay/myBeansPay";
			
			int amount = payService.getMyAmount(email);
			model.addAttribute("my_amount", amount);
			//빈즈내역
			List<PayDTO> mybeansHist = payService.list(email);
			model.addAttribute("beans", mybeansHist);
			// 유저 이름 가져오기
			String userName = payService.getUsernameByEmail(email); 
			model.addAttribute("userName", userName);
		} else {
			model.addAttribute("로그인이 필요한 서비스 입니다.");
		}
		return page;
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
	
	@RequestMapping(value = "/pay/Remittance.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> RemittanceAjax(String email, int idx){
		logger.info("{} 이 {} 게시글 판매자에게 송금", email, idx);
		Map<String, Object> map = new HashMap<String, Object>();
		map = payService.RemittanceAjax(email, idx);
		return map;
	}
	
	//충전
	@RequestMapping(value="/pay/charge", method=RequestMethod.POST)
    public String charge( PayDTO payDTO, HttpSession session) {
		String page = "redirect:/member/login.go";
		
		MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		if (loginInfo != null) {
			String email = loginInfo.getEmail();
			logger.info("{} 빈즈페이 충전 요청", email);
			payService.updateMemberPoint(email, payDTO.getPay());
			page = "redirect:/pay/mybeans.go"; // 충전 성공 페이지로 리다이렉트
		} 
	        
        return page;
	    
	}
    
}    
