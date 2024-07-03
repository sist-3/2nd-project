package action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.CategoryDAO;
import mybatis.dao.ProductDAO;
import mybatis.vo.CategoryVO;

public class CategoryDeleteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String ct_idx = request.getParameter("ct_idx");
		
		int cnt = ProductDAO.findproductByCtidx(ct_idx);
		
		if(cnt == 0) {
			CategoryDAO.deleteCategory(ct_idx);
		}
		CategoryVO[] c_list = CategoryDAO.allCategory();
		request.setAttribute("c_list", c_list);
		
		return "/jsp/admin/productAdd.jsp";
	}

}
