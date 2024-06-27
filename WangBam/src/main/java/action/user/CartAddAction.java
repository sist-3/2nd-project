package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.CartDAO;
import mybatis.vo.CartVO;
import mybatis.vo.UserVO;

public class CartAddAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("user");
		if (user == null) {
			// user 객체가 세션에 없으면 로그인 페이지로 리다이렉트합니다.
			response.sendRedirect("?type=login");
			return null;
		}
		// 장바구니버튼을 누르면 나의 장바구니에 해당 상품이 있으면 담을 상품 수량만큼 증가시키고
		// 없다면 상품을 추가시킨다.

		// user 객체에서 us_idx 값을 가져옵니다.
		String us_idx = user.getUs_idx();
		String pd_idx = request.getParameter("pd_idx");
		String pd_cnt = request.getParameter("pd_cnt");

		// 1.장바구니에 이미 상품이 담겨있는지 확인한다.
		// 2.장바구니에 있으면 수량 변경 or 장바구니 없으면 상품추가

		Map<String, String> map = new HashMap<>();
		map.put("pd_idx", pd_idx);
		map.put("us_idx", us_idx);
		map.put("ca_cnt", pd_cnt);

		CartVO Check = CartDAO.cartCheck(map);
		if (Check != null) {
			int cnt = CartDAO.updateCart(map);

		} else {
			int cnt = CartDAO.addCart(map);

		}
		// 장바구니 목록 페이지로 리다이렉트합니다.
		return "?type=cartList";

	}

}
