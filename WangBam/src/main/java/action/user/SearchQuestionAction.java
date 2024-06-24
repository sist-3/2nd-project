package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.vo.BoardsVO;
import util.Paging;

public class SearchQuestionAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath = null;
		Paging page = new Paging(5,5);
		
		String cPage = request.getParameter("cPage");
		String bo_type = request.getParameter("bo_type");
		String searchType = request.getParameter("searchType");
		String searchValue = request.getParameter("searchValue");
		String searchValue2 = request.getParameter("searchValue2");
		//String us_idx = request.getParameter("us_idx");
		
		Map<String, String> u_map = new HashMap<>();
		u_map.put("searchType", searchType);
		u_map.put("searchValue", searchValue);
		u_map.put("searchValue2", searchValue2);
		u_map.put("us_idx", "14"); //(!)us_idx로 변경 요망

		page.setTotalRecord(BoardsDAO.allSearchUserBoardsCount(u_map)); //검색 조건에 맞는 게시글 수 page에 등록
		if(cPage != null) {
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
		map.put("us_idx", "14"); //(!)us_idx로 변경 요망
		
		
		request.setAttribute("searchType",searchType);
		request.setAttribute("searchValue",searchValue);
		request.setAttribute("searchValue2",searchValue2);
		
		
		BoardsVO[] ar = BoardsDAO.find(map); // 게시글 목록 배열로 반환
		
		if(ar!=null) {
			request.setAttribute("ar", ar);
			request.setAttribute("page", page);
			
			viewPath = "/jsp/user/questionList.jsp";
		}
		return viewPath;
	
	}

}
