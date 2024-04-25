package com.beans.market.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import com.beans.market.main.dto.MainDTO;
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.member.dto.SellerDTO;
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
	
	
	
	
	
	
	
	
	
	
	
	
	/*         마이페이지          */

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
	
	



	



}
