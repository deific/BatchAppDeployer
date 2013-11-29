package com.dc.deploy.app;

import net.neoremind.sshxcute.core.Logger;

import com.dc.deploy.config.ConfigInfo;

public abstract class BaseDeploy implements IDeploy {
	static Logger logger = Logger.getLogger();
	/**
	 * 配置信息
	 */
	protected ConfigInfo config;
	/**
	 * 部署状态
	 */
	protected String deployStatus = "正在等待部署";
	public BaseDeploy() {
	}
	public BaseDeploy(ConfigInfo config) {
		this.config = config;
	}
	@Override
	public void setConfigInfo(ConfigInfo configInfo) {
		this.config = configInfo;
	}
	
	@Override
	public void run() {
		logger.putMsg(Logger.INFO, "【" + config.getName() + "[ip: " + config.getIp()+ "】开始部署...", true);
		deploy();
		logger.putMsg(Logger.INFO, "【" + config.getName() + "[ip: " + config.getIp()+ "】部署完成！", true);
	}
	
	@Override
	public String getDeployStatus() {
		return deployStatus;
	}
	public void setDeployStatus(String deployStatus) {
		this.deployStatus = deployStatus;
	}
}
