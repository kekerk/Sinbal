package logic;

import java.io.File;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDao;
import dao.ItemDao;
import dao.SaleDao;
import dao.SaleItemDao;
import dao.UserDao;
import exception.ShopException;
import util.CiperUtil;

/*
 * @Service = @Component(의 하위 클래스) + Service 기능(Controller와 Repository 사이의 중간 객체) 부여.
 */
@Service
public class ShopService {
	@Autowired // 객체 주입
	private ItemDao itemDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private SaleDao saleDao;

	@Autowired
	private SaleItemDao saleItemDao;

	@Autowired
	private BoardDao boardDao;

	public List<Item> getItemList() {
		return itemDao.list();
	}

	public Item getItem(Integer id) {
		return itemDao.getItemById(id);
	}

	/*
	 * 2가지 역할 1. item테이블에 내용 insert하기 2. item 객체의 picture 파일을 파일로 저장하기
	 */
	public void itemCreate(Item item, HttpServletRequest request) {
		// 업로드된 이미지가 있는 경우
		if (item.getPicture() != null && !item.getPicture().isEmpty()) {
			uploadFileCreate(item.getPicture(), request, "picture"); // picture의 내용을 파일로 저장하는 메서드
			// db에 파일의 이름을 저장
			item.setPictureUrl(item.getPicture().getOriginalFilename());
		}
		itemDao.insert(item);
	}

	public void itemEdit(Item item, HttpServletRequest request) {

		if (item.getPicture() != null && !item.getPicture().isEmpty()) {
			uploadFileCreate(item.getPicture(), request, "picture");
			item.setPictureUrl(item.getPicture().getOriginalFilename());
		}
		itemDao.update(item);
	}

