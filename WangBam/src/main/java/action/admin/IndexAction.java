package action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.OrderDAO;
import mybatis.vo.OrderVO;

public class IndexAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		OrderVO[] ar = OrderDAO.findSalesByMonth();
		if(ar != null) {
			request.setAttribute("ar", ar);
		}
		
		return "/jsp/admin/main.jsp";
	}

}
