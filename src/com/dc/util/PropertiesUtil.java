package com.dc.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;
import org.apache.log4j.Logger;

public class PropertiesUtil {
	protected Logger log = Logger.getLogger(this.getClass());
	private static final String CONFIG_FILE = "config/config.properties";

	private static HashMap<String, String> map;
	private static PropertiesUtil instance = new PropertiesUtil();
	
	private PropertiesUtil() {
		map = new HashMap();
	}
	
	public static  PropertiesUtil getInstance(){
		if(instance==null){
			instance = new PropertiesUtil();
		}
		return instance;
	}
	public static String getProperty(String key) {
		return PropertiesUtil.getInstance().getPropertiesByKey(key);
		
	}
	
	public static String getProperty(String configFile,String key) {
	
		return PropertiesUtil.getInstance().getPropertiesByConfigFile(configFile,key);
	}
	
	private String getPropertiesByConfigFile(String configFile,String key){
		if (map.containsKey(key) == false) {
			load(configFile);
		}
		return (String) map.get(key);
	}
	private String getPropertiesByKey(String key){
		if (map.containsKey(key) == false) {
			load(CONFIG_FILE);
		}
		return (String) map.get(key);
	}
	
	private void load(String configFile) {
		Properties props = new Properties();
		String path = UrlUtil.getClassPath(this.getClass());
//		path = System.getProperty("install_dir");
		path = path +"/"+ configFile;
		log.info("path:"+path);
		try {
			props.load(new FileInputStream(path));
			Iterator iter = props.keySet().iterator();
			while ((iter != null) && (iter.hasNext())) {
				String key = (String) iter.next();
				String value = props.getProperty(key);
				map.put(key, value);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(0);
		}
	}
	
}
