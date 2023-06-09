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
	public int insertSender(SqlSessionTemplate sqlSession, MailStatus status) {
		return sqlSession.insert("mailMapper.insertSender", status);
	}
	public int insertStatus(SqlSessionTemplate sqlSession, MailStatus status, Mail m) {
		int result1 = 1;
		int result2 = 1;
		int result3 = 1;
		
		if(!m.getRecipientArr()[0].equals("")) {
			for(String s : m.getRecipientArr()) {
				status.setRecipientMail(s);
				status.setMailType(1);
				result1 = sqlSession.insert("mailMapper.insertStatus", status);
			}
		}
		if(!m.getRefArr()[0].equals("")) {
			for(String s : m.getRefArr()) {
				status.setRecipientMail(s);
				status.setMailType(2);
				result2 = sqlSession.insert("mailMapper.insertStatus", status);
			}			
		}
		if(!m.getHidRefArr()[0].equals("")) {
			for(String s : m.getHidRefArr()) {
				status.setRecipientMail(s);
				status.setMailType(3);
				result3 = sqlSession.insert("mailMapper.insertStatus", status);
			}			
		}
		
		return result1 * result2 * result3;
	}
	
	public int selectRecieveListCount(SqlSessionTemplate sqlSession, String userMail) {
		return sqlSession.selectOne("mailMapper.selectRecieveListCount", userMail);
	}
	public ArrayList<MailStatus> selectRecieveList(SqlSessionTemplate sqlSession, String userMail, PageInfo pi){
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();	// 몇개를 건너띄고
		int limit = pi.getBoardLimit();	// 몇개 조회
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("mailMapper.selectRecieveList", userMail, rowBounds);
	}
	
	public int selectReadStatus(SqlSessionTemplate sqlSession, MailStatus status) {
		return sqlSession.selectOne("mailMapper.selectReadStatus", status);
	}
	public int updateReadDate(SqlSessionTemplate sqlSession, MailStatus status) {
		return sqlSession.update("mailMapper.updateReadDate", status);
	}
	public Mail selectRecieve(SqlSessionTemplate sqlSession, MailStatus status) {
		return sqlSession.selectOne("mailMapper.selectRecieve", status);
	}
	public ArrayList<MailAttachment> selectAttachmentList(SqlSessionTemplate sqlSession, int mailNo){
		return (ArrayList)sqlSession.selectList("mailMapper.selectAttachmentList", mailNo);
	}
	
	public int selectSendListCount(SqlSessionTemplate sqlSession, String userMail) {
		return sqlSession.selectOne("mailMapper.selectSendListCount", userMail);
	}
	public ArrayList<MailStatus> selectSendList(SqlSessionTemplate sqlSession, PageInfo pi, String userMail){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();	// 몇개를 건너띄고
		int limit = pi.getBoardLimit();	// 몇개 조회
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("mailMapper.selectSendList", userMail, rowBounds);
	}
	public Mail selectSend(SqlSessionTemplate sqlSession, int mailNo) {
		return sqlSession.selectOne("mailMapper.selectSend", mailNo);
	}
	
	public int selectImportantListCount(SqlSessionTemplate sqlSession, String userMail) {
		return sqlSession.selectOne("mailMapper.selectImportantListCount", userMail);
	}
	public ArrayList<MailStatus> selectImportantList(SqlSessionTemplate sqlSession, PageInfo pi, String userMail){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();	// 몇개를 건너띄고
		int limit = pi.getBoardLimit();	// 몇개 조회
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("mailMapper.selectImportantList", userMail, rowBounds);
	}
	public ArrayList<MailStatus> selectImportantListOlder(SqlSessionTemplate sqlSession, PageInfo pi, String userMail){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();	// 몇개를 건너띄고
		int limit = pi.getBoardLimit();	// 몇개 조회
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("mailMapper.selectImportantListOlder", userMail, rowBounds);
	}
	
	public int deleteImportantStatus(SqlSessionTemplate sqlSession, MailStatus status) {
		return sqlSession.update("mailMapper.deleteImportantStatus", status);
	}
	public int updateImportantStatus(SqlSessionTemplate sqlSession, MailStatus status) {
		return sqlSession.update("mailMapper.updateImportantStatus", status);
	}
	
	public int deleteMail(SqlSessionTemplate sqlSession, MailStatus status) {
		if(status.getMailType() == 4) {	// 보낸 메일
			return sqlSession.update("mailMapper.deleteSendMail", status);
		} else {
			return sqlSession.update("mailMapper.deleteMail", status);		
		}
	}
	
	public int updateReadNull(SqlSessionTemplate sqlSession, MailStatus status) {
		return sqlSession.update("mailMapper.updateReadNull", status);
	}
	
	/* 받은메일 필터 */
	public int selectUnreadRecieveListCount(SqlSessionTemplate sqlSession, String userMail) {
		return sqlSession.selectOne("mailMapper.selectUnreadRecieveListCount", userMail);
	}
	public ArrayList<MailStatus> selectUnreadRecieveList(SqlSessionTemplate sqlSession, String userMail, PageInfo pi){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("mailMapper.selectUnreadRecieveList", userMail, rowBounds);
	}
	public int selectImportantRecieveListCount(SqlSessionTemplate sqlSession, String userMail) {
		return sqlSession.selectOne("mailMapper.selectImportantRecieveListCount", userMail);
	}
	public ArrayList<MailStatus> selectImportantRecieveList(SqlSessionTemplate sqlSession, String userMail, PageInfo pi){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("mailMapper.selectImportantRecieveList", userMail, rowBounds);
	}
	public int selectToMeRecieveListCount(SqlSessionTemplate sqlSession, String userMail) {
		return sqlSession.selectOne("mailMapper.selectToMeRecieveListCount", userMail);
	}
	public ArrayList<MailStatus> selectToMeRecieveList(SqlSessionTemplate sqlSession, String userMail, PageInfo pi){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("mailMapper.selectToMeRecieveList", userMail, rowBounds);
	}
	public int selectAtcRecieveListCount(SqlSessionTemplate sqlSession, String userMail) {
		return sqlSession.selectOne("mailMapper.selectAtcRecieveListCount", userMail);
	}
	public ArrayList<MailStatus> selectAtcRecieveList(SqlSessionTemplate sqlSession, String userMail, PageInfo pi){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("mailMapper.selectAtcRecieveList", userMail, rowBounds);
	}
	
	/* 보낸메일 필터 */
	public int selectImportantSendListCount(SqlSessionTemplate sqlSession, String userMail) {
		return sqlSession.selectOne("mailMapper.selectImportantSendListCount", userMail);
	}
	public ArrayList<MailStatus> selectImportantSendList(SqlSessionTemplate sqlSession, PageInfo pi, String userMail){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("mailMapper.selectImportantSendList", userMail, rowBounds);
	}
	public int selectAtcSendListCount(SqlSessionTemplate sqlSession, String userMail) {
		return sqlSession.selectOne("mailMapper.selectAtcSendListCount", userMail);
	}
	public ArrayList<MailStatus> selectAtcSendList(SqlSessionTemplate sqlSession, PageInfo pi, String userMail){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("mailMapper.selectAtcSendList", userMail, rowBounds);
	}
	
	public int selectBinListCount(SqlSessionTemplate sqlSession, String userMail) {
		return sqlSession.selectOne("mailMapper.selectBinListCount", userMail);
	}
	public ArrayList<MailStatus> selectBinList(SqlSessionTemplate sqlSession, PageInfo pi, String userMail){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();	// 몇개를 건너띄고
		int limit = pi.getBoardLimit();	// 몇개 조회
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("mailMapper.selectBinList", userMail, rowBounds);
	}
	
	public int selectTempListCount(SqlSessionTemplate sqlSession, String userMail) {
		return sqlSession.selectOne("mailMapper.selectTempListCount", userMail);
	}
	public ArrayList<Mail> selectTempList(SqlSessionTemplate sqlSession, PageInfo pi, String userMail){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();	// 몇개를 건너띄고
		int limit = pi.getBoardLimit();	// 몇개 조회
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("mailMapper.selectTempList", userMail, rowBounds);
	}
	public Mail selectTemp(SqlSessionTemplate sqlSession, int mailNo) {
		return sqlSession.selectOne("mailMapper.selectTemp", mailNo);
	}
	public int deleteTemp(SqlSessionTemplate sqlSession, MailStatus status) {
		return sqlSession.delete("mailMapper.deleteTemp", status);
	}
	
	public int recoverMail(SqlSessionTemplate sqlSession, MailStatus status) {
		if(status.getMailType() == 4) {	// 보낸 메일
			return sqlSession.update("mailMapper.recoverSendMail", status);
		} else {
			return sqlSession.update("mailMapper.recoverMail", status);		
		}
	}
	
	
	/* 스케줄링에 의함 */
	public int completeDeleteMail(SqlSessionTemplate sqlSession) {
		return sqlSession.delete("mailMapper.completeDeleteMail");
	}
	
	
	
}
