package com.beans.market.pay.dao;

import java.util.List;

import com.beans.market.pay.dto.PayDTO;

public interface PayDAO {

	int getMyAmount(String email);

	List<PayDTO> list(String email);

	String getUsernameByEmail(String email);


	

}
