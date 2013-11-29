package com.dc.util;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.ArrayList;
/**
 * 创建日期 2005-7-5
 *
 * <p>Title: File读取类</p>
 *
 * <p>Description:用来做File读取的实用工具</p>
 *
 * <p>Copyright: Copyright (c) 2005</p>
 *
 * <p>Company: DigitalChina</p>
 *
 * @author 姚玉明
 *
 * @version 1.0
 *
 */

public class FileUtil {

    /**
     * 读取文件
     *
     * @param fileName
     * @return
     */
    public static String readFile(String fileName) {
		try {
			File adfile = new File(fileName);
			StringBuffer content = new StringBuffer();
			if (adfile.isFile() && adfile.exists()) {
				InputStreamReader read = new InputStreamReader(
						new FileInputStream(adfile), Charset.defaultCharset());
				BufferedReader in = new BufferedReader(read);
				String line1;
				while ((line1 = in.readLine()) != null) {
					content = content.append(line1 + ";");
				}
			}

			return content.toString();
		} catch (Exception e) {
			return null;
		}

    }
    /**
     * 读取文件
     *
     * @param fileName
     * @return
     */
    public static String readFile(String fileName, String encoding) {
		try {
			File adfile = new File(fileName);
			StringBuffer content = new StringBuffer();
			if (adfile.isFile() && adfile.exists()) {
				InputStreamReader read = new InputStreamReader(
						new FileInputStream(adfile), encoding);
				BufferedReader in = new BufferedReader(read);
				String line1;
				while ((line1 = in.readLine()) != null) {
					content = content.append(line1);
				}
			}

			return content.toString();
		} catch (Exception e) {
			return null;
		}
    }
    
    /**
     * 写入二进制文件
     *
     * @param fileName
     * @param content
     */
    public static void writeFile(String fileName, byte[] content) {

        try {
            FileOutputStream fos = new FileOutputStream(fileName);
            fos.write(content);
            fos.flush();
            fos.close();
        } catch (Exception e) {
        }
    }

    /**
     * 写入字符串文件
     *
     * @param fileName
     * @param content
     */
    public static void writeFile(String fileName, String content) {

        writeFile(fileName, content.getBytes());
    }

