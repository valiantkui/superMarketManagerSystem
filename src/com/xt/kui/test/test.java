package com.xt.kui.test;
import java.util.Calendar;
public class test {
	public static void main(String args[])
	{
		Calendar calendar=Calendar.getInstance();
		int year=calendar.get(Calendar.YEAR);
		int month=calendar.get(Calendar.MONTH);
		int day=calendar.get(Calendar.DAY_OF_MONTH);
		System.out.println(year+"Äê"+month+"ÔÂ"+day+"ÈÕ");
		
		String demo="2017*3|2013*5|";
		String [] s=demo.split("\\|");
		for(int i=0;i<s.length && !s[i].equals("");i++)
		{
			String[] d=s[i].split("\\*");
			System.out.println(d[0]);
			System.out.println(d[1]);
		}
	}
}
