package action.admin;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.dao.CommentDAO;
import mybatis.vo.BoardsVO;

public class DeleteCommentAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath = null;
		String co_idx = request.getParameter("co_idx");
		String bo_idx = request.getParameter("bo_idx");
		String bo_type = request.getParameter("bo_type");
		String cPage = request.getParameter("cPage");
		String us_type = request.getParameter("us_type");
		
		if(us_type.equals("0")) {
			BoardsDAO.updateByidx(bo_idx);
		}else {
			BoardsDAO.updateByidx2(bo_idx);
		}
		CommentDAO.delete(co_idx);
		BoardsVO vo = BoardsDAO.findByidx(bo_idx);
		
		request.setAttribute("cPage", cPage);
		request.setAttribute("vo", vo);
		
		switch(bo_type) {
		case "0":  //공지사항
			viewPath = "jsp/admin/noticeDetail.jsp";
			break;
		case "1":  //문의사항
			viewPath = "jsp/admin/questionDetail.jsp";
			break;
		case "2":  //리뷰
			viewPath = "jsp/admin/reviewDetail.jsp";
			break;
		}
		return viewPath;
	}

}
