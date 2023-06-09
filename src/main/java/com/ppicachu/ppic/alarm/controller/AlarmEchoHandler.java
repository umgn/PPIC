package com.ppicachu.ppic.alarm.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.ppicachu.ppic.alarm.model.service.AlarmService;
import com.ppicachu.ppic.alarm.model.vo.Alarm;
import com.ppicachu.ppic.member.model.vo.Member;

@Controller
public class AlarmEchoHandler extends TextWebSocketHandler{
	
	@Autowired
	private AlarmService aService;

	private ArrayList<WebSocketSession> sessionList = new ArrayList<>();  
	HashMap<String, WebSocketSession> userSessions = new HashMap<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		userSessions.put(String.valueOf(((Member)session.getAttributes().get("loginUser")).getUserNo()), session);
	}
	
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception { 
		String msg =  (String) message.getPayload();
		String[] strs = msg.split(",");
		if(strs != null) {
			// 알림소분류,발신자회원번호,발신자이름,수신자회원번호,알림대분류,알림내용
			String dcatNo = strs[0];
			String sendNo = strs[1];
			String sendName = strs[2];
			String receiveNo = strs[3];
			String catNo = strs[4];
			String title = strs[5];
			
			String[] receives = receiveNo.split("/");
			TextMessage tmpMsg = null;
			WebSocketSession receiveSession = null;
			switch(dcatNo) {
			case "0": tmpMsg = new TextMessage(sendName + "님이 \"" + title + "\"을(를) 승인했어요."); break;
			case "1": tmpMsg = new TextMessage(sendName + "님이 \"" + title + "\"을(를) 반려했어요."); break;
			case "2": tmpMsg = new TextMessage(sendName + "님이 \"" + title + "\"의 결재를 요청했어요."); break;
			case "3": tmpMsg = new TextMessage(sendName + "님이 \"" + title + "\"의 참조를 요청했어요."); break;
			case "4": tmpMsg = new TextMessage(sendName + "님이 \"" + title + "\" 프로젝트를 생성했어요."); break;
			case "5": tmpMsg = new TextMessage(sendName + "님이 \"" + title + "\" 업무를 추가했어요."); break;
			case "6": tmpMsg = new TextMessage(sendName + "님이 \"" + title + "\" 예약을 완료했어요."); break;
			case "7": tmpMsg = new TextMessage(sendName + "님이 \"" + title + "\"을(를) 지급했어요."); break;
			case "8": tmpMsg = new TextMessage(sendName + "님이 \"" + title + "\"(으)로 휴가를 회수했어요."); break;
			case "9": tmpMsg = new TextMessage(sendName + "님이 \"" + title + "\"을(를) 승인했어요."); break;
			case "10": tmpMsg = new TextMessage(sendName + "님이 \"" + title + "\"을(를) 거절했어요."); break;
			case "11": tmpMsg = new TextMessage(sendName + "님이 \"" + title + "\"을(를) 신청했어요."); break;
			case "12" : tmpMsg = new TextMessage(sendName + "님으로부터 메일이 도착했어요."); break;
			case "newchat": tmpMsg = new TextMessage("새채팅," + strs[6]); break;
			}
			
			for(int i=0; i<receives.length; i++) {
				receiveSession = userSessions.get(receives[i]);
				if(receiveSession != null) {
					receiveSession.sendMessage(tmpMsg);
				}
				
				if(!dcatNo.equals("newchat")) {
					Alarm a = new Alarm(); 
					a.setDcatNo(dcatNo); 
					a.setSendNo(sendNo);
					a.setReceiveNo(receives[i]); 
					a.setCatNo(catNo);
					a.setNfContent(tmpMsg.getPayload());
					aService.insertAlarm(a);
				}
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		userSessions.remove(String.valueOf(((Member)session.getAttributes().get("loginUser")).getUserNo()));
	}
}
