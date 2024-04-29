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
	
	@RequestMapping(value="/pay/mybeans")
	public String mybeans(Model model, HttpSession session) {
		logger.info("나의 빈즈 내역 요청");
		//빈즈페이 금액
		String email = "zxz0608@gmail.com";  //테스트용 이메일 //테스트 끝나고 매개변수로 email받기
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
    	//String email = (String) session.getAttribute("userEmail"); //파라미터 추가하면 이거 코드 사용
		String email = "zxz0608@gmail.com";  //테스트용 이메일 //테스트 끝나고 매개변수로 email받기
	    // 가져온 이메일이 null이 아닐 경우에만 처리
	    if(email != null) {
	        payService.updateMemberPoint(email, payDTO.getPay());
	        return "redirect:/pay/mybeans"; // 충전 성공 페이지로 리다이렉트
	    } else {
	        // 예외 처리: 로그인하지 않은 사용자
	        return "redirect:/main/member/login.go"; // 로그인 페이지로 리다이렉트
	    }//현재는 데드코드라고 뜨지만 , 로그인 세션 주석 삭제시 정상코드로 변환
	
 
	
}
    
}    
