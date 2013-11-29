package com.dc.deploy.config;

import java.util.ArrayList;
import java.util.List;

import com.dc.util.FileUtil;
import com.dc.util.PropertiesUtil;
import com.dc.util.UrlUtil;
/**
 * 
 * <p>Title: FileConfigFactory</P>
 * <p>Description: 文件形式配置文件</p>
 * <p>Copyright: Copyright (c) 2007</p>
 * <p>Company: DigitalChina Co.Ltd</p>
 * @auther chensga
 * @version 1.0
 * @since 2012-7-3
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 修改版本号：
 */
public class FileConfigFactory implements IConfig {

	private String ipConfigFile = PropertiesUtil.getProperty("ip_configfile");
	@Override
	public List<ConfigInfo> getConfigInfoList() {
		String[] ips = readConfigFile();
		List<ConfigInfo> configList = new ArrayList<ConfigInfo>();
		for (int i = 0; i < ips.length; i ++) {
			ConfigInfo config = new ConfigInfo();
			// 解析值
			String[] values = ips[i].split(",");
			config.setName(values[0]);
			config.setIp(values[1]);
			config.setSshPort((values[2] == null || "".equals(values[2]))?22:Integer.parseInt(values[2]));
			config.setSysUserName(values[3]);
			config.setSysPassword(values[4]);
			config.setDbName(values[5]);
			config.setDbPort((values[2] == null || "".equals(values[6]))?3306:Integer.parseInt(values[6]));
			config.setDbUserName(values[7]);
			config.setDbPassword(values[8]);
			configList.add(config);
		}
		
		return configList;
	}
	/**
	 * 
	 * <p>方法名称：readConfigFile</p>
	 * <p>方法描述：读取配置文件</p>
	 * @return
	 * @author chensga
	 * @since 2012-7-3
	 */
	public String[] readConfigFile() {
		String path = UrlUtil.getClassPath(this.getClass());
		String content = FileUtil.readFile(path + ipConfigFile);
		if (content != null) {
			return content.split(";");
		} else {
			return null;
		}
		
	}
}
