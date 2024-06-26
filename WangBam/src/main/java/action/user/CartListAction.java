package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import action.Action;
import mybatis.dao.CartDAO;
import mybatis.vo.CartVO;
import mybatis.vo.ProductVO;
import mybatis.vo.UserVO;

public class CartListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("user");
		if (user == null) {
			// user 객체가 세션에 없으면 로그인 페이지로 리다이렉트합니다.
			response.sendRedirect("?type=login");
			return null;
		}
		
		String us_idx = user.getUs_idx();
		
		
		
		Map<String, String> map = new HashMap<>();
		
		map.put("us_idx", us_idx);
		
		
		

		CartVO[] cvo = CartDAO.allCart(us_idx);
		request.setAttribute("cvo", cvo);

		return "jsp/user/cart.jsp";

		
	}

}
