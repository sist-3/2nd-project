package action.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.ProductDAO;
import mybatis.vo.OrderDetailVO;
import mybatis.vo.ProductVO;

public class BuyAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath = null;
		// 받고 보내줘야 할 정보
		// 1. 구매할 상세 주문 리스트 => List<order_detail> 
		// userVO, productVO, 수량, 내부 정보 상품 계산 후 가격
		
		// 샘플 데이터
		OrderDetailVO odvo = new OrderDetailVO();
		ProductVO pvo = ProductDAO.findByid("1");
		odvo.setPvo(pvo);
		odvo.setOd_price("2700");
		odvo.setOd_cnt("3");

		List<OrderDetailVO> odvoList = new ArrayList<>();
		odvoList.add(odvo);
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			request.setAttribute("odvoList", odvoList);
			viewPath = "/jsp/user/buy.jsp";
		} else if(request.getMethod().equalsIgnoreCase("POST")) {
			viewPath = "/jsp/user/buy_success.jsp";
		}
		
		return viewPath;
	}
}
