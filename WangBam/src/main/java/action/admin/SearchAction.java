package action.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.dao.CategoryDAO;
import mybatis.dao.ProductDAO;
import mybatis.vo.BoardsVO;
import mybatis.vo.CategoryVO;
import mybatis.vo.ProductVO;
import util.Paging;

public class SearchAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath = null;
		Paging page = new Paging(5,5);
		
		String cPage = request.getParameter("cPage");
		String bo_type = request.getParameter("bo_type");
		String searchType = request.getParameter("searchType");
		String searchValue = request.getParameter("searchValue");
		String searchValue2 = request.getParameter("searchValue2");
		String searchValue3 = request.getParameter("searchValue3");
		String searchCategory = request.getParameter("searchCategory");
		String searchProduct = request.getParameter("searchProduct");
		
		Map<String, String> s_map = new HashMap<>();
		s_map.put("bo_type", bo_type);
		s_map.put("searchType", searchType);
		s_map.put("searchValue", searchValue);
		s_map.put("searchValue2", searchValue2);
		s_map.put("searchValue3", searchValue3);
		s_map.put("searchCategory", searchCategory);
		s_map.put("searchProduct", searchProduct);

		page.setTotalRecord(BoardsDAO.allSearchCount(s_map)); //검색 조건에 맞는 게시글 수 page에 등록
		if(cPage != null) { //시작 페이지 설정
			page.setNowPage(Integer.parseInt(cPage));
		}else {
			page.setNowPage(1);
		}
		
		
		
		Map<String, String> map = new HashMap<>();
		map.put("bo_type", bo_type);
		map.put("begin", Integer.toString(page.getBegin()));
		map.put("end", Integer.toString(page.getEnd()));
		
		map.put("searchType", searchType);
		map.put("searchValue", searchValue);
		map.put("searchValue2", searchValue2);
		map.put("searchValue3", searchValue3);
		map.put("searchCategory", searchCategory);
		map.put("searchProduct", searchProduct);
		request.setAttribute("searchType",searchType);
		request.setAttribute("searchValue",searchValue);
		request.setAttribute("searchValue2",searchValue2);
		request.setAttribute("searchValue3",searchValue3);
		request.setAttribute("searchCategory",searchCategory);
		request.setAttribute("searchProduct",searchProduct);
		
		
		
		BoardsVO[] ar = BoardsDAO.find(map); // 게시글 목록 배열로 반환
		
		CategoryVO[] ct_ar = CategoryDAO.allCategory();
		ProductVO[] pd_ar = ProductDAO.allProduct();

		if(ar!=null) {
			switch(bo_type) {
			case"0": //공지사항
				viewPath = "/jsp/admin/noticeList.jsp";
				break;
			case"1": //문의사항
				viewPath = "/jsp/admin/questionList.jsp";
				break;
			case"2": //리뷰
				viewPath = "/jsp/admin/reviewList.jsp";
				break;
			}
			request.setAttribute("ar", ar);
			request.setAttribute("page", page);
			request.setAttribute("pd_ar", pd_ar);
			request.setAttribute("ct_ar", ct_ar);
		}
		return viewPath;
	}

}
