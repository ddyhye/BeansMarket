package com.beans.market.message.dao;

import java.util.List;

import com.beans.market.message.dto.MessageDTO;
import com.beans.market.message.dto.RoomDTO;

public interface MessageDAO {

	List<MessageDTO> messageList(int idx, String email, String otherEmail);

	int sendMessage(String content, String receiveEmail, String senderEmail, int idx);

	List<RoomDTO> roomList(String email);

	RoomDTO lastContent(int idx, String other_email, String email);

	int sendMessagePic(MessageDTO dto);

	MessageDTO getMessageInfo(int message_idx);

	int updateSenderDel(int message_idx);

	int updateReceiveDel(int message_idx);

	void messageRead(int idx, String email, String otherEmail);

}
