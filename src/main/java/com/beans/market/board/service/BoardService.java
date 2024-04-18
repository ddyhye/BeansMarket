package com.beans.market.board.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beans.market.board.dao.BoardDAO;

@Service
public class BoardService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired BoardDAO boardDAO;

	public int connectTest() {
		return boardDAO.connectTest();
	}
	
	
	
}
