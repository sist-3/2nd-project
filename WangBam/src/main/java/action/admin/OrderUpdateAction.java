package action.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.OrderDAO;
import mybatis.vo.OrderVO;
import util.Paging;

public class OrderUpdateAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String or_idx = request.getParameter("or_idx");
		String[] or_idx_ar = request.getParameterValues("or_idx_ar");
		String or_status_code = request.getParameter("or_status_code");
		
		if(or_idx != null) {
			Map<String,String> map = new HashMap<>();
			map.put("or_idx", or_idx);
			map.put("or_status_code", or_status_code);
			OrderDAO.updateStatusCode(map);
		}
		
		if(or_idx_ar != null && or_idx_ar.length > 0) {
			for(String or_idx2 : or_idx_ar ) {
				Map<String,String> map = new HashMap<>();
				map.put("or_idx", or_idx2);
				map.put("or_status_code", or_status_code);
				OrderDAO.updateStatusCode(map);
			}
			
		}
		
		return "/jsp/admin/orderUpdate.jsp";
	}

}
