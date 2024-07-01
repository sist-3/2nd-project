package action.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.OrderDAO;
import mybatis.vo.OrderVO;
import mybatis.vo.UserVO;

public class OrderDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("user");
		if (obj!=null) {
			UserVO uvo = (UserVO)obj;
			String or_idx = request.getParameter("or_idx");
			OrderVO ovo = OrderDAO.findByIdxWithDetail(or_idx);
			if (uvo.getUs_idx().equals(ovo.getUs_idx())) {
				request.setAttribute("ovo", ovo);
				return "jsp/user/order_detail.jsp";
			}else {
				return "jsp/user/redirectMain.jsp";
			}
		}
		return "jsp/user/login.jsp";
	}

}
