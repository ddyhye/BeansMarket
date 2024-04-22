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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beans.market.board.dto.BoardDTO;
import com.beans.market.board.service.BoardService;
import com.beans.market.main.dao.MainDAO;
import com.beans.market.main.dto.MainDTO;
import com.beans.market.main.service.MainService;
import com.beans.market.photo.dto.PhotoDTO;

@Controller
public class MainController {
	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired MainService mainService;
	@Autowired BoardService boardService;
	
	@RequestMapping(value="/")
	public String main(Model model) {
		logger.info("메인 페이지...");
		
		mainService.goodsList(model); 	/* css 테스트용 */
		
		return "main";
	}
	
	
	// 로그아웃
	
	
	
	// 리스트 출력
	@RequestMapping(value="/list.ajax")
	@ResponseBody
	public Map<String, Object> listAjax(HttpSession session, String selectedSort, String sellOptionChk, String AuctionOptionChk){
		Map<String, Object> map = new HashMap<String, Object>();
		
		String logEmail = "";
		if (session.getAttribute("logEmail") != null) {
			logEmail = (String) session.getAttribute("logEmail");
		}
		boolean isSell = sellOptionChk.equals("true")? true : false;
		boolean isAuction = AuctionOptionChk.equals("true")? true : false;
		
		mainService.goodsListAjax(map, logEmail, selectedSort, isSell, isAuction);
		
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
	public String myPage_go(HttpSession session, Model model) {
		logger.info("마이페이지...");
		String page = "main";
		
		if (session.getAttribute("logEmail") != null) {
			page = "/member/profile";
		} else {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다...");
		}
		
		return page;
	}
	
	// 관심 목록 페이지 이동
	@RequestMapping(value = "/member/minePage.go")
	public String minePage_go(HttpSession session, Model model) {
		logger.info("관심 목록 페이지...");
		
		String page = "main";
		
		if (session.getAttribute("logEmail") != null) {
			page = "/member/mine";
		} else {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다...");
		}
		
		return page;
	}

	// 물품 팔기 페이지 이동
	@RequestMapping(value="/board/sellWrite.go")
	public String goodsWrite_go() {
		logger.info("게시글 작성 페이지...");
		return "board/saleOfGoodsWrite";
	}

}
