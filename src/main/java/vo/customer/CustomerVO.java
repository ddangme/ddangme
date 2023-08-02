package vo.customer;

import java.sql.Date;

public class CustomerVO {
	private int no;
	private int kind; // 0 : 카카오, 1 : 네이버
	private String name;
	private String phone;
	private String email;
	private Date birth_date;
	private int mileage;
	private Date join_date;
	private String gender; // M : 남, F : 여
	private int height;
	private int weight;
	private String profile;
	private int agree_email; // 0 : 허락, 1 : 거부
	private int age_group; // 1 : 10대, 2 : 20대, ..., 8 : 8대 이상
	private String unique_id;
	
	public CustomerVO() { }
	

	
	public CustomerVO(int kind, String name, String email, String gender, int age_group, String unique_id) {
		super();
		this.kind = kind;
		this.name = name;
		this.email = email;
		this.gender = gender;
		this.age_group = age_group;
		this.unique_id = unique_id;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getKind() {
		return kind;
	}

	public void setKind(int kind) {
		this.kind = kind;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getBirth_date() {
		return birth_date;
	}

	public void setBirth_date(Date birth_date) {
		this.birth_date = birth_date;
	}

	public int getMileage() {
		return mileage;
	}

	public void setMileage(int mileage) {
		this.mileage = mileage;
	}

	public Date getJoin_date() {
		return join_date;
	}

	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public int getWeight() {
		return weight;
	}

	public void setWeight(int weight) {
		this.weight = weight;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public int getAgree_email() {
		return agree_email;
	}

	public void setAgree_email(int agree_email) {
		this.agree_email = agree_email;
	}

	public int getAge_group() {
		return age_group;
	}

	public void setAge_group(int age_group) {
		this.age_group = age_group;
	}

	public String getUnique_id() {
		return unique_id;
	}

	public void setUnique_id(String unique_id) {
		this.unique_id = unique_id;
	}

}