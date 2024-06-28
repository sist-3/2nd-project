package action.user;

import java.io.BufferedReader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import action.Action;
import mybatis.dao.AddrDAO;
import mybatis.vo.AddressVO;
import mybatis.vo.CartVO;
import mybatis.vo.OrderDetailVO;
import mybatis.vo.UserVO;

public class BuyAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath = null;

		if(request.getMethod().equalsIgnoreCase("POST")) {
			HttpSession session = request.getSession();
			
			Object obj = session.getAttribute("cvo");
			CartVO[] cvo = null;
			if (obj != null) {
				cvo = (CartVO[]) obj;
			}
			
			BufferedReader reader = request.getReader();
			StringBuilder sb = new StringBuilder();
			String line;
			
			while ((line = reader.readLine()) != null) {
				sb.append(line);
			}
			if(reader != null) {
				reader.close();
			}
			
			// JSON 배열 문자열로부터 객체 생성
			String jsonArrayString = sb.toString();
			
			JSONParser parser = new JSONParser();
			
			JSONObject jsonObj = (JSONObject) parser.parse(jsonArrayString);
			
			JSONArray indexArr = (JSONArray) jsonObj.get("index");
			JSONArray cntArr = (JSONArray) jsonObj.get("cnt");
			JSONArray totalArr = (JSONArray) jsonObj.get("total");
			JSONArray cartArr = (JSONArray) jsonObj.get("cart");
			
			List<OrderDetailVO> odvoList = new ArrayList<OrderDetailVO>();
			List<String> cartIdxList = new ArrayList<String>();
			
			for (int i = 0; i < indexArr.size(); i++) {
				OrderDetailVO odvo = new OrderDetailVO();
				odvo.setOd_cnt(cntArr.get(i).toString());
				odvo.setOd_price(totalArr.get(i).toString());
				int index = Integer.parseInt(indexArr.get(i).toString());
				odvo.setPvo(cvo[index].getPvo());
				odvoList.add(odvo);
				cartIdxList.add(cartArr.get(i).toString());
				
			}
			
			session.setAttribute("odvoList", odvoList);
			session.setAttribute("cartIdxList", cartIdxList);
			
			viewPath = "/jsp/user/buy.jsp";
		} else if(request.getMethod().equalsIgnoreCase("GET")) {
			HttpSession session = request.getSession();
			
			Object obj = session.getAttribute("user");
			UserVO user = null;
			if(obj != null) {
				user = (UserVO)obj;
				AddressVO avo = AddrDAO.findUserDefault(user.getUs_idx());
				if(avo != null) {
					request.setAttribute("avo", avo);
				}
			}
			
			viewPath = "/jsp/user/buy.jsp";
		}
		return viewPath;
	}
}
