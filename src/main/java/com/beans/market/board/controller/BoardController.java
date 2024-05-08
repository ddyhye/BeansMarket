package com.beans.market.board.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beans.market.board.dto.BoardDTO;
import com.beans.market.board.service.BoardService;
import com.beans.market.history.service.HistoryService;
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.member.service.MemberService;
import com.beans.market.photo.dto.PhotoDTO;
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
			
			// 판매자가 나인가
			int my_bbs = boardService.myBbsCheck(idx, email);
			// 글 올리기 수정하고 난 후*****
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
	
	// 물품 팔기 페이지 이동
	@RequestMapping(value="/board/goodsWrite.go", method = RequestMethod.GET)
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
	
	// 물풀 팔기 글쓰기
	@RequestMapping(value = "/board/goodsWrite.do", method = RequestMethod.POST)
    public String goodsWrite(HttpSession session, Model model,
                             MultipartFile[] photos,
                             @RequestParam("tempoPhotoNames[]") String[] tempoPhotoNames,
                             @RequestParam Map<String, String> params) {

		// tempoPhotoNames 확인
	    for (String name : tempoPhotoNames) {
	        logger.info(name);
	    }
	    
	    MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
	    
	    if(loginInfo != null) {
	    	String logEmail = (String) session.getAttribute("logEmail");
	    	
	    	params.put("logEmail", logEmail);
	    	
	    	int priceInt = 0;
	    	int start_priceInt = 0;
	    	int immediate_priceInt = 0;
	    	int auction_period = Integer.parseInt(params.get("auction-period"));
	    	
	    	logger.info("params: "+params);
	    	
	    	// 판매일 경우, start-price가 안들어온다.
	    	if (params.get("price") != null && !params.get("price").trim().isEmpty()) {
	    		priceInt = Integer.parseInt(params.get("price").trim());
	    	}
	    	// 경매일 경우, price가 안들어온다.
	    	if (params.get("start-price") != null && !params.get("start-price").trim().isEmpty()) {
	    		start_priceInt = Integer.parseInt(params.get("start-price").trim());
	    		immediate_priceInt = Integer.parseInt(params.get("immediate-price").trim());
	    	}
	    	
	    	// 임시저장
	    	if (params.get("draft").equals("Y") && params.get("subject") != null) {
	    		boardService.tempSave(params, priceInt, start_priceInt, immediate_priceInt, auction_period, photos);
	    	} else {
	    		boardService.writeBoard(params, loginInfo, priceInt, start_priceInt, immediate_priceInt, auction_period, photos, tempoPhotoNames);
	    	}
	    	
	    }
	    
		 
		// 해당 글 상세보기 페이지로 이동
		return "redirect:/";

	}
	
	// 물품 팔기 임시저장
	@RequestMapping(value = "/board/TempSave.ajax", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> tempSave_ajax(HttpSession session, Model model,
            								MultipartFile[] photos,
            								@RequestParam Map<String, String> params) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String logEmail = (String) session.getAttribute("logEmail");
		params.put("logEmail", logEmail);
		
		int priceInt = 0;
		int start_priceInt = 0;
		int immediate_priceInt = 0;
		int auction_period = Integer.parseInt(params.get("auction-period"));
		
		logger.info("params: "+params);
		
		
		
		if (!params.get("price").isEmpty()) {
			priceInt = Integer.parseInt(params.get("price"));
		}
		if (!params.get("start-price").isEmpty()) {
			start_priceInt = Integer.parseInt(params.get("start-price"));
		}
		if (!params.get("immediate-price").isEmpty()) {
			immediate_priceInt = Integer.parseInt(params.get("immediate-price"));
		}
		
		boardService.tempSave(params, priceInt, start_priceInt, immediate_priceInt, auction_period, photos);
		
		return map;
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
	
	// 예약으로 바꾸기
	// 예약은 판매자 용
	@RequestMapping(value = "/board/reserveToggle.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> reserveToggleAjax(HttpSession session, String reserve, String email, int idx){
		logger.info("reserve data Check {}, {} , "+idx, email, reserve);
		Map<String, Object> map = new HashMap<String, Object>();
		
		// session검사 + 현재 세션의 사람이 게시글 작성자 본인이 맞는지
		MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		String seller = boardService.getEmail(idx);
		if (loginInfo != null && seller.equals(loginInfo.getEmail())) {
			// 버튼을 누른 시점의 텍스트가 reserve 예약 OR 예약 취소
			map = boardService.reserveToggleAjax(reserve, email, idx);			
		}
		
		return map;
	}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*                도혜                  */
	// 판매자 기능 - 수정하기
	@RequestMapping(value="/board/saleOfGoodsUpdate.go")
	public String saleOfGoodsUpdate_go(String idx, Model model) {
		int idxInt = Integer.parseInt(idx);
		
		BoardDTO dto = boardService.goodsUpdate(idxInt);
		model.addAttribute("idx", dto.getIdx());
		model.addAttribute("price", dto.getPrice());
		logger.info(dto.getCategory_idx());
		model.addAttribute("category_idx", dto.getCategory_idx());
		model.addAttribute("subject", dto.getSubject());
		model.addAttribute("content", dto.getContent());
		model.addAttribute("place", dto.getPlace());
		List<PhotoDTO> list = boardService.goodsUpdatePic(idxInt);
		model.addAttribute("photoList", list);
		
		return "/board/saleOfGoodsUpdate";
	}
	// 판매자 기능 - 수정하기 완료
	@RequestMapping(value="/board/saleOfGoodsUpdate.do")
	public String saleOfGoodsUpdate_do(Model model, MultipartFile[] photos,
										@RequestParam Map<String, String> params) {
		
		int priceInt = Integer.parseInt(params.get("price"));

		boardService.goodsUpdate(Integer.parseInt(params.get("idx")), priceInt, params.get("category"), params.get("subject"), params.get("content"), params.get("place"), photos);
		
//		return boardService.goodsDetail(Integer.parseInt(params.get("idx")), model);
		return "redirect:/board/detail.go?idx="+params.get("idx");
	}
	
	// 글 작성 시, 사진 미리보기,,
	@RequestMapping(value="/board/tempoPhoto.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> tempoPhoto(@RequestParam("photos") MultipartFile[] photos) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		boardService.tempoPhoto(map, photos);
		
		return map;
	}
	// 글 작성 시, 사진 미리보기에서 사진 삭제
	@RequestMapping(value="/board/tempoPhotoDel.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> tempoPhotoDel(int pic_idx, int tempoBbsIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		boardService.tempoPhotoDel(map, pic_idx, tempoBbsIdx);
		
		return map;
	}
	// 글 작성 시, 사진 미리보기에 사진 추가하기,,
	@RequestMapping(value="/board/tempoPhotoAnother.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> tempoPhotoAnother(@RequestParam("photos") MultipartFile[] photos, int tempoBbsIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		boardService.tempoPhotoAnother(map, photos, tempoBbsIdx);
		
		return map;
	}
	
	
	// 게시글 숨김
	@RequestMapping(value="/board/saleOfGoodsHidden.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saleOfGoodsHidden(String bbsIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int idx = Integer.parseInt(bbsIdx);
		
		boardService.saleOfGoodsHidden(idx);
		
		return map;
	}
	// 게시글 삭제
	@RequestMapping(value="/board/saleOfGoodsDel.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saleOfGoodsDel(String bbsIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		logger.info(bbsIdx);
		int idx = Integer.parseInt(bbsIdx);
		//logger.info(idx);
		
		boardService.saleOfGoodsDel(idx);
		
		return map;
	}

}
