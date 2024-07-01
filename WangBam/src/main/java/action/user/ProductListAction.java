package action.user;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.CategoryDAO;
import mybatis.dao.ProductDAO;
import mybatis.vo.CategoryVO;
import mybatis.vo.ProductVO;
import util.Paging;

public class ProductListAction implements Action {

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
		String ct_idx = request.getParameter("ct_idx");
		request.setAttribute("searchValue", searchValue);
		request.setAttribute("ct_idx", ct_idx);
		if(ct_idx == null) {
			ct_idx = "전체";
		}
		HashMap<String, String> map2 = new HashMap<>();
		map2.put("searchValue", searchValue);
		map2.put("ct_idx", ct_idx);
		
		page.setTotalRecord(ProductDAO.allCount(map2));
		
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
		map.put("ct_idx", ct_idx);
		
		ProductVO[] p_ar = ProductDAO.findProductByName(map);
		
		request.setAttribute("paging", page);
		
		if(p_ar != null) {
			request.setAttribute("p_ar", p_ar);
		}
		CategoryVO[] c_list = CategoryDAO.allCategory();
		request.setAttribute("c_list", c_list);
		
		return "/jsp/user/productList.jsp";
	}

}
