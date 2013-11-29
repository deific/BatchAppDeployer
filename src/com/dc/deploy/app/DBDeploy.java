package com.dc.deploy.app;

import java.io.FileReader;
import java.io.PrintWriter;
import net.neoremind.sshxcute.core.Logger;
import com.dc.deploy.config.ConfigInfo;
import com.dc.deploy.config.IConfig;
import com.ibatis.common.jdbc.ScriptRunner;
/**
 * 
 * <p>Title: DBDeploy</P>
 * <p>Description: 数据库部署，更新</p>
 * <p>Copyright: Copyright (c) 2007</p>
 * <p>Company: DigitalChina Co.Ltd</p>
 * @auther chensga
 * @version 1.0
 * @since 2012-7-4
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 修改版本号：
 */
public class DBDeploy extends BaseDeploy {
	public DBDeploy() {
		super();
	}
	public DBDeploy(ConfigInfo config) {
		super(config);
	}
	
	@Override
	public void deploy() {
		deployStatus = "【" + config.getName() + "[ip: " + config.getIp()+ "】正在执行数据库脚本...";
		logger.putMsg(Logger.INFO, deployStatus, true);
		// 执行脚本
		boolean isSuccess = executeScript();
		if (isSuccess) {
			deployStatus = "【" + config.getName() + "[ip: " + config.getIp()+ "】数据库脚本正常执行完毕";
			logger.putMsg(Logger.INFO, deployStatus, true);
		} else {
			deployStatus = "【" + config.getName() + "[ip: " + config.getIp()+ "】数据库脚本执行发生异常，" +
			"详细信息请查看错误日志文件【" + IConfig.db_error_log_derictory + "mysql_error_" + config.getName() + ".log】";
			logger.putMsg(Logger.INFO, deployStatus, true);
		}
	}
	
	/**
	 * 
	 * <p>方法名称：executeScript</p>
	 * <p>方法描述：执行数据库脚本</p>
	 * @return
	 * @author chensga
	 * @since 2012-7-9
	 */
	public boolean executeScript() {
		ScriptRunner runner = null;
		try {
			String url = "";
			url="jdbc:mysql://"+config.getIp()+":"+config.getDbPort()+"/" + config.getDbName() + "?characterEncoding=gbk&amp";	
			
			runner = new ScriptRunner(IConfig.db_driver, url, config.getDbUserName(), 
					config.getDbPassword(), false, true);
	
			runner.setErrorLogWriter(new PrintWriter(
					IConfig.db_error_log_derictory + "mysql_error_" +  config.getName() + ".log"));
			runner.setLogWriter(null);
			runner.runScript(new FileReader(IConfig.db_deploy_sqlfile));
			return true;
		} catch (Exception e) {
			//e.printStackTrace();
			return false;
		}
	}

}
