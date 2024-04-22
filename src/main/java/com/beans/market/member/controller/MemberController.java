package com.beans.market.member.controller;

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
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.member.service.MemberService;

@Controller
public class MemberController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MemberService memberService;
	
	//나의 빈즈 내역 : 윤경배
	@RequestMapping(value="/mybeans")
	public String mybeans(Model model) {
		logger.info("나의 빈즈 내역 요청");
		//빈즈페이 금액
		String email = "zeus@hanmail.net"; //테스트를 위한 이메일 //테스트 끝나고는 매개변수로 email입력받음
		int amount = memberService.getMyAmount(email);
        model.addAttribute("my_amount", amount);
		//빈즈내역
		List<MemberDTO> mybeanshist = memberService.list();
		model.addAttribute("beans", mybeanshist);
		return "member/myBeansPay";
	}
	
	//로그인페이지
	@RequestMapping(value="/login.go")
	public String logingo() {
		logger.info("로그인페이지 이동");
		return "login/login";
	}
	//로그인
	@RequestMapping(value ="/login", method=RequestMethod.POST )
	public String login(HttpSession session, Model model, String email, String password) {
		logger.info("로그인 시도");
		String page = "login/login";
		String msg = "로그인에 실패하였습니다.";	
		MemberDTO loginId = memberService.login(email,password);
		String logEmail = memberService.logEmail(email,password);
		logger.info("info :"+ loginId);
	
		if(loginId!=null) {
			page="main";
			msg = "로그인 되었습니다.";
			session.setAttribute("loginfo", loginId);
			session.setAttribute("logEmail", logEmail);
			model.addAttribute("msg",msg);	
			//memberService.lastdate(email,password);
		}
		model.addAttribute("msg",msg);	
		return page;
	}	
	
	//아이디 등록 확인
	@RequestMapping(value = "/findEmail")
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
	@RequestMapping(value = "/resetPW01")
	public String resetPW01() {
		logger.info("비밀번호변경하러 접속");		
		return"login/resetPW01";
	}
	
	//새비밀번호 업데이트
	@RequestMapping(value = "/newPW")
	public String newPW(String pw) {
		logger.info("비밀번호 변경시도.");
		String page = "redirect:/";
		String msg = "다시 시도해주세요";	
		String pass = memberService.newPW(pw);				
		return"page";
	}
	
	//회원가입 페이지
	@RequestMapping(value = "/join.go")
	public String joinform() {		
		logger.info("회원가입페이지");
		return "login/join";
	}
	
	//회원가입 신청
	@RequestMapping(value="/join.do")
	public String join(Model model,@RequestParam Map<String,String>param) {
		String page = "login/join";
		String msg = "회원가입에 실패하였습니다. 다시 시도해주세요.";
		
		int row = memberService.join(param);
		if(row == 1) {
			logger.info("회원가입 입력한 값입니다."+param);
			msg = "축하합니다! 회원가입에 성공하였습니다.";
			
			model.addAttribute("msg",msg);
			page = "login/login";
		}		
		return page;
	}
	
	
	
}
