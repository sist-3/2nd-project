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
		//페이징 처리를 위한 객체 생성
		Paging page = new Paging(5,5);
		
		String searchType = request.getParameter("searchType");
		String searchValue = request.getParameter("searchValue");
	
		if(searchValue == "all") {
			searchValue = null;
		}
		
		Map<String, String> map2 = new HashMap<>();
		map2.put(searchType,searchValue); // or_date : 2024-04-12
		
		//전체 페이지 수 구하기
		page.setTotalRecord(OrderDAO.allCount(map2));
		
		//현재 페이지 값 받기
		String cPage = request.getParameter("cPage");

		if(cPage != null) {
			int nowPage = Integer.parseInt(cPage);
			page.setNowPage(nowPage);
		}else {
			page.setNowPage(1);
		}
		
		String begin = Integer.toString(page.getBegin());
		String end = Integer.toString(page.getEnd());
		
		Map<String, String> map = new HashMap<>();
		map.put("begin",begin);
		map.put("end",end);
		map.put(searchType,searchValue); // or_date : 2024-04-12
		
		List<OrderVO> list = OrderDAO.find(map);

		//배열 ar을 jsp에서 표현하기 위해 request에 저장
		request.setAttribute("list", list);
		request.setAttribute("page", page);
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchValue", searchValue);
		
		return "/jsp/admin/orderList.jsp";
		
	}

}
