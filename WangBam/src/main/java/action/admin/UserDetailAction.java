package action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.UserDAO;
import mybatis.vo.UserVO;

public class UserDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String us_idx = request.getParameter("us_idx");
		
		UserVO vo = UserDAO.findByidx(us_idx);
		request.setAttribute("vo", vo);
		
		return "/jsp/admin/userDetail.jsp";
		
	}

}

