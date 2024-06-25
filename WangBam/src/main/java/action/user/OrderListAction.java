package action.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.OrderDAO;
import mybatis.dao.OrderDetailDAO;
import mybatis.vo.OrderDetailVO;
import mybatis.vo.OrderVO;
import mybatis.vo.UserVO;

public class OrderListAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("user");
		if(obj != null){
			UserVO uvo = (UserVO) obj;
			OrderVO[] o_list = OrderDAO.findByUsIdxWithDetail(uvo.getUs_idx());
			request.setAttribute("o_list", o_list);
			return "jsp/user/order_list.jsp";
		}else{
			return "jsp/user/login.jsp";
		}
		
	}
}
