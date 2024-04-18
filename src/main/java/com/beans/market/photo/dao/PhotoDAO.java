package com.beans.market.photo.dao;

import java.util.List;

import com.beans.market.photo.dto.PhotoDTO;
import com.beans.market.photo.dto.ProfilePicDTO;

public interface PhotoDAO {

	ProfilePicDTO profile(String email);

	List<PhotoDTO> photos(int idx, int option_idx);

}
