package com.ppicachu.ppic.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ppicachu.ppic.member.model.dao.MemberDao;
import com.ppicachu.ppic.member.model.vo.Department;
import com.ppicachu.ppic.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MemberDao mDao;
	
	@Override
	public ArrayList<Member> selectListMember() {
		return mDao.selectListMember(sqlSession);
	}

	@Override
	public ArrayList<Department> selectDeptList() {
		return mDao.selectDeptList(sqlSession);
	}

	@Override
	public Member selectMember(int userNo) {
		return mDao.selectMember(sqlSession, userNo);
	}


}
