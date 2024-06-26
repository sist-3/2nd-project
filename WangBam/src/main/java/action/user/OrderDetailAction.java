package action.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.OrderDAO;
import mybatis.vo.OrderVO;

public class OrderDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String or_idx = request.getParameter("or_idx");
		OrderVO ovo = OrderDAO.findByIdxWithDetail(or_idx);
		request.setAttribute("ovo", ovo);
		return "jsp/user/order_detail.jsp";
	}

}
