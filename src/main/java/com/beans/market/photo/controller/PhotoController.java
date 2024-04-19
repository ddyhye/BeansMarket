package com.beans.market.photo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.beans.market.photo.service.PhotoService;

@Controller
public class PhotoController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired PhotoService photoService;
	
	
}
