package com.beans.market.message.dao;

import java.util.List;

import com.beans.market.message.dto.MessageDTO;

public interface MessageDAO {

	List<MessageDTO> messageList(int idx, String email, String otherEmail);

	int sendMessage(String content, String receiveEmail, String senderEmail, int idx);

}
