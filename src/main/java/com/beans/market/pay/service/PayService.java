package com.beans.market.pay.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beans.market.pay.dto.PayDTO;
import com.beans.market.pay.dao.PayDAO;

import org.springframework.stereotype.Service;

@Service
public class PayService {

	@Autowired PayDAO payDAO;
	
	public int getMyAmount(String email) {
		return payDAO.getMyAmount(email);
	}

	public List<PayDTO> list() {
		return payDAO.list();
	}

}
