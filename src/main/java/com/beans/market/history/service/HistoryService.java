package com.beans.market.history.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beans.market.history.dao.HistoryDAO;
import com.beans.market.history.dto.HistoryDTO;

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

	public int insertPayHistory(int idx, String email, String option, int price, String content) {
		logger.info("내용 : {}, 이메일 : {}, 인덱스 : "+idx, content, email);
		logger.info("구분 : {}, 가격 : {}", option, price);
		return historyDAO.insertPayHistory(idx, email, option, price, content);
	}

	public Map<String, Object> historyList(String searchText, String option) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<HistoryDTO> list = new ArrayList<HistoryDTO>();
		boolean result = false;
		
		int intSearchText = -1;
		if (!searchText.contains("@")) {
			// @가 없다면 번호로 검색
			try { // 숫자가 아니면 0으로
				intSearchText = searchText.equals("") ? 0 : Integer.parseInt(searchText); // 숫자가 아닐때라고 유효성 검사를 주는게 좋아보임
			} catch (Exception e) {
				intSearchText = 0;
			}
		} 
		
		if (intSearchText != -1) { // 번호 검색
			switch (option) {
			case "member_penalty":
				list = historyDAO.penaltyHistoryListIdx(intSearchText);
				break;
			case "report_hist":
				list = historyDAO.reportHistoryListIdx(intSearchText);
				break;
			case "pay_hist":
				list = historyDAO.payHistoryListIdx(intSearchText);
				break;
			case "deal_aution_hist":
				list = historyDAO.dealAutionHistoryListIdx(intSearchText);
				break;
			case "deal_approv_hist":
				list = historyDAO.approveHistoryListIdx(intSearchText);
				break;
			case "deal_detail":
				list = historyDAO.dealDetailHistoryListIdx(intSearchText);
				break;
			case "deal_coment":
				list = historyDAO.comentHistoryListIdx(intSearchText);
				break;
			case "alarm":
				list = historyDAO.alarmHistoryListIdx(intSearchText);
				break;
			default:
				break;
			}
		} else { // 이메일 검색
			switch (option) {
			case "member_penalty":
				list = historyDAO.penaltyHistoryListEmail(searchText);
				break;
			case "report_hist":
				list = historyDAO.reportHistoryListEmail(searchText);
				break;
			case "pay_hist":
				list = historyDAO.payHistoryListEmail(searchText);
				break;
			case "deal_aution_hist":
				list = historyDAO.dealAutionHistoryListEmail(searchText);
				break;
			case "deal_approv_hist":
				list = historyDAO.approveHistoryListEmail(searchText);
				break;
			case "deal_detail":
				list = historyDAO.dealDetailHistoryListEmail(searchText);
				break;
			case "deal_coment":
				list = historyDAO.comentHistoryListEmail(searchText);
				break;
			case "alarm":
				list = historyDAO.alarmHistoryListEmail(searchText);
				break;
			default:
				break;
			}
		}
		
		if (list != null) {
			result = true;
		}
		
		map.put("list", list);
		map.put("result", result);
		
		return map;
	}
	
}
