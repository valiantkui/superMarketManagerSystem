package com.xt.kui.info;
/**
 * ��װ��Ʒ����Ϣ
 * @author KUIKUI
 *
 */
public class goods {
	private String code;	//��Ʒ���
	private String name;	//����
	private String type;//����
	private int number;	//����
	private double price;	//�۸�
	private Boolean isSell;	//�Ƿ��ϼ�
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
