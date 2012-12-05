package com.ecko.core.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FileUtils {
	private static final int BUFFER = 8192;// 缓存大小

	public static String copyFile(File src, File desc) {
		InputStream is = null;
		OutputStream os = null;

		try {

			if (!desc.getParentFile().exists()) {
				desc.getParentFile().mkdirs();
			}
			if (!desc.exists()) {
				desc.createNewFile();
			}

			is = new BufferedInputStream(new FileInputStream(src));
			os = new BufferedOutputStream(new FileOutputStream(desc));
			int length = 0;
			byte[] b = new byte[1024 * 1024];
			while ((length = is.read(b, 0, BUFFER)) != -1) {
				os.write(b, 0, length);
			}
			os.flush();
		} catch (Exception e) {
			return null;
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {

					e.printStackTrace();
				}
			}
			if (os != null) {
				try {
					os.close();
				} catch (IOException e) {

					e.printStackTrace();
				}
			}

		}

		return null;
	}

	public static String getExt(File file){
		
		String fileName = file.getName();
		 String fileType = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length());
		 return fileType;

	}
	
	public static String getExt(String fileName){
		 String fileType = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length());
		 return fileType;
		
	}

	public static String genFilePath(String prop, String ext) {
		String src = PropertiesRead.getProperty(prop);
		Date d = new Date();
		String path = d.getYear() + "\\" + d.getMonth() + "\\" + d.getDate()
				+ "\\";
		return src + path + d.getTime() + "." + ext;
	}

	public static void main(String[] args) throws IOException {
		String s = genFilePath("oa_notify_attachment_path", "txt");
		File desc = new File(s);
		if (!desc.getParentFile().exists()) {
			desc.getParentFile().mkdirs();
		}
		if (!desc.exists()) {
			desc.createNewFile();
		}

	}
}
