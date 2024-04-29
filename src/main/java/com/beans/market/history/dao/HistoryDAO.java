package com.beans.market.history.dao;

import java.util.Map;

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

}
