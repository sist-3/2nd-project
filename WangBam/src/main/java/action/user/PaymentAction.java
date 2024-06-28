package action.user;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.CartDAO;
import mybatis.dao.OrderDAO;
import mybatis.dao.OrderDetailDAO;
import mybatis.vo.OrderDetailVO;

public class PaymentAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		// 구매한 장바구니 목록 삭제
		Object obj = session.getAttribute("cartIdxList");
		List<String> cartIdxList = null;
		if(obj != null) {
			cartIdxList = (List<String>)obj;
			Map<String, Object> params = new HashMap<>();
	        params.put("ca_idx_list", cartIdxList);
	        int cnt = CartDAO.deleteCarts(params);
	        session.removeAttribute("cartIdxList");
		}
		
		// 사용했던 세션 삭제
		session.removeAttribute("cvo");
		
		// 주문 정보 insert 하기
		OrderDAO.add(makeMapOrderData(request));
		OrderDetailDAO.multiAdd(makeMapOrderDetailData(request));
        
		String viewPath = "/jsp/user/buy_success.jsp";
		
		return viewPath;
	}

	private Map<String, String> makeMapOrderData(HttpServletRequest request) {
		// order_t 데이터맵 생성
		Map<String, String> map = new HashMap<String, String>();
		map.put("us_idx", request.getParameter("us_idx")); // 세션에서 사용자 ID 가져오기
		map.put("or_name", request.getParameter("or_name")); // 폼 데이터
		map.put("or_postal_code", request.getParameter("postal_code"));
		map.put("or_addr", request.getParameter("addr"));
		map.put("or_addr_detail", request.getParameter("addr_detail"));
		map.put("or_tel", request.getParameter("tel1") + request.getParameter("tel2") + request.getParameter("tel3"));
		map.put("or_request", request.getParameter("request"));
		map.put("or_total_price", request.getParameter("total_price"));
		map.put("or_payment_code", request.getParameter("paymentId"));
		map.put("or_status_code", "UNKNOWN");

		return map;
	}

	private HashMap<String, List<HashMap<String, String>>> makeMapOrderDetailData(HttpServletRequest request) {
		// 여러개를 한번에 저장시키기 위해서는 어떻게 코드를 짜야할까??
		// order_t 데이터맵 생성
		HashMap<String, List<HashMap<String, String>>> commandMap = new HashMap<String, List<HashMap<String, String>>>();
		List<HashMap<String, String>> defaultList = new ArrayList<HashMap<String, String>>();
		int or_idx = OrderDAO.findLastIdx();
		// 이전 페이지에서 입력받은 List<OrderDetailVO>를 가져온다.
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("odvoList");
		session.removeAttribute("odvoList");
		List<OrderDetailVO> odvoList = null;
		if (obj != null) {
			odvoList = (List<OrderDetailVO>) obj;
			for (OrderDetailVO odvo : odvoList) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("or_idx", String.valueOf(or_idx));
				map.put("pd_idx", odvo.getPvo().getPd_idx());
				map.put("od_price", odvo.getOd_price());
				map.put("od_cnt", odvo.getOd_cnt());
				defaultList.add(map);
			}
			commandMap.put("odvoList", defaultList);
			request.setAttribute("idx", or_idx);
		}

		return commandMap;
	}
}
