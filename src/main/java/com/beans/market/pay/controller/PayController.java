package com.beans.market.pay.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.beans.market.pay.dto.PayDTO;
import com.beans.market.pay.service.PayService;

@Controller
public class PayController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired PayService payService;
	
	@RequestMapping(value="/pay/mybeans")
	public String mybeans(Model model) {
		logger.info("나의 빈즈 내역 요청");
		//빈즈페이 금액
		String email = "zeus@hanmail.net";  //테스트용 이메일 //테스트 끝나고 매개변수로 email받기
		int amount = payService.getMyAmount(email);
		model.addAttribute("my_amount", amount);
		//빈즈내역
		List<PayDTO> mybeansHist = payService.list();
		model.addAttribute("beans", mybeansHist);
		return "pay/myBeansPay";
	}
	
}
