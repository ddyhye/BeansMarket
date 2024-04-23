package com.beans.market.main.dao;

import java.util.List;

import com.beans.market.board.dto.BoardDTO;
import com.beans.market.main.dto.MainDTO;
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.photo.dto.PhotoDTO;
import com.beans.market.photo.dto.ProfilePicDTO;

public interface MainDAO {


	
	// 게시글 리스트
	List<MainDTO> goodsList();
	List<MainDTO> goodsList2();
	List<MainDTO> goodsList3();
	List<MainDTO> goodsList4();
	List<MainDTO> goodsHitList();
	List<MainDTO> goodsHitList2();
	List<MainDTO> goodsHitList3();
	List<MainDTO> goodsHitList4();
	String mainPhoto(int i);
	int fullPrice(int idx);
	int bidCnt(int idx);
	String sellerName(int idx);
	int heartCnt(int idx);
	// 로그인 시, 나의 관심목록 표시
	int mine(int idx, String logEmail);
	
	// 게시글 관심 등록삭제
	void clickHeart(int idxInt, String logEmail);
	void deleteHeart(int idxInt, String logEmail);
	
	// 게시글 제목 검색
	List<MainDTO> bbsSearch(String textVal);
	
	// 게시글 카테고리 검색
	List<MainDTO> bbsCategorySearch(String textVal);
	
	// 알림
	int newAlarm(String logEmail);
	List<MainDTO> alarm(String logEmail);
	int alarmRead(int idxInt);
	
	// 최근 본 게시글
	MainDTO recentBBS(int idx);
	
	
	// 멤버 프로필
	MemberDTO profile(String logEmail);
	ProfilePicDTO profilePic(String logEmail);

}
