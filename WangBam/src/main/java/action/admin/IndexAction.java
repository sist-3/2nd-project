package action.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.CategoryDAO;
import mybatis.dao.OrderDAO;
import mybatis.dao.UserDAO;
import mybatis.vo.CategoryVO;
import mybatis.vo.OrderVO;
import mybatis.vo.UserVO;

public class IndexAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 월별 매출액 차트
		OrderVO[] ar = OrderDAO.findSalesByMonth();
		if (ar != null) {
			request.setAttribute("ar", ar);
		}

		// 배송 상태
		final String[] STATUS_CODES_KO = {"주문완료", "배송중", "배송완료", "취소요청","환불완료" };
		final String[] STATUS_CODES = {"UNKNOWN", "INFORMATION_RECEIVED", "DELIVERED", "UNKNOWN_WAIT","CANCEL" };

		// 배송 상태 초기화 배열
		int[] deliAr = new int[STATUS_CODES_KO.length];
		List<OrderVO> delivery = OrderDAO.all();

		if (delivery != null) {
		    for (OrderVO vo : delivery) {
		        String status = vo.getOr_status_code();
		        for (int i = 0; i < STATUS_CODES.length; i++) {
		            if (STATUS_CODES[i].equals(status)) {
		                deliAr[i]++;
		                break;
		            }
		        }
		    }
		    request.setAttribute("STATUS_CODES", STATUS_CODES);
		    request.setAttribute("STATUS_CODES_KO", STATUS_CODES_KO);
		    request.setAttribute("deliAr", deliAr);
		}

		// 카테고리별 재고
		CategoryVO[] c_list = CategoryDAO.findPdcntPerOdcntByCategory();
		if(c_list != null) {
			request.setAttribute("c_list", c_list);
		}
		// vip 회원
		UserVO[] vip = UserDAO.findByVIP();
		if (ar != null) {
			request.setAttribute("vip", vip);
		}

		return "/jsp/admin/main.jsp";
	}

}
