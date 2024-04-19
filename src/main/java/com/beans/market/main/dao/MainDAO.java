package com.beans.market.main.dao;

import java.util.List;

import com.beans.market.board.dto.BoardDTO;
import com.beans.market.main.dto.MainDTO;
import com.beans.market.photo.dto.PhotoDTO;

public interface MainDAO {


	
	// 게시글 리스트
	List<MainDTO> goodsList();
	List<MainDTO> goodsList2();
	List<MainDTO> goodsList3();
	List<MainDTO> goodsList4();
	String mainPhoto(int i);
	int fullPrice(int idx);
	int bidCnt(int idx);
	String sellerName(int idx);
	int heartCnt(int idx);

}
