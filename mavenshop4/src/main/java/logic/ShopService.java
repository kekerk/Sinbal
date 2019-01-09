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

@Service //@Component + Service ���(Controller�� Repository������ �߰� ��ü)
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
	//item ���̺� ���� insert �ϱ�
	//item ��ü�� picture ������ ���Ϸ� �����ϱ�
	public void itemCreate(Item item, HttpServletRequest request) {
		//���ε�� �̹��� �ִ� ���
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
			//transferTo : ������ ������ (uploadPath + orgFile)�� ���Ͽ� ����.
			picture.transferTo(new File(uploadPath + orgFile));
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public void itemUpdate(Item item, HttpServletRequest request) {
		//������ ������ ���ε� �� ���
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
        sendMail.setSubject("[�̸��� ����]");
        sendMail.setText(new StringBuffer().append("<h1>��������</h1>")
                .append("<a href='http://192.168.0.72:8080/mavenshop4/user/emailConfirm.shop?authKey=")
                .append(key)
                .append("' target='_blenk'>�̸��� ���� Ȯ��</a>")
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
		sale.setSaleId(saleDao.getMaxSaleId()); //�ֹ���ȣ �ڵ� ����
		sale.setUser(loginUser); //��ǰ ���� �� ����
		sale.setUpdateTime(new Date());
		List<ItemSet> itemList = cart.getItemSetList();
		//Cart�� itemSet ������ SaleItem ������ ��ȯ
		int i = 0;
		for(ItemSet s : itemList) {
			int saleItemId = ++i;
			SaleItem saleItem = new SaleItem(sale.getSaleId(),saleItemId,s,sale.getUpdateTime());
			sale.getItemList().add(saleItem);
		}
		saleDao.insert(sale); //sale ���̺� ���ڵ� �߰�
		List<SaleItem> saleItemList = sale.getItemList();
		for(SaleItem s : saleItemList) {
			saleItemDao.insert(s); //�ֹ���ǰ ������ saleitem ���̺� �߰�
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
			throw new ShopException("����ο� ��ȭ ���","../login.shop");
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
		sendMail.setSubject("[��й�ȣ ����]");
		sendMail.setText(new StringBuffer().append("<h1>��й�ȣ ����</h1>")
				.append("<a href='http://192.168.0.72:8080/team/user/passChange.shop?authKey=").append(key)
				.append("' target='_blenk'>��й�ȣ �����ϱ�</a>").toString());
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
