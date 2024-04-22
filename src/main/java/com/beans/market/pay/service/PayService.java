package com.beans.market.pay.service;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beans.market.history.dao.HistoryDAO;
import com.beans.market.pay.dao.PayDAO;
import com.beans.market.pay.dto.PayDTO;

@Service
public class PayService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired PayDAO payDAO;
	@Autowired HistoryDAO historyDAO;
	
	public int getMyAmount(String email) {
		return payDAO.getMyAmount(email);
	}

	public List<PayDTO> list() {
		return payDAO.list();
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

}
