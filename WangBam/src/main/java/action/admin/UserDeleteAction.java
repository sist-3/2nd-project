package action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.UserDAO;

public class UserDeleteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String us_idx = request.getParameter("us_idx");
		
		if(us_idx != null) {
			UserDAO.delete(us_idx);
		}
		
		return "/jsp/admin/userDelete.jsp";
	}

}
