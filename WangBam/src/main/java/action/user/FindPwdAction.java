package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.UserDAO;
import mybatis.vo.UserVO;

public class FindPwdAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath=null;
		if(request.getMethod().equals("GET")){
			viewPath = "jsp/user/findPwd.jsp";
		}else if(request.getMethod().equals("POST")){
			String us_name = request.getParameter("us_name");
			String us_email = request.getParameter("us_email");
			
			Map<String, Object> map = new HashMap<>();
			map.put("us_name", us_name);
			map.put("us_email", us_email);
			System.out.println(map);
			UserVO[] u_list = UserDAO.findByEmailAndName(map);
			System.out.println(u_list.length);
			if(u_list.length == 0){
				request.setAttribute("message", "해당하는 사용자가 없습니다.");
				viewPath = "jsp/user/findPwd.jsp";
			}else{
				request.setAttribute("u_list", u_list);
				viewPath = "jsp/user/FindPwdSuccess.jsp";
			}
		}
		return viewPath;
	}
}
