package action.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.ProductDAO;

public class ProductDeleteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String pd_idx = request.getParameter("pd_idx");
		String pd_status = request.getParameter("pd_status");
		
		Map<String, String> map = new HashMap<>();
		map.put("pd_idx", pd_idx);
		map.put("pd_status", pd_status);
		
		int cnt = ProductDAO.deleteProduct(map);
		
		if(cnt>0) {
			request.setAttribute("deletemsg", "삭제성공!");
		}else {
			request.setAttribute("deletemsg", "삭제실패...");
		}
		
		return "admin?type=productDetail&pd_idx="+pd_idx;
	}

}
