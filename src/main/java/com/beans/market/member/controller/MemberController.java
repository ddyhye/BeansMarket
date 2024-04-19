package com.beans.market.member.controller;

import java.util.HashMap;
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

import com.beans.market.board.service.BoardService;
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
	
	//로그인
	@RequestMapping(value ="login", method=RequestMethod.POST )
	public String login(HttpSession session, Model model, String email, String password) {
		logger.info("로그인 시도");
		String page = "login/login";
		String msg = "로그인에 실패하였습니다.";	
		String loginId = memberService.login(email,password);
		logger.info("login id "+ email);
		logger.info("login pw "+ password);
		
		if(loginId!=null) {
			page="redirect:/home";
			msg = "로그인 되었습니다.";
			session.setAttribute("loginId", loginId);
			model.addAttribute("msg",msg);	
		}
		model.addAttribute("msg",msg);	
		return page;
	}
	
	
	
	//아이디 등록 확인
	@RequestMapping(value = "findEmail")
	public String findemail() {
		logger.info("아이디 등록확인 접속");		
		return"login/findEmail";
	}
	
	@RequestMapping(value="/overlay.do",method =RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> overlay(String id) {
		logger.info("id"+id);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("use", memberService.overlay(id));
		
		return map;
	}
	
	//비밀번호재설정페이지
	@RequestMapping(value = "resetPW01")
	public String resetPW01() {
		logger.info("아이디 등록확인 접속");		
		return"login/resetPW01";
	}
	
	//새비밀번호 업데이트
	@RequestMapping(value = "newPW")
	public String newPW(String pw) {
		logger.info("비밀번호 변경시도.");
		String page = "redirect:/";
		String msg = "다시 시도해주세요";
		
		String pass = memberService.newPW(pw);
		
				
		return"page";
	}
	
}
