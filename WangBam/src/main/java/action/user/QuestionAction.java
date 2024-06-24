package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.vo.BoardsVO;
import util.Paging;

public class QuestionAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath = null;
		Paging page = new Paging(5,5);
		String cPage = request.getParameter("cPage");
		
		//HttpSession session = request.getSession(false);
		//String us_idx = (String) session.getAttribute("user");
		//System.out.println(us_idx);
		
		page.setTotalRecord(BoardsDAO.allUserQuestionCount("14")); //(!)us_idx로 변경 요망 //특정 유저의 문의사항 갯수 등록
		
		if(cPage != null) { //시작 페이지 설정
			page.setNowPage(Integer.parseInt(cPage));
		}else {
			page.setNowPage(1);
		}
		
		Map<String, String> map = new HashMap<>();
		map.put("bo_type", "1");
		map.put("begin", Integer.toString(page.getBegin()));
		map.put("end", Integer.toString(page.getEnd()));
		map.put("us_idx", "14");  //(!)us_idx로 변경 요망
		
		BoardsVO[] ar = BoardsDAO.find(map);
		
		if(ar!=null) {
			viewPath = "/jsp/user/questionList.jsp";
			request.setAttribute("ar", ar);
			request.setAttribute("page", page);
		}
		return viewPath;
	}

}
