package com.beans.market.admin.dao;

import java.util.List;

import com.beans.market.admin.dto.QuestionDTO;

public interface QuestionDAO {

	List<QuestionDTO> list(int pagePerCnt, int start);

	Object allCount(int pagePerCnt);

	int write(QuestionDTO dto);

}
