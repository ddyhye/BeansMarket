package com.beans.market.history.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beans.market.history.dao.HistoryDAO;

@Service
public class HistoryService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired HistoryDAO historyDAO;
	
	public int myBidCheck(Integer idx, String email) {
		logger.info("{}이 {} 게시글의 최고 입찰자인지 확인", email, idx);
		int result = historyDAO.myBidCheck(idx, email);
		return result;
	}
	
	public int dealApprove(int idx, String email) {
		logger.info("{}이 {} 게시글 거래 승인", email, idx);
		int result = historyDAO.dealApprove(idx, email);
		return result;
	}

	public int dealApproveCancel(int idx, String email) {
		logger.info("{}이 {} 게시글 거래 승인 취소", email, idx);
		int result = historyDAO.dealApproveCancel(idx, email);
		return result;
	}

	public int dealApproveCheck(int idx, String email) {
		logger.info("{}이 {} 게시글 상대방 승인 여부 확인", email, idx);
		int result = historyDAO.dealApproveCheck(idx, email);
		return result;
	}

	public void insertDealHistory(String seller, String buyer, int idx) {
		logger.info("판매자 : {}, 구매자 : {}, 인덱스 : "+idx, seller, buyer);
		historyDAO.insertDealHistory(seller, buyer, idx);
	}

	public int comentDo(String coment, String email, int idx) {
		logger.info("내용 : {}, 이메일 : {}, 인덱스 : "+idx, coment, email);
		return historyDAO.comentDo(coment, email, idx);
	}
	
}
