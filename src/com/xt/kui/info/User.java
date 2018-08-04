package com.xt.kui.info;
/**
 * 用于使用超市收银系统的收银员或者管理员
 * @author KUIKUI
 *
 */
public class User {
	private String id;
	private String password;
	private String name;
	private String gender;
	private int age;
	private String right;
	public User(String id, String password, String name, String gender, int age, String right) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.gender = gender;
		this.age = age;
		this.right = right;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getRight() {
		return right;
	}
	public void setRight(String right) {
		this.right = right;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", password=" + password + ", name=" + name + ", gender=" + gender + ", age=" + age
				+ ", right=" + right + "]";
	}
	
}
