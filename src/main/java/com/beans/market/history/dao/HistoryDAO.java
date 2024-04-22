package com.beans.market.history.dao;

public interface HistoryDAO {

	int bidHistoryInsert(String email, int bid_price, int bbsIdx);

	int BidReturnHistory(String option, String content, int bbsIdx);

	int BidWithHistory(String option, String content, int bbsIdx, String email, int bid_price);

	
}
