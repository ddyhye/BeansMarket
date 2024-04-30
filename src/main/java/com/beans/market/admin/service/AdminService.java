package com.beans.market.admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beans.market.admin.dao.AdminDAO;
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.admin.dto.AdminDTO;
import com.beans.market.admin.dto.AlarmDTO;
import com.beans.market.board.dto.BoardDTO;

@Service
public class AdminService {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired AdminDAO adminDao;
	@Autowired AdminDAO adminDAO;

	public AdminDTO login(String id, String pw) {
		return adminDAO.login(id, pw);
	}

	public List<AlarmDTO> alarm() {
		return adminDAO.alarm();
	}
	
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
	
	
}
