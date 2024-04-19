package com.beans.market.board.service;

import java.text.SimpleDateFormat;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.beans.market.board.dao.BoardDAO;
import com.beans.market.board.dto.BoardDTO;
import com.beans.market.photo.dao.PhotoDAO;
import com.beans.market.photo.dto.ProfilePicDTO;


@Service
public class BoardService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired BoardDAO boardDAO;
	@Autowired PhotoDAO photoDAO;

	public String goodsDetail(int idx, Model model) {
		String page = "board/saleOfGoodsDetail";
		BoardDTO dto = boardDAO.goodsDetail(idx);
		
		if(dto.getOption().equals("경매")) {
			page = "board/auctionOfGoodsDetail";
			dto = boardDAO.auctionDetail(idx);
		} 
		
		// 조회수 증가
		boardDAO.upHit(idx); // upHit
		
		// 게시글 출력
		model.addAttribute("bbs", dto);
        logger.info("{} 게시물 정보  {}", idx, dto);
		
		// reg_date가 .0이 붙어서 나오는 관계로 포멧 작업
        // SimpleDateFormat을 사용하여 날짜 형식 지정 -> dateFormat으로 날짜 포맷
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = dateFormat.format(dto.getReg_date());
		model.addAttribute("reg_date",formattedDateTime);
		if(dto.getOption().equals("경매")) {
			formattedDateTime = dateFormat.format(dto.getClose_date());
			model.addAttribute("close_date",formattedDateTime);			
		}
        
        // 프로필 사진
        ProfilePicDTO profile = photoDAO.profile(dto.getEmail());
        model.addAttribute("profilePic", profile);
        
        logger.info(page);
        
		return page;  
	}

	public String interestToggle(String className, int bbsIdx) {
		String result = "실패";
		int row = 0;
		if(className.equals("fa-solid fa-heart")) {
			row = boardDAO.interestInsert(bbsIdx, "zxz0608@naver.com");
			if(row == 1) {
				result = "추가";
			}
		} else {
			row = boardDAO.interestDel(bbsIdx, "zxz0608@naver.com");
			if(row == 1) {
				result = "삭제";				
			}
		}
		
		return result;
	}

	public int write(Map<String, String> map) {
		int row = -1;
		row = boardDAO.write(map);
		logger.info("insert count :"+row);
		return row;
	}

	
	
	
	
}
