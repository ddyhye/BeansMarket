package com.beans.market.message.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beans.market.message.service.MessageService;

@Controller
public class MessageController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired MessageService messageService;
	
	@RequestMapping(value = "/message/noteMessage.go")
	public String noteMessageGo() {	
		return "noteMessage/noteMessage";
	}
	
	@RequestMapping(value = "/message/messageCall.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> messageCallAjax(int idx, String email, String otherEmail){
		logger.info("{}번 게시물, {}가 요청", idx, email);
		return messageService.messageCallAjax(idx, email, otherEmail);
	}
	
	@RequestMapping(value = "/message/messageSend.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> messageSendAjax(int idx, String email, String content){
		logger.info("{}번 게시물, {}가 쪽지 전송", idx, email);
		return messageService.messageSendAjax(idx, email, content);
	}
	
}
