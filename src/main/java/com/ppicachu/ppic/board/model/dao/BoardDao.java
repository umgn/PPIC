package com.ppicachu.ppic.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ppicachu.ppic.board.model.vo.Board;
import com.ppicachu.ppic.board.model.vo.Report;
import com.ppicachu.ppic.common.model.vo.PageInfo;

@Repository
public class BoardDao {
	
	public int selectListCount(SqlSessionTemplate sqlSession, String userNo) {
		return sqlSession.selectOne("boardMapper.selectListCount", userNo);
	}
	
	public ArrayList<Board> selectList(SqlSessionTemplate sqlSession, String userNo, PageInfo pi){
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); 
		int limit = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);	
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectList", userNo, rowBounds);
	}
	
	public int insertBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertBoard", b);
	}
	
	public int increaseCount(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("boardMapper.increaseCount", boardNo);
	}
	
	public Board selectBoard(SqlSessionTemplate sqlSession, HashMap<String, Integer> map) {
		return sqlSession.selectOne("boardMapper.selectBoard", map);
	}
	
	public int deleteBoard(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("boardMapper.deleteBoard", boardNo);
	}
	
	public int updateBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.update("boardMapper.updateBoard", b);
	}
	
	public int selectSearchCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("boardMapper.selectSearchCount", map);
	}
	
	public ArrayList<Board> selectSearchList(SqlSessionTemplate sqlSession, HashMap<String, String> map, PageInfo pi){
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectSearchList", map, rowBounds);
	}
	
	public int insertReport(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.insert("boardMapper.insertReport", r);
	}
	
	public int selectReportCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.selectReportCount");
	}
	
	public ArrayList<Report> selectReportList(SqlSessionTemplate sqlSession, PageInfo pi){
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); 
		int limit = pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, limit);	
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectReportList", null, rowBounds);
	}
	
	public int blindReportUpdate(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.update("boardMapper.blindReportUpdate", r);
	}
	
	public int blindBoardUpdate(SqlSessionTemplate sqlSession, Report r) {
		return sqlSession.update("boardMapper.blindBoardUpdate", r);
	}
	
	public int deleteReport(SqlSessionTemplate sqlSession, String[] reportNo) {
		return sqlSession.update("boardMapper.deleteReport", reportNo);
	}
	
	public int deleteLike(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.delete("boardMapper.deleteLike", b);
	}
	
	public int insertLike(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertLike", b);
	}
}
