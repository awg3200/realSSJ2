package com.oracle.S202350102.dao.chDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.S202350102.dto.Board;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ChSearchImpl implements ChSearchDao {
	private final SqlSession session;
	
	
	@Override
	public List<Board> srchResult() {
		
		return null;
	}

}
