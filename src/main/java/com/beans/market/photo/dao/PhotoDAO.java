package com.beans.market.photo.dao;

import java.util.List;

import com.beans.market.photo.dto.PhotoDTO;
import com.beans.market.photo.dto.ProfilePicDTO;

public interface PhotoDAO {

	ProfilePicDTO profile(String email);

	List<PhotoDTO> photos(int idx, int option_idx);

	String getMainPhoto(int idx, int opiton_idx);

	void insertPhoto(String newFileName, int message_idx, int option);

}
