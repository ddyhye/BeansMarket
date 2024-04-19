package com.beans.market.member.dao;

import java.util.List;

import com.beans.market.member.dto.MemberDTO;

public interface MemberDAO {

	int connectTest();

	int overlay(String id);

	String login(String email, String pw);

	String newPW(String pw);

	List<MemberDTO> list();

	int getMyAmount(String email);

}
