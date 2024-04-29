package com.beans.market.member.dao;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import com.beans.market.main.dto.MainDTO;
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.member.dto.SellerDTO;
import com.beans.market.message.dto.ApproveDTO;
import com.beans.market.member.dto.AuctionDTO;
import com.beans.market.member.dto.BlockDTO;
import com.beans.market.photo.dto.ProfilePicDTO;

public interface MemberDAO {

	int connectTest();

	int overlay(String id);

	MemberDTO login(String email, String pw);

	String newPW(String pw);


	List<MemberDTO> list();

	int getMyAmount(String email);


	int join(Map<String, String> param);

	Object joinoverlay(String email);

	void updateLastLoginDate(Map<String, Object> params);

	void newPW(String email, String pw);

	void saveprofile(Map<String, Object> profileParam);


	void lastdate(String email, String password);


	SellerDTO sellerInfo(String email);

	int nowPoint(String email);
	
	
	
	
	
	
	
	
	
	
	
	
	/*         마이페이지-도혜          */

	String logEmail(String email, String password);

	// 프로필 불러오기
	MemberDTO profileGet(String logEmail);
	ProfilePicDTO profilePicGet(String logEmail);
	// 프로필 업데이트
	void newPicPath(String logEmail, String newFileName);
	void profilePicO(Map<String, String> param);
	void profilePicDel(Map<String, String> param);
	void profilePicY(Map<String, String> param);
	void profileUpdate(Map<String, String> param);

	
	// 관심목록
	int[] mineIdxList(String logEmail);
	MainDTO mineIdxGoodsList(int i);

	
	// 차단 목록
	List<BlockDTO> banList(String logEmail);
	String banProfile(String string);
	// 차단 해제
	void banUnravel(String logEmail, String blockEmail);


	// 판매 내역
	int[] mySellIdxList(String logEmail);
	int[] mySellIdxList2(String logEmail);
	int[] mySellIdxList3(String logEmail);
	int[] mySellIdxList4(String logEmail);
	MainDTO mySellIdxGoodsList(int i);
	// 판매 내역 관리
	void mySellManage(int intIdx);
	void mySellManage2(int intIdx);
	void mySellManage3(int intIdx);

	// 구매 내역
	int[] myBuyIdxList(String logEmail);
	// 구매 내역 관리
	void myBuyManage(int intIdx);
	
	// 탈퇴하기
	void secession(String logEmail);
	
	// 거래 미승인 목록
	int[] mybbsArr(String logEmail);
	int myApproved(int i, String logEmail);
	ApproveDTO opponentApproved(int i, String logEmail);
	void myApproveClick(String logEmail, int idxInt);
	
	
	// 타 회원 판매 품목 리스트
	List<MainDTO> otherGoodsList(String otherEmail);
	// 타 회원 차단
	void otherBan(String logEmail, String otherEmail);

	
	
	



	// 나의 입찰 목록
	List<AuctionDTO> auctionBid(String logEmail);
	String getBidPic(int idx);
	String getBidSubject(int idx);
	Timestamp getBidClose(int idx);
	String getBidState(int idx);
	
	int getBidderY(int idx, String logEmail);

}
