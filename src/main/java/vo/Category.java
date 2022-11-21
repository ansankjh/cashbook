package vo;

// private로 정보 숨기는걸 정보은닉이라한다.
// 자바에서는 정보은닉 없이는 캡슐화가 될수 없다
// 클래스를 만드는 추상화
// 상속 
// 다형성
// 캡슐화
public class Category {
	private int categoryNo;
	private String categoryKind;
	private String categoryName;
	private String updatedate;
	private String createdate;
	
	
	
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getCategoryKind() {
		return categoryKind;
	}
	public void setCategoryKind(String categoryKind) {
		this.categoryKind = categoryKind;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	
	
	
	
	
	
}
