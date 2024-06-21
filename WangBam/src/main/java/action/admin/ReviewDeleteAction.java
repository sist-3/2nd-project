package action.admin;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.vo.BoardsVO;

public class ReviewDeleteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String bo_idx = request.getParameter("bo_idx");
		
		
		BoardsDAO.delete(bo_idx);

		
		return "/jsp/admin/reviewDelete.jsp";    //"admin?type=reviewList";
	}

}
