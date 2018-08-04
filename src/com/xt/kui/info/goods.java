package com.xt.kui.info;
/**
 * 封装商品的信息
 * @author KUIKUI
 *
 */
public class goods {
	private String code;	//商品编号
	private String name;	//名称
	private String type;//类型
	private int number;	//数量
	private double price;	//价格
	private Boolean isSell;	//是否上架
	public goods(String code, String name, String type, int number, double price, Boolean isSell) {
		super();
		this.code = code;
		this.name = name;
		this.type = type;
		this.number = number;
		this.price = price;
		this.isSell = isSell;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public Boolean getIsSell() {
		return isSell;
	}
	public void setIsSell(Boolean isSell) {
		this.isSell = isSell;
	}
	@Override
	public String toString() {
		return "goods [code=" + code + ", name=" + name + ", type=" + type + ", number=" + number + ", price=" + price
				+ ", isSell=" + isSell + "]";
	}
	
	
}
