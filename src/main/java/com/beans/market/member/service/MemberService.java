package com.beans.market.member.service;


import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.beans.market.main.dao.MainDAO;
import com.beans.market.main.dto.MainDTO;
import com.beans.market.member.dao.MemberDAO;
import com.beans.market.member.dto.AuctionDTO;
import com.beans.market.member.dto.BlockDTO;
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.member.dto.SellerDTO;
import com.beans.market.photo.dto.ProfilePicDTO;

@Service
public class MemberService {

   Logger logger = LoggerFactory.getLogger(getClass());
   
   public String upload_root="C:/upload/";
   
   @Autowired MemberDAO memberDAO;
   @Autowired MainDAO mainDAO;
   @Autowired MainDAO mainDao;

   public int connectTest() {
      return memberDAO.connectTest();
   }

   public int overlay(String id) {
      
      return memberDAO.overlay(id);
   }

   public MemberDTO login(String email, String password) {
      
      return memberDAO.login(email,password);
   }



   public int join(Map<String, String> param) {

      return memberDAO.join(param);
   }

   public Object joinoverlay(String email) {

      return memberDAO.joinoverlay(email);
   }

   public void updateLastLoginDate(Map<String, Object> params) {
       memberDAO.updateLastLoginDate(params);
   }

    public void newPW(String email, String pw) {
       logger.info("email: " + email);
       logger.info("pw: " + pw);
       memberDAO.newPW(email, pw);
       
    }

	public void saveProfilePic(Map<String, Object> profileParam) {
		memberDAO.saveprofile(profileParam);
		
	} 
	
