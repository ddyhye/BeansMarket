package com.beans.market.admin.dao;

import java.util.List;
import java.util.Map;

import com.beans.market.admin.dto.AdminDTO;
import com.beans.market.admin.dto.AlarmDTO;
import com.beans.market.admin.dto.CategoryDTO;
import com.beans.market.board.dto.BoardDTO;
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.member.dto.MemberPenaltyDTO;
import com.beans.market.message.dto.MessageDTO;
import com.beans.market.pay.dto.PayDTO;
import com.beans.market.report.dto.ReportDTO;

public interface AdminDAO {

	/* 성영 */
	AdminDTO login(String id, String pw);

	int noCompleteInquiry();

	int noCompleteReport();

	List<AlarmDTO> alarm();

	int alarmRead(int idx);

	int newAlarm();
	
	List<MessageDTO> messageList(int searchText);
	List<MessageDTO> messageReportList(int searchText);

	List<MessageDTO> roomListCall(int intSearchText);
	List<MessageDTO> roomReportListCall(int intSearchText);
	List<MessageDTO> roomDetailCall(int idx, String seller, String buyer);
	
	List<CategoryDTO> categoryCall();
	
	int categorySave(String idx, String name, String hidden);
	int categoryInsert(String idx, String name);
	
	List<ReportDTO> reportListCallNumber(int intSearchText, String incompleteYN);
	List<ReportDTO> reportListCallPerpet(String searchText, String incompleteYN);
	
	int complete(Integer idx, String admin_name); 	// 신고 처리 완료
	
	
	/* 성영 END*/








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
	
	// 회원 상세보기 - 페이내역
	List<PayDTO> memberPayHistory(String memberEmail);
	List<MemberPenaltyDTO> memberDisciplineHistory(String memberEmail);





	
	
	
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






	
	// 게시글 상세보기
	BoardDTO boardDetail(int boardIdx);
	
	// 블라인드 처리
	BoardDTO boardBlind(int boardIdx);




	
	
	
	
	
	
	
	
	
	
	
	
	
}
