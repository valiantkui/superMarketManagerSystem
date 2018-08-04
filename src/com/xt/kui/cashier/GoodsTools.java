package com.xt.kui.cashier;
/**
 * 	此类用来处理商品数据库的类
 * @author KUIKUI
 *
 */

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;


public class GoodsTools {
		List<Goods> goodsList=new ArrayList<Goods>();
		
		/**
		 * 向Goods类型的集合中添加Goods对象
		 * 根据goods编号来检查，如果添加的对象编号已经存在则在原有的对象上数量上加1即可
		 * @param good
		 * @return
		 */
		private static boolean isExist=true;
		private static GoodsTools gt=null;
		private GoodsTools()
		{
			
		}
	//本类只有一个实例对象
		public static GoodsTools getGoodsTools()
		{
			if(isExist==true)
			{
				isExist=false;
				gt=new GoodsTools();
				return gt;
			}
			return gt;
		}
		public boolean addGoods(Goods good)
		{
			boolean isAdd=false;
			Iterator<Goods> iter=goodsList.iterator();
			while(iter.hasNext())
			{
				Goods g=(Goods)iter.next();
				if(g.getCode().equals(good.getCode()))
				{
					g.setNumber(g.getNumber()+1);
					isAdd=true;
					return true;
				}
			}
			if(isAdd==false)
			{
				goodsList.add(good);
				return true;
			}
			return false;
		}
		/**
		 * 返回goodsList
		 * @return
		 */
		public List<Goods>  getGoodsList()

		{
			return goodsList;
		}
		/**
		 * 清空集合保存的数据
		 */
		public void clearGoods()
		{
			goodsList.clear();
		}
}
