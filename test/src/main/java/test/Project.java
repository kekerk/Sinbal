package test;


public class Project {

	private OracleArticleDao articleDao;

	private String dir;

	public void test() {

		System.out.println("프로젝트 테스트 시작");

		articleDao.insert(articleDao + "insert 메서드 실행됨");

	}
	public void setArticleDao(OracleArticleDao articleDao) {
		this.articleDao = articleDao;
	}

	public void setDir(String dir) {
		this.dir = dir;
	}
	
}