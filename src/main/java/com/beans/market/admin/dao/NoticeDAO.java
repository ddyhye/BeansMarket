package com.beans.market.admin.dao;

import java.util.List;

import com.beans.market.admin.dto.NoticeDTO;

public interface NoticeDAO {

	List<NoticeDTO> list(int pagePerCnt, int start);

	Object allCount(int pagePerCnt);

	NoticeDTO detail(String notice_idx);

	void increaseHitCount(String notice_idx);

	List<NoticeDTO> noticesearch(String textval);

}
