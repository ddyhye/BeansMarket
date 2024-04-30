package com.beans.market.admin.dao;

import java.util.List;
import java.util.Map;

import com.beans.market.member.dto.MemberDTO;
import com.beans.market.admin.dto.AdminDTO;
import com.beans.market.admin.dto.AlarmDTO;

public interface AdminDAO {

	AdminDTO login(String id, String pw);

	int noCompleteInquiry();

	int noCompleteReport();

	List<AlarmDTO> alarm();

	int alarmRead(int idx);

	int newAlarm();











	// 옵션 별 유저 리스트
	List<MemberDTO> memberSelect1();
	List<MemberDTO> memberSelect2();
	List<MemberDTO> memberSelect3();
	List<MemberDTO> memberSelect4();
	List<MemberDTO> memberSelect5();
	List<MemberDTO> memberSelect6(int warningCnt);
	List<MemberDTO> memberSelect7(int warningCnt);
	List<MemberDTO> memberSelect8(int warningCnt);
	List<MemberDTO> memberSelect9(int warningCnt);
	List<MemberDTO> memberSelect10(int warningCnt);
	List<MemberDTO> memberSelect11(String memberSearch);
	List<MemberDTO> memberSelect12(String memberSearch);
	List<MemberDTO> memberSelect13(String memberSearch);
	List<MemberDTO> memberSelect14(String memberSearch);
	List<MemberDTO> memberSelect15(String memberSearch);
	List<MemberDTO> memberSelect16(int warningCnt, String memberSearch);
	List<MemberDTO> memberSelect17(int warningCnt, String memberSearch);
	List<MemberDTO> memberSelect18(int warningCnt, String memberSearch);
	List<MemberDTO> memberSelect19(int warningCnt, String memberSearch);
	List<MemberDTO> memberSelect20(int warningCnt, String memberSearch);
	// 유저 제제
	int userManageDo(Map<String, String> param);
	void userManageUpdate1(Map<String, String> param);
	void userManageUpdate2(Map<String, String> param);
	void userManageUpdate3(Map<String, String> param);
	void userManageUpdate4(Map<String, String> param);
	void userManageUpdate5(Map<String, String> param);

	// 회원 프로필 가져오기
	MemberDTO getMemberProfile(String memberEmail);
	String getmemberProfilePic(String memberEmail);

	// 회원 포인트 수정
	void userPointUpdate1(String memberEmail, int point);
	void userPointUpdate1Insert(String memberEmail, int point);
	void userPointUpdate2(String memberEmail, int point);
	void userPointUpdate2Insert(String memberEmail, int point);


}
