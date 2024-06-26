package com.beans.market.admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.beans.market.admin.dao.AdminDAO;
import com.beans.market.admin.dto.AdminDTO;
import com.beans.market.admin.dto.AlarmDTO;
import com.beans.market.admin.dto.CategoryDTO;
import com.beans.market.board.dto.BoardDTO;
import com.beans.market.main.dto.InquiryDTO;
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.member.dto.MemberPenaltyDTO;
import com.beans.market.message.dto.MessageDTO;
import com.beans.market.pay.dto.PayDTO;
import com.beans.market.report.dto.ReportDTO;

@Service
public class AdminService {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired AdminDAO adminDao;
	@Autowired AdminDAO adminDAO;
	
	/* 성영 */
	// 로그인
	public AdminDTO login(String id, String pw) {
		return adminDAO.login(id, pw);
	}
	
	// 알림 리스트 가져오기
	public List<AlarmDTO> alarm() {
		return adminDAO.alarm();
	}
	
	// 문의, 신고 미처리 횟수 가져오기
	public Map<String, Object> noComplete() {
		Map<String, Object> map = new HashMap<String, Object>();
		int cnt = 0;
		
		cnt = adminDAO.noCompleteInquiry();
		logger.info("문의 미처리 개수 : {}", cnt);
		map.put("inquiryCnt", cnt);
		
		cnt = adminDAO.noCompleteReport();
		logger.info("신고 미처리 개수 : {}", cnt);
		map.put("reportCnt", cnt);
		
		return map;
	}
	
	// 알림 읽음 처리
	public int alarmRead(int idx) {
		return adminDAO.alarmRead(idx);
	}

	// 새로운 알림 있는지 확인
	public Map<String, Object> newAlarm() {
		Map<String, Object> map = new HashMap<String, Object>();
		int cnt = adminDAO.newAlarm();
		map.put("newAlarm", cnt);
		
		cnt = adminDAO.noCompleteInquiry();
		map.put("inquiryCnt", cnt);
		
		cnt = adminDAO.noCompleteReport();
		map.put("reportCnt", cnt);
		
		return map;
	}

	// 쪽지 리스트 가져오기
	public Map<String, Object> messageList(int searchText, String reportYN) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<MessageDTO> list = new ArrayList<MessageDTO>();
		boolean result = false;
		logger.info("searchText : {}", searchText);
		
		if (reportYN.equals("Y")) { // 신고 받은거만
			list = adminDAO.messageReportList(searchText);
			result = true;
		} else { // 전부
			list = adminDAO.messageList(searchText);
			result = true;
		}
		
		map.put("list", list);
		map.put("result", result);
		
