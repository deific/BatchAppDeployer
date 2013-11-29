package com.dc.ssh;

import net.neoremind.sshxcute.core.ConnBean;
import net.neoremind.sshxcute.core.IOptionName;
import net.neoremind.sshxcute.core.Logger;
import net.neoremind.sshxcute.core.Result;
import net.neoremind.sshxcute.core.SSHExec;
import net.neoremind.sshxcute.task.CustomTask;
import net.neoremind.sshxcute.task.impl.ExecCommand;
import net.neoremind.sshxcute.task.impl.ExecShellScript;

public class SSHTool {
	static Logger logger = Logger.getLogger();
	final static public String importJavaProfile = "source /etc/profile;source ~/.bash_profile;source ~/.bashrc;";
	private static ThreadLocal<SSHExec> tl = new ThreadLocal<SSHExec>();
	
	public SSHTool(String host, int port, String username,
			String password) {
		init(host, port, username, password);
	}
	/**
	 * 连接sftp服务器
	 * 
	 * @param host
	 *            主机
	 * @param port
	 *            端口
	 * @param username
	 *            用户名
	 * @param password
	 *            密码
	 * @return
	 */
	public static boolean init(String host, int port, String username,
			String password) {
		try {
			
			ConnBean conn = new ConnBean(host, username, password);
			SSHExec sshExec = SSHExec.getInstance(conn, SSHExec.MODE_UNSINGLETON);
			SSHExec.setOption(IOptionName.SSH_PORT_NUMBER, port);
			SSHExec.setOption(IOptionName.TIMEOUT, 360001);
			SSHExec.setOption(IOptionName.INTEVAL_TIME_BETWEEN_TASKS, 0l);
			boolean result = sshExec.connect();
			if (result) {
				tl.set(sshExec);
				return true;
			} else {
				//logger.putMsg(Logger.ERROR, "SSH 工具初始化错误，连接拒绝", true);
				return false;
			}
		} catch (Exception e) {
			logger.putMsg(Logger.ERROR, "SSH 工具初始化异常", true);
			return false;
		}
	}

