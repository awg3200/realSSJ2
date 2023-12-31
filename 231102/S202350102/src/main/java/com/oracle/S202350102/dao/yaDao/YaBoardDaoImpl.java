package com.oracle.S202350102.dao.yaDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Board;

import lombok.RequiredArgsConstructor;
@Repository
@RequiredArgsConstructor
public class YaBoardDaoImpl implements YaBoardDao {
		
	private final SqlSession session;

	
	@Override
	public List<Board> listCommunity(Board board) {
		
		// board테이블 community게시판 조회
		List<Board> listCommunity = null;
		System.out.println("YaBoardDaoImpl listCommunity start...");
		try {
			listCommunity = session.selectList("listCommunity", board);
			System.out.println("YaBoardDaoImpl listCommunity communityList.size()?"+listCommunity.size());
		} catch (Exception e) {
			System.out.println("YaBoardDaoImpl listCommunity e.getMessage()?"+e.getMessage());
		}
		
		return listCommunity;
	}
	
	@Override
	// board테이블 community 게시판 상세글 내용 확인
	public Board detailCommunity(int brd_num) {
		System.out.println("YaBoarDaoImpl detail start...");
		Board board = new Board();
		try {
			board = session.selectOne("YaCommunityOne", brd_num);
		} catch (Exception e) {
			System.out.println("YaBoarDaoImpl detai e.getMessage)?"+e.getMessage());
		}
		return board;
	}
	
	// 게시글 조회수 증가
	@Override
	public void upViewCnt(int brd_num) {
		System.out.println("YaBoardDaoImpl upViewCnt start...");
		 	
		try {
			session.update("YaBoardUpviewCnt" , brd_num);
		} catch (Exception e) {
			System.out.println("YaBoarDaoImpl void upViewCnt e.getMessage)?"+e.getMessage());
		}
		
	}
	
	//userid를 통해 usernum 가져옴
	@Override
	public int getuserNum(String userId) {	
		return session.selectOne("YaBoardGetUserNum",userId);
	
	}

	@Override
	public int insertCommunity(Board board) {
		
		int insertResult =0;
		System.out.println("YaBoardDaoImpl insertCommunity start..");
		try {
			insertResult = 	session.insert("YaBoardInsert", board);
		} catch (Exception e) {
			System.out.println("YaBoarDaoImpl void upViewCnt e.getMessage)?"+e.getMessage());
		}
		return insertResult;
		
		
	
		
	}

	
	


	

}
