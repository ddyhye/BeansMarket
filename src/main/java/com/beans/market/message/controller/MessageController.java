package com.beans.market.message.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beans.market.message.service.MessageService;

@Controller
public class MessageController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired MessageService messageService;
	
	// 이동 요청
	@RequestMapping(value = "/message/noteMessage.go", method = RequestMethod.GET)
	public String noteMessageGo(Model model, String idx) {	
		logger.info("idx : {}",idx);
		if (idx != null) {
			model.addAttribute("callPage", idx);
		}
		return "noteMessage/noteMessage";
	}
	
	// 대화 내용 요청 ajax
	@RequestMapping(value = "/message/messageCall.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> messageCallAjax(int idx, String email, String otherEmail){
		logger.info("{}번 게시물, {}가 요청", idx, email);
		return messageService.messageCallAjax(idx, email, otherEmail);
	}
	
	// 대화방 리스트 요청 ajax
	@RequestMapping(value = "/message/roomListCall.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> roomListCallAjax(String email){
		logger.info("{}의 대화방 리스트 출력", email);
		return messageService.roomListCallAjax(email);
	}
	
	// 쪽지 보내기 ajax
	@RequestMapping(value = "/message/messageSend.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> messageSendAjax(int idx, String email, String otherEmail, String content){
		logger.info("{}번 게시물, {}가 쪽지 전송", idx, email);
		return messageService.messageSendAjax(idx, email, otherEmail, content);
	}
	
	// 제목 요청
	@RequestMapping(value = "/message/subjectCall.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> subjectCallAjax(int idx){
		logger.info("{}번 게시물, 제목 요청", idx);
		return messageService.subjectCallAjax(idx);
	}
	
	
	
	
	
}
