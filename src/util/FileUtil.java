package util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Simple file utility functions.
 */
public class FileUtil {
	public static void writeFile(String filePath, String content,
			Boolean shouldAppend) {
		BufferedWriter out = null;
		try {
			out = new BufferedWriter(new FileWriter(filePath, shouldAppend));
			out.write(content);
			out.close();
		} catch (IOException e) {
		}
	}

	public static ArrayList<String> readAsList(String filePath) {
		String temp = "";
		ArrayList<String> lines = new ArrayList<String>();
		try {
			BufferedReader in = new BufferedReader(new FileReader(filePath));
			while ((temp = in.readLine()) != null) {
				String UTF8Str = new String(temp.getBytes(), "UTF-8");
				lines.add(UTF8Str);
			}
			in.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return lines;
	}
}