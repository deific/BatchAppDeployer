package com.dc.util;


public class ClassUtil {
	@SuppressWarnings("unchecked")
	public static Object getInstance(String className) {
		try {
			Class classes = null;
			classes = Class.forName(className);
			return classes.newInstance();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
