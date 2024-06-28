<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="/jsp/common/adminHeader.jsp"%>

<c:set var="deliAr" value="${requestScope.deliAr}" />
<c:set var="statusCodes" value="${requestScope.STATUS_CODES}" />
<c:set var="statusLabels" value="${requestScope.STATUS_CODES_KO}" />
<section>
	<div class="title">
		<h3>판매진행현황</h3>
	</div>
	<ul class="order-state">
		<c:forEach var="status" items="${statusLabels}" varStatus="statusIndex">
            <li><a href="admin?type=orderList&searchType=or_status_code&searchValue=${statusCodes[statusIndex.index]}">${status} : ${deliAr[statusIndex.index]}건</a></li>
        </c:forEach>
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

<c:set var="vip_ar" value="${requestScope.vip }" />
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
				<th>총구매액</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="vip" items="${vip_ar}" varStatus="st">
				<tr>
					<td>${vip.us_idx}</td>
					<td>${vip.us_name}</td>
					<td>${vip.us_tel}</td>
					<td><fmt:formatNumber value="${vip.us_total_price}" pattern="#,###" />원</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</section>
<%@include file="/jsp/common/footer.jsp"%>

<%-- 월별 매출액  --%>
<c:set var="ar" value="${requestScope.ar}" />
<c:forEach var="vo" items="${ar}" varStatus="st">
	<input type="hidden" name="chartMonth" id="chartMonth${st.index}"
		value="${vo.or_sales_month}">
	<input type="hidden" name="chartSales" id="chartData${st.index}"
		value="${vo.or_sales}">
</c:forEach>

<%-- 카테고리별 회전율 --%>
<c:set var="c_ar" value="${requestScope.c_list}" />
<c:forEach var="cvo" items="${c_ar}" varStatus="st">
	<input type="hidden" name="ctName" id="ctName${st.index}"
		value="${cvo.ct_name}">
	<input type="hidden" name="odCntPerpdCnt" id="odCntPerpdCnt${st.index}"
		value="${cvo.odCnt_per_pdCnt}">
</c:forEach>

<script>
// 월별 매출액
function setData(object){
	const obj = object;
	const ar = [];
	for(let i=0;i<obj.length;i++){
		ar.push(obj[i].value);
	}
	
	return ar;
}

// 데이터 요청
const arMonth = setData(document.querySelectorAll('input[name=chartMonth]'));
const arSales = setData(document.querySelectorAll('input[name=chartSales]'));
const arCategoryName = setData(document.querySelectorAll('input[name=ctName]'));
const arodCntPerpdCnt = setData(document.querySelectorAll('input[name=odCntPerpdCnt]'));
// 차트
const periodSalesCanvas = $('#periodSales');
const salesByCategoryCanvas = $('#salesByCategory');

//월별 매출액 차트 데이터 설정
const periodSalesData = {
		labels: arMonth,
		datasets:[{
			label: "월별 매출액",
	        data: arSales,
	        backgroundColor: [
	  	      'rgba(255, 99, 132, 0.2)',
	  	      'rgba(255, 159, 64, 0.2)',
	  	      'rgba(255, 205, 86, 0.2)',
	  	      'rgba(75, 192, 192, 0.2)',
	  	      'rgba(54, 162, 235, 0.2)',
	  	      'rgba(153, 102, 255, 0.2)',
	  	    ],
		}],
}

// 카테고리별 재고대비 매출액 설정
const salesByCategoryData = {
		labels: arCategoryName,
		datasets:[{
			label: "카테고리별 재고대비 매출액",
	        data: arodCntPerpdCnt,
	        backgroundColor: [
	  	      'rgba(233, 102, 255, 0.2)',
	  	      'rgba(77, 255, 207, 0.2)'
	  	    ],
		}],
}
// 차트 default 옵션
const options = {
    plugins:{
        legend: {
            display: false
        },
    }
}
// 차트 default 설정값
const config = {
	type: 'bar',
  	data: periodSalesData,
  	options,
}
// 월별 판매액 차트
const periodSalesChart = new Chart(periodSalesCanvas, {...config});

// 회전율 차트
const salesByCategoryChart = new Chart(salesByCategoryCanvas, {...config, data:salesByCategoryData});
</script>
</body>
</html>