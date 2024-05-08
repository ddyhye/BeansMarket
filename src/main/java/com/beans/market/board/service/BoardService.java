package com.beans.market.board.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
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
import com.beans.market.history.dao.HistoryDAO;
import com.beans.market.main.dao.MainDAO;
import com.beans.market.main.service.MainService;
import com.beans.market.member.dao.MemberDAO;
import com.beans.market.member.dto.MemberDTO;
import com.beans.market.member.dto.SellerDTO;
import com.beans.market.message.dao.MessageDAO;
import com.beans.market.pay.service.PayService;
import com.beans.market.photo.dao.PhotoDAO;
import com.beans.market.photo.dto.PhotoDTO;
import com.beans.market.photo.dto.ProfilePicDTO;


@Service
public class BoardService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public String upload_root="C:/upload/";
	
	@Autowired BoardDAO boardDAO;
	@Autowired PhotoDAO photoDAO;
	@Autowired MemberDAO memberDAO;
	@Autowired HistoryDAO historyDAO;
	@Autowired PayService payService;
	@Autowired MainDAO mainDAO;
	@Autowired MessageDAO messageDAO;
	@Autowired MainService mainService;

	public String goodsDetail(int idx, Model model) {
		String page = "board/saleOfGoodsDetail";
		BoardDTO dto = boardDAO.goodsDetail(idx);
		
		if(dto == null) return "redirect:/";

		if(dto.getOption().equals("경매")) {
			page = "board/auctionOfGoodsDetail";
			dto = boardDAO.auctionDetail(idx);
		}

		// 조회수 증가
		boardDAO.upHit(idx); // upHit
		
		// 게시글 출력
        logger.info("{} 게시물 정보  {}", idx, dto);
		
        // logger.info("게시 시간 : {}", dto.getReg_date());
		// reg_date가 .0이 붙어서 나오는 관계로 포멧 작업
        // SimpleDateFormat을 사용하여 날짜 형식 지정 -> dateFormat으로 날짜 포맷
        // SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        // String formattedDateTime = dateFormat.format(dto.getReg_date());
		
		if(dto.getOption().equals("경매")) {
			// formattedDateTime = dateFormat.format(dto.getClose_date());
			model.addAttribute("close_date", dto.getClose_date().toString());
			
			// 남은 시간이 종료 됐는데 입찰자가 있다면 예약중으로 변경하고 메시지 보내기 - 원래는 스케줄러로 했어야 함
			if (dto.getBbs_state().equals("거래가능")){
				LocalDateTime currentTime = LocalDateTime.now(); // 현재 시간 가져오기
			    LocalDateTime closeTime = 
			    		LocalDateTime.parse(dto.getClose_date().toString(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.0")); // 종료시간 설정하기
			    long remaingTime = ChronoUnit.SECONDS.between(currentTime, closeTime);
			    
			    if (remaingTime < 0) {
			    	// 최고 입찰자 가져오기
			    	String highestBidder = historyDAO.highestBidder(idx);
			    	String sellerEmail = dto.getEmail();
			    	
			    	if (highestBidder != null) {
			    		boardDAO.updateBbsState(idx, "예약중"); // 상태 예약중으로 변경
			    		boardDAO.updateReserveEmail(idx, highestBidder); // 최고 입찰자로 예약자 변경
			    		
			    		mainService.alarmSend(idx+"번 게시물 최고 입찰자로 경매 종료", highestBidder);
			    		mainService.alarmSend(idx+"번 게시물 경매 종료", sellerEmail);
			    		messageDAO.sendMessage("경매 종료 후 입찰자와 매칭되었습니다.", sellerEmail, highestBidder, idx);						
					} else { // 입찰자가 없다는 뜻이기에 숨기기
						mainService.alarmSend(idx+"번 게시물 입찰자 없이 경매 종료", sellerEmail);
						// 숨기기
						memberDAO.mySellManage(idx);
						
						model.addAttribute("hidden", "종료된 경매 입니다.");
					}
			    	
				}
			}
			dto = boardDAO.auctionDetail(idx);			
		}
		model.addAttribute("bbs", dto);
		model.addAttribute("reg_date", dto.getReg_date().toString());
		
        // 판매자 정보 - 이름, 거래 후기
		SellerDTO sellerInfo = memberDAO.sellerInfo(dto.getEmail());
		logger.info("판매자 닉네임 : {}", sellerInfo);
		model.addAttribute("sellerInfo", sellerInfo);
		
        // 판매자 프로필 사진
        ProfilePicDTO sellerPic = photoDAO.profile(dto.getEmail());
        model.addAttribute("sellerPic", sellerPic);
        logger.info("프로필 사진 : {}", sellerPic);
        logger.info(page);
        
		return page;  
	}

	public String interestToggle(String email, String className, int bbsIdx) {
		String result = "실패";
		int row = 0;
		if(className.equals("fa-solid fa-heart")) { // 빈 하트면 채운(solid) 하트로 바뀐 다음에 자바로 들어옴
			row = boardDAO.interestInsert(bbsIdx, email);
			if(row == 1) {
				result = "추가";
			}
		} else {
			row = boardDAO.interestDel(bbsIdx, email);
			if(row == 1) {
				result = "삭제";				
			}
		}
		
		return result;
	}

	public int biddingAjax(MemberDTO loginInfo, int bid_price, int bbsIdx) {
		int result = 5; // 5는 시스템 에러
		String email = loginInfo.getEmail();
		
		// 게시글 정보 가져오기
		BoardDTO bbsInfo = boardDAO.auctionDetail(bbsIdx);
		int successful_bid = bbsInfo.getSuccessful_bid();
		
		// 회원의 현재 포인트 가져오기
		int nowPoint = memberDAO.nowPoint(email);
		logger.info("bbsInfo : {}, nowPoint : {}", bbsInfo, nowPoint);

		// 현재 시간 가져오기
		LocalDateTime currentTime = LocalDateTime.now();
	    // 종료시간 설정하기
	    LocalDateTime closeTime = LocalDateTime.parse(bbsInfo.getClose_date().toString(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.0"));
	    long remaingTime = ChronoUnit.SECONDS.between(currentTime, closeTime);
	    logger.info("현재시간 : {}, colseDate : {}", currentTime, closeTime);
	    logger.info("남은 시간 : {}", remaingTime);
	    
		// 거래가능인거만 입찰 가능하도록 + 남은 시간이 있는 경우
		if (bbsInfo.getBbs_state().equals("거래가능") && remaingTime > 0) { // 거래가능 상태이고, 남은 시간이 종료되지 않았는가
			// bid_price와 비교 + 현재 내 페이 가격 가져오기 비교후 처리
			if ((bbsInfo.getPrice() > bid_price) || (bid_price == bbsInfo.getPrice() && bbsInfo.getBid_count() != 0)) { // 입찰금이 현재입찰가 보다 높은가
				logger.info("입찰 가능액보다 적게 입력");
				result = 2;
			} else if (bid_price > nowPoint) { // 현재 자신 포인트보다 입찰가 보다 높은가
				logger.info("포인트 부족");
				result = 3;
			} else if (bid_price%1000 > 0) { // 1000단위 입찰을 하였는가
				logger.info("입찰 가능액보다 적게 입력");
				result = 4;
			} else {
				if(successful_bid < bid_price) bid_price = successful_bid;
				if(successful_bid == bid_price) { // 즉시 구매시
					// 예약중으로, 종료시간을 현재시간으로
					boardDAO.updateBbsState(bbsIdx, "예약중");
					boardDAO.updateReserveEmail(bbsIdx, email);
					messageDAO.sendMessage("경매 종료 후 입찰자와 매칭되었습니다.", boardDAO.getEmail(bbsIdx), email, bbsIdx);
					mainService.alarmSend(bbsIdx+"번 게시물 낙찰되셨습니다.", email);
					mainService.alarmSend(bbsIdx+"번 게시물 경매 종료(낙찰)", boardDAO.getEmail(bbsIdx));
					
					Timestamp currentTimeStamp = Timestamp.valueOf(currentTime);
					logger.info("종료 시간을 현재시간으로 변경 : 현재 -> {}", currentTimeStamp);
					boardDAO.updateCloseDate(bbsIdx, currentTimeStamp);
					
					// 현재 사용자 예약자에 넣기 reserve_email + 쪽지 보내기
				} else {
					// 남은 시간이 5분 이하라면 10분이 추가 된다.
					if(remaingTime <= 300) {
						LocalDateTime newCloseTime = closeTime.plusMinutes(10);
						Timestamp newCloseTimestamp = Timestamp.valueOf(newCloseTime);
						logger.info("새로운 시간으로 변경 : {}", newCloseTimestamp);
						
						boardDAO.updateCloseDate(bbsIdx, newCloseTimestamp);
					} 
					if(bbsInfo.getBid_count() != 0) {
						// 이전 입찰자에게 반환과정 필요
						payService.bidReturn(bbsIdx);
					}					
				}
				// 입찰 히스토리에 추가
				int bidHisResult = historyDAO.bidHistoryInsert(email, bid_price, bbsIdx);
				if(bidHisResult == 1) logger.info("{} 번 게시물 입찰 완료", bbsIdx);
				
				// 입찰금 차감하고 입출금 히스토리 남기기
				payService.bidWithdrawal(email, bid_price, bbsIdx);						
				
				// 게시물 가격, 입찰횟수 변경
				int bbsResult = boardDAO.bidResultUpdate(bbsIdx, bid_price);
				
				logger.info("history {}, bbsResult {}", bidHisResult, bbsResult);
				
				if(bidHisResult == 1 && bbsResult == 2) result = 1;
				
				// 알림은 나중에 - 종료 되면 쪽지도 가야함
			}
			
		} // 거래 가능하고 남은시간 종료된거 END
		
		return result;
	}

	
	
	
	
	// 임시저장 글 삭제
	public void tempdel(String idx) {
		// 임시저장 Y일 때만 삭제하도록
		boardDAO.tempdel(idx);
	}

	// 입찰시 갱신되어 수정되야 하는 detail을 가져오기 위한 Ajax 
	public Map<String, Object> detailAjax(String idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		BoardDTO bbsInfo = boardDAO.auctionDetail(Integer.parseInt(idx));
		map.put("bbs_state", bbsInfo.getBbs_state());
		map.put("bid_count", bbsInfo.getBid_count());
		map.put("close_date", bbsInfo.getClose_date().toString());
		map.put("price", bbsInfo.getPrice());
		
		return map;
	}

	
	
	
	
	// 글작성
	//	public int writeBoard(Map<String, String> params) {
	//		
	//		return boardDAO.writeBoard(params);
	//	}

	public void writeBoard(Map<String, String> params, MemberDTO loginInfo, int priceInt, int start_priceInt, int immediate_priceInt, int auction_period, MultipartFile[] photos, String[] tempoPhotoNames) {
		BoardDTO dto = new BoardDTO();
		dto.setEmail(params.get("logEmail"));
		dto.setOption(params.get("option"));
		dto.setCategory_idx(params.get("category"));
		dto.setSubject(params.get("subject"));
		dto.setContent(params.get("content"));
		dto.setPlace(params.get("place"));
		dto.setLocation(loginInfo.getLocation());
		
		if(boardDAO.writeBoard(dto) > 0) {
			logger.info("글 작성 완료");
			
			int idx = dto.getIdx();
			
			if (dto.getOption().equals("판매")) {
				boardDAO.updatePrice(priceInt, idx);
				//fileSave(idx, photos);
				photoSave(idx, tempoPhotoNames);
			} else {
				boardDAO.updateAuctionPrice(start_priceInt, immediate_priceInt, idx);
				boardDAO.updateAuctionPrice2(start_priceInt, immediate_priceInt, auction_period, idx);
				photoSave(idx, tempoPhotoNames);
			}
		}
	}

	private void photoSave(int idx, String[] tempoPhotoNames) {
		for (String string : tempoPhotoNames) {
			if (string.equals(tempoPhotoNames[0])) {
				boardDAO.photoSave(idx, string);
			} else {
				boardDAO.photoSave2(idx, string);
			}
		}
	}

	// 임시저장
	public void tempSave(Map<String, String> params, int priceInt, int start_priceInt, int immediate_priceInt, int auction_period, MultipartFile[] photos) {
	    BoardDTO dto = new BoardDTO();
	    dto.setEmail(params.get("logEmail"));
	    dto.setOption(params.get("option"));
	    dto.setCategory_idx(params.get("category"));
	    dto.setSubject(params.get("subject"));
	    dto.setContent(params.get("content"));
	    dto.setPlace(params.get("place"));
	    dto.setDraft(params.get("draft")); // 임시 저장 여부 설정

	    if(boardDAO.tempSave(dto) > 0) {
	        logger.info("임시 저장 완료");
	        int idx = dto.getIdx();
	        
	        if (dto.getOption().equals("판매")) {
	            boardDAO.updatePrice(priceInt, idx);
	            fileSave(idx, photos);
	        } else {
	            boardDAO.updateAuctionPrice(start_priceInt, immediate_priceInt, idx); // bbs 업데이트
	            boardDAO.updateAuctionPrice2(start_priceInt, immediate_priceInt, auction_period, idx); // auction 업데이트
	            fileSave(idx, photos);
	        }
	    }
	}


	// 사진 DB에 저장
	private void fileSave(int idx, MultipartFile[] photos) {		
     for(MultipartFile photo : photos) {
        // 1. 원래 이름 추출
        String orifilename = photo.getOriginalFilename();
        // 2. 확장만 뗴내서 새로운 이름 생성
        String ext = orifilename.substring(orifilename.lastIndexOf("."));
        String newfileName = System.currentTimeMillis()+ext;
        
        try {
           // 3. 파일 저장
           Path path = Paths.get(upload_root+newfileName);
           Files.write(path, photo.getBytes());
           // 4. DB에 저장
    	   if (photo == photos[0]) {
    		   boardDAO.savePhoto(idx,orifilename,newfileName);
    	   } else {
    		   boardDAO.savePhoto2(idx,orifilename,newfileName);
    	   }
           
           Thread.sleep(1);
        } catch (Exception e) {
           e.printStackTrace();
        }
      }
	}

	public String getEmail(int idx) {
		logger.info("{} 번 게시자 이메일 가져오기", idx);
		return boardDAO.getEmail(idx);
	}

	
	public BoardDTO getBoardInfo(int idx) {
		logger.info("{} 번 정보 가져오기", idx);
		return boardDAO.goodsDetail(idx);
	}
	

	public List<BoardDTO> Listcall(String email) {
		
		return boardDAO.list(email);
	}

	public Map<String, Object> reserveToggleAjax(String reserve, String email, int idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		int row = 0;
		String returnReserve = "";
		String bbs_state = "";
		boolean result = false;
		
		BoardDTO dto = boardDAO.goodsDetail(idx);
		if(!dto.getOption().equals("경매")) { // 막아둘거지만 혹시라도 경매 게시물로 버튼 클릭시 서버측에서 한번 더 막도록
			if(reserve.equals("예약")) {
				bbs_state = "예약중";
				row = boardDAO.reserveUpdate(email, idx, bbs_state);
				if (row == 1) {
					returnReserve = "예약 취소";
					mainService.alarmSend(idx+"번 게시물 예약되셨습니다.", email);
				}
			} else if(reserve.equals("예약 취소")) {
				bbs_state = "거래가능";
				row = boardDAO.reserveUpdate(null, idx, bbs_state);
				if (row == 1) {
					returnReserve = "예약";
					mainService.alarmSend(idx+"번 게시물 예약 취소되셨습니다.", email);
				}
			}
			logger.info(returnReserve+"로 변경");
			result = true;
			
			map.put("idx", idx);
			map.put("reserve", returnReserve);		
		}
		map.put("result", result);
		
		return map;
	}

	public void updataBbsState(int idx, String state) {
		boardDAO.updateBbsState(idx, state);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 게시글의 판매자가 나인가?
	public int myBbsCheck(Integer idx, String email) {
		return boardDAO.myBbsCheck(idx, email);
	}
	// 게시글 수정하기로 이동
	public BoardDTO goodsUpdate(int idxInt) {
		return boardDAO.goodsDetail(idxInt);
	}
	// 게시글 수정
	public void goodsUpdate(int idxInt, int priceInt, String category, String subject, String content, String place, MultipartFile[] photos) {
		boardDAO.goodsUpdate(idxInt, priceInt, category, subject, content, place);
	}

	// 글 작성 시, 사진 미리보기
	public Map<String, Object> tempoPhoto(Map<String, Object> map, MultipartFile[] photos) {
		// 포토 임시 인덱스 번호. (게시글의,,)
		int photoTempoIdx = (int) (System.currentTimeMillis() % Integer.MAX_VALUE);
		
		List<String> list = tempoPhotoSave(photoTempoIdx, photos);
		List<Integer> list2 = new ArrayList<Integer>();
		
		// 포토의 새로운 내임으로 pic_idx 찾기
		for (String string : list) {
			int pic_idx = boardDAO.tempoPhotoGetPicidx(string);
			list2.add(pic_idx);
		}
		
		map.put("list", list);
		map.put("list2", list2);
		// 글 작성 완료 누르면 해당 게시글의 idx로 수정하기 위한 식별 임시 idx값..
		// 근데 이거없어도 new_picname이 unique하므로 괜찮을듯? 확인해보기
		// --> 아님. 삭제때문ㅇ ㅔ필요함
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
	           boardDAO.tempoPhoto(idx, orifilename, newfileName);
	           
	           Thread.sleep(1);
	        } catch (Exception e) {
	           e.printStackTrace();
	        }
	    }
	    
	    return tempoPhotosName;
	}
	// 사진 미리보기 삭제
	public Map<String, Object> tempoPhotoDel(Map<String, Object> map, int pic_idx, int tempoBbsIdx) {
		boardDAO.tempoPhotoDel(pic_idx);
		
		List<String> list = boardDAO.tempoPhotoGetNames(tempoBbsIdx);
		List<Integer> list2 = new ArrayList<Integer>();
		
		// 포토의 새로운 내임으로 pic_idx 찾기
		for (String string : list) {
			int pic_idx2 = boardDAO.tempoPhotoGetPicidx(string);
			list2.add(pic_idx2);
		}
		
		map.put("list", list);
		map.put("list2", list2);
		map.put("photoTempoIdx", tempoBbsIdx);
		
		return map;
	}

	public Map<String, Object> tempoPhotoAnother(Map<String, Object> map, MultipartFile[] photos, int tempoBbsIdx) {
		tempoPhotoSave(tempoBbsIdx, photos);
		
		List<String> list = boardDAO.tempoPhotoGetNames(tempoBbsIdx);
		List<Integer> list2 = new ArrayList<Integer>();
		
		// 포토의 새로운 내임으로 pic_idx 찾기
		for (String string : list) {
			int pic_idx = boardDAO.tempoPhotoGetPicidx(string);
			list2.add(pic_idx);
		}
		
		map.put("list", list);
		map.put("list2", list2);
		map.put("photoTempoIdx", tempoBbsIdx);
		
		return map;
	}

	public List<PhotoDTO> goodsUpdatePic(int idxInt) {
		return boardDAO.goodsUpdatePic(idxInt);
	}

	
	
	// 글 숨김
	public void saleOfGoodsHidden(int idx) {
		memberDAO.mySellManage(idx);
	}
	// 글 삭제
	public void saleOfGoodsDel(int idx) {
		memberDAO.mySellManage3(idx);
	}
	

	
}
