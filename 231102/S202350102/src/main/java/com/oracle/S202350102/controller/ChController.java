package com.oracle.S202350102.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.Challenge;
import com.oracle.S202350102.dto.SearchHistory;
import com.oracle.S202350102.dto.User1;
import com.oracle.S202350102.service.chService.ChBoardService;
import com.oracle.S202350102.service.chService.ChChallengeService;
import com.oracle.S202350102.service.chService.ChSearchService;
import com.oracle.S202350102.service.chService.ChUser1Service;
import com.oracle.S202350102.service.hbService.Paging;
import com.oracle.S202350102.service.main.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class ChController {
	
	
	private final ChBoardService 		chBoardService;
	private final ChSearchService 		chSearchService;
	private final ChChallengeService	chChallengeService;
	private final ChUser1Service		chUser1Service;
	private final UserService			userService;
	
	// notice List 조회 
	@RequestMapping("/notice")
	public String noticeList(Board board,Model model,HttpSession session, String currentPage) {
		System.out.println("ChController noticeList Start...");
		int totalNotice = chBoardService.noticeCount(board.getBrd_md());
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			User1 user1 = userService.userSelect(user_num);
			model.addAttribute("status_md", user1.getStatus_md());
			model.addAttribute("user_num", user_num);
			
		}
		
		Paging page = new Paging(totalNotice, currentPage);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		List<Board> noticeList = chBoardService.noticeLIst(board);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("brd_md", board.getBrd_md());
		model.addAttribute("totalNotice", totalNotice);
		model.addAttribute("page", page);
		
		return "notice";
	}
	// notice 작성 form
	@PostMapping("noticeWriteForm")
	public String noticeWrite(int brd_md,Model model,HttpSession session) {
		System.out.println("ChController noticeList Start...");
		
		model.addAttribute("brd_md", brd_md);
		// 권한 확인 
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			User1 user1 = userService.userSelect(user_num);
			
			if(user1.getStatus_md() == 102) {
				//user id에 맞는 값 가지고 가기
				model.addAttribute("user1",user1);
				return "/ch/noticeWriteForm";
			}
		}
		
		
		return "forward:notice";
		
		
	}
	
	// notice 작성	
	@PostMapping("noticeWrite")
	public String noticeWrite(Board board, Model model, HttpServletRequest request, HttpSession session) {
		
		System.out.println("ChController noticeWrite Start...");
		System.out.println("brd_md->"+ board.getBrd_md());
		int result = chBoardService.noticeWrite(board);
		System.out.println("Insert result->" + result);
		request.setAttribute("brd_md", board.getBrd_md());
		
		return "forward:notice";
	}
	// notice 조회
	@GetMapping("noticeConts")
	public String noticeConts(int brd_num, Model model,HttpSession session) {
		System.out.println("ChController noticeConts Start...");
		System.out.println("brd_num->" + brd_num);
		// 작성자 확인 
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			User1 user1 = userService.userSelect(user_num);
			model.addAttribute("status_md", user1.getStatus_md());
			model.addAttribute("user_num", user_num);
		}
		
		
		chBoardService.noticeViewUp(brd_num);
		Board noticeConts = chBoardService.noticeConts(brd_num);
		
		model.addAttribute("noticeConts", noticeConts);
		
		return "/ch/noticeConts";
	}
	
	// notice UpdateForm
	@RequestMapping(value = "noticeUpdateForm")
	public String noticeUpdateForm(Board board, Model model, HttpSession session) {
		System.out.println("ChController noticeUpdateForm Start...");
		System.out.println("brd_num->" + board.getBrd_num());
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			// 글의 user_num과 내 session의 user_num이 같은가?
			if(board.getUser_num() == user_num) {
				Board noticeConts = chBoardService.noticeConts(board.getBrd_num());
				model.addAttribute("noticeConts", noticeConts);
				
				return "/ch/noticeUpdateForm";
			}
		}
		
		return "/ch/notAnAdmin";
		
	}
	// notice Update
	@PostMapping("noticeUpdate")
	public String noticeUpdate(Board board, HttpServletRequest request) {
		System.out.println("ChController noticeUpdate Start...");
		int result = 0;
		
		result = chBoardService.noticeUpdate(board);
	
		request.setAttribute("brd_md", board.getBrd_md());
		return "forward:notice";
	}
	// notice 삭제 확인
	@GetMapping("deleteNoticeForm")
	public String deleteform(int brd_num, Model model) {
			System.out.println("ChController deleteform Start...");
			Board board = chBoardService.noticeConts(brd_num);
			model.addAttribute("brd_num", brd_num);
			model.addAttribute("brd_md", board.getBrd_md());
			
		return "/ch/deleteNoticeForm";
	}
	// 실제 삭제
	@PostMapping("deleteNotice")
	public String deleteNotice(Board board, HttpServletRequest request,HttpSession session) {
		System.out.println("ChController deleteNotice Start...");
		int user_num = 0;
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			// 글의 user_num과 내 session의 user_num이 같은가?
			if(board.getUser_num() == user_num) {
				int result = chBoardService.deleteNotice(board.getBrd_num());
				request.setAttribute("brd_md",board.getBrd_md());
				
				return "forward:notice";
			}
		}
		
		return "/ch/notAnAdmin";
		
		
	}
	// 검색 기본 page
	@GetMapping("search")
	public String search(Model model) {
		System.out.println("ChController search Start...");
		List<Challenge> popchgList = chChallengeService.popchgList();
		List<Board> popBoardList = chBoardService.popBoardList();
		
		model.addAttribute("popchgList", popchgList);
		model.addAttribute("popBoardList", popBoardList);
		
		return "search";
	}
	// 검색기능 
	@GetMapping("searching")
	public String searching(String srch_word, HttpSession session, Model model) {
		System.out.println("ChController searching Start...");
		int user_num = 0;
		
		if(session.getAttribute("user_num") != null) {
			user_num = (int) session.getAttribute("user_num");
			User1 user1 = userService.userSelect(user_num);
			SearchHistory sh = new SearchHistory();
			sh.setSrch_word(srch_word);
			sh.setUser_num(user1.getUser_num());
			chSearchService.saveWord(sh);
		}
		// 입력된 키워드에 따라 검색 
		List<Challenge> srch_chgResult = chSearchService.chgSearching(srch_word);
		List<Board> srch_brdResult = chSearchService.brdSearching(srch_word); //100~103
		
		model.addAttribute("srch_word",srch_word);
		model.addAttribute("srch_chgResult",srch_chgResult);
		model.addAttribute("srch_brdResult",srch_brdResult);
		
		
		return "/ch/srchResult";
	}
	
}
