package com.xt.kui.cashier;
/**
 * 	��������������Ʒ���ݿ����
 * @author KUIKUI
 *
 */

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;


public class GoodsTools {
		List<Goods> goodsList=new ArrayList<Goods>();
		
		/**
		 * ��Goods���͵ļ��������Goods����
		 * ����goods�������飬�����ӵĶ������Ѿ���������ԭ�еĶ����������ϼ�1����
		 * @param good
		 * @return
		 */
		private static boolean isExist=true;
		private static GoodsTools gt=null;
		private GoodsTools()
		{
			
		}
	//����ֻ��һ��ʵ������
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
		 * ����goodsList
		 * @return
		 */
		public List<Goods>  getGoodsList()

		{
			return goodsList;
		}
		/**
		 * ��ռ��ϱ��������
		 */
		public void clearGoods()
		{
			goodsList.clear();
		}
}
