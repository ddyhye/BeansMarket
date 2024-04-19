package com.beans.market.main.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beans.market.board.dao.BoardDAO;
import com.beans.market.board.dto.BoardDTO;
import com.beans.market.main.dao.MainDAO;

@Service
public class MainService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MainDAO mainDao;
	@Autowired BoardDAO boardDao;
	

	public BoardDTO goodsList() {
		// TODO Auto-generated method stub
		return mainDao.goodsList();
	}


}