	public void otherprofile(String email, Model model) {
		SellerDTO sellerInfo = memberDAO.sellerInfo(email);
		 
		logger.info("판매자 닉네임 : {}", sellerInfo);
		model.addAttribute("sellerInfo", sellerInfo);
		model.addAttribute("name", sellerInfo);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*                   도혜                     */
	// 메인 임시 로그인
	public String logEmail(String email, String password) {
		return memberDAO.logEmail(email, password);
	}

	// 회원 특정 게시물 좋아요 정보 가져오기
	public int getInterest(Integer idx, String email) {
		logger.info("좋아요 정보 가져오기");
		return mainDAO.mine(idx, email);
	}
	
	// 마이페이지 - 프로필 업데이트
	public ProfilePicDTO profilePicGet(String logEmail) {
		return memberDAO.profilePicGet(logEmail);
	}
	public MemberDTO profileGet(String logEmail) {
		return memberDAO.profileGet(logEmail);
	}
	// 마이페이지 - 프로필 사진 업데이트 (수정 완료 전)
	public String newPicPath(String logEmail, MultipartFile photo) {
		String orifilename = photo.getOriginalFilename();
		String ext = orifilename.substring(orifilename.lastIndexOf("."));
		String newFileName = System.currentTimeMillis()+ext;
		
		try {
			Path path = Paths.get(upload_root+newFileName);
			Files.write(path, photo.getBytes());
			
			memberDAO.newPicPath(logEmail, newFileName);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("실패");
		}
		
		return newFileName;
	}
	// 마이페이지 - 프로필 업데이트 완료
	public MemberDTO profileUpdate(Map<String, String> param) {
		/*
		 * 새로운 realPicName을 컬럼 N에서 O로 변경
		 * O를 제외하곤 전부 삭제
		 * O를 Y로 변경
		 * */
		memberDAO.profilePicO(param);
		memberDAO.profilePicDel(param);
		memberDAO.profilePicY(param);
		// 정보 업데이트하자!
		memberDAO.profileUpdate(param);
		
		return memberDAO.profileGet(param.get("logEmail"));
	}


	// 관심목록 페이지
	public Map<String, Object> goodsListAjax(Map<String, Object> map, String logEmail) {
		List<MainDTO> list = new ArrayList<MainDTO>(); 
		
		int[] mineIdxList = memberDAO.mineIdxList(logEmail);
		
		//list = memberDAO.mineGoodsList(logEmail);
		
		for (int i = 0; i < mineIdxList.length; i++) {
			MainDTO dto = memberDAO.mineIdxGoodsList(mineIdxList[i]);
			list.add(dto);
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


	// 마이페이지 - 차단 목록 리스트
	public Map<String, Object> banList(Map<String, Object> map, String logEmail) {
		// 로그인 회원의 차단 회원 이메일 리스트 불러오기
		/*
		 * List<String> banEmailList = new ArrayList<String>(); for (String string :
		 * banEmailList) { banEmailList.add(memberDAO.banList(logEmail)); }
		 * logger.info("banEmailList: {}", banEmailList);
		 * 
		 * // 차단 회원 이메일 리스트로 닉네임 불러오기 List<MemberDTO> list = new ArrayList<MemberDTO>();
		 * for (String string : banEmailList) { MemberDTO dto =
		 * memberDAO.banProfile(string); list.add(dto); } logger.info("list: {}", list);
		 */
		List<BlockDTO> list = memberDAO.banList(logEmail);
		
		for (BlockDTO dto : list) {
			String banName = memberDAO.banProfile(dto.getBlock_email());
			dto.setBlock_name(banName);
		}
		
		map.put("list", list);
		
		return map;
	}
	// 회원 차단 해제
	public Map<String, Object> banUnravel(Map<String, Object> map, String logEmail, String blockEmail) {
		memberDAO.banUnravel(logEmail, blockEmail);
		
		List<BlockDTO> list = memberDAO.banList(logEmail);
		
		for (BlockDTO dto : list) {
			String banName = memberDAO.banProfile(dto.getBlock_email());
			dto.setBlock_name(banName);
		}
		
		map.put("list", list);
		
		return map;
	}	
	
	public Map<String, Object> mySellList(Map<String, Object> map, String logEmail, String selectedSort) {
		/* 사진, 제목, 가격, 옵션(판매,경매), 게시글 거래 상태, 숨김, */
		List<MainDTO> list = new ArrayList<MainDTO>();
		int[] mineIdxList = null;
		
		if (selectedSort.equals("전체보기")) {
			mineIdxList = memberDAO.mySellIdxList(logEmail);
		} else if(selectedSort.equals("판매 중")) {
			mineIdxList = memberDAO.mySellIdxList2(logEmail);
		} else if(selectedSort.equals("거래 완료")) {
			mineIdxList = memberDAO.mySellIdxList3(logEmail);
		} else if(selectedSort.equals("숨김")) {
			mineIdxList = memberDAO.mySellIdxList4(logEmail);
		}
		
		for (int i = 0; i < mineIdxList.length; i++) {
			MainDTO dto = memberDAO.mySellIdxGoodsList(mineIdxList[i]);
			if (dto == null) {
		        logger.info("DTO is null for index: " + mineIdxList[i]);
		    } else {
		        list.add(dto);
		    }
		}

		map.put("list", bbsListDB(list, logEmail));
		
		return map;
	}

	public Map<String, Object> mySellManage(Map<String, Object> map, String logEmail, int intIdx, String pText) {		
		// 숨김 또는 삭제(블라인드) 처리
		if (pText.equals("숨김")) {
			memberDAO.mySellManage(intIdx);
		} else if(pText.equals("숨김 해제")) {
			memberDAO.mySellManage2(intIdx);
		} else if(pText.equals("삭제")) {
			memberDAO.mySellManage3(intIdx);
		}
		
		List<MainDTO> list = new ArrayList<MainDTO>();
		int[] mineIdxList = null;
		
		mineIdxList = memberDAO.mySellIdxList(logEmail);
		
		for (int i = 0; i < mineIdxList.length; i++) {
			MainDTO dto = memberDAO.mySellIdxGoodsList(mineIdxList[i]);
			if (dto == null) {
		        logger.info("DTO is null for index: " + mineIdxList[i]);
		    } else {
		        list.add(dto);
		    }
		};
		
		map.put("list", bbsListDB(list, logEmail));
		
		return map;
	}
	
	// 마이페이지 - 구매 내역
	public Map<String, Object> myBuyList(Map<String, Object> map, String logEmail) {
		List<MainDTO> list = new ArrayList<MainDTO>();
		int[] mineIdxList = memberDAO.myBuyIdxList(logEmail);
		
		for (int i = 0; i < mineIdxList.length; i++) {
			MainDTO dto = memberDAO.mySellIdxGoodsList(mineIdxList[i]);
			if (dto == null) {
		        logger.info("DTO is null for index: " + mineIdxList[i]);
		    } else {
		        list.add(dto);
		    }
		}

		map.put("list", bbsListDB(list, logEmail));
		
		return map;
	}
	public Map<String, Object> myBuyManage(Map<String, Object> map, String logEmail, int intIdx, String pText) {
		// 숨김 또는 삭제(블라인드) 처리
		if (pText.equals("삭제")) {
			memberDAO.myBuyManage(intIdx);
		} 
		
		List<MainDTO> list = new ArrayList<MainDTO>();
		int[] mineIdxList = null;
		
		mineIdxList = memberDAO.myBuyIdxList(logEmail);
		
		for (int i = 0; i < mineIdxList.length; i++) {
			MainDTO dto = memberDAO.mySellIdxGoodsList(mineIdxList[i]);
			if (dto == null) {
		        logger.info("DTO is null for index: " + mineIdxList[i]);
		    } else {
		        list.add(dto);
		    }
		};
		
		map.put("list", bbsListDB(list, logEmail));
		
		return map;
	}
	/*
	public void otherprofile(String email, Model model) {
				SellerDTO sellerInfo = memberDAO.sellerInfo(email);
				 
				logger.info("판매자 닉네임 : {}", sellerInfo);
				model.addAttribute("sellerInfo", sellerInfo);
				model.addAttribute("name", sellerInfo);
	}
	*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	// 나의 입찰내역
	public Map<String, Object> auctionBid(Map<String, Object> map, String logEmail) {
		List<AuctionDTO> list = memberDAO.auctionBid(logEmail);
		
		for (AuctionDTO dto : list) {
			// 사진 경로명, 게시글 제목, 경매 종료날짜, 게시글 거래 상태 (거래완료면 낙찰, 그 외엔 입찰 중), 현재입찰자는 추후..
			String new_picname = memberDAO.getBidPic(dto.getIdx());
			String subject = memberDAO.getBidSubject(dto.getIdx());
			Timestamp close_date = memberDAO.getBidClose(dto.getIdx());
			String state = memberDAO.getBidState(dto.getIdx());
			
			dto.setNew_picname(new_picname);
			dto.setSubject(subject);
			dto.setClose_date(close_date);
			if (state.equals("거래완료")) {
				dto.setBbs_state("낙찰");
			} else {
				dto.setBbs_state("입찰 중");
			}
		}
		
		map.put("list", list);
		
		return map;
		
	}

}
