package action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.ProductDAO;
import mybatis.vo.ProductVO;

public class ProductListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		ProductVO[] pvo = ProductDAO.allProduct();
		request.setAttribute("pvo", pvo);
		
		
		return "jsp/admin/productList.jsp";
	}

}