	private void uploadFileCreate(MultipartFile picture, HttpServletRequest request, String path) {
		String uploadPath = request.getServletContext().getRealPath("/") + "/" + path + "/";
		String orgFile = picture.getOriginalFilename();// 파일 이름
		try {
			// transferTo : 파일의 내용을 (uploadPath + orgFile)인 파일에 저장.
			picture.transferTo(new File(uploadPath + orgFile));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void itemDelete(Integer id) {
		itemDao.delete(id);
	}

	public void userCreate(User user) {
		String ciperemail = CiperUtil.encrypt(user.getEmail(), user.getUserId());
		user.setEmail(ciperemail);
		user.setPassword(getHashValue(user.getPassword()));
		userDao.insertUser(user);

	}

	public User selectUser(String userId) {
		User user = userDao.selectUser(userId);
		user.setEmail(CiperUtil.decrypt(user.getEmail(), user.getUserId()));
		return user;
	}

	public Sale checkEnd(User loginUser, Cart cart) {
		Sale sale = new Sale();
		sale.setSaleId(saleDao.getMaxSaleId()); // 주문번호 자동 생성
		sale.setUser(loginUser);// 상품 구매 고객 정보
		sale.setUpdateTime(new Date()); // 구매 일자
		List<ItemSet> itemList = cart.getItemSetList();
		// cart의 itemSet 정보를 saleItem 정보로 변환
		int i = 0;
		for (ItemSet is : itemList) {
			int saleItemId = ++i;
			SaleItem saleItem = new SaleItem(sale.getSaleId(), saleItemId, is, sale.getUpdateTime());
			sale.getItemList().add(saleItem);
		}
		saleDao.insert(sale); // sale 테이블에 레코드 추가
		List<SaleItem> saleItemList = sale.getItemList();
		for (SaleItem is : saleItemList) {
			saleItemDao.insert(is); // 주문상품정보를 saleitem 테이블에 추가
		}
		return sale;
	}

	public List<Sale> SaleList(String id) {
		return saleDao.Salelist(id);
	}

	public List<SaleItem> SaleItemlist(Integer saleId) {
		return saleItemDao.SaleItemlist(saleId);
	}

	public void update(User user) {
		String ciperemail = CiperUtil.encrypt(user.getEmail(), user.getUserId());
		user.setEmail(ciperemail);
		userDao.update(user);

	}

	public void deleteUser(String userId) {
		userDao.deleteUser(userId);

	}

	public List<User> userList() {
		List<User> list = userDao.userList();
		for(User u : list) {
			u.setEmail(CiperUtil.decrypt(u.getEmail(), u.getUserId()));
		}
		return list;
	}

	public List<User> userList(String[] idchks) {
		List<User> list =  userDao.userList(idchks);
		for(User u : list) {
			u.setEmail(CiperUtil.decrypt(u.getEmail(), u.getUserId()));
		}
		return list;
	}

	public Board selectBoard(Integer num) {
		return boardDao.selectBoard(num);
	}

	public List<Board> boardList(String searchType, String searchContent, Integer pageNum, int limit) {
		return boardDao.list(searchType, searchContent, pageNum, limit);
	}

	public int boardcount(String searchType, String searchContent) {

		return boardDao.count(searchType, searchContent);
	}

	public void write(Board board, HttpServletRequest request) { // 글쓰기와 답글 기능 동시 사용
		int num = boardDao.maxNum();
		int ref = board.getRef();
		int reflevel = board.getReflevel();
		int refstep = board.getRefstep();
		board.setNum(++num);
		if (request.getRequestURI().contains("write")) { // 글쓰기(write)
			board.setRef(num);
		}
		if (request.getRequestURI().contains("reply")) { // 답글(reply)
			boardDao.updateAboutRef(ref, refstep);
			board.setRef(ref);
			board.setReflevel(++reflevel);
			board.setRefstep(++refstep);
		}
		if (board.getFile1() != null && !board.getFile1().isEmpty()) {
			uploadFileCreate(board.getFile1(), request, "file");
			board.setFileurl(board.getFile1().getOriginalFilename());
		}
		boardDao.write(board);

	}

//write에서 reply 분리해서 사용 시
	public void reply(Board board, HttpServletRequest request) {
		int num = boardDao.maxNum();
		int ref = board.getRef();
		int reflevel = board.getReflevel();
		int refstep = board.getRefstep();
		boardDao.updateAboutRef(ref, refstep);
		board.setNum(++num);
		board.setRef(ref);
		board.setReflevel(++reflevel);
		board.setRefstep(++refstep);
		boardDao.write(board);
	}

//	public void replys(Board board, HttpServletRequest request) {
//		Board b1 = boardDao.selectBoard(board.getNum());
//		int num = boardDao.maxNum();
//		int ref=board.getRef();
//		int reflevel = board.getReflevel();
//		int refstep = board.getRefstep();
//		boardDao.updateAboutRef(ref,refstep);
//		board.setNum(++num);
//		board.setRef(ref);
//		board.setReflevel(++reflevel);
//		board.setRefstep(++refstep);
//		boardDao.write(board);
//	}
	public int maxNum() {
		return boardDao.maxNum();
	}

	public void reatCnt(int num) {
		boardDao.readcnt(num);
	}

	public void updateboard(Board board, HttpServletRequest request) {
		if (board.getFile1() != null && !board.getFile1().isEmpty()) {
			uploadFileCreate(board.getFile1(), request, "file");
			board.setFileurl(board.getFile1().getOriginalFilename());
		}
		boardDao.updateboard(board);
		
	}

	public void deleteboard(Integer num) {
		boardDao.deleteBoard(num);
		
	}

	public String getHashValue(String password){
		MessageDigest md;
		String hashvalue="";
		try {
			md = MessageDigest.getInstance("SHA-256");
			byte[] plain=password.getBytes();
			byte[] hash=md.digest(plain);
			for(byte b : hash) {
				hashvalue+=String.format("%02x", b);
			}
		}catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
			throw new ShopException("전산부에 전화 요망","../login.shop");
		}
		return hashvalue;
	}

}
