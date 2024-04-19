package com.beans.market.member.dao;

public interface MemberDAO {

	int connectTest();

	int overlay(String id);

	String login(String email, String pw);

	String newPW(String pw);

}
