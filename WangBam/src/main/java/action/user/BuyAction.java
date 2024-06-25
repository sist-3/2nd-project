package action.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.AddrDAO;
import mybatis.dao.OrderDAO;
import mybatis.dao.OrderDetailDAO;
import mybatis.dao.ProductDAO;
import mybatis.dao.UserDAO;
import mybatis.vo.AddressVO;
import mybatis.vo.OrderDetailVO;
import mybatis.vo.ProductVO;
import mybatis.vo.UserVO;

public class BuyAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath = null;
		// 받고 보내줘야 할 정보
		// 1. 구매할 상세 주문 리스트 => List<order_detail> 
		// userVO, productVO, 수량, 내부 정보 상품 계산 후 가격

		// 유저 정보는 원래 session에서 가져온다. 지금은 샘플 데이터로 작성
		UserVO uvo = UserDAO.findByidx("1");
		HttpSession session = request.getSession();
		session.setAttribute("uvo", uvo);
		AddressVO avo = AddrDAO.findUserDefault("1");

		// 샘플 데이터
		OrderDetailVO odvo = new OrderDetailVO();
		OrderDetailVO odvo2 = new OrderDetailVO();
		ProductVO pvo = ProductDAO.findByid("1");
		odvo.setPvo(pvo);
		odvo.setOd_price("8100");
		odvo.setOd_cnt("3");
		
		odvo2.setPvo(pvo);
		odvo2.setOd_price("10800");
		odvo2.setOd_cnt("4");

		List<OrderDetailVO> odvoList = new ArrayList<>();
		odvoList.add(odvo);
		odvoList.add(odvo2);
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			request.setAttribute("odvoList", odvoList);
			request.setAttribute("avo", avo);
			viewPath = "/jsp/user/buy.jsp";
		} else if(request.getMethod().equalsIgnoreCase("POST")) {
			// 주문 정보 insert 하기
			OrderDAO.add(makeMapOrderData(request));
			OrderDetailDAO.multiAdd(makeMapOrderDetailData(request));
	        
			viewPath = "/jsp/user/buy_success.jsp";
		}
		
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
		
		// 이전 페이지에서 입력받은 List<OrderDetailVO>를 가져온다.
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("odvoList");
		List<OrderDetailVO> odvoList = null;
		if(obj != null) {
			odvoList = (List<OrderDetailVO>)obj;
			for(OrderDetailVO odvo : odvoList) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("or_idx", "26");
				map.put("pd_idx", odvo.getPvo().getPd_idx());
				map.put("od_price", odvo.getOd_price());
				map.put("od_cnt", odvo.getOd_cnt());
				defaultList.add(map);
			}
			commandMap.put("odvoList", defaultList);
		}
		
        return commandMap;
	}
}
