package com.beans.market.admin.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beans.market.admin.dao.AdminDAO;
import com.beans.market.member.dto.MemberDTO;

@Service
public class AdminService {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired AdminDAO adminDao;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
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
	
	
}
