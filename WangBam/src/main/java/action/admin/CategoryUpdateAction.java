package action.admin;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.CategoryDAO;
import mybatis.vo.CategoryVO;

public class CategoryUpdateAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String ct_name = request.getParameter("ct_name");
		String ct_idx = request.getParameter("ct_idx");
		
		HashMap<String, String> map = new HashMap<>();
		map.put("ct_idx", ct_idx);
		map.put("ct_name", ct_name);
		
		CategoryDAO.updateCategory(map);
		
		CategoryVO[] c_list = CategoryDAO.allCategory();
		request.setAttribute("c_list", c_list);
		
		return "/jsp/admin/productAdd.jsp";
	}

}
