<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/adminHeader.jsp" %>
<section>
            <div class="title">
              <h3>판매진행현황</h3>
            </div>
              <ul class="order-state">
              	<li>배송대기 : 1건</li>
              	<li>배송중 : 1건</li>
              	<li>배송완료 : 1건</li>
              	<li>주문취소 : 1건</li>
              	<li>환불요청 : 1건</li>
              </ul>
          </section>

          <section>
            <div class="title">
              <h3>기간별 월매출</h3>
            </div>
            <div class="chart-box">
            	<canvas id="periodSales"></canvas>
            </div>
          </section>

          <section>
            <div class="title">
              <h3>카테고리별 재고대비 판매량</h3>
            </div>
            <div class="chart-box">
            	<canvas id="salesByCategory"></canvas>
            </div>
          </section>

          <section>
            <div class="title">
              <h3>VIP 회원</h3>
            </div>
              <table class="table">
              	<thead>
					<tr>
						<th>no</th>
						<th>이름</th>
						<th>전화번호</th>
						<th>주소</th>
						<th>총구매액</th>
					</tr>
              	</thead>
              	<tbody>
              		<tr>
              			<td></td>
              			<td></td>
              			<td></td>
              			<td></td>
              			<td></td>
              		</tr>
              	</tbody>
			</table>
          </section>
<%@include file="/jsp/common/footer.jsp" %>
<script>
const periodSalesCanvas = document.querySelector('#periodSales');
const salesByCategoryCanvas = document.querySelector('#salesByCategory');
const periodSalesData = {
		labels: ['2024-01', '2024-02', '2024-03', '2024-04', '2024-05', '2024-06'],
	    datasets: [{
	        label: '# of Votes',
	        data: [12, 19, 3, 5, 2, 3],
	        borderWidth: 1,
	        backgroundColor: [
	        	'rgba(255, 99, 132, 0.2)',
	            'rgba(255, 159, 64, 0.2)',
	            'rgba(255, 205, 86, 0.2)',
	            'rgba(75, 192, 192, 0.2)',
	            'rgba(54, 162, 235, 0.2)',
	            'rgba(153, 102, 255, 0.2)',
          	],
          	borderColor: [
          		'rgba(255, 99, 132, 0.2)',
	            'rgba(255, 159, 64, 0.2)',
	            'rgba(255, 205, 86, 0.2)',
	            'rgba(75, 192, 192, 0.2)',
	            'rgba(54, 162, 235, 0.2)',
	            'rgba(153, 102, 255, 0.2)',
              ],
		}],
}
const options = {
	scales: {
	      y: {
	        beginAtZero: true
	      }
    }
}
const config = {
	type: 'bar',
  	data: periodSalesData,
  	options
}
const periodSalesChart = new Chart(periodSalesCanvas, config);
const salesByCategoryChart = new Chart(salesByCategoryCanvas, {...config, type:"doughnut"});
</script>
</body>
</html>