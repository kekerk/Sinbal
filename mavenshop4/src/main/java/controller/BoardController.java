package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import exception.ShopException;
import logic.Board;
import logic.ShopService;

@Controller
public class BoardController {
	@Autowired
	private ShopService service;
	//http://localhost:8080/mavenshop3/board/list.shop
	@RequestMapping(value="board/*", method=RequestMethod.GET)
	public ModelAndView getboard(Integer num,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Board board= new Board();
		if(num != null) {
			if(request.getRequestURI().contains("detail")) {
				service.reatCnt(num);
			}
			board = service.selectBoard(num);
		}
		mav.addObject("board",board);
		return mav;
	}
	
	@RequestMapping("board/list")
	public ModelAndView list(Integer pageNum, String searchType, String searchContent) {
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		ModelAndView mav = new ModelAndView();
		int limit = 10; //한페이지에 출력할 게시물 개수
		//총 게시물 건수
		int listcount = service.boardcount(searchType,searchContent);
		List<Board> boardlist = service.boardList(searchType,searchContent,pageNum,limit);
		int maxpage=(int)((double)listcount/limit + 0.95);
		int startpage=((int)((pageNum/10.0+0.9)-1))*10+1;
		int endpage = startpage+9;
		if(endpage > maxpage) endpage = maxpage;
		int boardcnt = listcount-(pageNum-1)*limit;
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", listcount);
		mav.addObject("boardlist", boardlist);
		mav.addObject("boardcnt", boardcnt);
		return mav;
	}

//	@RequestMapping("board/detail")
//	public ModelAndView detail(int num,HttpServletRequest request) {
//	ModelAndView mav = new ModelAndView();
//	System.out.println(request.getRequestURI());
//	service.reatCnt(num);
//	Board board = service.selectBoard(num);
//	mav.addObject("board",board);
//	return mav;
//	}
	
	@RequestMapping(value="board/write", method=RequestMethod.POST)
	public ModelAndView write(@Valid Board board, BindingResult bindResult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		try {
			service.write(board,request);
			mav.addObject("board", board);
			mav.setViewName("redirect:/board/list.shop");
		}catch(Exception e) {
			e.printStackTrace();
			throw new ShopException("게시물 등록에 실패했습니다.","write.shop");
		}
		return mav;
	}
	
	/*
	 * 답글 등록
	 * 1. 유효성 검증
	 * 2. 답글을 DB에 등록
	 * 	   원글 정보 중 ref는 답글의 ref값
	 *   원글 정보 중 reflevel은 답글의 reflevel+1 값
	 *   원글 정보 중 refstep은 답글의 refstep+1 값
	 *        => 작업 전 기존의 원글의 refstep보다 큰 레코드들을 refstep+1로 수정하기  
	 * 3. 등록 후 list.shop으로 이동
	 */
	@RequestMapping(value="board/reply", method=RequestMethod.POST)
	public ModelAndView reply(@Valid Board board, BindingResult bindResult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		try {
			service.write(board,request); 
			mav.addObject("board", board);
			mav.setViewName("redirect:/board/list.shop");
		}catch(Exception e) {
			e.printStackTrace();
			throw new ShopException("게시물 답글 등록에 실패했습니다.","reply.shop?num="+board.getNum());
		}
		return mav;
	}
	
	@RequestMapping(value="board/update", method=RequestMethod.POST)
	public ModelAndView update(@Valid Board board,String file2,BindingResult bindResult,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Board dbboard = service.selectBoard(board.getNum());
		String pass = request.getParameter("pass");
		if(bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			board.setFileurl(file2);
			mav.addObject("board",board);
			return mav;
		}
		if(!pass.equals(dbboard.getPass())) {
			bindResult.reject("error.board.password");
			mav.getModel().putAll(bindResult.getModel());
			board.setFileurl(file2);
			mav.addObject("board",board);
			return mav;
		}
		board.setFileurl(file2);
		try {
				service.updateboard(board,request);
				Board updateboard = service.selectBoard(board.getNum());
				mav.addObject("board", updateboard);
				mav.setViewName("redirect:/board/detail.shop?num="+board.getNum());	
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new ShopException("게시물 수정에 실패했습니다.","update.shop?num="+board.getNum());
		}
		return mav;
	}
	
	@RequestMapping(value="board/delete", method = RequestMethod.POST)
	public ModelAndView delete(Integer num, HttpSession session,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Board board = service.selectBoard(num);
		String pass = request.getParameter("pass");
		if(!pass.equals(board.getPass())) {
			throw new ShopException("비밀번호가 틀렸습니다.", "delete.shop?num="+board.getNum());
		}else {
			service.deleteboard(num);
			mav.setViewName("redirect:/board/list.shop");
		}
		return mav;
	}
}
