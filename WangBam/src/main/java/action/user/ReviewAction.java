package action.user;

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

public class ReviewAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath = null;
		Paging page = new Paging(5,5);
		
		String cPage = request.getParameter("cPage");

		Map<String, String> count_map = new HashMap<>();
		count_map.put("bo_type", "2");
		//count_map.put("us_idx", "7"); //(!)us_idx로 변경 요망 //특정 유저의 문의사항 갯수 등록
		page.setTotalRecord(BoardsDAO.allUserBoardsCount(count_map));
		
		if(cPage != null) { //시작 페이지 설정
			page.setNowPage(Integer.parseInt(cPage));
		}else {
			page.setNowPage(1);
		}
		
		Map<String, String> map = new HashMap<>();
		map.put("bo_type", "2");
		map.put("begin", Integer.toString(page.getBegin()));
		map.put("end", Integer.toString(page.getEnd()));
		//map.put("us_idx", "7");  //(!)us_idx로 변경 요망
		
		BoardsVO[] ar = BoardsDAO.find(map); //리뷰 목록 배열로 반환
		
		
		//카테고리 + 상품명 가져오기
		CategoryVO[] ct_ar = CategoryDAO.allCategory();
		ProductVO[] pd_ar = ProductDAO.allProduct();

		
		if(ar!=null) {
			viewPath = "/jsp/user/reviewList.jsp";
			request.setAttribute("ar", ar);
			request.setAttribute("page", page);
			request.setAttribute("pd_ar", pd_ar);
			request.setAttribute("ct_ar", ct_ar);
		}
		return viewPath;
	}

}
