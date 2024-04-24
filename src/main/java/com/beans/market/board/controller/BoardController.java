package com.beans.market.board.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.beans.market.board.service.BoardService;
import com.beans.market.history.service.HistoryService;
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.member.service.MemberService;
import com.beans.market.photo.service.PhotoService;

@Controller
public class BoardController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired BoardService boardService;
	@Autowired PhotoService photoService;
	@Autowired MemberService memberService;
	@Autowired HistoryService historyService;

	// 게시글로 이동
	@RequestMapping(value="/board/detail.go", method = RequestMethod.GET)
	public String boardDetailGo(HttpSession session, Model model, Integer idx) {
		logger.info("{} 디테일로 이동", idx);
		int option_idx = 1; // 게시글이라는 의미
		String page = "redirect:/";
		if(idx != null) {
			page = boardService.goodsDetail(idx, model);
			photoService.boardPhoto(idx, model, option_idx);						
		}
		
		if (session.getAttribute("loginInfo") != null) {
			MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
			String email = loginInfo.getEmail();
			// 관심 목록에 있는가
			int mine = memberService.getInterest(idx, email);
			model.addAttribute("mine", mine);
			
			// 최고 입찰자가 나인가
			int my_bid = historyService.myBidCheck(idx, email);
			model.addAttribute("my_bid", my_bid);
		}	
		
		return page;
	}
	
	// 게시글 정보 새로 받아오기
	@RequestMapping(value = "/board/detail.ajax", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> detailAjax(String idx){
		logger.info("detail idx ajax : {}", idx);
		return boardService.detailAjax(idx);
	}
	
	// 관심 목록 추가 및 삭제
	@RequestMapping(value = "/board/interest.ajax", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> interestToggle(HttpSession session, String className, String bbsIdx){
		logger.info("interestToggle.do className : {}, bbsIdx : {}", className, bbsIdx);
		Map<String, Object> map = new HashMap<String, Object>();
		MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		String result = boardService.interestToggle(loginInfo.getEmail(), className, Integer.parseInt(bbsIdx));
		map.put("result", result);
		return map;
	}
	
	
	// 물품 팔기 페이지로 이동
	@RequestMapping(value = "/board/goodsWrite.go", method = RequestMethod.GET)
	public String goodsWrite() {
		logger.info("물품 팔기 페이지...");
		
		return "board/saleOfGoodsWrite";
	}
	
	
	// 물풀 팔기 글쓰기
	@RequestMapping(value = "/board/goodsWrite.do", method = RequestMethod.POST)
    public String goodsWrite(HttpSession session, Model model,
                             MultipartFile[] photos,
                             @RequestParam Map<String, String> params) {

		String logEmail = (String) session.getAttribute("logEmail");
		
		params.put("logEmail", logEmail);
		
		int priceInt = 0;
		int start_priceInt = 0;
		int immediate_priceInt = 0;
		int auction_period = Integer.parseInt(params.get("auction-period"));
		
		logger.info("params: "+params);
		
		
		// 판매일 경우, start-price가 안들어온다.
		if (params.get("start_priceInt") == null || params.get("immediate-price") == null) {
			priceInt = Integer.parseInt(params.get("price"));
		}
		// 경매일 경우, price가 안들어온다.
		if (params.get("price") == null) {
			start_priceInt = Integer.parseInt(params.get("start-price"));
			immediate_priceInt = Integer.parseInt(params.get("immediate-price"));
		}
		
		// 임시저장
		if (params.get("draft").equals("Y") && params.get("subject") != null) {
			boardService.tempSave(params, priceInt, start_priceInt, immediate_priceInt, auction_period, photos);
		} else {
			boardService.writeBoard2(params, priceInt, start_priceInt, immediate_priceInt, auction_period, photos);	
		}
		
		
		
		// 해당 글 상세보기 페이지로 이동
		return "board/saleOfGoodsWrite";

	}
	
	
	
	// 임시저장 글로 이동
	@RequestMapping(value = "/board/TempSave.go")
	public String tempSave() {
		return "board/TempSave";
	}
	
	
	// 임시저장 글 삭제
	@RequestMapping(value = "tempdel")
	public String tempdel(HttpSession session, String idx) {
		String page = "redirect:/";
		logger.info("삭제 ID : "+idx);
		boardService.tempdel(idx);
		
		return page;
	}
	

	// 남은 시간 변경 AJAX
	@RequestMapping(value = "/board/remaingTime.ajax", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> remaingTime(String close_date){
		// logger.info("remaingTime.do close_date : {}", close_date);
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 현재 시간 가져오기
		LocalDateTime currentTime = LocalDateTime.now();
        // 비교할 특정 시간 설정하기
        LocalDateTime specificTime = LocalDateTime.parse(close_date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.0"));
        // logger.info("{}, {} : ", currentTime, specificTime);

        // 현재 시간과 특정 시간 사이의 차이 계산하기
        long remaingTime = ChronoUnit.SECONDS.between(currentTime, specificTime);
        // logger.info("남은 시간 : {}", remaingTime);

		map.put("remaingTime", remaingTime);
		return map;
	}	
	
	@RequestMapping(value = "/board/bidding.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> biddingAjax(HttpSession session, String bid_price, String bbsIdx){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		logger.info("{} 님이 {} 번 게시물 입찰 시도", loginInfo.getEmail(), bbsIdx);
		
		// 자기 게시물 입찰 불가
		if(loginInfo.getEmail().equals(boardService.getEmail(Integer.parseInt(bbsIdx)))) {
			map.put("result", false);
			map.put("content", "자기 게시물에는 입찰할 수 없습니다.");
			return map;
		}
		
		int result = boardService.biddingAjax(loginInfo, Integer.parseInt(bid_price), Integer.parseInt(bbsIdx));
		String content = "";
		
		if (result == 1) {
			map.put("result", true);
			content = "'마이페이지 > 경매 > 나의 입찰' 을 확인해주세요.";
		} else if(result == 2) {
			content = "누군가 당신보다 먼저 입찰하였습니다.";
		} else if(result == 3) {
			content = "빈즈페이 잔액이 부족합니다.";
		} else if(result == 4) {
			content = "1,000 단위로 입력해주세요.";
		} else {
			content = "시스템 오류, 다시 시도해 주세요.";
		}
		
		if (result != 1) map.put("result", false);
		map.put("content", content);
		
		return map;
	}

}
