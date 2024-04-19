package com.beans.market.main.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.beans.market.board.dao.BoardDAO;
import com.beans.market.board.dto.BoardDTO;
import com.beans.market.main.dao.MainDAO;
import com.beans.market.main.dto.MainDTO;
import com.beans.market.photo.dto.PhotoDTO;

@Service
public class MainService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MainDAO mainDao;


	/* 리스트로 뽑아오기 */
	public void goodsList(Model model) {
		List<MainDTO> list = mainDao.goodsList();
		
		
		for (MainDTO dto : list) {
			String seller = mainDao.sellerName(dto.getIdx());
			String photo = mainDao.mainPhoto(dto.getIdx());
			int successful_bid = 0;
			int bid_count = 0;
			
			if (dto.getOption().equals("경매")) {	// 시작가와 종료날짜는 디테일에서,,,?
				successful_bid = mainDao.fullPrice(dto.getIdx());
				bid_count = mainDao.bidCnt(dto.getIdx());
			} 
			
			dto.setSellerName(seller);
			dto.setNew_picname(photo);
			dto.setSuccessful_bid(successful_bid);
			dto.setBid_count(bid_count);
			
			logger.info(dto.getSubject()+" 옵션 ["+dto.getOption()+"]");
		}
		
		model.addAttribute("list", list);
	}


//	public Map<String, Object> goodsListAjax(Map<String, Object> map) {
//		List<MainDTO> list = mainDao.goodsList();
//
//		for (MainDTO dto : list) {
//			String seller = mainDao.sellerName(dto.getIdx());
//			String photo = mainDao.mainPhoto(dto.getIdx());
//			int successful_bid = 0;
//			int bid_count = 0;
//
//			if (dto.getOption().equals("경매")) { // 시작가와 종료날짜는 디테일에서,,,?
//				successful_bid = mainDao.fullPrice(dto.getIdx());
//				bid_count = mainDao.bidCnt(dto.getIdx());
//			}
//
//			dto.setSellerName(seller);
//			dto.setNew_picname(photo);
//			dto.setSuccessful_bid(successful_bid);
//			dto.setBid_count(bid_count);
//
//			logger.info(dto.getSubject() + " 옵션 [" + dto.getOption() + "]");
//		}
//		
//		map.put("list", list);
//		
//		return map;
//	}
	public Map<String, Object> goodsListAjax(Map<String, Object> map, String selectedSort, boolean isSell, boolean isAuction) {
		
		List<MainDTO> list;
		
		// 최신순은 그냥, 인기순은,, 관심목록 쪼인,,필요,,,,,,,,,,,,
		if (selectedSort.equals("최신순")) {
			if (isSell) {
				if (isAuction) {
					list = mainDao.goodsList();
				} else {
					list = mainDao.goodsList2();
				}
			} else {
				if (isAuction) {
					list = mainDao.goodsList3();
				} else {
					list = mainDao.goodsList4();
				}
			}
		} else {
			list = mainDao.goodsList();
		}

		for (MainDTO dto : list) {
			String seller = mainDao.sellerName(dto.getIdx());
			String photo = mainDao.mainPhoto(dto.getIdx());
			int successful_bid = 0;
			//int heartCnt = mainDao.heartCnt(dto.getIdx());
			int bid_count = 0;

			if (dto.getOption().equals("경매")) { // 시작가와 종료날짜는 디테일에서,,,?
				successful_bid = mainDao.fullPrice(dto.getIdx());
				bid_count = mainDao.bidCnt(dto.getIdx());
				
			}

			dto.setSellerName(seller);
			dto.setNew_picname(photo);
			dto.setSuccessful_bid(successful_bid);
			//dto.setHeartCnt(heartCnt);
			dto.setBid_count(bid_count);

			logger.info(dto.getSubject() + " 옵션 [" + dto.getOption() + "]");
		}
		
		map.put("list", list);
		
		return map;
	}


}
