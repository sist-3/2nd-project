package action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.CategoryDAO;
import mybatis.vo.CategoryVO;

public class CategoryAddAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String ct_name = request.getParameter("ct_name");
		
		if(ct_name != null) {
			CategoryDAO.addCategory(ct_name);
		}
		CategoryVO[] c_list = CategoryDAO.allCategory();
		request.setAttribute("c_list", c_list);
		
		return "/jsp/admin/productAdd.jsp";
	}

}
