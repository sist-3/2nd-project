package action.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.OrderDAO;
import mybatis.vo.OrderVO;
import util.Paging;

public class OrderUpdateAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String or_idx = request.getParameter("or_idx");
		String[] or_idx_ar = request.getParameterValues("or_idx_ar");
		String or_status_code = request.getParameter("or_status_code");
		Random random = new Random();
        
        // 12자리 숫자를 생성하기 위해서는 100000000000L부터 999999999999L까지의 숫자 중에서 랜덤뽑가
        long lowerBound = 100000000000L;
        long upperBound = 999999999999L;

      
        
		if(or_idx != null) {
			  // nextLong() 메소드를 사용하여 하한과 상한 사이의 숫자를 생성합니다.
	        long random12DigitNumber = lowerBound + (long)(random.nextDouble() * (upperBound - lowerBound));
	        String or_tracking_number = Long.toString(random12DigitNumber);
			Map<String,String> map = new HashMap<>();
			map.put("or_idx", or_idx);
			map.put("or_status_code", or_status_code);
			map.put("or_tracking_number", or_tracking_number);
			OrderDAO.updateStatusCode(map);
		}
		
		if(or_idx_ar != null && or_idx_ar.length > 0) {
			for(String or_idx2 : or_idx_ar ) {
				  // nextLong() 메소드를 사용하여 하한과 상한 사이의 숫자를 생성합니다.
		        long random12DigitNumber = lowerBound + (long)(random.nextDouble() * (upperBound - lowerBound));
		        //String or_tracking_number = Long.toString(random12DigitNumber);
		        String or_tracking_number = "6864011244408";
				Map<String,String> map = new HashMap<>();
				map.put("or_idx", or_idx2);
				map.put("or_status_code", or_status_code);
				map.put("or_tracking_number", or_tracking_number);
				OrderDAO.updateStatusCode(map);
			}
			
		}
		
		return "/jsp/admin/orderUpdate.jsp";
	}

}
