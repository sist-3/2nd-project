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

public class OrderDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String or_idx = request.getParameter("or_idx");
		
		Map<String, String> map = new HashMap<>();
		map.put("or_idx", or_idx);
		List<OrderVO> list = OrderDAO.find(map);
		
		OrderVO vo = list.get(0);
		System.out.println(vo.getOr_addr());
		request.setAttribute("vo", vo);
		
		return "/jsp/admin/orderDetail.jsp";
		
	}

}

