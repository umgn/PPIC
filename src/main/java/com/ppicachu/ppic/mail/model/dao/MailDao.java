package com.ppicachu.ppic.mail.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ppicachu.ppic.common.model.vo.PageInfo;
import com.ppicachu.ppic.mail.model.vo.Mail;
import com.ppicachu.ppic.mail.model.vo.MailAttachment;
import com.ppicachu.ppic.mail.model.vo.MailStatus;

@Repository
public class MailDao {	
	
	/***** 메일 보내기 *****/
	public int sendMail(SqlSessionTemplate sqlSession, Mail m) {
		return sqlSession.insert("mailMapper.sendMail", m);
	}
	public int sendAttachment(SqlSessionTemplate sqlSession, ArrayList<MailAttachment> list) {
		int result = 0;
		for(MailAttachment at : list) {
			result = sqlSession.insert("mailMapper.sendAttachment", at);			
		}
		return result;
	}
	public int insertStatus(SqlSessionTemplate sqlSession, MailStatus status, Mail m) {
		int result = 0;

		if(!m.getRecipientArr()[0].equals("")) {
			for(String s : m.getRecipientArr()) {
				System.out.println("받은사람 : " + s);
				status.setRecipientMail(s);
				status.setMailType("1");
				result = sqlSession.insert("mailMapper.insertStatus", status);
			}
		}
		if(!m.getRefArr()[0].equals("")) {
			for(String s : m.getRefArr()) {
				System.out.println("참조 : " + s);
				status.setRecipientMail(s);
				status.setMailType("2");
				result = sqlSession.insert("mailMapper.insertStatus", status);
			}			
		}
		if(!m.getHidRefArr()[0].equals("")) {
			for(String s : m.getHidRefArr()) {
				System.out.println("숨은참조 : " + s);
				status.setRecipientMail(s);
				status.setMailType("3");
				result = sqlSession.insert("mailMapper.insertStatus", status);
			}			
		}
		
		return result;
	}
	
	public int selectRecieveListCount(SqlSessionTemplate sqlSession, String userMail) {
		return sqlSession.selectOne("mailMapper.selectRecieveListCount", userMail);
	}
	public ArrayList<Mail> selectRecieveList(SqlSessionTemplate sqlSession, String userMail, PageInfo pi){
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();	// 몇개를 건너띄고
		int limit = pi.getBoardLimit();	// 몇개 조회
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("mailMapper.selectRecieveList", userMail, rowBounds);
	}
	
}
