package action.user;

import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import action.Action;
import util.APIenv;
import util.OAuthAPI; 

public class LogoutAction implements Action { 

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("user") != null) {
			Properties prop = APIenv.getProp();
			request.setAttribute("client_id", prop.getProperty("kakao.api_key"));
			request.setAttribute("logout_redirect_uri", prop.getProperty("kakao.logout_redirect_uri"));
			session.invalidate();
		}
		
		if(session.getAttribute("type")!=null)
			return "jsp/user/logout.jsp";
		else
			return "jsp/user/redirectMain.jsp";
	}

}
