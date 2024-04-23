package com.beans.market.message.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beans.market.board.service.BoardService;
import com.beans.market.message.dao.MessageDAO;
import com.beans.market.message.dto.MessageDTO;

@Service
public class MessageService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MessageDAO messageDAO;
	@Autowired BoardService boardService;
	
	public Map<String, Object> messageCallAjax(int idx, String email, String otherEmail) {
		Map<String, Object> map = new HashMap<String, Object>();
		String publisher = boardService.getEmail(idx); // 이메일 가져오기 - 필요없을지도?
		logger.info("email : {}",publisher);
		List<MessageDTO> messageList = messageDAO.messageList(idx, email, otherEmail); // 특정 게시물의 특정 인원과의 게시물을 가져오기
		logger.info("mssageList : {}", messageList.toString());
		map.put("messageList", messageList);
		map.put("bbs_email", email);
		
		return map;
	}

	public Map<String, Object> messageSendAjax(int idx, String senderEmail, String content) {
		boolean result = false;
		Map<String, Object> map = new HashMap<String, Object>();
		String receiveEmail = boardService.getEmail(idx);
		logger.info("email : {}",receiveEmail);
		
		int row = messageDAO.sendMessage(content, receiveEmail, senderEmail, idx);
		if(row == 1) result = true;
		map.put("result", result);
		
		return map;
	}
	
	
}
