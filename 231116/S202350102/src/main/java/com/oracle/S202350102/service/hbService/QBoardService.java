package com.oracle.S202350102.service.hbService;

import java.util.List;

import com.oracle.S202350102.dto.Board;

public interface QBoardService {
	List<Board>  qBoardList(Board board);
	Board 			qBoardSelect(int brd_num);
	int 				qBoardInsert(Board board);
	int 				qBoardDelete(int brd_num);
	void 				readCnt(int brd_num);
	int 				qBoardUpdate(Board board);
	int 				totalQBoard();
	List<Board> 	qboardListSearch(Board board);
	int 				qBoardCommentWrite(Board board);
	List<Board>  qBoardCommentList(int brd_group);
	int 				qBoardCommentUpdate(Board board);
	int 				qBoardCommentDelete(int brd_num);
	int 				qBoardSearchListCount(Board board);
}
