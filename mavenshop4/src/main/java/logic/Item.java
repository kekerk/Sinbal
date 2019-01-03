package logic;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class Item {
	private Integer id;
	@NotEmpty(message="상품명을 등록하세요") //NotNull 의미 + 빈문자열의 의미
	private String name;
	@NotNull(message="가격을 등록하세요")
	@Min(value=10, message="가격은 10원 이상 가능합니다.")
	@Max(value=100000, message="가격은 10만원 이하만 가능합니다.")
	private Integer price;
	@NotEmpty(message="상품내용을 등록하세요")
	private String description;
	private String pictureUrl;
	//UPLOAD된 파일의 내용을 저장 : shop-3-servlet.xml의 multipartResolver bean이 관여
	private MultipartFile picture; //<input type="file" name="picture"> 인 파일의 내용 저장
	public MultipartFile getPicture() {
		return picture;
	}
	public void setPicture(MultipartFile picture) {
		this.picture = picture;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getPictureUrl() {
		return pictureUrl;
	}
	public void setPictureUrl(String pictureUrl) {
		this.pictureUrl = pictureUrl;
	}
	@Override
	public String toString() {
		return "Item [id=" + id + ", name=" + name + ", price=" + price + ", description=" + description
				+ ", pictureUrl=" + pictureUrl + "]";
	}
	
}
