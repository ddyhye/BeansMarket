package com.beans.market.pay.dao;

import java.util.List;

import com.beans.market.pay.dto.PayDTO;

public interface PayDAO {

	int getMyAmount(String email);

	List<PayDTO> list();

	int payDeposit(int bbsIdx);

	int payWithdrawal(String email, int bid_price);

}
