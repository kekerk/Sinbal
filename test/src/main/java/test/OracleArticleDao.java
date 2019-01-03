package test;

import org.springframework.stereotype.Component;

@Component
public class OracleArticleDao implements ArticleDao{
	public void insert(String str) {
		System.out.println(str);
	}
	public String toString() {
		return "OracleArticleDao ";
	}
}