		return map;
	}
	
	// 쪽지 방 리스트 가져오기
	public Map<String, Object> roomList(String searchText, String reportYN) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<MessageDTO> list = new ArrayList<MessageDTO>();
		boolean result = false;
		logger.info("searchText : {}", searchText);
		
		int intSearchText; 
		try {
			intSearchText = searchText.equals("") ? 0 : Integer.parseInt(searchText); // 숫자가 아닐때라고 유효성 검사를 주는게 좋아보임
		} catch (Exception e) {
			intSearchText = 0;
		}
		
		if (reportYN.equals("Y")) { // 신고 받은거만
			list = adminDAO.roomReportListCall(intSearchText);
			result = true;
		} else { // 전부
			list = adminDAO.roomListCall(intSearchText);
			result = true;
		}

		map.put("list", list);
		map.put("result", result);
		
		return map;
	}
	
	// 쪽지방 내역 불러오기
	public Map<String, Object> roomDetailCall(String idx, String seller, String buyer) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<MessageDTO> list = new ArrayList<MessageDTO>();
		boolean result = false;
		
		list = adminDAO.roomDetailCall(Integer.parseInt(idx), seller, buyer);
		if (list != null) {
			result = true;
		}
		
		map.put("list", list);
		map.put("result", result);
		map.put("seller", seller);
		map.put("buyer", buyer);
		map.put("idx", idx);
		
		return map;
	}
	
	// 카테고리 리스트 불러오기
	public Map<String, Object> categoryCall() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<CategoryDTO> list = new ArrayList<CategoryDTO>();
		boolean result = false;
		
		list = adminDAO.categoryCall();
		if (list != null) {
			result = true;
		}
		
		map.put("list", list);
		map.put("result", result);
		
		return map;
	}
	
	// 카테고리 정보 저장하기
	public void categorySave(Model model, String idx, String name, String hidden) {
		int row = adminDAO.categorySave(idx, name, hidden);
		
		if (row == 1) {
			model.addAttribute("msg", "변경 완료");
		} else {
			model.addAttribute("msg", "변경 실패");
		}
	}
	
	// 카테고리 정보 추가하기
	public void categoryInsert(Model model, String idx, String name) {
		int row = adminDAO.categoryInsert(idx, name);
		
		if (row == 1) {
			model.addAttribute("msg", "추가 완료");
		} else {
			model.addAttribute("msg", "추가 실패");
		}
		
	}
	
	// 신고리스트 불러오기
	public Map<String, Object> reportListCall(String searchText, String incompleteYN) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ReportDTO> list = new ArrayList<ReportDTO>();
		boolean result = false;
		int intSearchText = -1;
		
		try { // 문자가 아니면 0으로
			if (!searchText.equals("")) {
				intSearchText = Integer.parseInt(searchText);
			}else {
				intSearchText = 0;
			}
			list = adminDAO.reportListCallNumber(intSearchText, incompleteYN);
		} catch (Exception e) {
			list = adminDAO.reportListCallPerpet(searchText, incompleteYN);
		}
		
		if (list != null) {
			result = true;
		}
		
		map.put("list", list);
		map.put("result", result);
		
		return map;
	}
	
	/* 성영 END */








	/*                     도혜                       */
	public Map<String, Object> memberList(Map<String, Object> map, String memberSearch, String warningOption, String memberStateOption) {
		
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		
		if (memberSearch.equals("")) {
			if (warningOption.equals("all")) {
				if (memberStateOption.equals("all")) {
					list = adminDao.memberSelect1();
				} else if (memberStateOption.equals("periodStop")) {
					list = adminDao.memberSelect2();
				} else if (memberStateOption.equals("stop")) {
					list = adminDao.memberSelect3();
				} else if (memberStateOption.equals("dormant")) {
					list = adminDao.memberSelect4();
				} else if (memberStateOption.equals("secession")) {
					list = adminDao.memberSelect5();
				}
			} else {
				int warningCnt = Integer.parseInt(warningOption);
				
				if (memberStateOption.equals("all")) {
					list = adminDao.memberSelect6(warningCnt);
				} else if (memberStateOption.equals("periodStop")) {
					list = adminDao.memberSelect7(warningCnt);
				} else if (memberStateOption.equals("stop")) {
					list = adminDao.memberSelect8(warningCnt);
				} else if (memberStateOption.equals("dormant")) {
					list = adminDao.memberSelect9(warningCnt);
				} else if (memberStateOption.equals("secession")) {
					list = adminDao.memberSelect10(warningCnt);
				}
			}
		} else {
			if (warningOption.equals("all")) {
				if (memberStateOption.equals("all")) {
					list = adminDao.memberSelect11(memberSearch);
				} else if (memberStateOption.equals("periodStop")) {
					list = adminDao.memberSelect12(memberSearch);
				} else if (memberStateOption.equals("stop")) {
					list = adminDao.memberSelect13(memberSearch);
				} else if (memberStateOption.equals("dormant")) {
					list = adminDao.memberSelect14(memberSearch);
				} else if (memberStateOption.equals("secession")) {
					list = adminDao.memberSelect15(memberSearch);
				}
			} else {
				int warningCnt = Integer.parseInt(warningOption);
				
				if (memberStateOption.equals("all")) {
					list = adminDao.memberSelect16(warningCnt, memberSearch);
				} else if (memberStateOption.equals("periodStop")) {
					list = adminDao.memberSelect17(warningCnt, memberSearch);
				} else if (memberStateOption.equals("stop")) {
					list = adminDao.memberSelect18(warningCnt, memberSearch);
				} else if (memberStateOption.equals("dormant")) {
					list = adminDao.memberSelect19(warningCnt, memberSearch);
				} else if (memberStateOption.equals("secession")) {
					list = adminDao.memberSelect20(warningCnt, memberSearch);
				}
			}
		}
		
		map.put("list", list);

		return map;
	}

	public int userManageDo(Map<String, String> param) {
		if (param.get("manageOption").equals("경고 1회 추가")) {
			adminDao.userManageUpdate1(param);
		} else if (param.get("manageOption").equals("경고 1회 차감")) {
			adminDao.userManageUpdate2(param);
		} else if (param.get("manageOption").equals("기간 정지 3일")) {
			adminDao.userManageUpdate3(param);
		} else if (param.get("manageOption").equals("기간 정지 해제")) {
			adminDao.userManageUpdate4(param);
		} else if (param.get("manageOption").equals("영구 정지")) {
			adminDao.userManageUpdate5(param);
		}
		
		return adminDao.userManageDo(param);
	}

	public MemberDTO getMemberProfile(String memberEmail) {
		return adminDao.getMemberProfile(memberEmail);
	}
	public String getmemberProfilePic(String memberEmail) {
		return adminDao.getmemberProfilePic(memberEmail);
	}

	public void userPointUpdate1(String memberEmail, int point) {
		adminDao.userPointUpdate1Insert(memberEmail, point);
		adminDao.userPointUpdate1(memberEmail, point);
	}

	public void userPointUpdate2(String memberEmail, int point) {
		adminDao.userPointUpdate2Insert(memberEmail, point);
		adminDao.userPointUpdate2(memberEmail, point);
	}
	
	public List<PayDTO> memberPayHistory(String memberEmail) {
		return adminDao.memberPayHistory(memberEmail);
	}
	
	// 문의
	public Map<String, Object> inquiryList(Map<String, Object> map, String memberSearch, String warningOption,
			String memberStateOption) {
		
		List<InquiryDTO> list = new ArrayList<InquiryDTO>();
		
		if (memberSearch.equals("")) {
			if (warningOption.equals("all")) {
				if (memberStateOption.equals("all")) {
					list = adminDao.inquirySelect1();
				} else if (memberStateOption.equals("success")) {
					list = adminDao.inquirySelect2();
				} else if (memberStateOption.equals("unSuccess")) {
					list = adminDao.inquirySelect3();
				}
			} else {
				if (memberStateOption.equals("all")) {
					list = adminDao.inquirySelect4(warningOption);
				} else if (memberStateOption.equals("success")) {
					list = adminDao.inquirySelect5(warningOption);
				} else if (memberStateOption.equals("unSuccess")) {
					list = adminDao.inquirySelect6(warningOption);
				}
			}
		} else {
			if (warningOption.equals("all")) {
				if (memberStateOption.equals("all")) {
					list = adminDao.inquirySelect7(memberSearch);
				} else if (memberStateOption.equals("success")) {
					list = adminDao.inquirySelect8(memberSearch);
				} else if (memberStateOption.equals("unSuccess")) {
					list = adminDao.inquirySelect9(memberSearch);
				}
			} else {
				if (memberStateOption.equals("all")) {
					list = adminDao.inquirySelect10(memberSearch, warningOption);
				} else if (memberStateOption.equals("success")) {
					list = adminDao.inquirySelect11(memberSearch, warningOption);
				} else if (memberStateOption.equals("unSuccess")) {
					list = adminDao.inquirySelect12(memberSearch, warningOption);
				}
			}
		}
		
		map.put("list", list);

		return map;
		
	}
	public String getAdminName(String adminID) {
		return adminDao.getAdminName(adminID);
	}

	public InquiryDTO getInquiryData(int inquiry_idx) {
		return adminDao.getInquiryData(inquiry_idx);
	}

	public void inquiryReply(int inquiry_idx2, String adminID, String adminReplyContent) {
		adminDao.inquiryReply(inquiry_idx2, adminID, adminReplyContent);
		adminDao.inquiryUpdate(inquiry_idx2);
	}
	
	
	
	

	
	
	
	
	
	
	
	/*                     정언                       */
	public Map<String, Object> bbsList(Map<String, Object> map, String textVal, String selectedCategory, String selectedState, String selectedRadio) {

		List<BoardDTO> list = new ArrayList<BoardDTO>();
		
		if (textVal.equals("")) { // 검색어 없을 경우
			if (selectedCategory.equals("all")) { // 카테고리 전체일 경우
				if (selectedState.equals("all")) { // 거래상태 전체일 경우
					if (selectedRadio == null || selectedRadio == "") {
						list = adminDao.bbsSelect1();
					} else if (selectedRadio.equals("blind")) {
						list = adminDao.bbsSelect2();
					} else if (selectedRadio.equals("tempsave")) {
						list = adminDao.bbsSelect3();
					}
				} else {
					if (selectedRadio == null || selectedRadio == "") {
						list = adminDao.bbsSelect4(selectedState);
					} else if (selectedRadio.equals("blind")) {
						list = adminDao.bbsSelect5(selectedState);
					} else if (selectedRadio.equals("tempsave")) {
						list = adminDao.bbsSelect6(selectedState);
					}
				}			
			} else { // 카테고리가 전체가 아닐 경우
				if (selectedState.equals("all")) { // 거래상태 전체일 경우
					if (selectedRadio == null || selectedRadio == "") {
						list = adminDao.bbsSelect7(selectedCategory);
					} else if (selectedRadio.equals("blind")) {
						list = adminDao.bbsSelect8(selectedCategory);
					} else if (selectedRadio.equals("tempsave")) {
						list = adminDao.bbsSelect9(selectedCategory);
					}
				} else {
					if (selectedRadio == null || selectedRadio == "") {
						list = adminDao.bbsSelect10(selectedCategory,selectedState);
					} else if (selectedRadio.equals("blind")) {
						list = adminDao.bbsSelect11(selectedCategory,selectedState);
					} else if (selectedRadio.equals("tempsave")) {
						list = adminDao.bbsSelect12(selectedCategory,selectedState);
					}
				}
			}
		} else {
			int textValInt = 0;
			
			if (textVal.matches("[0-9]+")) { // 검색어가 숫자일 경우
				textValInt = Integer.parseInt(textVal);
			}
			 
			if (selectedCategory.equals("all")) { // 카테고리 전체일 경우
				if (selectedState.equals("all")) { // 거래상태 전체일 경우
					if (selectedRadio == null || selectedRadio == "") {
						list = adminDao.bbsSelect13(textVal,textValInt);
					} else if (selectedRadio.equals("blind")) {
						list = adminDao.bbsSelect14(textVal,textValInt);
					} else if (selectedRadio.equals("tempsave")) {
						list = adminDao.bbsSelect15(textVal,textValInt);
					}
				} else {
					if (selectedRadio == null || selectedRadio == "") {
						list = adminDao.bbsSelect16(textVal,textValInt,selectedState);
					} else if (selectedRadio.equals("blind")) {
						list = adminDao.bbsSelect17(textVal,textValInt,selectedState);
					} else if (selectedRadio.equals("tempsave")) {
						list = adminDao.bbsSelect18(textVal,textValInt,selectedState);
					}
				}			
			} else { // 카테고리가 전제가 아닐 경우
				if (selectedState.equals("all")) { // 거래상태 전체일 경우
					if (selectedRadio == null || selectedRadio == "") {
						list = adminDao.bbsSelect19(textVal,textValInt,selectedCategory);
					} else if (selectedRadio.equals("blind")) {
						list = adminDao.bbsSelect20(textVal,textValInt,selectedCategory);
					} else if (selectedRadio.equals("tempsave")) {
						list = adminDao.bbsSelect21(textVal,textValInt,selectedCategory);
					}
				} else {
					if (selectedRadio == null || selectedRadio == "") {
						list = adminDao.bbsSelect22(textVal,textValInt,selectedState,selectedCategory);
					} else if (selectedRadio.equals("blind")) {
						list = adminDao.bbsSelect23(textVal,textValInt,selectedState,selectedCategory);
					} else if (selectedRadio.equals("tempsave")) {
						list = adminDao.bbsSelect24(textVal,textValInt,selectedState,selectedCategory);
					}
				}
			}
		}
		
		map.put("list", list);

		return map;
	}

	public List<MemberPenaltyDTO> memberDisciplineHistory(String memberEmail) {
		// TODO Auto-generated method stub
		return adminDao.memberDisciplineHistory(memberEmail);
	}

	// 게시글 상세보기
	public BoardDTO boardDetail(int boardIdx) {
		return adminDao.boardDetail(boardIdx);
	}

	// 블라인드 처리
	public BoardDTO boardBlind(int boardIdx) {
		return adminDao.boardBlind(boardIdx);
	}

	// 블라인드 해제
	public BoardDTO boardBlindDel(int boardIdx) {
		return adminDao.boardBlindDel(boardIdx);		
	}
	
	public Map<String, Object> completeAjax(List<Integer> compleList, String admin_name) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int cnt = 0;
		for (Integer idx : compleList) {
			cnt += adminDAO.complete(idx, admin_name);
		}
		
		logger.info("cnt : {} ", cnt);	
		map.put("cnt", cnt);
		
		return map;
	}


	

	
	
	
}
