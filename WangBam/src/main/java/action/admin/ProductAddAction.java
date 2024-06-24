package action.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.ProductDAO;

public class ProductAddAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String pd_name = request.getParameter("pd_name");
		String ct_idx = request.getParameter("ct_idx");
		String pd_cnt = request.getParameter("pd_cnt");
		String pd_sale = request.getParameter("pd_sale");
		String pd_price = request.getParameter("pd_price");
		String pd_date = request.getParameter("pd_date");
		String pd_status = request.getParameter("pd_status");
		

		Map<String, String> map = new HashMap<>();
		map.put("pd_name", pd_name);
		map.put("ct_idx", ct_idx);
		map.put("pd_price", pd_price);
		map.put("pd_date", pd_date);
		map.put("pd_status", pd_status);
		map.put("pd_cnt",pd_cnt);
		map.put("pd_sale",pd_sale);
		
		int cnt = ProductDAO.addProduct(map);
		if(cnt>0) {
			request.setAttribute("addmsg", "추가 완료");
		}else {
			
			request.setAttribute("addmsg", "추가 실패");
		}
		
		return "admin?type=productList";
	}

}
