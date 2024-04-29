package com.beans.market.admin.dao;

import java.util.List;

import com.beans.market.admin.dto.NoticeDTO;

public interface NoticeDAO {

	List<NoticeDTO> list(int pagePerCnt, int start);

	Object allCount(int pagePerCnt);

}
