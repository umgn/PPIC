package com.ppicachu.ppic.member.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Member {
	
	private int userNo;
	private String userId;
	private String userPwd;
	private String userName;
	private String mail;
	private String phone;
	private String address;
	private String birthday;
	private String position;
	private String department;
	private String employeeNo;
	private String profileImg;
	private String hireDate;
	private String resignDate;
	private String status;
	private String authorityNo;
	private String memberSign;
	private String connSta;
	
	private String giveDay;
	private String useDay;
	private String addDay;
	
	private String chatLike;
	private int roomNo;
	private int lastreadChat;
}
