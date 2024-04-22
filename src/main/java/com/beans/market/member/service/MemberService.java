package com.beans.market.member.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beans.market.member.dao.MemberDAO;
import com.beans.market.member.dto.MemberDTO;

@Service
public class MemberService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MemberDAO memberDAO;

	public int connectTest() {
		return memberDAO.connectTest();
	}

	public int overlay(String id) {
		
		return memberDAO.overlay(id);
	}

	public MemberDTO login(String email, String password) {
		
		return memberDAO.login(email,password);
	}


	public List<MemberDTO> list() {
		logger.info("memberservice list 요청");
		return memberDAO.list();
	}

	public int getMyAmount(String email) {
		return memberDAO.getMyAmount(email);
	}

	public int join(Map<String, String> param) {

		return memberDAO.join(param);
	}

	public Object joinoverlay(String email) {

		return memberDAO.joinoverlay(email);
	}

	public void updateLastLoginDate(Map<String, Object> params) {
	    memberDAO.updateLastLoginDate(params);
	}

    public void newPW(String email, String pw) {
	    logger.info("email: " + email);
	    logger.info("pw: " + pw);
	    memberDAO.newPW(email, pw);
	    
    }

	public void saveProfilePic(Map<String, Object> profileParam) {
		memberDAO.saveprofile(profileParam);
		
	} 


}
