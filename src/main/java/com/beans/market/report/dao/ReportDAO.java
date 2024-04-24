package com.beans.market.report.dao;

import com.beans.market.report.dto.ReportDTO;

public interface ReportDAO {

	int reportDo(ReportDTO rdto);

	void ban(String logemail, String blockemail);


	
}
