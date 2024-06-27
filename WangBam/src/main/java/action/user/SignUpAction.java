package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.UserDAO;
import mybatis.vo.UserVO;

public class SignUpAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if(request.getMethod().equals("GET")){
			return "/jsp/user/signUp.jsp";
		}else if(request.getMethod().equals("POST")){
			String us_name = request.getParameter("us_name");
			String us_email = request.getParameter("us_email");
			String us_pwd = request.getParameter("us_pwd");
			String us_nickname = request.getParameter("us_nickname");
			String[] arr_tel = request.getParameterValues("us_tel");
			String us_postcode = request.getParameter("postcode");
			String us_address = request.getParameter("address");
			String us_extraAddress = request.getParameter("extraAddress");
			StringBuffer sb = new StringBuffer();
			for(String tel : arr_tel){
				sb.append(tel);
			}
			String us_tel = sb.toString();

			Map<String, String> map = new HashMap<>();
			map.put("us_name", us_name);
			map.put("us_email", us_email);
			map.put("us_pwd", us_pwd);
			map.put("us_nickname", us_nickname);
			map.put("us_tel", us_tel);

			map.put("ad_name", us_name);
			map.put("ad_postal_code", us_postcode);
			map.put("ad_addr", us_address);
			map.put("ad_addr_detail", us_extraAddress);
			map.put("ad_tel", us_tel);
			map.put("ad_default", "1");
			
			//이메일 중복검사
			UserVO user = UserDAO.findByEmail(us_email);
			if(user != null){
				return "jsp/user/signupFailByEmail.jsp";
			}
			//닉네임중복검사
			user = UserDAO.findByNickname(us_nickname);
			if(user != null){
				return "jsp/user/signupFailByNick.jsp";
			}
			//회원가입
			int cnt = UserDAO.add(map);
			return "jsp/user/signupSuccess.jsp";
		}
		return "/";
		
	}
	

}
