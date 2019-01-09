package logic;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDao;
import dao.ItemDao;
import dao.SaleDao;
import dao.SaleItemDao;
import dao.UserDao;
import exception.ShopException;
import util.MailHandler;
import util.TempKey;

@Service //@Component + Service 기능(Controller와 Repository사이의 중간 객체)
public class ShopService {
	@Autowired
	private ItemDao itemDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private SaleDao saleDao;
	@Autowired
	private SaleItemDao saleItemDao;
	@Autowired
	private BoardDao boardDao; 
	@Autowired
	private JavaMailSender mailSender;
	
	
	public List<Item> getItemList()	{
		return itemDao.list();
	}
	public Item getItemById(String id) {
		return itemDao.getItemById(id);
	}
	//item 테이블에 내용 insert 하기
	//item 객체에 picture 파일을 파일로 저장하기
	public void itemCreate(Item item, HttpServletRequest request) {
		//업로드된 이미지 있는 경우
		if(item.getPicture() != null && !item.getPicture().isEmpty()) {
			uploadFileCreate(item.getPicture(), request, "picture");
			item.setPictureUrl(item.getPicture().getOriginalFilename());
		}
		itemDao.insert(item);
	}
	private void uploadFileCreate(MultipartFile picture, HttpServletRequest request, String path) {
		String uploadPath = request.getServletContext().getRealPath("/") + "/"+path+"/";
		String orgFile = picture.getOriginalFilename();
		try {
			//transferTo : 파일의 내용을 (uploadPath + orgFile)인 파일에 저장.
			picture.transferTo(new File(uploadPath + orgFile));
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public void itemUpdate(Item item, HttpServletRequest request) {
		//수정할 사진이 업로드 된 경우
		if(item.getPicture() != null && !item.getPicture().isEmpty()) {
			uploadFileCreate(item.getPicture(), request, "picture");
			item.setPictureUrl(item.getPicture().getOriginalFilename());
		}
		itemDao.update(item);
	}
	public void itemDelete(String id) {
		itemDao.delete(id);			
	}

	public void userCreate(User user) throws Exception {
        userDao.insert(user);
        String key = new TempKey().getKey(50, false);
        userDao.createAuthKey(user.getEmail(), key);
        MailHandler sendMail = new MailHandler(mailSender);
        sendMail.setSubject("[이메일 인증]");
        sendMail.setText(new StringBuffer().append("<h1>메일인증</h1>")
                .append("<a href='http://192.168.0.72:8080/mavenshop4/user/emailConfirm.shop?authKey=")
                .append(key)
                .append("' target='_blenk'>이메일 인증 확인</a>")
                .toString());
        sendMail.setFrom("ziflrtm12@gmail.com", "Sinbal");
        sendMail.setTo(user.getEmail());
        sendMail.send();
    }
	public User selectUser(String userId) {
		return userDao.select(userId);
	}
	public Sale checkEnd(User loginUser, Cart cart) {
		Sale sale = new Sale();
		sale.setSaleId(saleDao.getMaxSaleId()); //주문번호 자동 생성
		sale.setUser(loginUser); //상품 구매 고객 정보
		sale.setUpdateTime(new Date());
		List<ItemSet> itemList = cart.getItemSetList();
		//Cart의 itemSet 정보를 SaleItem 정보로 변환
		int i = 0;
		for(ItemSet s : itemList) {
			int saleItemId = ++i;
			SaleItem saleItem = new SaleItem(sale.getSaleId(),saleItemId,s,sale.getUpdateTime());
			sale.getItemList().add(saleItem);
		}
		saleDao.insert(sale); //sale 테이블에 레코드 추가
		List<SaleItem> saleItemList = sale.getItemList();
		for(SaleItem s : saleItemList) {
			saleItemDao.insert(s); //주문상품 정보를 saleitem 테이블에 추가
		}
		return sale;
	}
	public List<Sale> saleList(String id) {
		return saleDao.list(id);
	}
	public List<SaleItem> saleItemList(Integer saleId) {
		List<SaleItem> list = saleItemDao.list(saleId);
		for(SaleItem s : list) {
			s.setItem(itemDao.getItemById(s.getItemId()));
		}
		return list;
	}
	public void update(User user) {
		userDao.update(user);	
	}
	public void delete(String id) {
		userDao.delete(id);
	}
	public List<User> userList() {
		return userDao.userList();
	}
	public List<User> userList(String[] idchks) {
		return userDao.list(idchks);
	}
	public Board getBoard(Integer num, HttpServletRequest request) {
		if(request.getRequestURI().contains("detail")) {
			boardDao.readcntadd(num);
		}
		return boardDao.select(num);
	}
	public int boardcount(String searchType, String searchContent) {
		return boardDao.count(searchType,searchContent);
	}
	public List<Board> boardlist(String searchType, String searchContent, Integer pageNum, int limit) {
		return boardDao.list(searchType,searchContent,pageNum,limit);
	}
	public void insert(Board board, HttpServletRequest request) {
		if(board.getFile1() != null && !board.getFile1().isEmpty()) {
			uploadFileCreate(board.getFile1(), request, "file");
			board.setFileurl(board.getFile1().getOriginalFilename());
		}
		int max = boardDao.maxNum();
		board.setNum(++max);		
		board.setRef(max);
		boardDao.insert(board);
	}
	public void replyAdd(Board board) {
		Board b = boardDao.select(board.getNum());
		int max = boardDao.maxNum();
		board.setNum(++max);
		board.setRef(b.getRef());
		board.setReflevel(b.getReflevel()+1);
		board.setRefstep(b.getRefstep()+1);
		boardDao.updateRefstep(b.getRef(), b.getRefstep());
		boardDao.insert(board);	
	}
	public void boardupdate(Board board, HttpServletRequest request) {
		if(board.getFile1() != null && !board.getFile1().isEmpty()) {
			uploadFileCreate(board.getFile1(), request, "file");
			board.setFileurl(board.getFile1().getOriginalFilename());
		}
		boardDao.update(board);	
	}
	public void boarddelete(Board board) {
		boardDao.delete(board.getNum());
	}
	public String getHashvlaue(String password) {
		MessageDigest md;
		String hashvalue = "";
		try {
			md = MessageDigest.getInstance("SHA-256");
			byte[] plain = password.getBytes();
			byte[] hash = md.digest(plain);
			for(byte b : hash) {
				hashvalue += String.format("%02X", b);
			}
		}catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
			throw new ShopException("전산부에 전화 요망","../login.shop");
		}
		return hashvalue;
	}
	public void userAuth(String userEmail) throws Exception {
		userDao.userAuth(userEmail);
	}
	public String Email(String key) {
		return userDao.userEmail(key);	
	}
	public void updateAuth(String email) {
		userDao.userAuth(email);
	}
	public String findId(String email) {
		return userDao.findId(email);
	}
	public String findEmail(User user) {
		return userDao.findEmail(user);
	}

	public void passEmail(String email) throws Exception {
		String key = new TempKey().getKey(50, false);
		userDao.createAuthKey(email, key);
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("[비밀번호 변경]");
		sendMail.setText(new StringBuffer().append("<h1>비밀번호 변경</h1>")
				.append("<a href='http://192.168.0.72:8080/team/user/passChange.shop?authKey=").append(key)
				.append("' target='_blenk'>비밀번호 변경하기</a>").toString());
		sendMail.setFrom("ziflrtm12@gmail.com", "Sinbal");
		sendMail.setTo(email);
		sendMail.send();
	}
	public void passChange(String pass, String email) {
		userDao.updatePass(pass,email);	
	}

	public void delkey(String authKey) {
		userDao.delkey(authKey);
	}
}
