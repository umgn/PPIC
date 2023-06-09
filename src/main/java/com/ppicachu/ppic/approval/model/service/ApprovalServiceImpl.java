package com.ppicachu.ppic.approval.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ppicachu.ppic.approval.model.dao.ApprovalDao;
import com.ppicachu.ppic.approval.model.vo.AppChange;
import com.ppicachu.ppic.approval.model.vo.AppDetail;
import com.ppicachu.ppic.approval.model.vo.AppProcess;
import com.ppicachu.ppic.approval.model.vo.Approval;
import com.ppicachu.ppic.approval.model.vo.FormCash;
import com.ppicachu.ppic.approval.model.vo.FormConsume;
import com.ppicachu.ppic.approval.model.vo.FormDraft;
import com.ppicachu.ppic.approval.model.vo.FormTransfer;
import com.ppicachu.ppic.approval.model.vo.MyDept;
import com.ppicachu.ppic.common.model.vo.Attachment;
import com.ppicachu.ppic.common.model.vo.PageInfo;
import com.ppicachu.ppic.member.model.vo.Member;

@Service
public class ApprovalServiceImpl implements ApprovalService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ApprovalDao aDao;
	
	@Override
	public int selectListCount(MyDept md) {
		return aDao.selectListCount(sqlSession, md);
	}

	@Override
	public ArrayList<Approval> selectList(MyDept md, PageInfo pi) {
		return aDao.selectList(sqlSession, md, pi);
	}

	@Override
	public int selectTemListCount(MyDept md) {
		return aDao.selectTemListCount(sqlSession, md);
	}

	@Override
	public ArrayList<Approval> selectTemList(MyDept md, PageInfo pi) {
		return aDao.selectTemList(sqlSession, md, pi);
	}

	@Override
	public int selectMaListCount(MyDept md) {
		return aDao.selectMaListCount(sqlSession, md);
	}

	@Override
	public ArrayList<Approval> selectMaList(MyDept md, PageInfo pi) {
		return aDao.selectMaList(sqlSession, md, pi);
	}
	
	@Override
	public int selectSearchListCount(Approval a) {
		return aDao.selectSearchListCount(sqlSession, a);
	}

	@Override
	public ArrayList<Approval> selectSearchList(Approval a, PageInfo pi) {
		return aDao.selectSearchList(sqlSession, a, pi);
	}

	@Override
	public int updateBook(Approval a) {
		return aDao.updateBook(sqlSession, a);
	}

	@Override
	public int deleteApproval(String[] noArr) {
		return aDao.deleteApproval(sqlSession, noArr);
	}

	@Override
	public int removeApproval(ArrayList<Approval> aList, String what) {
		aDao.removeProcess(sqlSession, aList);
		aDao.removeChange(sqlSession, aList);
		for(int i=0; i<aList.size(); i++) {
			switch(aList.get(i).getForm()) {
			case "업무기안" : aDao.removeDraft(sqlSession, aList.get(i).getApprovalNo()); break;
			case "인사발령품의서" : aDao.removeTransfer(sqlSession, aList.get(i).getApprovalNo()); break;
			case "비품신청서" : aDao.removeConsume(sqlSession, aList.get(i).getApprovalNo()); break;
			case "지출결의서" : aDao.removeCash(sqlSession, aList.get(i).getApprovalNo()); break;
			}
		}
		int result = 0;
		if(what.equals("remove")) {
			result = aDao.removeApproval(sqlSession, aList);
		} else if(what.equals("update")) {
			result = aDao.updateApproval(sqlSession, aList.get(0));
		}
		return result;
	}
	
	@Override
	public ArrayList<Attachment> selectAttChangeName(String[] noArr){
		return aDao.selectAttChangeName(sqlSession, noArr);
	}
	
	@Override
	public int removeAppAttachment(ArrayList<Attachment> atList) {
		return aDao.removeAppAttachment(sqlSession, atList);
	}

	@Override
	public int recoverApproval(String[] noArr) {
		return aDao.recoverApproval(sqlSession, noArr);
	}

	@Override
	public AppDetail selectDraftApp(int approvalNo) {
		return aDao.selectDraftApp(sqlSession, approvalNo);
	}

	@Override
	public AppDetail selectTransferApp(int approvalNo) {
		return aDao.selectTransferApp(sqlSession, approvalNo);
	}

	@Override
	public AppDetail selectConsumeApp(int approvalNo) {
		return aDao.selectConsumeApp(sqlSession, approvalNo);
	}

	@Override
	public AppDetail selectCashApp(int approvalNo) {
		return aDao.selectCashApp(sqlSession, approvalNo);
	}

	@Override
	public ArrayList<AppChange> selectChange(int approvalNo) {
		return aDao.selectChange(sqlSession, approvalNo);
	}

	@Override
	public int updateProcess(AppProcess ap) {
		return aDao.updateProcess(sqlSession, ap);
	}

	@Override
	public int updateCurrentOrder(Approval a) {
		return aDao.updateCurrentOrder(sqlSession, a);
	}

	@Override
	public int insertChange(AppChange ac) {
		return aDao.insertChange(sqlSession, ac);
	}

	@Override
	public ArrayList<Member> selectMemberList() {
		return aDao.selectMemberList(sqlSession);
	}

	@Override
	public int insertApproval(Approval a, ArrayList<AppProcess> apList, AppChange ac, ArrayList<Attachment> atList, String what) {
		if(what.equals("insert")) {
			aDao.insertApproval(sqlSession, a);
		}
		int result1 = aDao.insertProcess(sqlSession, apList);
		int result2 = aDao.insertChange(sqlSession, ac);

		if(!atList.isEmpty()) {
			aDao.insertAppAttachment(sqlSession, atList);
		}
		
		return result1 * result2;
	}

	@Override
	public int insertDraft(FormDraft fdr) {
		return aDao.insertDraft(sqlSession, fdr);
	}

	@Override
	public int insertTransfer(ArrayList<FormTransfer> ftrList) {
		return aDao.insertTransfer(sqlSession, ftrList);
	}

	@Override
	public int insertConsume(ArrayList<FormConsume> fcoList) {
		return aDao.insertConsume(sqlSession, fcoList);
	}

	@Override
	public int insertCash(ArrayList<FormCash> fcaList) {
		return aDao.insertCash(sqlSession, fcaList);
	}

	@Override
	public int updateApprovalStatus(Approval a) {
		return aDao.updateApprovalStatus(sqlSession, a);
	}
	
	@Override
	public int deleteChange(int changeNo) {
		return aDao.deleteChange(sqlSession, changeNo);
	}
}
