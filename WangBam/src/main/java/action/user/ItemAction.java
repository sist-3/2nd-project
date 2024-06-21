package action.user;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.ProductDAO;
import mybatis.vo.ProductVO;
import util.Paging;

public class ItemAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String productPerBlock = request.getParameter("productPerBlock");
		int numPerPage = 6;
		if( productPerBlock != null) {
			numPerPage = Integer.valueOf(productPerBlock);
		}
		Paging page = new Paging(numPerPage,5);
		
		String cPage = request.getParameter("cPage");
		String searchValue = request.getParameter("searchValue");
		
		page.setTotalRecord(ProductDAO.allCount(searchValue));
		
		if(cPage != null) { //시작 페이지 설정
			page.setNowPage(Integer.parseInt(cPage));
		}else {
			page.setNowPage(1);
		}
		
		String start = Integer.toString(page.getBegin());
		String end = Integer.toString(page.getEnd());
		
		HashMap<String, String> map = new HashMap<>();
		map.put("start", String.valueOf(start));
		map.put("end", String.valueOf(end));
		map.put("searchValue", searchValue);
		
		ProductVO[] p_ar = ProductDAO.findProductByName(map);
		
		request.setAttribute("paging", page);
		
		if(p_ar != null) {
			request.setAttribute("p_ar", p_ar);
		}
		
		return "/jsp/user/itemList.jsp";
	}

}
