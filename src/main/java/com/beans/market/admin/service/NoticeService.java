package com.beans.market.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.beans.market.admin.dao.NoticeDAO;
import com.beans.market.admin.dto.NoticeDTO;
import com.beans.market.board.dao.BoardDAO;

@Service
public class NoticeService {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired NoticeDAO noticeDAO;

	public Map<String, Object> list(int currPage, int pagePerCnt) {
		
	int start = (currPage-1)* pagePerCnt;
	Map<String, Object>result = new HashMap<String, Object>();
	List<NoticeDTO>list= noticeDAO.list(pagePerCnt, start);
	logger.info("list size :" + list.size());
	logger.info("pagePerCnt : " + pagePerCnt);
	result.put("list", list);
	result.put("currPage", currPage);
	result.put("totalPages", noticeDAO.allCount(pagePerCnt));
		
		return result;
	}

	public NoticeDTO detail(String notice_idx) {
		
		return noticeDAO.detail(notice_idx);
	}

	public void increaseHitCount(String notice_idx) {
		noticeDAO.increaseHitCount(notice_idx);
		
	}

	public Map<String, Object> noticesearch(Map<String, Object> map, String textval) {
		List<NoticeDTO>list = noticeDAO.noticesearch(textval);
		map.put("list", list);
		
		return map;
	}


	

}
