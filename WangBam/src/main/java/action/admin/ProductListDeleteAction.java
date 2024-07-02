package action.admin;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.ProductDAO;

public class ProductListDeleteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
           String[] pdIdxArray = request.getParameterValues("pd_idx_list");
    if (pdIdxArray != null) {
        Map<String, Object> params = new HashMap<>();
        params.put("pd_idx_list", Arrays.asList(pdIdxArray));
        int cnt = ProductDAO.deleteProducts(params);
        response.getWriter().write(cnt + " products deleted.");
    } else {
        response.getWriter().write("No products selected for deletion.");
    }

		
		return "admin?type=productList";
	}

}
