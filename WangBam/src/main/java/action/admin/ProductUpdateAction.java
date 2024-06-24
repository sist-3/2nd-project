package action.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.ProductDAO;

public class ProductUpdateAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String pd_idx = request.getParameter("pd_idx");
        String pd_name = request.getParameter("pd_name");
        String ct_idx = request.getParameter("ct_idx");
        String pd_price = request.getParameter("pd_price");
       
        

        Map<String, String> map = new HashMap<>();
        map.put("pd_idx", pd_idx);
        map.put("pd_name", pd_name);
        map.put("ct_idx", ct_idx);
        map.put("pd_price", pd_price);

        int cnt = ProductDAO.updateProduct(map);
        if (cnt > 0) {
            request.setAttribute("updatemsg", "상품 정보가 성공적으로 업데이트되었습니다.");
        } else {
            request.setAttribute("updatemsg", "상품 정보 업데이트에 실패했습니다.");
        }
      
        
        return "admin?type=productDetail&pd_idx="+pd_idx;
        
    }
}