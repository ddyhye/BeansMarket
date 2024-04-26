package com.beans.market.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.beans.market.admin.dao.QuestionDAO;
import com.beans.market.admin.dto.QuestionDTO;

@Service
public class QuestionService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired QuestionDAO questionDAO;
	
	public Map<String, Object> list(int currPage, int pagePerCnt) {
		
		int start = (currPage-1) * pagePerCnt;
		Map<String, Object> result = new HashMap<String, Object>();
		List<QuestionDTO> list= questionDAO.list(pagePerCnt, start); 
		logger.info("list size :" + list.size());
		logger.info("pagePerCnt : " + pagePerCnt);
		result.put("list", list);
		result.put("currPage", currPage);
		result.put("totalPages", questionDAO.allCount(pagePerCnt));
		
		return result;
	}







	public int write(MultipartFile photos, Map<String, String> param) {
		int row = -1;
		QuestionDTO dto = new QuestionDTO();
		dto.setInquiry_title(param.get("inquiry_title"));
		dto.setCategory_idx(param.get("category_idx"));
		dto.setEnquirer(param.get("enquirer"));
		dto.setInquiry_pw(param.get("inquiry_pw"));
		dto.setInquiry_account(param.get("inquiry_account"));
		row = questionDAO.write(dto);
		
		return row;
	}







	public List<QuestionDTO> getSearchList(QuestionDTO questionDTO) {
		
		return questionDAO.selectSearchList(questionDTO);
	}

}