	private static SSHExec getSSHExec() {
		return tl.get();
	}
	/**
	 * 上传文件
	 * 
	 * @param directory
	 *            上传的目录
	 * @param uploadFile
	 *            要上传的文件
	 * @param sftp
	 */
	public static boolean upload(String directory, String uploadFile) {
		try {
			getSSHExec().uploadSingleDataToServer(uploadFile, directory);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 上传文件
	 * 
	 * @param startApp
	 *            上传的目录
	 * @param uploadFile
	 *            要上传的文件
	 * @param sftp
	 */
	public static String[] startApp(String app_start_directory, String app_start_file, String appName) {
		SSHTool.execShellScript(importJavaProfile + " cd " + app_start_directory + ";./" + app_start_file + ";");
		return SSHTool.getProccessId(appName);
	}
	/**
	 * 上传文件
	 * 
	 * @param startApp
	 *            上传的目录
	 * @param uploadFile
	 *            要上传的文件
	 * @param sftp
	 */
	public static String[] shutdownApp(String app_shutdown_directory, String app_shutdown_file, String appName) {
		String[] processIds = SSHTool.getProccessId(appName);
		if (null == app_shutdown_file || "".equals(app_shutdown_file)) {
			kill(processIds);
			return processIds;
		} else {
			SSHTool.execShellScript(importJavaProfile + " cd " + app_shutdown_directory + ";./" + app_shutdown_file + ";");
			return processIds;
		}
	}
	/**
	 * 删除文件
	 * 
	 * @param directory
	 *            要删除文件所在目录
	 * @param deleteFile
	 *            要删除的文件
	 * @param sftp
	 */
	public static boolean delete(String directory, String deleteFile) {
		return execCommand("rm -rf " + directory + deleteFile);
	}
	
	/**
	 * 解压文件
	 * 
	 * @param file
	 *            解压文件
	 * @param unzipDirectory
	 *            解压目录
	 * @param sftp
	 */
	public static boolean unZip(String file, String unzipDirectory) {
		return execCommand(" unzip -o " + file + " -d " + unzipDirectory);
	}
	
	/**
	 * 删除文件
	 * 
	 * @param directory
	 *            要删除文件所在目录
	 * @param deleteFile
	 *            要删除的文件
	 * @param sftp
	 */
	public static String execCommand(String... command) {
		try {
			CustomTask ct1 = new ExecCommand(command);
			Result res = getSSHExec().exec(ct1);
			// 检查执行结果，如果执行成功打印输出，如果执行失败，打印错误信息
			 if (res.isSuccess) 
			 { 
				 logger.putMsg(Logger.INFO, "Return code: " + res.rc);
				 logger.putMsg(Logger.INFO, "sysout: " + res.sysout);
				 return res.sysout;
			 } else { 
				 logger.putMsg(Logger.INFO, "Return code: " + res.rc);
				 logger.putMsg(Logger.INFO, "error message: " + res.error_msg);
				 return "failed";
			 } 
		} catch (Exception e) {
			e.printStackTrace();
			return "failed";
		}
	}
	/**
	 * 
	 * <p>方法名称：execCommand</p>
	 * <p>方法描述：执行命令</p>
	 * @param command
	 * @return
	 * @author chensga
	 * @since 2012-7-3
	 */
	public static boolean execCommand(String command) {
		if ("failed".equals(execCommand(new String[]{command}))) {
			return false;
		} else {
			return true;
		}
	}
	public static boolean execShellScript(String command) {
		try {
			CustomTask ct1 = new ExecShellScript(command);
			Result res = getSSHExec().exec(ct1);
			// 检查执行结果，如果执行成功打印输出，如果执行失败，打印错误信息
			 if (res.isSuccess) 
			 { 
				 logger.putMsg(Logger.INFO, "Return code: " + res.rc);
				 logger.putMsg(Logger.INFO, "sysout: " + res.sysout);
				 return true;
			 } else { 
				 logger.putMsg(Logger.INFO, "Return code: " + res.rc);
				 logger.putMsg(Logger.INFO, "error message: " + res.error_msg);
				 return false;
			 } 
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static boolean execShellScript(String path,String command, String args) {
		try {
			CustomTask ct1 = new ExecShellScript(path, command);
			Result res = getSSHExec().exec(ct1);
			// 检查执行结果，如果执行成功打印输出，如果执行失败，打印错误信息
			 if (res.isSuccess) 
			 { 
				 logger.putMsg(Logger.INFO, "Return code: " + res.rc);
				 logger.putMsg(Logger.INFO, "sysout: " + res.sysout);
				 return true;
			 } else { 
				 logger.putMsg(Logger.INFO, "Return code: " + res.rc);
				 logger.putMsg(Logger.INFO, "error message: " + res.error_msg);
				 return false;
			 } 
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	

	public static boolean kill(String... proccessId) {
		try {
			// 检查执行结果，如果执行成功打印输出，如果执行失败，打印错误信息
			 if (null != proccessId && !"".equals(proccessId)) 
			 { 
				 CustomTask ct2=new ExecCommand(" kill -9 " + arrayToString(proccessId));
				 Result res = getSSHExec().exec(ct2);
				 if (res.isSuccess) {
					 logger.putMsg(Logger.INFO, "Return code: " + res.rc);
					 logger.putMsg(Logger.INFO, "sysout: " + res.sysout);
					 return true;
				 } else {
					 logger.putMsg(Logger.INFO, "Return code: " + res.rc);
					 logger.putMsg(Logger.INFO, "error message: " + res.error_msg);
					 return false; 
				 }
				
			 } else { 
				 logger.putMsg(Logger.INFO, "Return code: 1");
				 logger.putMsg(Logger.INFO, "error message: 没有" + proccessId + "的进程id");
				 return false;
			 } 
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static String[] getProccessId(String processName) {
		String result = "";
		try {
			CustomTask ct1 = new ExecCommand("ps -ef|grep " + processName + " |grep -v grep| awk -F' ' '{print $2}' | awk '{print $1}' ");
			Result res = getSSHExec().exec(ct1);
			// 检查执行结果，如果执行成功打印输出，如果执行失败，打印错误信息
			 if (res.isSuccess) 
			 { 
				 result = res.sysout;
			 } 
			if (!"".equals(result)) {
				return result.split("\n");
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * cd目录
	 * 
	 * @param directory
	 *            cd目录
	 * @param uploadFile
	 *            cd目录
	 * @param sftp
	 */
	public static boolean cd(String directory) {
		return execCommand("cd " + directory);
	}
	
	/**
	 * 新建文件
	 * 
	 * @param directory
	 *            新建文件
	 * @param uploadFile
	 *            新建文件
	 * @param sftp
	 */
	public static boolean mkdir(String directory) {
		return execCommand("mkdir " + directory);
	}
	
	public static boolean cp(String oldFile,String newFile) {
		return execCommand("cp -r " + oldFile + " -d " + newFile);
	}
	
	public static String[] getFileList(String directory) {
		String files = execCommand(new String[]{"ls -F " + directory});
		return files.split("\n");
	}
	
	/**
	 * 关闭
	 * 
	 * @param directory
	 *            上传的目录
	 * @param uploadFile
	 *            要上传的文件
	 * @param sftp
	 */
	public static void close() {
		if(getSSHExec()!=null){
			getSSHExec().disconnect();
		}
	}
	/**
	 * 
	 * <p>方法名称：find</p>
	 * <p>方法描述：查找关键字</p>
	 * @author chensga
	 * @since 2012-7-3
	 */
	public static String find(String directory, String keyWord) {
		return execCommand(new String[]{"grep " + keyWord + " " + directory + " -n -H"});
	}
	
	/**
	 * 
	 * <p>方法名称：arrayToString</p>
	 * <p>方法描述：数组转换字符串</p>
	 * @param array
	 * @return
	 * @author chensga
	 * @since 2012-7-3
	 */
	public static String arrayToString(String... array) {
		String result = "";
		if (null != array) {
			for (int i = 0; i < array.length; i++) {
				result = result + array[i] + " ";
			}
		}
		return result.trim();
	}
	
}


