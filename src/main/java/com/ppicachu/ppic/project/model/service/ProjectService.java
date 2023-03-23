package com.ppicachu.ppic.project.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.ppicachu.ppic.project.model.vo.Project;
import com.ppicachu.ppic.project.model.vo.ProjectParticipant;
import com.ppicachu.ppic.project.model.vo.Task;

public interface ProjectService {
	// 프로젝트 조회
	ArrayList<Project> selectProjectList(int userNo);
	
	// 프로젝트 참여자정보 조회
	ArrayList<ProjectParticipant> selectProjectParticipants(int projectNo);
	
	// 프로젝트 하위 작업 조회
	ArrayList<Task> selectTaskList(int projectNo);
	
	// 작업 참조자정보 조회
	ArrayList<ProjectParticipant> selectTaskParticipants(int taskNo);
	// 작업 참조자 수
	int selectCountTaskParticipants(int taskNo);
	
	// 작업상태 변경
	int updateTaskStatus(Task t);
	
	// 프로젝트 참여자 정보/부서 조회
	ArrayList<ProjectParticipant> selectDeptList(HashMap<String, Integer> map);
	ArrayList<ProjectParticipant> selectEmployeesList(HashMap<String, Integer> map);
	
	// task 추가
	int insertTask(Task t);
	// task 참조자 추가
	int insertTaskParticipants(ArrayList<ProjectParticipant> taskRefUser);
	
	// task detail 조회
	Task selectTaskDetail(int taskNo);
}
