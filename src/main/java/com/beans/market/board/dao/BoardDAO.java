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
	
	int insertBoard(BoardDTO boardDTO);

	void tempdel(String idx);

	
	
	// 도혜=정언
	//int writeBoard(Map<String, String> params);

	int writeBoard(BoardDTO dto);
	void updatePrice(int priceInt, int idx);	// 판매 가격 업데이트
	void updateAuctionPrice(int start_priceInt, int immediate_priceInt, int idx); // ㄱ매 가격 업데이트
	void updateAuctionPrice2(int start_priceInt, int immediate_priceInt, int auction_period, int idx);
	// 사진 저장
	void savePhoto(int idx, String orifilename, String newfileName);	// 대표
	void savePhoto2(int idx, String orifilename, String newfileName);	// ㄴㄴ

}
