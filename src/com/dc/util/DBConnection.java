package com.dc.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.apache.log4j.Logger;
/**
 * 
 * <p>Title: DBConnection</P>
 * <p>Description: 数据库连接</p>
 * <p>Copyright: Copyright (c) 2007</p>
 * <p>Company: DigitalChina Co.Ltd</p>
 * @auther chensga
 * @version 1.0
 * @since 2011-12-29
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 修改版本号：
 */
public class DBConnection {
	protected Logger log = Logger.getLogger(this.getClass());
	private String username;
	private String password;
	private String url;
	private String driver;
	
	public DBConnection(){
		init();
	}
	
	public DBConnection( String driver, String url, String username, String password) {
		super();
		this.username = username;
		this.password = password;
		this.url = url;
		this.driver = driver;
		
		init();
	}

	/**
	 * 
	 * <p>方法名称：init</p>
	 * <p>方法描述：初始化</p>
	 * @author chensga
	 * @since 2011-12-29
	 */
	private void init() {
		log.info("********加载数据库驱动:" + driver);
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			log.error("********加载数据库驱动异常，异常信息:", e);
		}
	}
	/**
	 * 
	 * <p>方法名称：getConnection</p>
	 * <p>方法描述：获取数据库连接</p>
	 * @return
	 * @author chensga
	 * @since 2011-12-29
	 */
	public Connection getConnection(){
		log.info("********获取数据库连接********");
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(url, username, password);
		} catch (SQLException e) {
			log.error("********获取数据库连接异常，异常信息:", e);
		}
		return conn ;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getDriver() {
		return driver;
	}

	public void setDriver(String driver) {
		this.driver = driver;
	}

}
