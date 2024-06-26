package action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.vo.BoardsVO;

public class NoticeDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String bo_idx = request.getParameter("bo_idx");

		BoardsVO vo = BoardsDAO.findByidx(bo_idx);
		//BoardsDAO.updateHit(bo_idx);
		request.setAttribute("vo", vo);

		return "/jsp/admin/noticeDetailAdmin.jsp";
	}

}
