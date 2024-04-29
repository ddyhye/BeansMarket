package com.beans.market.admin.dao;

import java.util.List;

import com.beans.market.admin.dto.AdminDTO;
import com.beans.market.admin.dto.AlarmDTO;

public interface AdminDAO {

	AdminDTO login(String id, String pw);

	int noCompleteInquiry();

	int noCompleteReport();

	List<AlarmDTO> alarm();

	int alarmRead(int idx);

	int newAlarm();
	
}
