package action.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.OrderDAO;
import mybatis.dao.OrderDetailDAO;
import mybatis.vo.OrderDetailVO;
import mybatis.vo.OrderVO;

public class OrderDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String or_idx = request.getParameter("or_idx");
		
		OrderVO vo = OrderDAO.findByOrIdxWithDetail(or_idx);
		
		List<OrderDetailVO> list = vo.getOd_list();
		
		System.out.println(vo.getOd_list().get(0).getPvo().getPd_name());
		request.setAttribute("vo", vo);
		request.setAttribute("list", list);
		return "/jsp/admin/orderDetail.jsp";
		
	}

}

