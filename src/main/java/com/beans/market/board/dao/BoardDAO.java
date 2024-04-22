package com.beans.market.board.dao;

import java.sql.Timestamp;

import com.beans.market.board.dto.BoardDTO;

public interface BoardDAO {

	int connectTest();

	void upHit(int idx);

	BoardDTO goodsDetail(int idx);

	int interestInsert(int bbsIdx, String email);

	int interestDel(int bbsIdx, String email);

	BoardDTO auctionDetail(int idx);

	void updateBbsState(String string);

	void updateCloseDate(Timestamp newCloseTimestamp);

	int bidResultUpdate(int bbsIdx, int bid_price);

}
