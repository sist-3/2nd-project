package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.OrderDAO;
import mybatis.vo.UserVO;

public class OrderCancelAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String or_idx = request.getParameter("or_idx");
		HttpSession session = request.getSession();
		Object user = session.getAttribute("user");

		Map<String, String> map = new HashMap<>();
		map.put("or_idx", or_idx);
		map.put("or_status_code", "UNKNOWN_WAIT");
		
		if(user != null) {
			UserVO userVO = (UserVO)user;
			int cnt = OrderDAO.updateStatusCode(map);
			return "jsp/user/ordercancel.jsp";
		}else {
			return "jsp/user/login.jsp";
		}
		
	}

}
