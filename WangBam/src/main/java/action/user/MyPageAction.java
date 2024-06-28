package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.AddrDAO;
import mybatis.dao.UserDAO;
import mybatis.vo.AddressVO;
import mybatis.vo.UserVO;

public class MyPageAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath = null;
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("user");
		if(obj !=null){
			UserVO user = (UserVO) obj;
			if(request.getMethod().equals("POST")){
				request.setCharacterEncoding("UTF-8");
				String us_pwd = request.getParameter("us_pwd");
				String us_nickname = request.getParameter("us_nickname");
				String us_tel = request.getParameter("us_tel");
				String address = request.getParameter("address");
				String address_detail = request.getParameter("address_detail");
				String postcode = request.getParameter("postcode");
				Map<String, String> map = new HashMap<>();
				if(us_pwd != null && !us_pwd.equals("")){
					map.put("us_pwd", us_pwd);
				}
				map.put("us_nickname", us_nickname);
				map.put("us_tel", us_tel);
				map.put("ad_addr", address);
				map.put("ad_addr_detail", address_detail);
				map.put("ad_postcode", postcode);
				map.put("ad_tel", us_tel);
				map.put("us_idx", user.getUs_idx());
				int cnt = UserDAO.update(map);
				if(cnt > 0){
					viewPath = "jsp/user/redirectMain.jsp";
				}else{
					request.setAttribute("msg", "회원정보 수정에 실패하였습니다.");
					viewPath = "jsp/user/mypage.jsp";
				}
			}else if(request.getMethod().equals("GET")){
				AddressVO avo = AddrDAO.findUserDefault(user.getUs_idx());
				request.setAttribute("addrVo", avo);
				viewPath = "jsp/user/mypage.jsp";
			}
		}else{
			viewPath = "jsp/user/login.jsp";
		}
		return viewPath;
	}
}
