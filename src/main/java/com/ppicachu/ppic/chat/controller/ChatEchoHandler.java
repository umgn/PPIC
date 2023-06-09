package com.ppicachu.ppic.chat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ppicachu.ppic.chat.model.service.ChatService;
import com.ppicachu.ppic.chat.model.vo.Chat;
import com.ppicachu.ppic.member.model.vo.Member;

@Controller
public class ChatEchoHandler extends TextWebSocketHandler{
	
	@Autowired
	private ChatService cService;
	
	private final ObjectMapper objectMapper = new ObjectMapper();
    
    // 채팅방 목록 <방 번호, ArrayList<session> >
    private HashMap<Integer, ArrayList<WebSocketSession>> RoomList = new HashMap<>();
    // session, 방 번호
    private HashMap<WebSocketSession, Integer> sessionList = new HashMap<>();
    
    private static int i;
    
    /**
     * websocket 연결 성공 시
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        i++;
        System.out.println(session.getId() + " 연결 성공 => 총 접속 인원 : " + i + "명");
    }
    
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
 
        // 전달받은 메세지
    	// roomNo,sendNo,chatContent,notRead,sendDate
        String msg = message.getPayload();
        String[] strs = msg.split(",");
        String roomNo = strs[0];
		String sendNo = strs[1];
		String chatContent = strs[2];
		String notRead = strs[3];
		String sendDate = strs[4];
		
        // 받은 메세지에 담긴 roomId로 해당 채팅방을 찾아온다.
        Chat chatRoom = cService.selectChatRoom(Integer.parseInt(strs[0]));
        // 채팅 세션 목록에 채팅방이 존재하지 않고, 처음 들어왔고, DB에서의 채팅방이 있을 때
        // 채팅방 생성
        if(strs[2].equals("ENTER-CHAT") && chatRoom != null) {
        	if(RoomList.get(chatRoom.getRoomNo()) == null) {
                
                // 채팅방에 들어갈 session들
                ArrayList<WebSocketSession> sessionTwo = new ArrayList<>();
                // session 추가
                sessionTwo.add(session);
                // sessionList에 추가
                sessionList.put(session, chatRoom.getRoomNo());
                // RoomList에 추가
                RoomList.put(chatRoom.getRoomNo(), sessionTwo);
            }
            
            // 채팅방이 존재 할 때
            else if(RoomList.get(chatRoom.getRoomNo()) != null) {
                
                // RoomList에서 해당 방번호를 가진 방이 있는지 확인.
                RoomList.get(chatRoom.getRoomNo()).add(session);
                // sessionList에 추가
                sessionList.put(session, chatRoom.getRoomNo());
            }
        	
        	Chat cc = new Chat();
        	cc.setRoomNo(Integer.parseInt(roomNo));
        	cc.setSendNo(Integer.parseInt(sendNo));
        	
        	// 마지막으로 읽은 채팅번호 조회
        	int lastRead = cService.selectLastReadChat(cc);
        	
        	// 상대방이 보낸 채팅 중 최대값 조회 (없으면 0)
        	cc.setLastreadChat(String.valueOf(lastRead));
        	int maxChat = cService.selectMaxChat(cc);
        	
        	if(maxChat > 0) {
        		cc.setChatNo(maxChat);
        		// 참여자, 채팅 수정
            	cService.updateParticipant(cc);
            	cService.updateChat(cc);
        	}
        	
        	// roomNo,sendNo,chatContent,notRead,sendDate,maxChat,lastRead
        	msg += "," + maxChat + "," + lastRead;
        	
        	TextMessage textMessage = new TextMessage(msg);
            
            for(WebSocketSession sess : RoomList.get(chatRoom.getRoomNo())) {
                sess.sendMessage(textMessage);
            }
            
        }
        // 채팅 메세지 입력 시
        else if(RoomList.get(chatRoom.getRoomNo()) != null && !strs[2].equals("ENTER-CHAT") && !strs[2].equals("OUT-CHAT")&& chatRoom != null) {
            
            // 현재 session 수
            int sessionCount = 0;
            for(int i=0; i<RoomList.get(chatRoom.getRoomNo()).size(); i++) {
            	sessionCount++;
            }
            
            // DB에 저장
            HashMap<String, Object> map = new HashMap<>();
			map.put("roomNo", roomNo);
			map.put("sendNo", sendNo);
			map.put("chatContent", chatContent);
			map.put("notRead", Integer.parseInt(notRead) - sessionCount + 1);
			map.put("outMsg", 0);
			
            int a = cService.insertChat(map);
            int b = cService.updateChatRoom(Integer.parseInt(roomNo));
            
            ArrayList<String> sessOnUser = new ArrayList<>();
            
            for(WebSocketSession sess : RoomList.get(chatRoom.getRoomNo())) {
            	String[] arr = sess.getAttributes().get("loginUser").toString().split(",");
                sessOnUser.add(arr[0].substring(14));
            }
            
            HashMap<String, Object> hm = new HashMap<>();
            hm.put("roomNo", Integer.parseInt(roomNo));
            hm.put("sessOnUser", sessOnUser);
            
            cService.updateNotreadChat(hm);
            cService.updateLastreadChat(hm);
            
            // roomNo,sendNo,chatContent,notRead,sendDate,sendName,sendProfile,realnotread,chatNo
            msg += "," + ((Member)session.getAttributes().get("loginUser")).getUserName() 
            	+ "," + ((Member)session.getAttributes().get("loginUser")).getProfileImg() 
            	+ "," + (Integer.parseInt(notRead) - sessionCount + 1)
            	+ "," + a;
            TextMessage textMessage = new TextMessage(msg);
            
            
            // 해당 채팅방의 session에 뿌려준다.
            for(WebSocketSession sess : RoomList.get(chatRoom.getRoomNo())) {
                sess.sendMessage(textMessage);
            }
        } 
        // 채팅방 완전히 나가기 시
        else if(RoomList.get(chatRoom.getRoomNo()) != null && strs[2].equals("OUT-CHAT") && chatRoom != null) {
        	
        	if(notRead.equals("1")) { // 그룹 채팅의 경우
        		// roomNo,sendNo,chatContent,groupSta,sendDate,sendName
            	msg += "," + ((Member)session.getAttributes().get("loginUser")).getUserName();
            	System.out.println("퇴장 메세지 : " + msg);
            	TextMessage textMessage = new TextMessage(msg);
            	for(WebSocketSession sess : RoomList.get(chatRoom.getRoomNo())) {
                    sess.sendMessage(textMessage);
                }
            	
            	// DB에 저장
                HashMap<String, Object> map = new HashMap<>();
    			map.put("roomNo", roomNo);
    			map.put("sendNo", sendNo);
    			map.put("chatContent", ((Member)session.getAttributes().get("loginUser")).getUserName() + "님이 나갔습니다.");
    			map.put("notRead", 0);
    			map.put("outMsg", 1);
    			
            	int a = cService.insertChat(map);
        	}
        }
    }
    
    /**
     * websocket 연결 종료 시
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        i--;
        System.out.println(session.getId() + " 연결 종료 => 총 접속 인원 : " + i + "명");
        // sessionList에 session이 있다면
        if(sessionList.get(session) != null) {
            // 해당 session의 방 번호를 가져와서, 방을 찾고, 그 방의 ArrayList<session>에서 해당 session을 지운다.
        	RoomList.get(sessionList.get(session)).remove(session);
            sessionList.remove(session);
        }
    }
    
}
