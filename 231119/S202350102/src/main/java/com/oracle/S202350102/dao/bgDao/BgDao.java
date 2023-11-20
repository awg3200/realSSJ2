package com.oracle.S202350102.dao.bgDao;

import java.util.List;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;

public interface BgDao {

	List<Board> boardCert(Board board);
	int         insertCertBrd(Board board);
	Challenge   bgChgDetail(int chg_id);
	List<Board> certBoard(Board board);
	int         updateCertBrd(Board board);
	int         deleteCertBrd(int brd_num);
	int         certTotal(int chg_id);
	void        commentInsert(Board board);

}
