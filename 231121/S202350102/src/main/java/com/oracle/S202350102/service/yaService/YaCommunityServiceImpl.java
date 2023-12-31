package com.oracle.S202350102.service.yaService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.yaDao.YaBoardDao;
import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.SharingList;
import com.oracle.S202350102.dto.User1;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class YaCommunityServiceImpl implements YaCommunityService {
	
	private final YaBoardDao ybd;
	
	@Override
	public List<Board> listCommunity(Board board) {
		List<Board> listCommunity = null;
		System.out.println("YaCommunityServiceImpl start...");
		listCommunity = ybd.listCommunity(board);
		System.out.println("YaCommunityServiceImpl listCommunity communityList.size()?"+listCommunity.size());
		return listCommunity ;
	}
	

	
	//게시글 상세보기
	@Override
	public Board detailCommunity(int brd_num) {
		System.out.println("YaCommunityServiceImpl detailCommunity start..");
		Board board = null;
		board = ybd.detailCommunity(brd_num);
		return board;
	}
	
	//게시글 조회수 증가
	@Override
	public void upViewCnt(int brd_num) {
		System.out.println("YaCommunityServiceImpl upViewCnt start..");
		ybd.upViewCnt(brd_num);
	}



	@Override
	public int insertCommunity(Board board) {
		int insertResult = 0;
		System.out.println("YaCommunityServiceImpl insert start....");
		insertResult = ybd.insertCommunity(board);
		return insertResult;
	}

	@Override
	public int updateCommunity(Board board) {
		int updateCommunity =0;
		System.out.println("YaCommunityServiceImpl update Board start...");
		updateCommunity = ybd.updateCommunity(board);
		return updateCommunity;
	}
	//게시글 삭제
	@Override
	public int deleteCommunity(int brd_num) {
		int deleteResult =0;
		System.out.println("YaCommunityServiceImpl delete start....");
		deleteResult = ybd.deleteCommunity(brd_num);
		return deleteResult;
	}

	@Override
	public List<Board> listSearchBoard(String keyword) {
		List<Board> boardSearchList = null;
		System.out.println("YaCommunityServiceImpl listSearchBoard start...");
		boardSearchList = ybd.boardSearchList(keyword);
		System.out.println("YaCommunityServiceImpl listSearchBoard boardSearchList.size()?"+boardSearchList.size());
		return boardSearchList;
	}
	@Override
	public List<Board> listBoardSort(String sort) {
		List<Board> listBoardSort = null;
		System.out.println("YaCommunityServiceImpl listBoardSort start...");
		
		if("view_cnt".contentEquals(sort)) {
			return ybd.sortByViewCnt();
		} else if ("reg_date".equals(sort)) {
			return ybd.sortByRegDate();
		} else {
			return ybd.sortByRegDate();
		}
	}


	@Override
	public User1 userSelect(int user_num) {
		if (user_num != 0) {
			User1 user = new User1();
			user = ybd.userSelect(user_num);
			return user;
		} else {
			return null;
		}
	}	

	@Override
	public List<Board> listComment(int brd_num) {
		List<Board> listComment = null;
		System.out.println("YaCommunityServiceImpl listComment start...");
		listComment = ybd.listComment(brd_num);
		return listComment;
	}

	@Override
	public void commentWrite(Board board) {
		System.out.println("YaCommunityServiceImpl commentWrite start..");
		ybd.commentWrite(board);
	}


	@Override
	public void commentUpdate(Board board) {
		System.out.println("YaCommunityServiceImpl commentUpdat start..");
		ybd.commentUpdate(board);
	}

	@Override
	public void commentDelete(Board board) {
		System.out.println("YaCommunityServiceImpl commentDelete start..");
		ybd.commentDelete(board);
	}

	@Override
	public int getLatestBrdStep(int brd_group) {
		System.out.println("YaCommunityServiceImpl getLatestBrdStep start....");
		int getLatestBrdStep = ybd.getLatestBrdStep(brd_group);
		return getLatestBrdStep;
		
	}

	@Override
	public int commentCount(int brd_num) {
		System.out.println("YaCommunityServiceImpl commentCount start...");
		int commentCount = ybd.commentCount(brd_num);
		
		return commentCount;
	}



	@Override
	public int totalCommunity(Board board) {
		System.out.println("YaCommunityServiceImpl totalCommuinty()t start...");
		int totalCommunity = ybd.totalCommunity(board);
		return totalCommunity;
	}



	@Override
	public int saveSharing(SharingList sharingList) {
		System.out.println("YaCommunityServiceImpl saveS");
		int saveResult = ybd.saveSharing(sharingList);
		return saveResult;
	}


	//마이페이지- 내가 올린 쉐어링 리스트 조회 
	@Override
	public List<Board> myUploadSharingList(int user_num) {
		System.out.println("YaCommunityServiceImpl myUploadSharingList start....");
		List<Board> myUploadSharingList = null;
		try {
			myUploadSharingList = ybd.myUploadSharingList(user_num);
			System.out.println("YaCommunityServiceImpl myUploadSharingList.size()?"+myUploadSharingList.size());			
		} catch (Exception e) {
			System.out.println("YaCommunityServiceImpl myUploadSharingList e.getMessage?"+e.getMessage());
		}
		return myUploadSharingList;
	}


	//마이페이지 - 내가 올린 쉐어링 게시글의 참가자리스트 조회
	@Override
	public List<SharingList> sharingParticipantsList(int brd_num) {
		System.out.println("YaCommunityServiceImpl sharingParticipantsList start...");
		List<SharingList> sharingParticipantsList = null;
		try {
			sharingParticipantsList = ybd.sharingParticipantsList(brd_num);
		} catch (Exception e) {
			System.out.println("YaCommunityServiceImpl sharingParticipantsList e.getMessage?"+e.getMessage());
		}
		return sharingParticipantsList;
	}
	
	// 마이페이지 - 내가참여한 쉐어링 조회
	@Override
	public List<SharingList> myJoinSharingList(int user_num) {
		System.out.println("YaControllerService  myJoinSharingList start...");
		List<SharingList> myJoinSharingList = null;
		try {
			myJoinSharingList = ybd.myJoinSharingList(user_num);
		} catch (Exception e) {
			System.out.println("YaCommunityServiceImpl myJoinSharingList e.getMessage?"+e.getMessage());
		}
		return myJoinSharingList;
	}

	// 마이페이지 - 승인완료  쉐어링 조회
	@Override
	public List<Board> myConfirmSharingList(int user_num) {
		System.out.println("YaControllerService   myConfirmSharingList start...");
		List<Board> myConfirmSharingList = null;
		try {
			myConfirmSharingList = ybd.myConfirmSharingList(user_num);
		} catch (Exception e) {
			System.out.println("YaCommunityServiceImpl myConfirmSharingList e.getMessage?"+e.getMessage());
		}
		return myConfirmSharingList;
	}


	//마이페이지 - 내가올린 쉐어링 참가자 승인처리 (state_md 101)
	@Override
	public int sharingConfirm(SharingList sharingList) {
		System.out.println("YaControllerServiceImpl sharingConfirm  start....");
		int sharingConfirm = 0;
		try {
			sharingConfirm = ybd.sharingConfirm(sharingList);
		} catch (Exception e) {
			System.out.println("YaControllerServiceImpl shairngConfirm e.getMessage?"+e.getMessage());
		}

		return sharingConfirm;
	}

	// 마이페이지 - 승인 처리 후 참가자 수 증가 
	@Override
	public  void upParticipantsCnt(int brd_num) {
		System.out.println("YaControllerService upParticipantsCnt start...");
		
		ybd.upParticipantsCnt(brd_num);
	}

	// 참가자 승인 state_md: 101 update & reject message null-->입력 
	@Override
	public int sharingReject(SharingList sharingList) {
		System.out.println("YaControllersERVICE Impl SharingReject start...");
		int sharingReject = 0;
		try {
			sharingReject = ybd.sharingReject(sharingList);
		} catch (Exception e) {
			System.out.println("YaControllerServiceImpl sharingReject e.getMessage?"+e.getMessage());
		}
		return sharingReject;
	}


	// board의 participants -1 감소
	@Override
	public void downParticipantsCnt(int brd_num) {
		System.out.println("YaControllerService downParticipantsCnt start...");
		
		ybd.downParticipantsCnt(brd_num);
	}


	
	
/*
	@Override
	  public boolean isParticipantApproved(int brd_num, int user_num) {
        // 여기에 해당 사용자의 승인 여부를 확인하는 로직을 구현
       
		return ybd.isParticipantApprovalStatus(brd_num, user_num) == 101; 
    }*/
}

