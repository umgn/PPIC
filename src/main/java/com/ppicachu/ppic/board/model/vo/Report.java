package com.ppicachu.ppic.board.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Report {

	private String reportBno;
	private String reportMno;
	private String reportKind;
	private String reportContent;
	private String reportDate;
	private String modifyDate;
	private String reportSta;
	private String status;
	private String boardTitle;
}
