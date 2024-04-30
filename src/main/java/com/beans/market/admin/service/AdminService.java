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
import com.beans.market.photo.dto.ProfilePicDTO;
import com.beans.market.admin.dto.AdminDTO;
import com.beans.market.admin.dto.AlarmDTO;

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
	
	
}
