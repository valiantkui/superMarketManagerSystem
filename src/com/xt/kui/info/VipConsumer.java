package com.xt.kui.info;

public class VipConsumer {
	private String cardNo;		//����
	private String name;	//����
	private String tel;		//�绰����
	private int rank;//��Ա�ȼ�
	public VipConsumer(String cardNo, String name, String tel, int rank) {
		super();
		this.cardNo = cardNo;
		this.name = name;
		this.tel = tel;
		this.rank = rank;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	@Override
	public String toString() {
		return "VipConsumer [cardNo=" + cardNo + ", name=" + name + ", tel=" + tel + ", rank=" + rank + "]";
	}
}
