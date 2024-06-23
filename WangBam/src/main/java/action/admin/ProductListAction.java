package action.admin;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.ProductDAO;
import mybatis.vo.ProductVO;
import util.Paging;

public class ProductListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		//페이징 처리를 위한 객체생성
		Paging page = new Paging(12,5);
		//현재 페이지 번호 구하기
		String cPage = request.getParameter("cPage");
		//검색어 구하기
		String searchValue = request.getParameter("searchValue");
		
		//검색으로 나온 리스트 전체 게시물 수 구하기 
		page.setTotalRecord(ProductDAO.allCount(searchValue));
		System.out.println(page);
		//시작 페이지 설정
		if(cPage != null){
			page.setNowPage(Integer.parseInt(cPage));
			//이때!
			//게시물을 추출할 때 사용되는 begin과 end가 구해지고
			//시작페이지(startPage)와 끝페이지(endPage)도 구해졌다.
		}else
			page.setNowPage(1);

		//시작페이지와 끝페이지 구하기
		String start = Integer.toString(page.getBegin());
		String end = Integer.toString(page.getEnd());
		//맵 생성
		HashMap<String,String> map = new HashMap<>();
		map.put("searchValue", searchValue);
		map.put("start", start);
		map.put("end", end);
		ProductVO[] p_ar = ProductDAO.findProductByName(map);
		request.setAttribute("paging", page);
		
		if(p_ar != null) {
			request.setAttribute("p_ar", p_ar);
		}
		
		return "jsp/admin/productList.jsp";
	}

}
