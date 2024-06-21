package action.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.dao.CategoryDAO;
import mybatis.dao.OrderDAO;
import mybatis.vo.BoardsVO;
import mybatis.vo.CategoryVO;
import mybatis.vo.OrderVO;
import util.Paging;

public class ReviewListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//페이징 처리를 위한 객체 생성
		Paging page = new Paging(5,5); 
		String bo_type = "2";
		String ct_idx = request.getParameter("ct_idx");
		
		if(ct_idx == null) {
			ct_idx = "all";
		}
		
		//전체 카테고리 가져오기
		CategoryVO[] cate_ar = CategoryDAO.allCategory();
		request.setAttribute("ct_idx", ct_idx);
		request.setAttribute("cate_ar", cate_ar);
		
		//전체 페이지 수 구하기
		page.setTotalRecord(BoardsDAO.countReview(ct_idx));
		
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
		map.put("bo_type",bo_type);
		map.put("ct_idx", ct_idx);
		
		BoardsVO[] ar = BoardsDAO.findReview(map);
		//배열 ar을 jsp에서 표현하기 위해 request에 저장
		request.setAttribute("ar", ar);
		request.setAttribute("page", page);
		
		return "/jsp/admin/reviewList.jsp";
		
	}

}
