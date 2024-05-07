package com.beans.market.main.controller;

import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beans.market.board.dto.BoardDTO;
import com.beans.market.board.service.BoardService;
import com.beans.market.main.dao.MainDAO;
import com.beans.market.main.dto.MainDTO;
import com.beans.market.main.service.MainService;
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.photo.dto.PhotoDTO;
import com.beans.market.photo.dto.ProfilePicDTO;

@Controller
public class MainController {
	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired MainService mainService;
	@Autowired BoardService boardService;
	
	@RequestMapping(value="/")
	public String main(Model model, @RequestParam(value="msg", required=false) String msg) {
		logger.info("메인 페이지...");
		
		//mainService.goodsList(model); 	/* css 테스트용 */
		
		if (msg != null && !msg.isEmpty()) {
			model.addAttribute("msg", msg);
		}
		
		return "main";
	}
	
	
	// 로그인 중인지 판별
	@RequestMapping(value="/loggedIn.ajax")
	@ResponseBody
	public Map<String, Object> loggedIn(HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		if (session.getAttribute("logEmail") != null) {
			map.put("logged", "on");
		} else {
			map.put("logged", "off");
		}
	
		return map;
	}	
	// 로그아웃
	@RequestMapping(value="/logout.ajax")
	@ResponseBody
	public Map<String, Object> logout(HttpSession session){
		Map<String, Object> map = new HashMap<String, Object>();
		
		/*
		 * session.setAttribute("loginInfo", loginInfo);
		 * session.setAttribute("logEmail", logEmail);
		 */
		session.removeAttribute("loginInfo");
		session.removeAttribute("logEmail");
	
		return map;
	}
	
	
	
	// 리스트 출력
	@RequestMapping(value="/list.ajax")
	@ResponseBody
	public Map<String, Object> listAjax(HttpSession session, String selectedSort, String sellOptionChk, String AuctionOptionChk, String currPage){
		Map<String, Object> map = new HashMap<String, Object>();
		
		String logEmail = "";
		if (session.getAttribute("logEmail") != null) {
			logEmail = (String) session.getAttribute("logEmail");
		}
		
		logger.info(selectedSort+" "+sellOptionChk+" "+AuctionOptionChk+" "+currPage);
		
		int currentPage = Integer.parseInt(currPage);
		boolean isSell = sellOptionChk.equals("true")? true : false;
		boolean isAuction = AuctionOptionChk.equals("true")? true : false;
		
		mainService.goodsListAjax(map, logEmail, selectedSort, isSell, isAuction, currentPage);
		
		return map;
	}
	
	// 게시글 관심 등록삭제
	@RequestMapping(value="/clickHeart.ajax")
	@ResponseBody
	public Map<String, Object> clickHeart(HttpSession session, String idx, String isToggled) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int idxInt = Integer.parseInt(idx);
		
		if (session.getAttribute("logEmail") != null) {
			String logEmail = (String) session.getAttribute("logEmail");
			if (isToggled.equals("true")) {
				mainService.goodsHeartAjax(idxInt, logEmail);
				map.put("msg", "내꺼 ❤에 추가했습니다.");
			} else {
				mainService.goodsDeleteHeartAjax(idxInt, logEmail);
				map.put("msg", "내꺼 ❤에서 삭제했습니다.");
			}
		} else {
			map.put("msg", "로그인이 필요한 서비스 입니다...");
		}
		
