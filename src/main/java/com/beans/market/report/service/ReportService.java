package com.beans.market.report.service;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beans.market.report.dao.ReportDAO;
import com.beans.market.report.dto.ReportDTO;

@Service
public class ReportService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired ReportDAO reportDAO;

	public String reportDo(Map<String, String> map) {
		String msg = "신고에 실패했습니다.";
		
		ReportDTO rdto = new ReportDTO(); 
		rdto.setCategory_idx(map.get("category_idx"));
		rdto.setContent(map.get("content"));
		rdto.setIdx(Integer.parseInt(map.get("idx")));
		rdto.setOption_idx(map.get("option_idx"));
		rdto.setPerpet_email(map.get("perpet_email"));
		rdto.setReporter_email(map.get("reporter_email"));
		
		
		int row = reportDAO.reportDo(rdto);
		if (row == 1) {
			msg= "정상적으로 신고처리되었습니다.";
		}
		return msg;
	}
	
	
}
