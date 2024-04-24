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
	
	
}
