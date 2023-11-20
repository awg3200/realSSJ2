package com.oracle.S202350102.service.chService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.chDao.ChSearchDao;
import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;
import com.oracle.S202350102.dto.SearchHistory;

import lombok.Data;
@Service
@Data
public class ChSearchServiceImpl implements ChSearchService {
	
	private final ChSearchDao chSearchDao;
	

	@Override
	public int saveWord(SearchHistory sh) {
		System.out.println("ChSearchServiceImpl saveWord Start...");
		int result = chSearchDao.saveWord(sh);
		
		return result;
	}


	@Override
	public List<Challenge> chgSearching(String srch_word) {
		System.out.println("ChSearchServiceImpl chgSearching Start...");
		
		List<Challenge> srch_chgresult = chSearchDao.chgSearching(srch_word);
		
		return srch_chgresult;
	}


	@Override
	public List<Board> brdSearching(String srch_word) {
		System.out.println("ChSearchServiceImpl chgSearching Start...");
		
		List<Board> srch_brdResult = chSearchDao.brdSearching(srch_word);
		
		return srch_brdResult;
	}
	
	@Override
	public List<Board> shareSearching(String srch_word) {
		System.out.println("ChSearchServiceImpl shareSearching Start...");
		
		List<Board> srch_shrResult = chSearchDao.shareSearching(srch_word);
		
		return srch_shrResult;
	}

	@Override
	public List<SearchHistory> sHistoryList(int user_num) {
		System.out.println("ChSearchServiceImpl sHistoryList Start...");
		List<SearchHistory> shList = chSearchDao.sHistoryList(user_num);
		return shList;
	}


	@Override
	public void updateHistory(SearchHistory sh) {
		System.out.println("ChSearchServiceImpl updateHistory");
		int result = chSearchDao.upDateHistory(sh);
		
	}


	@Override
	public void deleteHis(SearchHistory sh) {
		System.out.println("ChSearchServiceImpl deleteHis Start...");
		int result = chSearchDao.deleteHis(sh);
		
	}


	

}
