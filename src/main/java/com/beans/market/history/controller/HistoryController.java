package com.beans.market.history.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.beans.market.history.service.HistoryService;

@Controller
public class HistoryController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired HistoryService historyService;
	
	
	
}
