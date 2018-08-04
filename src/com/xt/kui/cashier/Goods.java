package com.xt.kui.cashier;
/**
 * 此类用来封装已经购买的物品
 * @author KUIKUI
 *
 */
public class Goods {
		private String code;
		private String name;
		private int number;
		private double price;
		
		public Goods(String code, String name, int number, double price) {
			super();
			this.code = code;
			this.name = name;
			this.number = number;
			this.price = price;
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
		@Override
		public String toString() {
			return "GoodsTools [code=" + code + ", name=" + name + ", number=" + number + ", price=" + price + "]";
		}
		
}
