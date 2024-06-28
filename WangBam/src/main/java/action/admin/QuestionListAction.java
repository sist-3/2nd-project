package action.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.vo.BoardsVO;
import util.Paging;

public class QuestionListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath = null;
		Paging page = new Paging(5,5);
		
		String cPage = request.getParameter("cPage");

		page.setTotalRecord(BoardsDAO.allCount("1"));
		
		if(cPage != null) { //시작 페이지 설정
			page.setNowPage(Integer.parseInt(cPage));
		}else {
			page.setNowPage(1);
		}
		
		Map<String, String> map = new HashMap<>();
		map.put("bo_type", "1");
		map.put("begin", Integer.toString(page.getBegin()));
		map.put("end", Integer.toString(page.getEnd()));
		
		
		BoardsVO[] ar = BoardsDAO.find(map);
		
		if(ar!=null) {
			viewPath = "/jsp/admin/questionList.jsp";
			request.setAttribute("ar", ar);
			request.setAttribute("page", page);
		}
		return viewPath;
	}

}
