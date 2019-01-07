package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatController {
	@RequestMapping("chat/chat")
	public String chat() {
		return null;//원래는 "chat/chat" : view이름 설정. null을 넣어도 chat/chat.jsp로 이동한다.(null인 경우 url이 "chat/chat"이므로, view는 chat/chat.jsp로 설정
	}
}
