package com.beans.market.board.dao;

import java.util.Map;

import com.beans.market.board.dto.BoardDTO;

public interface BoardDAO {

	int connectTest();

	void upHit(int idx);

	BoardDTO goodsDetail(int idx);

	int interestInsert(int bbsIdx, String email);

	int interestDel(int bbsIdx, String email);

	BoardDTO auctionDetail(int idx);

}