	/**
	 * 删除在解压缩时产生的临时文件夹
	 * 
	 * @param folder
	 *            临时文件夹路径
	 * @return true为删除成功，false为失败
	 */
	public static boolean deleteFolder(String folder) {
		boolean bool = false;
		try {
			deleteAllFile(folder);
			String filePath = folder;
			filePath = filePath.toString();
			File f = new File(filePath);
			f.delete();
			bool = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bool;
	}
	/**
	 * 
	 * <p>方法名称：deleteFile</p>
	 * <p>方法描述：删除文件</p>
	 * @param filename
	 * @return
	 * @author chensga
	 * @since 2012-7-5
	 */
	public static boolean deleteFile(String filename){
		File file = new File(filename);
		if(file.isFile()){
			return file.delete();
		}
		return false;
	}

	/**
	 * 删除文件夹下所有内容
	 * 
	 * @param folederPath
	 *            文件夹完整路径
	 * @return
	 */
	public static boolean deleteAllFile(String folederPath) {
		boolean bool = false;
		String filePath = null;
		File file = new File(folederPath);
		if (!file.exists()) {
			return bool;
		}
		if (!file.isDirectory()) {
			return bool;
		}
		String[] tempList = file.list();
		File temp = null;
		for (int i = 0; i < tempList.length; i++) {
			if (folederPath.endsWith(File.separator)) {
				temp = new File(folederPath + tempList[i]);
				filePath = temp.getPath();
			} else {
				temp = new File(folederPath + File.separator + tempList[i]);
			}
			if (temp.isFile()) {
				boolean b = temp.delete();
				if (!b) {
					String msg = filePath + "文件删除失败";
					bool = false;
				}
			}
			if (temp.isDirectory()) {
				deleteAllFile(folederPath + "/" + tempList[i]); // 删除文件夹里面的文件

				deleteFolder(folederPath + "/" + tempList[i]); // 在删除空文件夹

			}
		}
		return bool;
	}

	/**
	 * 判断文件是否存在
	 * 
	 * @param fileName
	 * @return
	 */
	public static boolean isFileExist(String folder, String fileName) {
		boolean bool = false;
		bool = new File(folder, fileName).exists();
		return bool;
	}
	
	/**
	 * 判断文件是否存在
	 * 
	 * @param fileName
	 * @return
	 */
	public static boolean isFileExist(String fileName) {
		boolean bool = false;
		bool = new File(fileName).exists();
		return bool;
	}

	/**
	 * 测试文件夹是否存在
	 * 
	 * @param folder
	 * @return
	 */
	public static boolean existFile(String folder) {
		File file = new File(folder);
		if (file.isDirectory()) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 新建目录
	 * 
	 * @param folderPath
	 *            String 如 c:/fqf
	 * @return boolean
	 */
	public static void newFolder(String folderPath) {
		try {
			String filePath = folderPath;
			filePath = filePath.toString();
			java.io.File myFilePath = new java.io.File(filePath);
			if (!myFilePath.exists()) {
				myFilePath.mkdir();
			}
		} catch (Exception e) {
			System.out.println("新建目录操作出错");
			e.printStackTrace();
		}
	}

	/**
	 * 对文件路径进行处理,主要是在传递过来的路径下创建一个文件夹
	 * 
	 * @param folder
	 * @return 返回新的路径名
	 */
	public static String fileDir(String folder, String folderName) {
		String path = null;
		if (!FileUtil.isFileExist(folder, folderName)) {
			String fullPath = folder + folderName;
			File f = new File(fullPath);
			f.mkdir();
			path = f.getPath();
		}
		return path;
	}
	
	/**
	 * 对文件路径进行处理,主要是在传递过来的路径下创建一个文件夹
	 * 
	 * @param filename
	 * @return 返回新的路径名
	 */
	public static String fileDir(String filename) {
		String path = null;
		if (!FileUtil.isFileExist(filename)) {
			
			File f = new File(filename);
			f.mkdir();
			path = f.getPath();
		}
		return path;
	}

	/**
	 * 遍历文件夹
	 * 
	 * @param file
	 */
	public ArrayList refreshFileList(String strPath) {
		ArrayList filelist = new ArrayList();
		File dir = new File(strPath);
		File[] files = dir.listFiles();
		if (files == null) {
			filelist = null;
		}
		for (int i = 0; i < files.length; i++) {
			if (files[i].isDirectory()) {
				filelist.addAll(refreshFileList(files[i].getAbsolutePath()));
			} else {
				String strFileName = files[i].getAbsolutePath().toLowerCase();
				// System.out.println("---" + strFileName);
				filelist.add(files[i].getAbsolutePath());
				// return filelist;
			}
		}
		return filelist;
	}

	public static boolean hasJpg(String path) {
		File dir = new File(path);
		File[] files = dir.listFiles();
		if (files == null) {
			return false;
		}
		for (int i = 0; i < files.length; i++) {
			if (files[i].isDirectory()) {
				return FileUtil.hasJpg(files[i].getAbsolutePath());
			} else {
				String filename = files[i].getAbsolutePath();
				String filetype = filename
						.substring(filename.lastIndexOf(".") + 1);
				if (filetype.equalsIgnoreCase("jpg")
						|| filetype.equalsIgnoreCase("jpeg")
						|| filetype.equalsIgnoreCase("gif")
						|| filetype.equalsIgnoreCase("bmp")
						|| filetype.equalsIgnoreCase("png")) {
					return true;
				}
			}
		}
		return false;
	}
    public static void main(String[] args) {
         System.out.println( FileUtil.deleteFile("xml/test/1.txt"));

    }
}
