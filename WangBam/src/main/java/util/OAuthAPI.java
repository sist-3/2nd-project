package util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Properties;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class OAuthAPI {
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
	
	public String getAccessToken(String code,String type) {
	    String accessToken = "";
	    String refreshToken = "";
	    String reqUrl = prop.getProperty(type+".token_uri");
	    OutputStreamWriter osw = null;
	    BufferedWriter bw = null;
	    BufferedReader br = null;
	    InputStreamReader isr = null;
	    try{
	        URL url = new URL(reqUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        
	        //필수 헤더 세팅
	        conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
	        conn.setDoOutput(true); //OutputStream으로 POST 데이터를 넘겨주겠다는 옵션.
	        osw = new OutputStreamWriter(conn.getOutputStream());
	        
	        bw = new BufferedWriter(osw);
	        StringBuilder sb = new StringBuilder();
	        
	        
	        
	        
	        //필수 쿼리 파라미터 세팅
	        sb.append(prop.getProperty(type+".defalt_param"));
	        
			sb.append("&client_id=").append(prop.getProperty(type+".api_key"));
	        sb.append("&redirect_uri=").append(prop.get(type+".redirect_uri"));
	        sb.append("&code=").append(code);

	        bw.write(sb.toString());
	        bw.flush();

	        int responseCode = conn.getResponseCode();

	        
	        if (responseCode >= 200 && responseCode < 300) {
	        	isr = new InputStreamReader((conn.getInputStream()));
	        } else {
	        	isr =new InputStreamReader(conn.getErrorStream());
	            
	        }
	        br = new BufferedReader(isr);
	        String line = "";
	        StringBuilder responseSb = new StringBuilder();
	        while((line = br.readLine()) != null){
	            responseSb.append(line);
	        }
	        String result = responseSb.toString();

	        JSONParser parser = new JSONParser();
	        JSONObject element = (JSONObject) parser.parse(result);
	        accessToken = element.get("access_token").toString();
	        refreshToken = element.get("refresh_token").toString();
	    }catch (Exception e){
	        e.printStackTrace();
	    }finally {
			try {
				if(osw!=null) {
					osw.close();
				}
				if(br!=null) {
					br.close();
				}
				if(bw!=null) {
					bw.close();
				}
				if(isr!=null) {
					isr.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	    return accessToken;
	}
	
	public String getUserId(String accessToken,String type) {
	    String reqUrl = prop.getProperty(type+".getUser_uri");
	    BufferedReader br = null;
	    InputStreamReader isr = null;
	    String id=null;
	    try{
	        URL url = new URL(reqUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Authorization", "Bearer " + accessToken);
	        conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

	        int responseCode = conn.getResponseCode();
	        
	        
	        if (responseCode >= 200 && responseCode <= 300) {
	        	isr = new InputStreamReader(conn.getInputStream());
	        } else {
	        	isr = new InputStreamReader(conn.getErrorStream());
	        }
	        br = new BufferedReader(isr);
	        
	        String line = "";
	        StringBuilder responseSb = new StringBuilder();
	        while((line = br.readLine()) != null){
	            responseSb.append(line);
	        }
	        String result = responseSb.toString();
	        
	        System.out.println(result);
	        
	        JSONParser parser = new JSONParser();
	        JSONObject element = (JSONObject) parser.parse(result);
	        
	        
	        id = element.get("id").toString();
	        
	    }catch (Exception e){
	        e.printStackTrace();
	    }finally {
			try {
				if(br!=null) {
					br.close();
				}
				if(isr!=null) {
					isr.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	    return id;
	}
	
	public void logout(String accessToken, String type) {
		String reqUrl = prop.getProperty(type+".logout_uri");
		OutputStreamWriter osw = null;
	    BufferedWriter bw = null;
		try {
			URL url = new URL(reqUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        osw = new OutputStreamWriter(conn.getOutputStream());
	        bw = new BufferedWriter(osw);
	        
	        StringBuffer sb = new StringBuffer();
	        sb.append("client_id").append(prop.getProperty(type+".api_key"));
	        sb.append("logout_redirect_uri").append(prop.getProperty(type=".logout_redirect_uri"));
	        
	        bw.write(sb.toString());
	        bw.flush();
	        
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {
				if(bw!=null) {
					bw.close();
				}
				if (osw!=null) {
					osw.close();
				}
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
}
