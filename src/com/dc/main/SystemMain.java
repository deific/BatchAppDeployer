package com.dc.main;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.neoremind.sshxcute.core.Logger;

import com.dc.deploy.app.IDeploy;
import com.dc.deploy.config.ConfigInfo;
import com.dc.deploy.config.IConfig;
import com.dc.util.ClassUtil;
/**
 * 
 * <p>Title: SystemMain</P>
 * <p>Description: 主程序</p>
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
public class SystemMain {
	static Logger logger = Logger.getLogger();
	
	// 所有状态
	public static Map<String, Object> allDePloyStatus = new HashMap<String, Object>();
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		start();
	}
	/**
	 * 
	 * <p>方法名称：start</p>
	 * <p>方法描述：启动</p>
	 * @author chensga
	 * @since 2012-7-9
	 */
	@SuppressWarnings("unchecked")
	public static void start() {
		ThreadPoolService threadPoolService = null;
		try {
			// 设置日志显示
			Logger.setAppInfoOutConsoleOnly(Boolean.parseBoolean(IConfig.appinfo_out_console_only));
			logger.putMsg(Logger.INFO, "程序启动", true);
			// 读取部署ip信息
			IConfig config = (IConfig)ClassUtil.getInstance(IConfig.config_class);
			if (null == config) {
				logger.putMsg(Logger.INFO, "配置文件处理类设置不正确，程序终止！", true);
				return;
			}
			List<ConfigInfo> configList = config.getConfigInfoList();
			if (configList.size() > 0) {

				// 创建线程池
				threadPoolService = new ThreadPoolService(
						(IConfig.deploy_max_thread_count == null || "".equals(IConfig.deploy_max_thread_count))?1:Integer.parseInt(IConfig.deploy_max_thread_count));
				// 启动部署
				for (ConfigInfo configInfo: configList) {
					// 启动部署线程
					if (IConfig.deploy_class != null) {
						String[] dePloyClasses = IConfig.deploy_class.split(",");
						for (int i = 0; i < dePloyClasses.length; i++) {
							IDeploy dp = (IDeploy) ClassUtil.getInstance(dePloyClasses[i]);
							if (dp != null) {
								
								List<Object> dePloyClassList = (List<Object>)allDePloyStatus.get(dePloyClasses[i]);
								if (dePloyClassList == null ) {
									dePloyClassList = new ArrayList<Object>();
									allDePloyStatus.put(dePloyClasses[i], dePloyClassList);
								}
								dePloyClassList.add(dp);
								dp.setConfigInfo(configInfo);
								threadPoolService.execute(dp);
							} else {
								logger.putMsg(Logger.INFO, "部署处理类设置不正确，程序终止！", true);
								return;
							}
						}
					} else {
						logger.putMsg(Logger.INFO, "部署处理类设置不正确，程序终止！", true);
						return;
					}
				}
			}
		} catch (Exception e) {
			logger.putMsg(Logger.INFO, "程序发生异常，程序终止！", true);
			e.printStackTrace();
		} finally {
			if (threadPoolService != null){
				threadPoolService.shutDown();
				while (!threadPoolService.isTerminated()) {
					try {
						Thread.sleep(1000l);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
				showAllDePloyStatus();
			}
		}
	}
	/**
	 * 
	 * <p>方法名称：showAllDePloyStatus</p>
	 * <p>方法描述：显示所有的部署状态</p>
	 * @author chensga
	 * @since 2012-7-9
	 */
	@SuppressWarnings("unchecked")
	public static void showAllDePloyStatus() {
		logger.putMsg(Logger.INFO, "=========================================所有部署的状态情况=========================================", true);
		Iterator<String> it = allDePloyStatus.keySet().iterator();
		while (it.hasNext()) {
			
			String dePloyClass = it.next();
			logger.putMsg(Logger.INFO, dePloyClass + "执行情况：", true);
			
			List<Object> dePloyClassList = (List<Object>)allDePloyStatus.get(dePloyClass);
			String deployStatus = null;
			for (int i = 0; i < dePloyClassList.size(); i++) {
				deployStatus = ((IDeploy)dePloyClassList.get(i)).getDeployStatus();
				logger.putMsg(Logger.INFO, deployStatus, true);
			}
		}
	}
}