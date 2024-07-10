package action.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.dao.HeartDAO;
import mybatis.dao.ProductDAO;
import mybatis.vo.BoardsVO;
import mybatis.vo.HeartVO;
import mybatis.vo.ProductVO;

public class ProductDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String pd_idx = request.getParameter("pd_idx");
		
		ProductVO pvo =  ProductDAO.findByid(pd_idx);
		session.setAttribute("pvo", pvo);
		
		BoardsVO[] bvo = BoardsDAO.findBypdidx(pd_idx);
		BoardsVO[] bvo2 = BoardsDAO.findBypdidx2(pd_idx);
		ArrayList<String> list = new ArrayList<>();
		
		if(bvo2 != null && bvo2.length > 0) {
			for(BoardsVO b : bvo2) {
				list.add(b.getBo_idx());
			}
			String bo_idx_best = HeartDAO.boardsCount(list);
			request.setAttribute("bo_idx_best", bo_idx_best);   
		}
		request.setAttribute("bvo", bvo);   
		return "jsp/user/productDetail.jsp";
	}

}
