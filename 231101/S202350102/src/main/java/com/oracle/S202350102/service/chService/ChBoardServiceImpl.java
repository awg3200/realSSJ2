package com.oracle.S202350102.service.chService;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.S202350102.dao.chDao.ChBoardDao;
import com.oracle.S202350102.dto.Board;

import lombok.Data;
@Service
@Data

public class ChBoardServiceImpl implements ChBoardService {
	
	private final ChBoardDao chBoardDao;
	

	@Override
	public List<Board> noticeLIst(int brd_md) {
		System.out.println("chBoardServiceImpl noticeList Start...");
		List<Board> noticeList = chBoardDao.noticeList(brd_md);
		
		return noticeList;
	}


	@Override
	public int noticeWrite(Board board) {
		System.out.println("chBoardServiceImpl noticeWrite Start...");
		
		int result = 0;
		
		result = chBoardDao.noticeWrite(board);
		
		return result;
	}


	@Override
	public Board noticeConts(int brd_num) {
		System.out.println("chBoardServiceImpl noticeConts Start...");
		Board noticeConts = null;
		
		noticeConts = chBoardDao.noticeConts(brd_num);
		
		
		return noticeConts;
	}


	@Override
	public int noticeUpdate(Board board) {
		System.out.println("chBoardServiceImpl noticeUpdate Start...");
		int result = 0;
		
		result = chBoardDao.noticeUpdate(board);
		
		return result;
	}


	@Override
	public int deleteNotice(int brd_num) {
		System.out.println("chBoardServiceImpl deleteNotice Start...");
		int result = 0;
		
		result = chBoardDao.deleteNotice(brd_num);
		
		return result;
	}


	@Override
	public void noticeViewUp(int brd_num) {
		System.out.println("chBoardServiceImpl noticeViewUp Start...");
		chBoardDao.noticeViewUp(brd_num);
		
	}


	@Override
	public List<Board> popBoardList() {
		System.out.println("chBoardServiceImpl popBoardList Start...");
		
		List<Board> popBoardList = chBoardDao.popBoardList();
		
		return popBoardList;
	}




	

}
