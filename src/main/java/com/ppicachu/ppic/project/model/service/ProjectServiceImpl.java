package com.ppicachu.ppic.project.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ppicachu.ppic.project.model.dao.ProjectDao;
import com.ppicachu.ppic.project.model.vo.Project;
import com.ppicachu.ppic.project.model.vo.ProjectParticipant;
import com.ppicachu.ppic.project.model.vo.Task;

@Service
public class ProjectServiceImpl implements ProjectService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ProjectDao pDao;
	
	@Override
	public ArrayList<Project> selectProjectList(int userNo) {
		return pDao.selectProjectList(sqlSession, userNo);
	}

	@Override
	public ArrayList<ProjectParticipant> selectProjectParticipants(int projectNo) {
		return pDao.selectProjectParticipants(sqlSession, projectNo);
	}
	
	@Override
	public ArrayList<Task> selectTaskList(int projectNo) {
		return pDao.selectTaskList(sqlSession, projectNo); 
	}

	@Override
	public ArrayList<ProjectParticipant> selectTaskParticipants(int taskNo) {
		return pDao.selectTaskParticipants(sqlSession, taskNo);
	}

	@Override
	public int selectCountTaskParticipants(int taskNo) {
		return pDao.selectCountTaskParticipants(sqlSession, taskNo);
	}

	@Override
	public int updateTaskStatus(Task t) {
		return pDao.updateTaskStatus(sqlSession, t);
	}

	@Override
	public ArrayList<ProjectParticipant> selectDeptList(HashMap<String, Integer> map) {
		return pDao.selectDeptList(sqlSession, map);
	}
	
	@Override
	public ArrayList<ProjectParticipant> selectEmployeesList(HashMap<String, Integer> map) {
		return pDao.selectEmployeesList(sqlSession, map);
	}



}
