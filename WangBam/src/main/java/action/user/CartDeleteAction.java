package action.user;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.CartDAO;

public class CartDeleteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String ca_idx = request.getParameter("ca_idx");
	
		if (ca_idx != null) {

			int cnt = CartDAO.deleteCart(ca_idx);
			
		} 
			
		
		return "?type=cartList";

	}

}
