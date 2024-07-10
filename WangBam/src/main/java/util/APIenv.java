package util;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class APIenv {
	public static Properties getProp() {
		return prop;
	}

	static Properties prop;
	String apiKey;
	String redirectUri;
	static{
		String propertiesPath="C:\\2nd-project\\WangBam\\src\\main\\java\\api\\env.properties";
		prop= new Properties();
		FileInputStream fis = null;
		try {
			fis=new FileInputStream(propertiesPath);
			prop.load(fis);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(fis!=null) {
				try {
					fis.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
}
