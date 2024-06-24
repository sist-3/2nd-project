package action.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.OrderDAO;
import mybatis.vo.OrderVO;

public class IndexAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 월별 매출액 차트
		OrderVO[] ar = OrderDAO.findSalesByMonth();
		if (ar != null) {
			request.setAttribute("ar", ar);
		}

		// 배송 상태
		final String[] STATUS_CODES = {"주문완료", "배송중", "배송완료", "환불요청"};

		// 배송 상태 초기화 배열
		int[] deliAr = new int[STATUS_CODES.length];
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
		    request.setAttribute("deliAr", deliAr);
		}

		// 카테고리별 재고

		// vip 회원

		return "/jsp/admin/main.jsp";
	}

}
