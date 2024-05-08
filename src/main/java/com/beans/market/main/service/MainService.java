package com.beans.market.main.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.beans.market.board.dao.BoardDAO;
import com.beans.market.board.dto.BoardDTO;
import com.beans.market.main.dao.MainDAO;
import com.beans.market.main.dto.InquiryDTO;
import com.beans.market.main.dto.MainDTO;
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.photo.dto.PhotoDTO;
import com.beans.market.photo.dto.ProfilePicDTO;

@Service
public class MainService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public String upload_root="C:/upload/";
	
	@Autowired MainDAO mainDao;


	/* 리스트로 뽑아오기 (테스트) */
//	public void goodsList(Model model) {
//		List<MainDTO> list = mainDao.goodsList();
//		
//		
//		for (MainDTO dto : list) {
//			String seller = mainDao.sellerName(dto.getIdx());
//			String photo = mainDao.mainPhoto(dto.getIdx());
//			int successful_bid = 0;
//			int bid_count = 0;
//			
//			if (dto.getOption().equals("경매")) {	// 시작가와 종료날짜는 디테일에서,,,?
//				successful_bid = mainDao.fullPrice(dto.getIdx());
//				bid_count = mainDao.bidCnt(dto.getIdx());
//			} 
//			
//			dto.setSellerName(seller);
//			dto.setNew_picname(photo);
//			dto.setSuccessful_bid(successful_bid);
//			dto.setBid_count(bid_count);
//		}
//		
//		model.addAttribute("list", list);
//	}


	public Map<String, Object> goodsListAjax(Map<String, Object> map, String logEmail, String selectedSort, boolean isSell, boolean isAuction, int currentPage) {
		
		List<MainDTO> list;
		
		int startNo = (currentPage-1) * 24;
		int totalPages = 1;
		
		// 최신순은 그냥, 인기순은,, 관심목록 쪼인,,필요,,,,,,,,,,,,
		if (selectedSort.equals("최신순")) {
			if (isSell) {
				if (isAuction) {
					list = mainDao.goodsList(logEmail, startNo);
					totalPages = mainDao.allCount(logEmail, startNo);
				} else {
					list = mainDao.goodsList2(logEmail, startNo);
					totalPages = mainDao.allCount2(logEmail, startNo);
				}
			} else {
				if (isAuction) {
					list = mainDao.goodsList3(logEmail, startNo);
					totalPages = mainDao.allCount3(logEmail, startNo);
				} else {
					list = mainDao.goodsList4(logEmail, startNo);
					totalPages = mainDao.allCount4(logEmail, startNo);
				}
			}
		} else {
			if (isSell) {
				if (isAuction) {
					list = mainDao.goodsHitList(logEmail, startNo);
					totalPages = mainDao.allCount(logEmail, startNo);
				} else {
					list = mainDao.goodsHitList2(logEmail, startNo);
					totalPages = mainDao.allCount2(logEmail, startNo);
				}
			} else {
				if (isAuction) {
					list = mainDao.goodsHitList3(logEmail, startNo);
					totalPages = mainDao.allCount3(logEmail, startNo);
				} else {
					list = mainDao.goodsHitList4(logEmail, startNo);
					totalPages = mainDao.allCount4(logEmail, startNo);
				}
			}
		}

		map.put("list", bbsListDB(list, logEmail));
		map.put("currentPage", currentPage);
		map.put("totalPages", totalPages);
		
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
	public String alarmReadUrl(int idxInt) {
		return mainDao.alarmReadUrl(idxInt);
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



	public Map<String, Object> tempoPhoto(Map<String, Object> map, MultipartFile[] photos) {
		// 포토 임시 인덱스 번호. (게시글의,,)
		int photoTempoIdx = (int) (System.currentTimeMillis() % Integer.MAX_VALUE);
		
		List<String> list = tempoPhotoSave(photoTempoIdx, photos);
		List<Integer> list2 = new ArrayList<Integer>();
		
		// 포토의 새로운 내임으로 pic_idx 찾기
		for (String string : list) {
			int pic_idx = mainDao.tempoPhotoGetPicidx(string);
			list2.add(pic_idx);
		}
		
		map.put("list", list);
		map.put("list2", list2);
		map.put("photoTempoIdx", photoTempoIdx);
		
		return map;
	}
	// 사진 임시 디비 및 서버에 저장
	private List<String> tempoPhotoSave(long idx, MultipartFile[] photos) {	
		List<String> tempoPhotosName = new ArrayList<String>();
		
	    for(MultipartFile photo : photos) {
	        // 1. 원래 이름 추출
	        String orifilename = photo.getOriginalFilename();
	        // 2. 확장만 뗴내서 새로운 이름 생성
	        String ext = orifilename.substring(orifilename.lastIndexOf("."));
	        String newfileName = System.currentTimeMillis()+ext;
	        tempoPhotosName.add(newfileName);
	        
	        try {
	           // 3. 파일 저장
	           Path path = Paths.get(upload_root+newfileName);
	           Files.write(path, photo.getBytes());
	           // 4. DB에 저장
	           mainDao.tempoPhoto(idx, orifilename, newfileName);
	           
	           Thread.sleep(1);
	        } catch (Exception e) {
	           e.printStackTrace();
	        }
	    }
	    
	    return tempoPhotosName;
	}



	public Map<String, Object> tempoPhotoAnother(Map<String, Object> map, MultipartFile[] photos, int tempoBbsIdx) {
		tempoPhotoSave(tempoBbsIdx, photos);
		
		List<String> list = mainDao.tempoPhotoGetNames(tempoBbsIdx);
		List<Integer> list2 = new ArrayList<Integer>();
		
		// 포토의 새로운 내임으로 pic_idx 찾기
		for (String string : list) {
			int pic_idx = mainDao.tempoPhotoGetPicidx(string);
			list2.add(pic_idx);
		}
		
		map.put("list", list);
		map.put("list2", list2);
		map.put("photoTempoIdx", tempoBbsIdx);
		
		return map;
	}



	public Map<String, Object> tempoPhotoDel(Map<String, Object> map, int pic_idx, int tempoBbsIdx) {
		mainDao.tempoPhotoDel2(pic_idx);
		
		List<String> list = mainDao.tempoPhotoGetNames(tempoBbsIdx);
		List<Integer> list2 = new ArrayList<Integer>();
		
		// 포토의 새로운 내임으로 pic_idx 찾기
		for (String string : list) {
			int pic_idx2 = mainDao.tempoPhotoGetPicidx(string);
			list2.add(pic_idx2);
		}
		
		map.put("list", list);
		map.put("list2", list2);
		map.put("photoTempoIdx", tempoBbsIdx);
		
		return map;
	}



	public void writeInquire(Map<String, String> params, MultipartFile[] photos, String[] tempoPhotoNames) {
		InquiryDTO dto = new InquiryDTO();
		dto.setEnquirer(params.get("logEmail"));
		dto.setInquiry_title(params.get("inquireSubject"));
		dto.setCategory_idx(params.get("category"));
		dto.setInquiry_pw(params.get("inquirePw"));
		dto.setInquiry_account(params.get("content"));
		
		if (mainDao.writeInquire(dto) > 0) {
			int inquiry_idx = dto.getInquiry_idx();
			
			photoSave(inquiry_idx, tempoPhotoNames);
		}
	}
	private void photoSave(int idx, String[] tempoPhotoNames) {
		if (tempoPhotoNames != null && tempoPhotoNames.length != 0) {
			for (String string : tempoPhotoNames) {
				mainDao.photoSave(idx, string);
			}
		}
	}



	public Map<String, Object> inquireListAjax(Map<String, Object> map, String logEmail, String inquireSort, String inquireSearch) {
		List<InquiryDTO> list = new ArrayList<InquiryDTO>();
		
		// 검색 내용이 있는지
		if (!inquireSearch.equals("")) {
			if (inquireSort.equals("all")) {
				list = mainDao.inquireListAjax();
			} else if(inquireSort.equals("subject")) {
				list = mainDao.inquireListAjax();
			} else if(inquireSort.equals("content")) {
				list = mainDao.inquireListAjax();
			}
		} else {
			list = mainDao.inquireListAjax();
		}

		map.put("list", list);
		
		return map;
	}



	public InquiryDTO inquireDetail(int idxInt) {
		return mainDao.inquireDetail(idxInt);
	}



	public List<PhotoDTO> inquireGetPhoto(int idxInt) {
		return mainDao.inquireGetPhoto(idxInt);
	}










}
