package action.user;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.CartDAO;
import mybatis.dao.ProductDAO;
import mybatis.vo.CartVO;

public class CartSelectDeleteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String[] ca_idx_list = request.getParameterValues("ca_idx_list");
	
		 if (ca_idx_list != null) {
		        Map<String, Object> params = new HashMap<>();
		        params.put("ca_idx_list", Arrays.asList(ca_idx_list));
		        int cnt = CartDAO.deleteCarts(params);
		        
		    } 
		        
		return "?type=cartList";
	}

}
