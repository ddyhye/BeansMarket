package com.beans.market.main.service;

import java.util.ArrayList;
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
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.photo.dto.PhotoDTO;
import com.beans.market.photo.dto.ProfilePicDTO;

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
		}
		
		model.addAttribute("list", list);
	}


	public Map<String, Object> goodsListAjax(Map<String, Object> map, String logEmail, String selectedSort, boolean isSell, boolean isAuction) {
		
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
			if (isSell) {
				if (isAuction) {
					list = mainDao.goodsHitList();
				} else {
					list = mainDao.goodsHitList2();
				}
			} else {
				if (isAuction) {
					list = mainDao.goodsHitList3();
				} else {
					list = mainDao.goodsHitList4();
				}
			}
		}

		map.put("list", bbsListDB(list, logEmail));
		
		return map;
	}
	
	
	
	public void goodsHeartAjax(int idxInt, String logEmail) {
		mainDao.clickHeart(idxInt, logEmail);
	}
	public void goodsDeleteHeartAjax(int idxInt, String logEmail) {
		mainDao.deleteHeart(idxInt, logEmail);
	}


	
	
	public Map<String, Object> bbsSearch(Map<String, Object> map, String textVal, String logEmail) {
		List<MainDTO> list = mainDao.bbsSearch(textVal);
		
		map.put("list", bbsListDB(list, logEmail));
		
		return map;
	}


	public Map<String, Object> bbsCategorySearch(Map<String, Object> map, String textVal, String logEmail) {
		List<MainDTO> list = mainDao.bbsCategorySearch(textVal);
		
		map.put("list", bbsListDB(list, logEmail));
		
		return map;
	}
	
	
	public Map<String, Object> recentBBS(Map<String, Object> map, List<String> currLookArr, String logEmail) {
		List<MainDTO> list = new ArrayList<>();
		
		for (String item : currLookArr) {
			int idx = Integer.parseInt(item);
			
			MainDTO dto = mainDao.recentBBS(idx);
			
			if (dto != null) {
				list.add(dto);
			} else {
				list.add(MainDTO.emptyDTO());
			}
		}
		
		map.put("list", bbsListDB(list, logEmail));
		
		return map;
	}
	
	
	// 판매자 닉네임, 대표사진, 관심개수, 로그인사용자의 찜 확인, 즉구가(낙찰), 입찰 횟수(낙찰) 의 경우,
	// 각 게시글의 idx로 찾아와야 한다.
	public List<MainDTO> bbsListDB(List<MainDTO> list, String logEmail) {
		for (MainDTO dto : list) {
			// dto가 존재할 경우에만 (idx==0이면 매퍼에서 0을 반환했다는 의미)
			if (dto.getIdx() != 0) {
				String seller = mainDao.sellerName(dto.getIdx());
				String photo = mainDao.mainPhoto(dto.getIdx());
				int successful_bid = 0;
				int heartCnt = mainDao.heartCnt(dto.getIdx());
				int bid_count = 0;
				int mine = 0;
				
				if (!logEmail.equals("")) {		//nullPointException 해결하기
					mine = mainDao.mine(dto.getIdx(), logEmail);
				}
				if (dto.getOption().equals("경매")) {
					successful_bid = mainDao.fullPrice(dto.getIdx());
					bid_count = mainDao.bidCnt(dto.getIdx());
					
				}
				dto.setSellerName(seller);
				dto.setNew_picname(photo);
				dto.setSuccessful_bid(successful_bid);
				dto.setHeartCnt(heartCnt);
				dto.setBid_count(bid_count);
				dto.setMine(mine);
			}
		}
		
		return list;
	}


	public int newAlarm(String logEmail) {
		return mainDao.newAlarm(logEmail);
	}
	public List<MainDTO> alarm(String logEmail) {
		return mainDao.alarm(logEmail);
	}
	public void alarmRead(int idxInt) {
		mainDao.alarmRead(idxInt);
	}
	public void alarmSend(String content, String email) {
		mainDao.alarmSend(content, email);
	}
	public void alarmSend(String content, String email, String link) { // 오버로드
		mainDao.alarmSendLink(content, email, link);
	}
	
	
	
	
	public MemberDTO profile(String logEmail) {
		return mainDao.profile(logEmail);
	}
	public ProfilePicDTO profilePic(String logEmail) {
		return mainDao.profilePic(logEmail);
	}


	public String nicname(String logEmail) {
		return mainDao.nicname(logEmail);
	}









}
