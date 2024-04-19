package com.beans.market.member.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.beans.market.member.dao.MemberDAO;
import com.beans.market.member.service.MemberService;

@Controller
public class MemberController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired MemberService memberService;
	
	
	//나의 빈즈 내역 : 윤경배
	@RequestMapping(value="/mybeans")
	public String mybeans() {
		return "member/myBeansPay";
	}
	

}
