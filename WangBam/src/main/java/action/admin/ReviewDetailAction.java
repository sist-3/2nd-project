package action.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.dao.CategoryDAO;
import mybatis.dao.OrderDAO;
import mybatis.vo.BoardsVO;
import mybatis.vo.CategoryVO;
import mybatis.vo.OrderVO;
import util.Paging;

public class ReviewDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		String bo_idx = request.getParameter("bo_idx");

		System.out.println(bo_idx + "zz");
		BoardsVO vo = BoardsDAO.findByidx(bo_idx);
		request.setAttribute("vo", vo);

		return "/jsp/admin/reviewDetail.jsp";
	}

}
