package com.beans.market.board.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.beans.market.board.dao.BoardDAO;
import com.beans.market.board.dto.BoardDTO;
import com.beans.market.history.dao.HistoryDAO;
import com.beans.market.member.dao.MemberDAO;
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.member.dto.SellerDTO;
import com.beans.market.pay.service.PayService;
import com.beans.market.photo.dao.PhotoDAO;
import com.beans.market.photo.dto.ProfilePicDTO;


@Service
public class BoardService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired BoardDAO boardDAO;
	@Autowired PhotoDAO photoDAO;
	@Autowired MemberDAO memberDAO;
	@Autowired HistoryDAO historyDAO;
	@Autowired PayService payService;

	public String goodsDetail(int idx, Model model) {
		String page = "board/saleOfGoodsDetail";
		BoardDTO dto = boardDAO.goodsDetail(idx);
		
		if(dto == null) return "redirect:/";

		if(dto.getOption().equals("경매")) {
			page = "board/auctionOfGoodsDetail";
			dto = boardDAO.auctionDetail(idx);
		}

		// 조회수 증가
		boardDAO.upHit(idx); // upHit
		
		// 게시글 출력
		model.addAttribute("bbs", dto);
        logger.info("{} 게시물 정보  {}", idx, dto);
		
        // logger.info("게시 시간 : {}", dto.getReg_date());
		// reg_date가 .0이 붙어서 나오는 관계로 포멧 작업
        // SimpleDateFormat을 사용하여 날짜 형식 지정 -> dateFormat으로 날짜 포맷
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = dateFormat.format(dto.getReg_date());
		model.addAttribute("reg_date",formattedDateTime);
		
		if(dto.getOption().equals("경매")) {
			formattedDateTime = dateFormat.format(dto.getClose_date());
			model.addAttribute("close_date",formattedDateTime);			
		}
		
        // 판매자 정보 - 이름, 거래 후기
		SellerDTO sellerInfo = memberDAO.sellerInfo(dto.getEmail());
		// logger.info("판매자 닉네임 : {}", sellerInfo);
		model.addAttribute("sellerInfo", sellerInfo);
		
        // 판매자 프로필 사진
        ProfilePicDTO sellerPic = photoDAO.profile(dto.getEmail());
        model.addAttribute("sellerPic", sellerPic);
        
        logger.info(page);
        
		return page;  
	}

	public String interestToggle(String email, String className, int bbsIdx) {
		String result = "실패";
		int row = 0;
		if(className.equals("fa-solid fa-heart")) {
			row = boardDAO.interestInsert(bbsIdx, email);
			if(row == 1) {
				result = "추가";
			}
		} else {
			row = boardDAO.interestDel(bbsIdx, email);
			if(row == 1) {
				result = "삭제";				
			}
		}
		
		return result;
	}

	public int biddingAjax(MemberDTO loginInfo, int bid_price, int bbsIdx) {
		int result = 5; // 5는 시스템 에러
		String email = loginInfo.getEmail();
		
		// 게시글 정보 가져오기
		BoardDTO bbsInfo = boardDAO.auctionDetail(bbsIdx);
		
		// 회원의 현재 포인트 가져오기
		int nowPoint = memberDAO.nowPoint(email);
		logger.info("bbsInfo : {}, nowPoint : {}", bbsInfo, nowPoint);

		// 현재 시간 가져오기
		LocalDateTime currentTime = LocalDateTime.now();
	    // 종료시간 설정하기
	    LocalDateTime closeTime = LocalDateTime.parse(bbsInfo.getClose_date().toString(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.0"));
	    long remaingTime = ChronoUnit.SECONDS.between(currentTime, closeTime);
	    logger.info("현재시간 : {}, colseDate : {}", currentTime, closeTime);
	    logger.info("남은 시간 : {}", remaingTime);

		// 거래가능인거만 입찰 가능하도록 + 남은 시간이 있는 경우
		if (bbsInfo.getBbs_state().equals("거래가능") && remaingTime > 0) { // 거래가능 상태이고, 남은 시간이 종료되지 않았는가
			// bid_price와 비교 + 현재 내 페이 가격 가져오기 비교후 처리
			if ((bbsInfo.getPrice() > bid_price) || (bid_price == bbsInfo.getPrice() && bbsInfo.getBid_count() != 0)) { // 입찰금이 현재입찰가 보다 높은가
				result = 2;
			} else if (bid_price > nowPoint) { // 현재 자신 포인트보다 입찰가 보다 높은가
				result = 3;
			} else if (bid_price%1000 > 0) { // 1000단위 입찰을 하였는가
				result = 4;
			} else {
				if(bbsInfo.getSuccessful_bid() == bid_price) { // 즉시 구매시
					// 예약중으로, 종료시간을 현재시간으로
					// boardDAO.updateBbsState("예약중");
					// boardDAO.updateCloseDate(currentTime);
					
				} else {
					// 남은 시간이 5분 이하라면 10분이 추가 된다.
					if(remaingTime <= 300) {
						LocalDateTime newCloseTime = closeTime.plusMinutes(10);
						Timestamp newCloseTimestamp = Timestamp.valueOf(newCloseTime);
						logger.info("새로운 시간 : {}", newCloseTimestamp);
						
						// boardDAO.updateCloseDate(newCloseTimestamp);
					} 
					if(bbsInfo.getBid_count() != 0) {
						// 이전 입찰자에게 반환과정 필요
						
						// 이전 입찰 내역 가져오기 입찰 히스토리 DTO
						
						// 그 회원에게 금액 만큼 반환
						
						// 입출금 히스토리 추가
						
					}					
				}
				// 입찰 히스토리에 추가
				int bidHisResult = historyDAO.bidHistoryInsert(email, bid_price, bbsIdx);
				
				// 게시물 가격, 입찰횟수 변경
				int bbsResult = boardDAO.bidResultUpdate(bbsIdx, bid_price);
				
				// 입찰금 차감하고 입출금 히스토리 남기기
				// int payChange = payService.bidPayChange(email, bid_price);
				logger.info("history {}, bbsResult {}", bidHisResult, bbsResult);
				
				if(bidHisResult == 1 && bbsResult == 2) result = 1;
				
				// 알림은 나중에
				
				// 추가 되고 동시에 게시글 정보가 다시 들어가게 -> 귀찮으니까 입찰 성공했을 때 X or 확인을 누르면 새로고침 되도록
			}
			
		} // 거래 가능하고 남은시간 종료된거 END
		
		return result;
	}

	

}
