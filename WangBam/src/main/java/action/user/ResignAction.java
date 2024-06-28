package action.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.UserDAO;
import mybatis.vo.UserVO;

public class ResignAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath=null;
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("user");
		if (obj!=null) {
			UserVO uvo = (UserVO)obj;
			String us_idx = uvo.getUs_idx();
			int cnt = UserDAO.delete(us_idx);
			if (cnt>0) {
				viewPath="jsp/user/redirectMain.jsp";
			}
		}else {
			viewPath="jsp/user/redirectMain.jsp";
		}
		return viewPath;
	}
}
