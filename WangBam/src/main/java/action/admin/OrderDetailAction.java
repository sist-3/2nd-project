package action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.OrderDetailDAO;
import mybatis.vo.OrderDetailVO;

public class OrderDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String or_idx = request.getParameter("or_idx");
		
		OrderDetailVO vo = OrderDetailDAO.findByIdxWithProduct(or_idx);
		request.setAttribute("vo", vo);
		
		return "/jsp/admin/orderDetail.jsp";
		
	}

}

