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
		int limit = 10; //�� �������� ����� �Խù� ����
		int listcount = service.boardcount(searchType, searchContent);
		//boardlist : �� �������� ����� �Խù� ���� ����
		List<Board> boardlist = service.boardlist(searchType, searchContent, pageNum, limit);
		int maxpage = (int)((double)listcount/limit + 0.95); //��ü ������ ��
		int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 + 1; //ȭ�鿡 ǥ�õ� ���� ������ ��
		int endpage = startpage + 9; //ȭ�鿡 ǥ�õ� ������ ������ ��
		if(endpage > maxpage) endpage = maxpage;
		int boardcnt = listcount - (pageNum -1) * limit; //ȭ�� ��½� �������� �Խù� ����
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
			throw new ShopException("�Խù� ��� ����","write.shop");
		}
		return mav;
	}
	/*
	 * ��� ���
	 * 1. ��ȿ�� ����
	 * 2. ���db�� ���
	 * 	    ���Խñ� ���� �� ref�� ��� ������ ref ��
	 *    ���Խñ� ���� �� reflevel�� ��� ������ reflevel+1 ��
	 *    ���Խñ� ���� �� refstep�� ��� ������ refstep+1 ��
	 *    => �۾� �� ������ ������ refstep ���� ū ��� ���ڵ���� refstep+1�� �����ϱ�
	 * 3. ��� �� list.shop ��û�ϱ�
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
			throw new ShopException("��й�ȣ�� Ʋ���ϴ�.","update.shop?num="+board.getNum());
		}
		board.setFileurl(file2);
		try {
			service.boardupdate(board, request);
			mav.setViewName("redirect:list.shop");
			mav.addObject("board",board);
		} catch(Exception e) {
			e.printStackTrace();
			throw new ShopException("���� ����.","update.shop?num="+board.getNum());
		}
		return mav;
	}
	@RequestMapping(value="board/delete", method=RequestMethod.POST)
	public ModelAndView delete(Board board, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Board b = service.getBoard(board.getNum(), request);
		if(!b.getPass().equals(board.getPass())) {
			throw new ShopException("��й�ȣ�� Ʋ���ϴ�.","delete.shop?num="+board.getNum());
		}
		try {
			service.boarddelete(board);
			mav.setViewName("redirect:list.shop");
			mav.addObject("board",board);
		} catch(Exception e) {
			e.printStackTrace();
			throw new ShopException("���� ����.","delete.shop?num="+board.getNum());
		}
		return mav;
		
	}
	
}
