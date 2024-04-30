package com.beans.market.admin.dao;

import java.util.List;

import com.beans.market.member.dto.MemberDTO;
import com.beans.market.admin.dto.AdminDTO;
import com.beans.market.admin.dto.AlarmDTO;
import com.beans.market.board.dto.BoardDTO;

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

	
	
	
	List<BoardDTO> bbsSelect1();
	List<BoardDTO> bbsSelect2();
	List<BoardDTO> bbsSelect3();
	List<BoardDTO> bbsSelect4(String selectedState);
	List<BoardDTO> bbsSelect5(String selectedState);
	List<BoardDTO> bbsSelect6(String selectedState);
	List<BoardDTO> bbsSelect7(String selectedCategory);
	List<BoardDTO> bbsSelect8(String selectedCategory);
	List<BoardDTO> bbsSelect9(String selectedCategory);
	List<BoardDTO> bbsSelect10(String selectedCategory, String selectedState);
	List<BoardDTO> bbsSelect11(String selectedCategory, String selectedState);
	List<BoardDTO> bbsSelect12(String selectedCategory, String selectedState);
	List<BoardDTO> bbsSelect13(String textVal, int textValInt);
	List<BoardDTO> bbsSelect14(String textVal, int textValInt);
	List<BoardDTO> bbsSelect15(String textVal, int textValInt);
	List<BoardDTO> bbsSelect16(String textVal, int textValInt, String selectedState);
	List<BoardDTO> bbsSelect17(String textVal, int textValInt, String selectedState);
	List<BoardDTO> bbsSelect18(String textVal, int textValInt, String selectedState);
	List<BoardDTO> bbsSelect19(String textVal, int textValInt, String selectedCategory);
	List<BoardDTO> bbsSelect20(String textVal, int textValInt, String selectedCategory);
	List<BoardDTO> bbsSelect21(String textVal, int textValInt, String selectedCategory);
	List<BoardDTO> bbsSelect22(String textVal, int textValInt, String selectedState, String selectedCategory);
	List<BoardDTO> bbsSelect23(String textVal, int textValInt, String selectedState, String selectedCategory);
	List<BoardDTO> bbsSelect24(String textVal, int textValInt, String selectedState, String selectedCategory);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
