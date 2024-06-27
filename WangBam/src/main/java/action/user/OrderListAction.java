package action.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.OrderDAO;
import mybatis.dao.OrderDetailDAO;
import mybatis.vo.OrderDetailVO;
import mybatis.vo.OrderVO;
import mybatis.vo.UserVO;
import util.Paging;

public class OrderListAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("user");
		
		if(obj != null){
			UserVO uvo = (UserVO) obj;
			String cPage = request.getParameter("cPage");
			String pd_name = request.getParameter("pd_name");
			Paging page = new Paging(4,5);

			
			Map<String, String> map = new HashMap<>();
			
			map.put("us_idx",uvo.getUs_idx());
			if(pd_name != null) {
				map.put("pd_name",pd_name);
			}
			int count = OrderDAO.countUsIdx(map);
			page.setTotalRecord(count);
			if(cPage == null || cPage.equals("")) {
				page.setNowPage(1);
			}else {
				int nowPage = Integer.parseInt(cPage);
				page.setNowPage(nowPage);
			}
			
			String begin = Integer.toString(page.getBegin());
			String end = Integer.toString(page.getEnd());
			
			map.put("begin",begin);
			map.put("end",end);
			OrderVO[] o_list = OrderDAO.findByUsIdxWithDetail(map);
			request.setAttribute("o_list", o_list);
			request.setAttribute("page", page);
			return "jsp/user/order_list.jsp";
		}else{
			return "jsp/user/login.jsp";
		}
		
	}
}
