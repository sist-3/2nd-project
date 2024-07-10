package action.user;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.OAuthDAO;
import mybatis.dao.UserDAO;
import mybatis.vo.UserVO;
import util.APIenv;
import util.OAuthAPI;

public class LoginAction implements Action {

	@Override 
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath=null;
		if(request.getMethod().equals("POST")) {
			String us_id = request.getParameter("us_id");
			String us_pw = request.getParameter("us_pw");
			HttpSession session = request.getSession();
			Map<String, String> map = new HashMap<>();
			map.put("us_email", us_id);
			map.put("us_pwd", us_pw);
			UserVO user = UserDAO.login(map);
			
			String oa_id = request.getParameter("o_id");
			String oa_type = request.getParameter("o_type");
			if(oa_id != null && oa_type != null) {
				session.setAttribute("type", oa_type);
				String us_idx = user.getUs_idx();
				map.put("oa_id", oa_id);
				map.put("oa_type", oa_type);
				map.put("us_idx", us_idx);
				OAuthDAO.add(map);
			}
			

			if(user != null) {
				session.setAttribute("user", user);
				viewPath="/jsp/user/loginSuccess.jsp";
			}else {
				viewPath="/jsp/user/loginFail.jsp";
			}
		}else if(request.getMethod().equals("GET")) {
			String oldurl = request.getHeader("referer");
			Properties api_prop = APIenv.getProp();
			request.setAttribute("KaKao_API_KEY", api_prop.get("kakao.api_key"));
			request.setAttribute("KaKao_REDIRECT_URI", api_prop.get("kakao.redirect_uri"));
			
			SecureRandom random = new SecureRandom();
		    String state = new BigInteger(130, random).toString();
		    
		    request.setAttribute("state", state);
			request.setAttribute("Naver_API_KEY", api_prop.get("naver.api_key"));
			request.setAttribute("Naver_REDIRECT_URI", api_prop.get("naver.redirect_uri"));
			
			if(oldurl != null && !oldurl.contains("login")&&!oldurl.contains("signup")&&!oldurl.contains("findPwd")&&!oldurl.contains("findEmail")) {
				request.setAttribute("oldUrl", oldurl);
			}else {
				request.setAttribute("oldUrl", "/WangBam");
			}
			viewPath="/jsp/user/login.jsp";
		}
		
		
		return viewPath;
	}
}
