package action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.BoardsDAO;

public class AnswerUpdateAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String ans = request.getParameter("answer");
		String bo_idx = request.getParameter("bo_idx");
		String cPage = request.getParameter("cPage");
		String bo_type = request.getParameter("bo_type");
		switch(ans) {
		case "0":
			BoardsDAO.updateByidx(bo_idx);
			break;
		case "1":
			BoardsDAO.updateByidx2(bo_idx);
			break;
		}
		return "admin?type=boardsDetail&bo_idx="+bo_idx+"&bo_type="+bo_type+"&cPage="+cPage;
	}

}
