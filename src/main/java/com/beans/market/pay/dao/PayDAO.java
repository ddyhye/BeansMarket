package com.beans.market.pay.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.beans.market.pay.dto.PayDTO;

public interface PayDAO {

	int getMyAmount(String email);

	List<PayDTO> list(String email);

	String getUsernameByEmail(String email);


	int payDeposit(int bbsIdx);

	int payWithdrawal(String email, int bid_price);

	int updatePoint(@Param("email") String email, @Param("pay") int pay);

	void insertPointHistory(PayDTO payDTO);

	void insertPayHistory(Map<String, Object> param);





}
