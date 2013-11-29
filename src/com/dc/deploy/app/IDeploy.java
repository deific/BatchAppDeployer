package com.dc.deploy.app;

import com.dc.deploy.config.ConfigInfo;

public interface IDeploy extends Runnable {

	/**
	 * 
	 * <p>方法名称：setConfigInfo</p>
	 * <p>方法描述：设置配置信息</p>
	 * @param configInfo
	 * @author chensga
	 * @since 2012-7-4
	 */
	public void setConfigInfo(ConfigInfo configInfo);
	
	/**
	 * 
	 * <p>方法名称：deploy</p>
	 * <p>方法描述：部署</p>
	 * @author chensga
	 * @since 2012-7-2
	 */
	public void deploy();
	/**
	 * 
	 * <p>方法名称：getDeployStatus</p>
	 * <p>方法描述：获取部署状态</p>
	 * @return
	 * @author chensga
	 * @since 2012-7-4
	 */
	public String getDeployStatus();
}
