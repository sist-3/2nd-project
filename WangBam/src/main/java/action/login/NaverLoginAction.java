package action.login;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.UserDAO;
import mybatis.vo.UserVO;
import util.NaverAPI;

public class NaverLoginAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath=null;
		if(request.getMethod().equals("GET")) {
			String code = request.getParameter("code");
			String type = request.getParameter("type");
			String state = request.getParameter("state");
			NaverAPI api = new NaverAPI();
			String accessToken = api.getAccessToken(code, state);
			HttpSession session = request.getSession();
			
			String id = api.getUserId(accessToken);
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
			String type = request.getParameter("go");
			if(type.equals("signup")) {
				viewPath = "jsp/user/signUp.jsp";
			}else if(type.equals("login")) {
				viewPath = "jsp/user/login.jsp";
			}
		}
		
		return viewPath;
	}

}
