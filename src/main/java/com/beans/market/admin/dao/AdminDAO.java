package com.beans.market.admin.dao;

import java.util.List;

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
}