		return map;
	}
	
	// 게시글 제목 검색
	@RequestMapping(value="/bbsSearch.ajax")
	@ResponseBody
	public Map<String, Object> bbsSearch(HttpSession session, String textVal) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String logEmail = "";
		if (session.getAttribute("logEmail") != null) {
			logEmail = (String) session.getAttribute("logEmail");
		}
		
		mainService.bbsSearch(map, textVal, logEmail);
		
		return map;
	}
	
	// 카테고리 선택
	@RequestMapping(value="/bbsCategorySearch.ajax")
	@ResponseBody
	public Map<String, Object> bbsCategorySearch(HttpSession session, String textVal) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String logEmail = "";
		if (session.getAttribute("logEmail") != null) {
			logEmail = (String) session.getAttribute("logEmail");
		}
		mainService.bbsCategorySearch(map, textVal, logEmail);
		
		return map;
	}
	
	// 알림
	@RequestMapping(value="/newAlarm.ajax")
	@ResponseBody
	public Map<String, Object> newAlarm(HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String logEmail = "";
		if (session.getAttribute("logEmail") != null) {
			logEmail = (String) session.getAttribute("logEmail");
			int newCnt = mainService.newAlarm(logEmail);
			// 로그인 되어있을 때, 안 읽은 알람의 개수 확인
			if (newCnt > 0) {
				map.put("newCnt", newCnt);
			}
		}
		
		return map;
	}
	@RequestMapping(value="/alarm.ajax")
	@ResponseBody
	public Map<String, Object> alarm(HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String logEmail = "";
		if (session.getAttribute("logEmail") != null) {
			logEmail = (String) session.getAttribute("logEmail");
		}
		
		List<MainDTO> list = mainService.alarm(logEmail);
		
		map.put("list", list);
		
		return map;
	}
	@RequestMapping(value="/alarmRead.ajax")
	@ResponseBody
	public Map<String, Object> alarmRead(HttpSession session, String idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int idxInt = Integer.parseInt(idx);
		
		String logEmail = "";
		if (session.getAttribute("logEmail") != null) {
			logEmail = (String) session.getAttribute("logEmail");
		}
		
		mainService.alarmRead(idxInt);
		// 링크가 있다면 링크 이동
		String urlStr = mainService.alarmReadUrl(idxInt);
		
		if (mainService.alarmReadUrl(idxInt) != null) {
			map.put("link", urlStr);
			// 알림 전송 시, 링크도 넣어야 함!
		}
		
		List<MainDTO> list = mainService.alarm(logEmail);
		
		map.put("list", list);
		
		return map;
	}
	
	
	// 최근 본 물품
	@RequestMapping(value="/recentBBS.ajax")
	@ResponseBody
	public Map<String, Object> recentBBS(@RequestParam(value="currLookArr[]") List<String> currLookArr, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String logEmail = "";
		if (session.getAttribute("logEmail") != null) {
			logEmail = (String) session.getAttribute("logEmail");
		}
		
		mainService.recentBBS(map, currLookArr, logEmail);
		
		return map;
	}
	
	
	
	
	
	/* 이동 */
	// 마이페이지 이동
	@RequestMapping(value="/member/myPage.go")
	public String myPage_go(HttpSession session, Model model, RedirectAttributes redirectAttrs) {
		logger.info("마이페이지...");
		String page = "redirect:/";
		
		if (session.getAttribute("logEmail") != null) {
			page = "/member/profile";
			String logEmail = (String) session.getAttribute("logEmail");
			logger.info(logEmail);
			MemberDTO dto = mainService.profile(logEmail);
			ProfilePicDTO dtoPic = mainService.profilePic(logEmail);
			logger.info(dtoPic.getNew_filename());
			model.addAttribute("photo", dtoPic.getNew_filename());
			model.addAttribute("name", dto.getName());
			model.addAttribute("posiCnt", dto.getPosiCnt());
			model.addAttribute("negaCnt", dto.getNegaCnt());
			model.addAttribute("email", dto.getEmail());
			model.addAttribute("location", dto.getLocation());
			model.addAttribute("birth_date", dto.getBirth_date());
			model.addAttribute("gender", dto.getGender());
			model.addAttribute("point", dto.getPoint());
		} else {
			redirectAttrs.addFlashAttribute("msg", "로그인이 필요한 서비스 입니다...");
		}
		
		return page;
	}
	
	// 관심 목록 페이지 이동
	@RequestMapping(value = "/member/minePage.go")
	public String minePage_go(HttpSession session, Model model, RedirectAttributes redirectAttrs) {
		logger.info("관심 목록 페이지...");
		
		String page = "redirect:/";
		
		if (session.getAttribute("logEmail") != null) {
			String logEmail = (String) session.getAttribute("logEmail");
			String name = mainService.nicname(logEmail);
			model.addAttribute("name", name);
			
			page = "/member/mine";
		} else {
			redirectAttrs.addFlashAttribute("msg", "로그인이 필요한 서비스 입니다...");
		}
		
		return page;
	}

	// 물품 팔기 페이지 이동
	@RequestMapping(value="/board/goodsWrite.go")
	public String goodsWrite_go(HttpSession session, Model model, RedirectAttributes redirectAttrs) {
		logger.info("게시글 작성 페이지...");
		
		String page = "redirect:/";
		
		if (session.getAttribute("logEmail") != null) {
			page = "/board/saleOfGoodsWrite";
		} else {
			redirectAttrs.addFlashAttribute("msg", "로그인이 필요한 서비스 입니다...");
		}
		
		return page;
	}
	
	// 1:1 문의하기 페이지 이동
	@RequestMapping(value="/customerService/inquire.go")
	public String inquire_go() {
		return "/customerService/inquire";
	}
	// 1:1 문의하기 작성 페이지 이동
	@RequestMapping(value="/customerService/inquireWrite.go")
	public String inquireWrite_go() {
		return "/customerService/inquireWrite";
	}
	// 1:1 문의하기 사진,,
	// 글 작성 시, 사진 미리보기,,
	@RequestMapping(value="/customerService/tempoPhoto.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> tempoPhoto(@RequestParam("photos") MultipartFile[] photos) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		mainService.tempoPhoto(map, photos);
		
		return map;
	}
	// 글 작성 시, 사진 미리보기에서 사진 삭제
	@RequestMapping(value="/customerService/tempoPhotoDel.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> tempoPhotoDel(int pic_idx, int tempoBbsIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		mainService.tempoPhotoDel(map, pic_idx, tempoBbsIdx);
		
		return map;
	}
	// 글 작성 시, 사진 미리보기에 사진 추가하기,,
	@RequestMapping(value="/customerService/tempoPhotoAnother.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> tempoPhotoAnother(@RequestParam("photos") MultipartFile[] photos, int tempoBbsIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		mainService.tempoPhotoAnother(map, photos, tempoBbsIdx);
		
		return map;
	}
	
	// 1:1 문의하기 작성
	@RequestMapping(value = "/customerService/inquireWrite.do", method = RequestMethod.POST)
    public String goodsWrite(HttpSession session, Model model,
                             MultipartFile[] photos,
                             @RequestParam("tempoPhotoNames[]") String[] tempoPhotoNames,
                             @RequestParam Map<String, String> params) {
		
		if (session.getAttribute("logEmail") != null) {
			String logEmail = (String) session.getAttribute("logEmail");
			params.put("logEmail", logEmail);
		} else {
			params.put("logEmail", "비회원");
		}
		
		logger.info("params: "+params);
		
		mainService.writeInquire(params, photos, tempoPhotoNames);
		
		 
		// 해당 글 상세보기 페이지로 이동
		return "redirect:/";

	}

}
