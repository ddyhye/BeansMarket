package com.beans.market.message.service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beans.market.board.dto.BoardDTO;
import com.beans.market.board.service.BoardService;
import com.beans.market.main.service.MainService;
import com.beans.market.message.dao.MessageDAO;
import com.beans.market.message.dto.MessageDTO;
import com.beans.market.message.dto.RoomDTO;
import com.beans.market.photo.service.PhotoService;

@Service
public class MessageService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MessageDAO messageDAO;
	@Autowired BoardService boardService;
	@Autowired PhotoService photoService;
	@Autowired MainService mainService;
	
	public Map<String, Object> messageCallAjax(int idx, String email, String otherEmail) {
		Map<String, Object> map = new HashMap<String, Object>();
		//String publisher = boardService.getEmail(idx); // 이메일 가져오기 - 필요없을지도?
		//logger.info("email : {}",publisher);
		List<MessageDTO> messageList = messageDAO.messageList(idx, email, otherEmail); // 특정 게시물의 특정 인원과의 게시물을 가져오기
		//logger.info("mssageList : {}", messageList.toString());
		map.put("messageList", messageList);
		map.put("bbs_email", email);
		
		return map;
	}

	public Map<String, Object> messageSendAjax(int idx, String senderEmail, String receiveEmail, String content) {
		boolean result = false;
		Map<String, Object> map = new HashMap<String, Object>();
		
		int row = messageDAO.sendMessage(content, receiveEmail, senderEmail, idx);
		if(row == 1) {
			result = true;
			mainService.alarmSend(idx+"번 게시물 : "+content, receiveEmail);
		}
		map.put("result", "보낸 결과"+result);
		
		
		return map;
	}

	public Map<String, Object> roomListCallAjax(String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<RoomDTO> roomList = messageDAO.roomList(email); // 특정 게시물의 특정 인원과의 게시물을 가져오기
		
		for (RoomDTO roomDTO : roomList) {
			logger.info("other_email : {}, idx : {}", roomDTO.getOther_email(), roomDTO.getIdx());
			RoomDTO lastContent = messageDAO.lastContent(roomDTO.getIdx(), roomDTO.getOther_email(), email);
			String content = lastContent.getContent();
			Timestamp reg_date = lastContent.getReg_date();
			String new_picname = lastContent.getNew_picname();
			
			//logger.info("content : {} ", content);
			//logger.info("reg_date : {} ", reg_date);
			//logger.info("new_picname : {}", new_picname);
			
			roomDTO.setContent(content);
			roomDTO.setReg_date(reg_date);
			roomDTO.setNew_picname(new_picname);
		}
		
		/*
		for (RoomDTO roomDTO : roomList) {
			logger.info("other_email : {}, idx : {}", roomDTO.getOther_email(), roomDTO.getIdx());
			logger.info("content : {}, reg_date : {}", roomDTO.getContent(), roomDTO.getReg_date());	
			logger.info("new_picname : {}", roomDTO.getNew_picname());
		}
		*/
		
		map.put("roomList", roomList);
		
		return map;
	}

	public Map<String, Object> subjectCallAjax(int idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		BoardDTO roomSubject = boardService.getBoardInfo(idx);
		String roomPhoto = photoService.getMainPhoto(idx);
		
		//logger.info("제목 정보 확인 : {}", roomSubject.getSubject());
		//logger.info("사진 이름 : {}", roomPhoto);
		map.put("bbs_idx", idx);
		map.put("other_email", roomSubject.getEmail());
		map.put("roomSubject", roomSubject);
		map.put("roomPhoto", roomPhoto);
		
		return map;
	}
	
	
}
