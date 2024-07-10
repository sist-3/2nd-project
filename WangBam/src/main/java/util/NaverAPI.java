package util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Properties;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.mysql.cj.xdevapi.JsonArray;

public class NaverAPI {
	Properties prop = APIenv.getProp();
	
	public String getAccessToken(String code,String state) throws UnsupportedEncodingException {
	    String accessToken = "";
	    String refreshToken = "";
	    String reqUrl = prop.getProperty("naver.token_uri");
	    StringBuilder sb = new StringBuilder();
	    String redirect_uri =URLEncoder.encode(prop.getProperty("naver.redirect_uri"),"UTF-8");
	    sb.append(reqUrl).append("?");
        sb.append(prop.getProperty("naver.defalt_param"));
        
		sb.append("&client_id=").append(prop.getProperty("naver.api_key"));
		sb.append("&client_secret=").append(prop.getProperty("naver.client_secret"));
        sb.append("&redirect_uri=").append(redirect_uri);
        sb.append("&code=").append(code);
        sb.append("&state=").append(state);
        String apiUrl =sb.toString();
        
	    OutputStreamWriter osw = null;
	    BufferedWriter bw = null;
	    BufferedReader br = null;
	    InputStreamReader isr = null;
	    try{
	        URL url = new URL(apiUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
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
	
	public String getUserId(String accessToken) {
	    String reqUrl = prop.getProperty("naver.getUser_uri");
	    BufferedReader br = null;
	    InputStreamReader isr = null;
	    String id=null;
	    try{
	        URL url = new URL(reqUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Authorization", "Bearer " + accessToken);
	        conn.setRequestProperty("User-Agent", "curl/7.12.1 (i686-redhat-linux-gnu) libcurl/7.12.1 OpenSSL/0.9.7a zlib/1.2.1.2 libidn/0.5.6");
	        conn.setRequestProperty("Host", "openapi.naver.com");
	        conn.setRequestProperty("Pragma", "no-cache");
	        conn.setRequestProperty("Accept", "*");

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
	        

	        
	        JSONParser parser = new JSONParser();
	        JSONObject element = (JSONObject) parser.parse(result);
	        JSONObject response = (JSONObject)element.get("response");
	        id = response.get("id").toString();
	        
	        
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
}
