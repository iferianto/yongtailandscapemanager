package be.mxs.common.util.io;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;

/**
 * This is a basic wrapper around the sun.net.ftp.FtpClient class, which is an
 * undocumented class which is included with Sun Java that allows you to make
 * FTP connections and file transfers.
 * 
 * Program version 1.0. Author Julian Robichaux, http://www.nsftools.com
 * 
 * @author Julian Robichaux ( http://www.nsftools.com )
 * @version 1.0
 */
public class SunFtpWrapper extends FTPClient {
	
	
	/** Get the present working directory */
	public String customPwd() throws IOException {
		String[] replyStr = super.doCommandAsStrings("PWD", null);
		if (replyStr != null && replyStr.length > 0) {
			return replyStr[0];
		} else {
			return "";
		}
	}

	/** Go up one directory */
	public boolean customCdup() throws IOException {
		return doCommand("CDUP", null);
	}

	/**
	 * Get the results of the LIST command as a Vector of Strings. Because
	 * there's no standard format for the results of a LIST command, it's hard
	 * to tell what resulting data will look like. Just be aware that different
	 * servers have different ways of returning your LIST data.
	 */
	// public Vector listRaw() throws IOException {
	// String fileName;
	// Vector ftpList = new Vector();
	// BufferedReader reader = new BufferedReader(new
	// InputStreamReader(list()));
	// while ((fileName = reader.readLine()) != null) {
	// ftpList.add(fileName);
	// }
	// return ftpList;
	// }
	/** Get the response code from the last command that was sent */
	public int getResponseCode() throws NumberFormatException {
		return getReplyCode();
	}

	/**
	 * Return true if the last response code was in the 200 range, false
	 * otherwise
	 */
	public boolean isValidResponse() {
		try {
			int respCode = getResponseCode();
			return (respCode >= 200 && respCode < 300);
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * Send a raw FTP command to the server. You can get the response by calling
	 * getResponseString (which returns the entire response as a single String)
	 * or getResponseStrings (which returns the response as a Vector).
	 */
	public int issueRawCommand(String command) throws IOException {
		return sendCommand(command);
	}

	public Boolean downloadFile(String remotePath, 	String localPath) throws Exception {

		BufferedOutputStream output = null;
		boolean success = false;
		try {
			// 检查本地路径
			this.checkFileExist(localPath);
			// 改变工作路径
			if (!changeWorkingDirectory(remotePath)) {
				System.out.println("服务器路径不存在");
				return false;
			}
			// 列出当前工作路径下的文件列表
			List<FTPFile> fileList = this.getFileList(remotePath);
			if (fileList == null || fileList.size() == 0) {
				System.out.println("服务器当前路径下不存在文件！");
				return success;
			}
			for (FTPFile ftpfile : fileList) {
				if (ftpfile.getName().equals(localPath)) {
					File localFilePath = new File(localPath + File.separator
							+ ftpfile.getName());
					output = new BufferedOutputStream(new FileOutputStream(
							localFilePath));
					success = retrieveFile(ftpfile.getName(), output);
				}
			}
			if (!success) {
				throw new Exception("文件下载失败!");
			}
		} catch (Exception e) {
			throw e;
		} finally {
			if (output != null) {
				output.close();
			}
		}
		return success;
	}

	/** Upload a file to the server */
	public boolean uploadFile(String localFile, String serverFile)
			throws Exception {
		boolean success = false;
		InputStream input = null;
		try {
			File file = new File(localFile);
			if (file.exists()) {
				input = new FileInputStream(file);
				success = storeFile(serverFile, input);
			}
			if (!success) {
				throw new Exception("文件上传失败!");
			}
		} catch (Exception e) {
			throw e;
		} finally {
			if (input != null) {
				input.close();
			}
		}
		return success;
	}

	/**
	 * 检查本地路径是否存在
	 * 
	 * @param filePath
	 * @return
	 * @throws Exception
	 */
	public boolean checkFileExist(String filePath) throws Exception {
		boolean flag = false;
		File file = new File(filePath);
		if (!file.exists()) {
			throw new Exception("本地路径不存在,请检查!");
		} else {
			flag = true;
		}
		return flag;
	}

	/**
	 * 获取FTP服务器上[指定路径]下的文件列表
	 * 
	 * @param path
	 * @return
	 * @throws Exception
	 */
	public List<FTPFile> getFileList(String remotePath) throws Exception {

		List<FTPFile> ftpfiles = Arrays.asList(listFiles(remotePath));

		return ftpfiles;
	}

}
