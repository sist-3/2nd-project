package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.UserDAO;
import mybatis.vo.UserVO;

public class LoginAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath=null;
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		HttpSession session = request.getSession();
		Map<String, String> map = new HashMap<>();
		map.put("us_email", id);
		map.put("us_pwd", pw);
		UserVO user = UserDAO.login(map);
		if(user != null) {
			session.setAttribute("user", user);
			viewPath="/jsp/user/loginSuccess.jsp";
		}else {
			viewPath="/jsp/user/loginFail.jsp";
		}
		return viewPath;
	}
}
