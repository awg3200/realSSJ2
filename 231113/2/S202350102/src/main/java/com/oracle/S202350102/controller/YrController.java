package com.oracle.S202350102.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.S202350102.dto.Challenger;
import com.oracle.S202350102.dto.Following;
import com.oracle.S202350102.service.yrService.YrChallengerService;
import com.oracle.S202350102.service.yrService.YrFollowingService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class YrController {
	private final YrChallengerService ycs;
	private final YrFollowingService yfis;
	
//	@RequestMapping(value = "checkBoard")
//	public String checkBoard() {
//		System.out.println("YrController index Start...");
//		return "yr/checkBoard";
//	}
//	test
	
	// jhChgDetail로 합침
	// 일단 작업 중지
	// @RequestMapping(value = "chgJoin")
	// public String chgJoin(int user_num, int chg_id, Model model) {
	// 	System.out.println("YrController chgJoin Start...");
		
	// 	return "yr/chgJoin";
	// }
	
	// JhController로 합침
	// @RequestMapping(value = "ssjFriends")
	// public String listSsj(int chg_id, Model model) {
	// 	System.out.println("YrController listSsj Start...");
	// 	List<User1> listSsj = ycs.getListSsj(chg_id);
		
	// 	model.addAttribute("listSsj", listSsj);
	// 	return "yr/ssjFriends";
	// }
	
	// chgDetail로 출력됨
	@ResponseBody
	@RequestMapping(value = "chgJoinPro")
	public Map<String, Object> chgJoinPro(Challenger chgr) {
		System.out.println("YrController chgJoinPro Start...");
		
		int insertResult = ycs.insertChgr(chgr);
		System.out.println("YrController Insert Success...");
//		model.addAttribute("insertResult", insertResult);		// 없어도 되나? -> 이게 되네
		
//		return "forward:chgDetail?chg_id=" + chgr.getChg_id() + "&insertResultStr=" + insertResult;	// forward 안써도 가능. 왜냐면 parameter를 직접 보내기 때문이다
//		return "redirect:chgDetail?chg_id=" + chgr.getChg_id() + "&insertResultStr=" + insertResult;
		Map<String, Object> joinResult = new HashMap<>();
		joinResult.put("chgJoin", insertResult);
		
		return joinResult;
	}

	@ResponseBody
	@RequestMapping(value = "followingPro")
	public Map<String, Object> followingPro(@RequestParam("user_num") int following_id
											, HttpSession session) {
		System.out.println("YrController followingPro Start...");
		System.out.println("YrController followingPro following_id -> " + following_id);
		
		int userNum = 0;
		if(session.getAttribute("user_num") != null) {
			userNum = (int) session.getAttribute("user_num");
			System.out.println("YrController followingPro userNum -> " + userNum);
		}
		
		Following fwi = new Following();
		Map<String, Object> followResult = new HashMap<>();
		if(userNum != following_id) {	// 나 자신은 팔로우할 수 없다
			fwi.setUser_num(userNum);
			fwi.setFollowing_id(following_id);
			int followingPro = yfis.following(fwi);
			System.out.println("YrController followingPro followingPro -> " + followingPro);
			
			followResult.put("following", followingPro);			
		} else {
			followResult.put("following", -1);
		}
		return followResult;
	}
	
}