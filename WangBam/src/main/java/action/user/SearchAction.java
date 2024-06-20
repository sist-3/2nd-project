package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.vo.BoardsVO;
import util.Paging;

public class SearchAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath = null;
		Paging page = new Paging(1,2);
		
		String cPage = request.getParameter("cPage");
		String bo_type = request.getParameter("bo_type");
		String searchType = request.getParameter("searchType");
		String searchValue = request.getParameter("searchValue");
		String searchValue2 = request.getParameter("searchValue2");
		
		Map<String, String> s_map = new HashMap<>();
		s_map.put("bo_type", bo_type);
		s_map.put("searchType", searchType);
		s_map.put("searchValue", searchValue);
		s_map.put("searchValue2", searchValue2);

		page.setTotalRecord(BoardsDAO.allSearchCount(s_map)); //검색 조건에 맞는 모든 공지사항 게시글 수 page에 등록
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
		request.setAttribute("searchType",searchType);
		request.setAttribute("searchValue",searchValue);
		request.setAttribute("searchValue2",searchValue2);
		
		
		BoardsVO[] ar = BoardsDAO.find(map); //공지사항 게시글 배열로 반환

		if(ar!=null) {
			switch(bo_type) {
			case"0": //공지사항
				viewPath = "/jsp/user/noticeList.jsp";
				break;
			case"1": //문의사항
				viewPath = "/jsp/user/questionList.jsp";
				break;
			case"2": //리뷰
				viewPath = "/jsp/user/reviewList.jsp";
				break;
			}
			request.setAttribute("ar", ar);
			request.setAttribute("page", page);
		}
		return viewPath;
	}
}
