package com.dc.deploy.app;

import java.text.SimpleDateFormat;
import java.util.Date;
import net.neoremind.sshxcute.core.Logger;
import com.dc.deploy.config.ConfigInfo;
import com.dc.deploy.config.IConfig;
import com.dc.ssh.SSHTool;
/**
 * 
 * <p>Title: Deploy</P>
 * <p>Description: 部署</p>
 * <p>Copyright: Copyright (c) 2007</p>
 * <p>Company: DigitalChina Co.Ltd</p>
 * @auther chensga
 * @version 1.0
 * @since 2012-7-2
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 修改版本号：
 */
public class AppDeploy extends BaseDeploy {

	public AppDeploy() {
		super();
	}
	public AppDeploy(ConfigInfo config) {
		super(config);
	}
	
	@Override
	public void deploy() {
		
		// 初始化SHH工具
		boolean sshIsOk = SSHTool.init(config.getIp(), config.getSshPort(), config.getSysUserName(), config.getSysPassword());
		if (!sshIsOk) {
			deployStatus="【" + config.getName() + "[ip: " + config.getIp()+ "】SSH初始化异常，退出部署！";
			logger.putMsg(Logger.ERROR, deployStatus , true);
			
		}
		
		try {
			
			//停止原应用
			String[] processIds = SSHTool.shutdownApp(null, null, IConfig.app_name);
			deployStatus="【" + config.getName() + "[ip: " + config.getIp()+ "】停止原有程序，进程id=" + SSHTool.arrayToString(processIds);
			logger.putMsg(Logger.INFO, deployStatus, true);
			deployStatus="【" + config.getName() + "[ip: " + config.getIp()+ "】正在创建原有程序备份...";
			logger.putMsg(Logger.INFO,deployStatus , true);
			// 创建备份
			bakApp();
			deployStatus="【" + config.getName() + "[ip: " + config.getIp()+ "】正在上传最新版本程序...";
			logger.putMsg(Logger.INFO, deployStatus, true);
			// 上传
			SSHTool.upload(IConfig.server_upload_directory, IConfig.local_upload_directory
					+ IConfig.upload_fileName);
			deployStatus="【" + config.getName() + "[ip: " + config.getIp()+ "】正在解压最新版本程序...";
			logger.putMsg(Logger.INFO, deployStatus, true);
			// 解压
			SSHTool.unZip(IConfig.server_upload_directory + IConfig.upload_fileName, IConfig.server_upload_directory);
            deployStatus="【" + config.getName() + "[ip: " + config.getIp()+ "】正在赋权限...";
			logger.putMsg(Logger.INFO,deployStatus , true);
			// 赋权限
			SSHTool.execCommand(" chmod +x "
					+ IConfig.server_upload_directory
					+ IConfig.app_start_directory + "*.*");
			deployStatus="【" + config.getName() + "[ip: " + config.getIp()+ "】正在转换文件编码...";
			logger.putMsg(Logger.INFO, deployStatus, true);
			// 转换文件编码
			SSHTool.execCommand("dos2unix "
					+ IConfig.server_upload_directory
					+ IConfig.app_start_directory + "*.sh "
					+ IConfig.server_upload_directory
					+ IConfig.app_start_directory + "*.sh ");
			deployStatus="【" + config.getName() + "[ip: " + config.getIp()+ "】正在启动程序...";
			logger.putMsg(Logger.INFO,deployStatus , true);
			// 启动扫描程序
			processIds = SSHTool.startApp(IConfig.server_upload_directory
					+ IConfig.app_start_directory, IConfig.app_start_file, IConfig.app_name);
			deployStatus="【" + config.getName() + "[ip: " + config.getIp()+ "】的程序已启动，程序进程id=" + 
					SSHTool.arrayToString(processIds);
			logger.putMsg(Logger.INFO, deployStatus, true);
			
			if (null != IConfig.app_log_isOk_time && !"".equals(IConfig.app_log_isOk_time) 
					&& !"0".equals(IConfig.app_log_isOk_time)) {
				// 休眠，检查日志是否有错误
				Thread.sleep(Long.parseLong(IConfig.app_log_isOk_time));
				String result = SSHTool.find(IConfig.app_log_directory, IConfig.app_log_isOk_keywords);
				if (null != result && !"".equals(result) && !"failed".equals(result)) {
					deployStatus = "【" + config.getName() + "[ip: " + config.getIp()+ "】的程序已启动，但发生错误，错误日志信息：" + result;
					logger.putMsg(Logger.INFO, deployStatus, true);
				} else {
					deployStatus = "【" + config.getName() + "[ip: " + config.getIp()+ "】的程序已启动，正常执行！";
					logger.putMsg(Logger.INFO, deployStatus, true);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			deployStatus = "【" + config.getName() + "[ip: " + config.getIp()+ "】部署发生异常，异常信息：" + e;
			logger.putMsg(Logger.INFO, deployStatus, true);
		} finally {
			// 关闭
			SSHTool.close();
		}
	}
	
	/**
	 * 
	 * <p>方法名称：bakApp</p>
	 * <p>方法描述：备份应用</p>
	 * @author chensga
	 * @since 2012-7-3
	 */
	public void bakApp() {
		boolean isSuccess = SSHTool.cd(IConfig.server_upload_directory + IConfig.app_name);
		if(isSuccess){
		    // 创建备份目录
			isSuccess = SSHTool.mkdir(IConfig.bak_directory);
			// 如果不成功，则目录已存在
			if (!isSuccess) {
				// 检查备份数并删除多余备份
				String[] fileList = SSHTool.getFileList(IConfig.bak_directory);
				if (fileList.length >= IConfig.int_server_max_bakapp_count) {
					for (int i = 0; i <= fileList.length - IConfig.int_server_max_bakapp_count; i++) {
						deployStatus = "【" + config.getName() + "[ip: " + config.getIp()+ "】正在删除多余备份" + fileList[i];
						logger.putMsg(Logger.INFO, deployStatus, true);
						SSHTool.delete(IConfig.bak_directory, fileList[i]);
					}
				}
			}
			// 备份
			SSHTool.cp(IConfig.server_upload_directory +  IConfig.app_name, 
					IConfig.bak_directory + IConfig.app_name + "_" + new SimpleDateFormat("yyyy-MM-dd_hh:mm:ss").format(new Date()));
			// 删除原程序
			SSHTool.delete(IConfig.server_upload_directory + IConfig.app_name, "/*");
		} else {
			// 创建上传目录
			SSHTool.mkdir(IConfig.server_upload_directory);
		}
	}
}
