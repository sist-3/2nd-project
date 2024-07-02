package action.user;


import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.Collections;
import java.util.stream.Collectors;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import action.Action;


public class EmailCheckAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String email = request.getParameter("email");
		String code = naverMailSend(email);
		request.setAttribute("code", code);
		return "/jsp/user/emailcheck.jsp";
	}

	public static String naverMailSend(String email) {
        String host = "smtp.naver.com"; // 네이버일 경우 네이버 계정, gmail경우 gmail 계정
        String user = "leeshtest@naver.com"; 
        String password = "test1234!";

        // SMTP 서버 정보를 설정한다.
        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", 587);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() { 
                return new PasswordAuthentication(user, password);
            }
        });
        //파일 읽기준비
        FileInputStream fis = null;
        InputStreamReader reader = null;
        BufferedReader in = null;
        int data = -1;
        
        //인증코드생성
        int arr[]=new int[6];
        for(int i=0;i<6;i++) {
            arr[i]=(int)(Math.random()*10);
        }
        String code=null;
        
        String path = "C:\\2nd-project\\WangBam\\src\\main\\webapp\\html\\email.html";
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

            // 메일 제목
            message.setSubject("왕밤빵 이메일 인증");

            // 메일 내용
            File file = new File(path);
            fis = new FileInputStream(file);
            reader = new InputStreamReader(fis, "UTF-8");
            in = new BufferedReader(reader);

            StringBuffer sb =new StringBuffer();
            while((data = in.read()) != -1) {
                sb.append((char)data);
            }
            code = Arrays.stream(arr).mapToObj(String::valueOf).collect(Collectors.joining(""));
            sb.replace(sb.indexOf("{code}"), sb.indexOf("{code}")+6, code );
            message.setContent(sb.toString(), "text/html; charset=UTF-8");
            // send the message
            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(in != null) in.close();
                if(reader != null) reader.close();
                if(fis != null) fis.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return code;
    }

}
