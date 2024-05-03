package com.beans.market.history.dao;

import java.util.List;

import com.beans.market.history.dto.HistoryDTO;

public interface HistoryDAO {

	int bidHistoryInsert(String email, int bid_price, int bbsIdx);

	int BidReturnHistory(String option, String content, int bbsIdx);

	int BidWithHistory(String option, String content, int bbsIdx, String email, int bid_price);

	int myBidCheck(Integer idx, String email);

	int dealApprove(int idx, String email);

	int dealApproveCancel(int idx, String email);

	int dealApproveCheck(int idx, String email);

	void insertDealHistory(String seller, String buyer, int idx);

	int InsertDepositHistoty(int idx, String email, String option, String content);

	int comentDo(String coment, String email, int idx);

	int insertPayHistory(int idx, String email, String option, int price, String content);

	// idx 검색
	List<HistoryDTO> penaltyHistoryListIdx(int intSearchText);
	List<HistoryDTO> reportHistoryListIdx(int intSearchText);
	List<HistoryDTO> payHistoryListIdx(int intSearchText);
	List<HistoryDTO> dealAutionHistoryListIdx(int intSearchText);
	List<HistoryDTO> approveHistoryListIdx(int intSearchText);
	List<HistoryDTO> dealDetailHistoryListIdx(int intSearchText);
	List<HistoryDTO> comentHistoryListIdx(int intSearchText);
	List<HistoryDTO> alarmHistoryListIdx(int intSearchText);

	// email 검색
	List<HistoryDTO> penaltyHistoryListEmail(String searchText);
	List<HistoryDTO> reportHistoryListEmail(String searchText);
	List<HistoryDTO> payHistoryListEmail(String searchText);
	List<HistoryDTO> dealAutionHistoryListEmail(String searchText);
	List<HistoryDTO> approveHistoryListEmail(String searchText);
	List<HistoryDTO> dealDetailHistoryListEmail(String searchText);
	List<HistoryDTO> comentHistoryListEmail(String searchText);
	List<HistoryDTO> alarmHistoryListEmail(String searchText);






}
