package com.xt.kui.info;

import java.util.Date;

/**
 * ��װ���׼�¼����
 * @author KUIKUI
 *
 */
public class TransRecord {
	 private String no;//���׺�
	 private String haveGoods;//�Ѿ��������Ʒ���ַ�����ʽ����
	 private String source;//�����˻��˺�
	 private float discount;//�ۿ�
	 private  double realAmount;//ʵ�����
	 private Date date;//����ʱ��
	public TransRecord(String no, String haveGoods, String source, float discount, double realAmount, Date date) {
		super();
		this.no = no;
		this.haveGoods = haveGoods;
		this.source = source;
		this.discount = discount;
		this.realAmount = realAmount;
		this.date = date;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getHaveGoods() {
		return haveGoods;
	}
	public void setHaveGoods(String haveGoods) {
		this.haveGoods = haveGoods;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public float getDiscount() {
		return discount;
	}
	public void setDiscount(float discount) {
		this.discount = discount;
	}
	public double getRealAmount() {
		return realAmount;
	}
	public void setRealAmount(double realAmount) {
		this.realAmount = realAmount;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "TransRecord [no=" + no + ", haveGoods=" + haveGoods + ", source=" + source + ", discount=" + discount
				+ ", realAmount=" + realAmount + ", date=" + date + "]";
	}
	 
	 
}
