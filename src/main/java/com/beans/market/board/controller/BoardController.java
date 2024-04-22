package com.beans.market.board.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.beans.market.board.service.BoardService;
import com.beans.market.main.service.MainService;
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.member.service.MemberService;
import com.beans.market.photo.service.PhotoService;

@Controller
public class BoardController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired BoardService boardService;
	@Autowired PhotoService photoService;
	@Autowired MemberService memberService;

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
			int mine = memberService.getInterest(idx, loginInfo.getEmail());
			model.addAttribute("mine", mine);
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
                             String subject, String content, String place,
                             String category_idx, int price, List<MultipartFile> imageFiles) {

		String email = (String) session.getAttribute("email");
        
        if (email == null) {
            return "redirect:/login";
        }
        
		// 등록날짜 설정
        LocalDateTime currentDateTime = LocalDateTime.now();
        Timestamp regDate = Timestamp.valueOf(currentDateTime);
        
        // 글쓰기 서비스 호출
        int boardIdx = boardService.writeBoard(email, subject, content, place, category_idx, price, imageFiles, regDate);
        
        // 상세보기 페이지로 이동하는 URL 생성
        String detailPageUrl = "/goodsDetail.go?idx=" + boardIdx;

        // 상세보기 페이지로 리다이렉트
        return "redirect:" + detailPageUrl;

	}
	
	
	
	// 임시저장 글로 이동
	@RequestMapping(value = "/TempSave.go")
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
        LocalDateTime specificTime = LocalDateTime.parse(close_date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
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
