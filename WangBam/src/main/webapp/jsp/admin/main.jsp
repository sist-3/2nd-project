<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@include file="/jsp/common/adminHeader.jsp" %>
<section>
            <div class="title">
              <h3>판매진행현황</h3>
              <div calss="graph">
                그래프
              </div>
            </div>
          </section>

          <section>
            <div class="title">
              <h3>기간별 매출</h3>
              <canvas id="periodSales" width="600" height="300"></canvas>
            </div>
          </section>

          <section>
            <div class="title">
              <h3>카테고리별 재고대비 판매량</h3>
              <canvas id="salesByCategory" width="600" height="300"></canvas>
            </div>
          </section>

          <section>
            <div class="title">
              <h3>VIP 회원</h3>
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
              		</tr>
              	</tbody>
			</table>
            </div>
          </section>
<%@include file="/jsp/common/footer.jsp" %>
<script>
const periodSalesCanvas = document.querySelector('#periodSales');
const salesByCategoryCanvas = document.querySelector('#salesByCategory');
const periodSalesData = {
		labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
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