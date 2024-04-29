package com.beans.market.pay.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beans.market.board.dto.BoardDTO;
import com.beans.market.board.service.BoardService;
import com.beans.market.history.dao.HistoryDAO;
import com.beans.market.history.service.HistoryService;
import com.beans.market.pay.dao.PayDAO;
import com.beans.market.pay.dto.PayDTO;




@Service
public class PayService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired PayDAO payDAO;
	@Autowired HistoryDAO historyDAO;
	@Autowired BoardService boardService;
	@Autowired HistoryService historyService;
	
	
	public int getMyAmount(String email) {
		return payDAO.getMyAmount(email);
	}

	public List<PayDTO> list(String email) {
		return payDAO.list(email);
	}

	public void bidReturn(int bbsIdx) {
		logger.info("{}번 게시글 입찰금 환불", bbsIdx);
		// 특정 회원 페이 가격 변경
		int row = payDAO.payDeposit(bbsIdx);
		logger.info("입찰 반환 결과 : {}", row);
		// 입찰금 히스토리
		row = historyDAO.BidReturnHistory("입찰금 반환", bbsIdx+"번 게시글 입찰금 반환", bbsIdx);
		logger.info("입찰 반환 히스토리 입력 결과 : {}", row);
	}

	public void bidWithdrawal(String email, int bid_price, int bbsIdx) {
		logger.info("{}번 게시글 입찰", bbsIdx);
		int row = payDAO.payWithdrawal(email, bid_price);
		logger.info("입찰 결과 변경 row : {}", row);
		row = historyDAO.BidWithHistory("경매글 입찰", bbsIdx+"번 게시글 입찰", bbsIdx, email, bid_price);
		logger.info("입출금 내역 히스토리 row : {}", row);
	}
	public String getUsernameByEmail(String email) {
		return payDAO.getUsernameByEmail(email);
	}
	
	

	//포인트 충전
	public void updateMemberPoint(String email, int pay) {
		payDAO.updatePoint(email, pay);		
		
		// 포인트 변경 내역 기록을 위한 파라미터 준비
	    Map<String, Object> param = new HashMap<>();
	    param.put("email", email);
	    param.put("amount", pay);
	    param.put("option", "빈즈페이 충전"); // mapper에 직접 값을 넣을거면 이거 왜 넣은건가
	    param.put("content", "빈즈페이 충전 내역");

	    // 포인트 변경 내역을 pay_hist 테이블에 기록
	    payDAO.insertPayHistory(param);
		
	}

	// 낙찰 후 거래금 처리
	public void autionPaySend(String email, int idx) {
		logger.info("{} 게시물 경매 낙찰 이후 거래 성사", idx);
		// 거래금 판매자에게 전송
		int row = payDAO.transactionDeposit(email, idx);
		logger.info("경매 거래금 수령 여부 ", row);
		
		// 거래금 수신에 대해서 입출금 내역에 저장
		if(row == 1) {
			row = historyDAO.InsertDepositHistoty(idx, email, "경매금 수령", idx+"번 게시글 경매금 수령");
			logger.info("거래금 수령 내역 작성 완료 여부 ", row);			
		}
		
		// 게시물 입찰 히스토리와 구매자 입출금 내역에 낙찰이라는 내역 추가하기
		
	}

	// 금액 송금하기
	public Map<String, Object> RemittanceAjax(String email, int idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		BoardDTO bbs = boardService.getBoardInfo(idx);
		int price = bbs.getPrice();
		boolean result = false;
		
		// 구매자 금액 차감
		if (payDAO.getMyAmount(email) >= price) {
			logger.info("구매 금액 차감 " + price);
			int row = payDAO.payWithdrawal(email, price);
			
			// 히스토리 작성
			if(row == 1) {
				row = 0;
				logger.info("출금 히스토리 작성");
				row = historyService.insertPayHistory(idx, email, "거래금 지불", price, idx+"번 거래금 "+price+"원 지불");
			}
			
			// 판매자에게 금액 만큼 증가
			if(row == 1) {
				row = 0;
				logger.info("판매 금액 증가");
				row = payDAO.updatePoint(email, price);			
			}
			
			// 거래금 수령
			// 히스토리 작성
			if(row == 1) {
				logger.info("입금 히스토리 작성");
				row = historyService.insertPayHistory(idx, email, "거래금 수령", price, idx+"번 거래금 "+price+"원 수령");
			}
			
			if(row == 1) {
				result = true;
			} 
		} 
		map.put("result", result);
		return map;
	}
	
	






	


	
	


}
