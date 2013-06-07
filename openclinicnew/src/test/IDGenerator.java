package test;

import java.io.File;
import java.io.FileOutputStream;

public class IDGenerator {
	public static void main(String[] args) throws Exception {
		java.io.File file = new File(
				"D:\\work\\project\\openclinicnew\\resources\\sql\\oc_label_id.txt");
		FileOutputStream fos = new FileOutputStream(file);
		for (int i = 1; i <= 64589; i++) {
			fos.write(new String(i+",\n").getBytes());
		}
		fos.close();
	}
}
