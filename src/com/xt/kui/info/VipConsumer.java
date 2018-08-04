package com.xt.kui.info;

public class VipConsumer {
	private String cardNo;		//卡号
	private String name;	//姓名
	private String tel;		//电话号码
	private int rank;//会员等级
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
