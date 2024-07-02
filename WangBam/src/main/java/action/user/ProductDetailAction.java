package action.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.dao.ProductDAO;
import mybatis.vo.BoardsVO;
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
		
		request.setAttribute("bvo", bvo);   
		return "jsp/user/productDetail.jsp";
	}

}
