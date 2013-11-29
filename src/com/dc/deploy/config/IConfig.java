package com.dc.deploy.config;

import java.util.List;

import com.dc.util.PropertiesUtil;

public interface IConfig {
	String config_class = PropertiesUtil.getProperty("config_class");
	String deploy_class = PropertiesUtil.getProperty("deploy_class");
	
	String server_upload_directory = PropertiesUtil.getProperty("server_upload_directory");
	String bak_directory = PropertiesUtil.getProperty("bak_directory");
	String str_server_max_bakapp_count = PropertiesUtil.getProperty("server_max_bakapp_count");
	int int_server_max_bakapp_count = (str_server_max_bakapp_count == null || "".equals(str_server_max_bakapp_count))?5:Integer.parseInt(str_server_max_bakapp_count);
	String app_start_directory = PropertiesUtil.getProperty("app_start_directory");
	String app_log_directory = PropertiesUtil.getProperty("app_log_directory");
	String app_log_isOk_time = PropertiesUtil.getProperty("app_log_isOk_time");
	String app_log_isOk_keywords = PropertiesUtil.getProperty("app_log_isOk_keywords");
	String app_start_file = PropertiesUtil.getProperty("app_start_file");
	String app_name = PropertiesUtil.getProperty("app_name");
	String upload_fileName = PropertiesUtil.getProperty("upload_fileName");
	String local_upload_directory = PropertiesUtil.getProperty("local_upload_directory");
	String deploy_max_thread_count = PropertiesUtil.getProperty("deploy_max_thread_count");
	String appinfo_out_console_only = PropertiesUtil.getProperty("appinfo_out_console_only");
	
	String db_deploy_sqlfile = PropertiesUtil.getProperty("db_deploy_sqlfile");
	String db_type = PropertiesUtil.getProperty("db_type");
	String db_driver = PropertiesUtil.getProperty("db_driver");
	String db_log_derictory = PropertiesUtil.getProperty("db_log_derictory");
	String db_error_log_derictory = PropertiesUtil.getProperty("db_error_log_derictory");
	/**
	 * 
	 * <p>方法名称：getConfigInfoList</p>
	 * <p>方法描述：获取配置信息列表</p>
	 * @return
	 * @author chensga
	 * @since 2012-7-4
	 */
	public List<ConfigInfo> getConfigInfoList();
}
