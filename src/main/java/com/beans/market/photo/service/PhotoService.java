package com.beans.market.photo.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.beans.market.photo.dao.PhotoDAO;
import com.beans.market.photo.dto.PhotoDTO;

@Service
public class PhotoService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired PhotoDAO photoDAO;

	public void boardPhoto(int idx, Model model, int option_idx) {
		List<PhotoDTO> list = photoDAO.photos(idx, option_idx);
		logger.info("게시글 Photo list : {}", list);
		model.addAttribute("photos", list);
		
		List<String> names = new ArrayList<String>(); 
		for (PhotoDTO photo : list) {
			names.add(photo.getNew_picname()); 
		}
		logger.info("파일 이름들 : "+names);
		model.addAttribute("names", names);
	}

	public String getMainPhoto(int idx) {
		logger.info("{}번 메인 사진 가져오기", idx);
		return photoDAO.getMainPhoto(idx, 1);
	}
	

	
}
