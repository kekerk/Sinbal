package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
	
	@RequestMapping(value="board/*", method=RequestMethod.GET)
	public ModelAndView getboard(Integer num, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Board board = new Board();
		if(num != null) {
			board = service.getBoard(num,request);
		}
		mav.addObject("board",board);
		return mav;
	}
	@RequestMapping(value="board/list")
	public ModelAndView list(Integer pageNum, String searchType, String searchContent) {
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		ModelAndView mav = new ModelAndView();
		int limit = 10; //한 페이지에 출력할 게시물 갯수
		int listcount = service.boardcount(searchType, searchContent);
		//boardlist : 한 페이지에 출력할 게시물 정보 저장
		List<Board> boardlist = service.boardlist(searchType, searchContent, pageNum, limit);
		int maxpage = (int)((double)listcount/limit + 0.95); //전체 페이지 수
		int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 + 1; //화면에 표시될 시작 페이지 수
		int endpage = startpage + 9; //화면에 표시될 마지막 페이지 수
		if(endpage > maxpage) endpage = maxpage;
		int boardcnt = listcount - (pageNum -1) * limit; //화면 출력시 보여지는 게시물 순서
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", listcount);
		mav.addObject("boardlist", boardlist);
		mav.addObject("boardcnt", boardcnt);
		return mav;
	}
	@RequestMapping(value="board/write", method=RequestMethod.POST)
	public ModelAndView write(@Valid Board board, BindingResult bindResult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		try {
			service.insert(board, request);
			mav.setViewName("redirect:list.shop");
			mav.addObject("board",board);
		} catch(Exception e) {
			e.printStackTrace();
			throw new ShopException("게시물 등록 실패","write.shop");
		}
		return mav;
	}
	/*
	 * 답글 등록
	 * 1. 유효성 검증
	 * 2. 답글db에 등록
	 * 	    원게시글 정보 중 ref는 답글 정보의 ref 값
	 *    원게시글 정보 중 reflevel는 답글 정보의 reflevel+1 값
	 *    원게시글 정보 중 refstep는 답글 정보의 refstep+1 값
	 *    => 작업 전 기존의 원글의 refstep 보다 큰 모든 레코드들을 refstep+1로 수정하기
	 * 3. 등록 후 list.shop 요청하기
	 *    
	 */
	@RequestMapping(value="board/reply", method=RequestMethod.POST)
	public ModelAndView reply(@Valid Board board, BindingResult bindResult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			return mav;
		}
		service.replyAdd(board);
		mav.addObject("board",board);
		mav.setViewName("redirect:list.shop");
		return mav;
	}
	@RequestMapping(value="board/update", method=RequestMethod.POST)
	public ModelAndView update(@Valid Board board, BindingResult bindResult, String file2, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Board b = service.getBoard(board.getNum(), request);
		if(bindResult.hasErrors()) {
			mav.getModel().putAll(bindResult.getModel());
			mav.addObject("board",b);
			return mav;
		}
		if(!b.getPass().equals(board.getPass())) {
			throw new ShopException("비밀번호가 틀립니다.","update.shop?num="+board.getNum());
		}
		board.setFileurl(file2);
		try {
			service.boardupdate(board, request);
			mav.setViewName("redirect:list.shop");
			mav.addObject("board",board);
		} catch(Exception e) {
			e.printStackTrace();
			throw new ShopException("수정 실패.","update.shop?num="+board.getNum());
		}
		return mav;
	}
	@RequestMapping(value="board/delete", method=RequestMethod.POST)
	public ModelAndView delete(Board board, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Board b = service.getBoard(board.getNum(), request);
		if(!b.getPass().equals(board.getPass())) {
			throw new ShopException("비밀번호가 틀립니다.","delete.shop?num="+board.getNum());
		}
		try {
			service.boarddelete(board);
			mav.setViewName("redirect:list.shop");
			mav.addObject("board",board);
		} catch(Exception e) {
			e.printStackTrace();
			throw new ShopException("삭제 실패.","delete.shop?num="+board.getNum());
		}
		return mav;
		
	}
	
}
