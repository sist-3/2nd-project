package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.CartDAO;
import mybatis.vo.CartVO;
import mybatis.vo.ProductVO;

public class CartListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		//us_idx가 담은 장바구니 확인 product 
		String us_idx = request.getParameter("us_idx");
		
		
		CartVO[] cvo = CartDAO.allCart(us_idx);
		request.setAttribute("cvo", cvo);
		
		return "jsp/user/cart.jsp";
		
	//장바구니를 누르면 해당 세션에 저장되어있는 유저의 아이디를 전달받아서 카트에 
	}

}
