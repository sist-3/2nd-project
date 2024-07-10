package action.login;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.UserDAO;
import mybatis.vo.UserVO;
import util.OAuthAPI;

public class LoginAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath=null;
		if(request.getMethod().equals("GET")) {
			String code = request.getParameter("code");
			String type = request.getParameter("type");
			OAuthAPI api = new OAuthAPI();
			String accessToken = api.getAccessToken(code, type);
			HttpSession session = request.getSession();
			session.setAttribute("accessToken", accessToken);
			session.setAttribute("type", type);
			
			String id = api.getUserId(accessToken,type);
			UserDAO userDAO = new UserDAO();
			UserVO user = userDAO.searchUserByOauth(id);
			if(user==null) {
				request.setAttribute("o_id", id);
				request.setAttribute("o_type", type);
				viewPath = "jsp/user/authenticate_login.jsp";
			} else {
			request.getSession().setAttribute("user", user);
				viewPath = "jsp/user/redirectMain.jsp";
			}
		}else if(request.getMethod().equals("POST")) {
			String type = request.getParameter("type");
			if(type.equals("signup")) {
				viewPath = "jsp/user/signUp.jsp";
			}else if(type.equals("login")) {
				viewPath = "jsp/user/login.jsp";
			}
		}
		
		return viewPath;
	}

}
