package com.beans.market.member.service;

import java.util.List;

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

	public String login(String email, String password) {
		
		return memberDAO.login(email,password);
	}

	public String newPW(String pw) {
		
		return memberDAO.newPW(pw);
	}

	public List<MemberDTO> list() {
		logger.info("memberservice list 요청");
		return memberDAO.list();
	}

	public int getMyAmount(String email) {
		return memberDAO.getMyAmount(email);
	}

}
