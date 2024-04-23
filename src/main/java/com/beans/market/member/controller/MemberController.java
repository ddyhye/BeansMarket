package com.beans.market.member.controller;

import java.io.File;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.taglibs.standard.lang.jstl.test.beans.PublicBean1;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.beans.market.member.dto.MemberDTO;
import com.beans.market.member.service.MemberService;
import com.beans.market.pay.dto.PayDTO;
import com.beans.market.photo.dto.ProfilePicDTO;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class MemberController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MemberService memberService;
	

	
	//로그인페이지
	@RequestMapping(value="/member/login.go")
	public String logingo() {
		logger.info("로그인페이지 이동");
		return "/login/login";
	}
	//로그인
	@RequestMapping(value ="member/login.do", method=RequestMethod.POST)
	public String login(HttpSession session, Model model, String email, String password) {
	    logger.info("로그인 시도");
	    String page = "login/login";
	    String msg = "로그인에 실패하였습니다.";   
	    MemberDTO loginInfo = memberService.login(email,password);
		String logEmail = memberService.logEmail(email,password);
		logger.info("info: {}", loginInfo);

	    if(loginInfo != null) {
	        page = "redirect:/";
	        msg = "로그인 되었습니다.";
	        session.setAttribute("loginInfo", loginInfo);
			session.setAttribute("logEmail", logEmail);
	        //model.addAttribute("msg", msg);
			//memberService.lastdate(email,password);
	        // 로그인 성공 시 마지막 로그인 날짜 업데이트 메서드 호출
	        Map<String, Object> params = new HashMap<>();
	        params.put("email", email);
	        params.put("lastLoginDate", LocalDateTime.now());
	        memberService.updateLastLoginDate(params);
	    }
	    // model.addAttribute("msg", msg);
	    return page;
	}    
	
	//아이디 등록 확인
	@RequestMapping(value = "/member/findEmail.go")
	public String findemail() {
		logger.info("아이디 등록확인 접속");		
		return"login/findEmail";
	}
	
	//중복체크 
	@RequestMapping(value="/member/overlay.do",method =RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> overlay(String id) {
		logger.info("id"+id);		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("use", memberService.overlay(id));	
		return map;
	}
	
	//비밀번호재설정페이지
	@RequestMapping(value = "/member/resetPW01.go")
	public String resetPW01() {
		logger.info("비밀번호변경하러 접속");		
		return"login/resetPW01";
	}
	
	//회원가입 페이지
	@RequestMapping(value = "/member/join.go")
	public String joinform() {		
		logger.info("회원가입페이지");
		return "login/join";
	}

	
	//비밀번호 재설정하기.
	@PostMapping("/member/updatepw.do")
	@ResponseBody
	public void updatePassword(@RequestParam("email") String email,@RequestParam("password") String password) {
	    
	    logger.info("email: " + email);
	    logger.info("password: " + password);
	    memberService.newPW(email, password);
	   
	}
	
	//회원가입
	@RequestMapping(value="member/join.do")
	public String join(Model model, @RequestParam Map<String,String> param, @RequestParam("file") CommonsMultipartFile file) {
	    String page = "login/join";
	    String msg = "회원가입에 실패하였습니다. 다시 시도해주세요.";

	    // 파일을 저장할 경로 설정
	    String uploadDir = "c:/img";

	    try {
	        // 업로드된 파일이 있는지 확인하고 파일을 저장
	        if (!file.isEmpty()) {
	            String fileName = StringUtils.cleanPath(file.getOriginalFilename());
	            String filePath = uploadDir + fileName;
	            File dest = new File(filePath);
	            file.transferTo(dest); // 파일을 저장

	            // 파일 경로를 파라미터에 추가
	            param.put("filePath", filePath);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    int row = memberService.join(param);
	    if(row == 1) {
	        logger.info("회원가입 입력한 값입니다."+param);
	        msg = "축하합니다! 회원가입에 성공하였습니다.";

	        // 파일 이름 추출
	        String fileName = file.getOriginalFilename();
	        String email = param.get("email");

	        // 프로필 사진 저장을 위한 맵 생성
	        Map<String, Object> profileParam = new HashMap<>();
	        profileParam.put("email", email);
	        profileParam.put("newFilename", fileName);

	        // 프로필 사진 저장
	        memberService.saveProfilePic(profileParam);

	        model.addAttribute("msg",msg);
	        page = "login/login";
	    }       
	    return page;
	}
	
	//회원가입 이메일 중복체크
	@RequestMapping(value="/member/joinoverlay.do", method=RequestMethod.POST) // overlay.do에서 joinoverlay.do로 수정
	@ResponseBody
	public Map<String, Object> joinoverlay(@RequestParam("email") String email) {
	    logger.info("email: " + email);      
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("use", memberService.joinoverlay(email));  
	    return map;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*             마이페이지              */
	
	// 마이페이지 - 프로필 업데이트
	@RequestMapping(value="/member/profileUpdate.go")
	public String profileUpdate_go(HttpSession session, Model model) {
		logger.info("프로필 수정 페이지...");
		
		String page = "redirect:/";
		
		if (session.getAttribute("logEmail") != null) {
			String logEmail = (String) session.getAttribute("logEmail");
			page = "/member/profileUpdate";
			MemberDTO dto = memberService.profileGet(logEmail);
			ProfilePicDTO dtoPic = memberService.profilePicGet(logEmail);
			
			model.addAttribute("photo", dtoPic.getNew_filename());
			model.addAttribute("name", dto.getName());
			model.addAttribute("email", dto.getEmail());
			model.addAttribute("location", dto.getLocation());
			model.addAttribute("birth_date", dto.getBirth_date());
			model.addAttribute("gender", dto.getGender());
		} else {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다...");
		}
		
		return page;
	}
	
	@RequestMapping(value="/member/profileUpdate.do")
	public String profileUpdate_do(HttpSession session, Model model) {
		logger.info("프로필 수정 완료...");
		
		String page = "redirect:/";
		
		if (session.getAttribute("logEmail") != null) {
			page = "/member/profileUpdate";
		} else {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다...");
		}
		
		return page;
	}
	
	
	
	
}
