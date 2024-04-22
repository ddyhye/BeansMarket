package com.beans.market.history.dao;

public interface HistoryDAO {

	int bidHistoryInsert(String email, int bid_price, int bbsIdx);

}
