package com.beans.market.board.dao;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.beans.market.board.dto.BoardDTO;

public interface BoardDAO {

	int connectTest();

	void upHit(int idx);

	BoardDTO goodsDetail(int idx);

	int interestInsert(int bbsIdx, String email);

	int interestDel(int bbsIdx, String email);

	BoardDTO auctionDetail(int idx);

	void updateBbsState(int bbsIdx, String state);

	void updateCloseDate(int bbsIdx, Timestamp newCloseTimestamp);

	int bidResultUpdate(int bbsIdx, int bid_price);
	
	int insertBoard(BoardDTO boardDTO);

	void tempdel(String idx);

	String getEmail(int idx);
	
	void updateReserveEmail(int bbsIdx, String email);

	// 도혜=정언
	//int writeBoard(Map<String, String> params);
	int writeBoard(BoardDTO dto);
	
	void updatePrice(int priceInt, int idx);	// 판매 가격 업데이트
	void updateAuctionPrice(int start_priceInt, int immediate_priceInt, int idx); // 경매 가격 업데이트
	void updateAuctionPrice2(int start_priceInt, int immediate_priceInt, int auction_period, int idx);
	// 사진 저장
	void savePhoto(int idx, String orifilename, String newfileName);	// 대표
	void savePhoto2(int idx, String orifilename, String newfileName);	// ㄴㄴ
	// 임시저장
	int tempSave(BoardDTO dto);

	List<BoardDTO> list(String email);

	int reserveUpdate(String email, int idx, String bbs_state);

	int myBbsCheck(Integer idx, String email);

	void goodsUpdate(int idxInt, int priceInt, String category, String subject, String content, String place);



}
