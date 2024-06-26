package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.dao.CommentDAO;
import mybatis.vo.BoardsVO;

public class SaveEditCommentAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath = null;
		String co_idx = request.getParameter("co_idx");
		String newContent = request.getParameter("newContent");
		String bo_idx = request.getParameter("bo_idx");
		String bo_type = request.getParameter("bo_type");
		String cPage = request.getParameter("cPage");
		
		Map<String, String> map = new HashMap<>();
		map.put("co_content", newContent);
		map.put("co_idx", co_idx);
		
		CommentDAO.update(map);
		BoardsVO vo = BoardsDAO.findByidx(bo_idx);
		
		request.setAttribute("cPage", cPage);
		request.setAttribute("vo", vo);
		
		switch(bo_type) {
		case "0":  //공지사항
			viewPath = "jsp/user/noticeDetail.jsp";
			break;
		case "1":  //문의사항
			viewPath = "jsp/user/questionDetail.jsp";
			break;
		case "2":  //리뷰
			viewPath = "jsp/user/reviewDetail.jsp";
			break;
		}
		return viewPath;
	}

}
