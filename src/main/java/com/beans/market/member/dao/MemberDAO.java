package com.beans.market.member.dao;

import java.util.List;
import java.util.Map;

import com.beans.market.member.dto.MemberDTO;
import com.beans.market.member.dto.SellerDTO;

public interface MemberDAO {

	int connectTest();

	int overlay(String id);

	MemberDTO login(String email, String pw);

	String newPW(String pw);

	List<MemberDTO> list();

	int getMyAmount(String email);
	
	void lastdate(String email, String password);

	int join(Map<String, String> param);

	SellerDTO sellerInfo(String email);

	int nowPoint(String email);

}
