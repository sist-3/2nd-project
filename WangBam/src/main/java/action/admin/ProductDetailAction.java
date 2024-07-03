package action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.CartDAO;
import mybatis.dao.CategoryDAO;
import mybatis.dao.ProductDAO;
import mybatis.vo.CartVO;
import mybatis.vo.CategoryVO;
import mybatis.vo.ProductVO;

public class ProductDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pd_idx = request.getParameter("pd_idx");
		
		ProductVO pvo = ProductDAO.findByid(pd_idx);
		
		CategoryVO[] ctvo = CategoryDAO.allCategory();
		request.setAttribute("pvo", pvo);
		request.setAttribute("ctvo", ctvo);
		return "jsp/admin/productDetail.jsp";
	}

}
