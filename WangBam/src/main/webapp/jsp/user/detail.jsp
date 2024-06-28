<%@page import="mybatis.vo.ProductVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>

	.main{
	background-color: white;
	opacity : 0.9;
	box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.5);
	}
.product-details th {
	width: 120px;
	margin: -1px 0 0;
	padding: 15px 0 15px 10px;
	border-top: 1px solid #eee;
	text-align: left;
	vertical-align: middle;
	font-size: 15px !important;
	font-weight: bold;
	color: #333;
}

.product-details td {
	position: relative;
	padding: 15px 0;
	border-top: 1px solid #eee;
	vertical-align: middle;
}



#quantity{
   
    width: 40px;
    height: 23px;
    line-height: 14px !important;
    padding: 0 2px 0 5px;
    border: 1px solid #ccc;
    border-radius: 3px 0 0 3px;
}
#home {
	display: inline-block;
	width: 20px;
	/* 아이콘의 너비 */
	height: 20px;
	/* 아이콘의 높이 */
	background-image: url(./img/home.png);
	background-size: cover;
	background-repeat: no-repeat;
	background-position: center;

	/* 텍스트 숨기기 */
}

.icons a {
	text-indent: -9999px;
}

#discount {
	color: #e74c3c;
	font-size: 20px;
	margin-bottom: 10px;
}

.product-details p>span {
	font-size: 50px;
}

#sale {
	font-size: 25px;
	color: red;
}

/* 리뷰 */
.review-container {
	margin-bottom: 20px;
}

.review-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.review-header h2 {
	margin: 0;
}

.review-header .review-count {
	font-size: 14px;
	color: #888;
}

.review-item {
	border-bottom: 1px solid #ddd;
	padding: 10px 0;
}

.review-item h3 {
	font-size: 16px;
	margin: 0;
}

.review-item h5 {
	font-size: 14px;
	margin: 5px 0;
}

.review-item p {
	font-size: 12px;
	color: #888;
}

.review-item .review-content {
	margin-top: 10px;
}

.review-item .review-images {
	display: flex;
	gap: 10px;
	margin-top: 10px;
}

.review-item .review-images img {
	width: 100px;
	height: 100px;
	object-fit: cover;
}

.review-item a {
	text-decoration: none;
	color: black;
	/* 기본 색상 */
	display: block;
	padding: 10px;
	border: 1px solid transparent;
	transition: background-color 0.3s, color 0.3s;
	/* 부드러운 전환 효과 */
}

.review-item a:hover {
	background-color: #f0f0f0;
	/* 배경색 변경 */
	color: #007bff;
	/* 글자색 변경 */
	border: 1px solid #007bff;
	/* 테두리 색상 변경 */
}

/* 문의사항 */
.total {
	margin: 0;
	height: 90px;
}

.inquiry-info {
	margin-bottom: 20px;
}

.inquiry-info p {
	margin: 5px 0;
}

.btn-inquiry {
	display: inline-block;
	padding: 10px 20px;
	margin-bottom: 20px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.btn-inquiry:hover {
	background-color: #0056b3;
}

.question {
	border-bottom: 1px solid #ddd;
	padding: 10px 0;
}

.question h3 {
	font-size: 16px;
	margin: 0;
}

.question h5 {
	font-size: 14px;
	margin: 5px 0;
}

.question p {
	font-size: 12px;
	color: #888;
}

.question a {
	text-decoration: none;
	color: black;
	/* 기본 색상 */
	display: block;
	padding: 10px;
	border: 1px solid transparent;
	transition: background-color 0.3s, color 0.3s;
	/* 부드러운 전환 효과 */
}

.question a:hover {
	background-color: #f0f0f0;
	/* 배경색 변경 */
	color: #007bff;
	/* 글자색 변경 */
	border: 1px solid #007bff;
	/* 테두리 색상 변경 */
}
</style>

<%@include file="/jsp/common/header.jsp"%>


<div class="top">
	<div class="icons">

		<a href="?type=index" id="home"></a> > <a href="?type=item">카테고리</a>
	</div>
</div>
<div class="product-page">
	<div class="product-image">
		<img src="img/${pvo.pd_thumbnail_img}" alt="Product Image">
	</div>
	<div class="product-details">
		<h1>[왕밤빵]${pvo.pd_name}
		<c:if test="${pvo.pd_sale != null}">
		<span id="sale" style="color:red;">&nbsp;${pvo.pd_sale}%할인!</span>
		</c:if>
		</h1>
		
		<table>
			<tr>
				<th>판매가</th>
				<td class="price">${pvo.pd_price}원</td>
			</tr>
			<tr>
				<th>상품요약정보</th>
				<td>${pvo.pd_name}</td>
			</tr>
			<tr>
				<th>국내·해외배송</th>
				<td>국내배송</td>
			</tr>
			<tr>
				<th>배송방법</th>
				<td>택배</td>
			</tr>
			<tr>
				<th>배송비</th>
				<td>4,000원 (50,000원 이상 구매 시 무료)</td>
			</tr>
			<tr>
				<th>수량</th>
				<td><input type="number" id="quantity" name="quantity"
					value="1" min="1"></td>
			</tr>
			<tr>
				<th>총 상품금액</th>
				<c:if test="${pvo.pd_sale != null}">
				<td class="total-price"><span id="discount"></span></td>
				
				</c:if>
				<c:if test="${pvo.pd_sale == null}">
				
				<td class="total-price"><span id="totalPrice"></span></td>
				</c:if>
			</tr>
		</table>
		<div class="buttons">
			<button class="buy-now">바로 구매하기</button>
			<button class="add-to-cart" onclick="check()">장바구니 담기</button>
		</div>
	</div>
</div>


<div id="tabs">
	<ul>
		<li><a href="#tabs-1">상품상세정보</a></li>
		<li><a href="#tabs-2">상품구매안내</a></li>
		<li><a href="#tabs-3">교환/반품</a></li>
		<li><a href="#tabs-4">상품후기</a></li>
		<li><a href="#tabs-5">상품문의</a></li>
	</ul>
	<div id="tabs-1">
		<p>${pvo.pd_name}상세정보</p>
	</div>
	<div id="tabs-2">
		<h4>상품결제정보</h4>
		<p>고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다. 확인과정에서 도난 카드의 사용이나 타인
			명의의 주문등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다.</p>
		<p>
			무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다. </br> 주문시
			입력한 입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며 입금되지 않은 주문은 자동취소
			됩니다.
		</p>
		</br>
		<h4>배송정보</h4>
		<p>
			배송 방법 : 택배</br> 배송 지역 : 전국지역</br> 배송 비용 : 4,000원 ~ 50,000원</br> 배송 기간 : 3일 ~ 7일</br> 배송
			안내 : - 산간벽지나 도서지방은 별도의 추가금액을 지불하셔야 하는 경우가 있습니다.</br> 고객님께서 주문하신 상품은 입금 확인후
			배송해 드립니다. 다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.
		</p>
		</br>


	</div>
	<div id="tabs-3">
		<h4>교환 및 반품정보</h4>
		<p>
			교환 및 반품 주소 -쌍용교육센터</br> 교환 및 반품이 가능한 경우 - 계약내용에 관한 서면을 받은 날부터 7일. 단, 그 서면을
			받은 때보다 재화등의 공급이 늦게 이루어진 경우에는 재화등을 공급받거나 재화등의 공급이 시작된 날부터 7일 이내 -
			공급받으신 상품 및 용역의 내용이 표시.광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날
			부터 3월이내, 그사실을 알게 된 날 또는 알 수 있었던 날부터 30일이내 교환 및 반품이 불가능한 경우 - 이용자에게 책임
			있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는 청약철회를
			할 수 있습니다) - 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우 - 시간의 경과에 의하여
			재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우 - 복제가 가능한 재화등의 포장을 훼손한 경우 - 개별 주문
			생산되는 재화 등 청약철회시 판매자에게 회복할 수 없는 피해가 예상되어 소비자의 사전 동의를 얻은 경우 - 디지털 콘텐츠의
			제공이 개시된 경우, (다만, 가분적 용역 또는 가분적 디지털콘텐츠로 구성된 계약의 경우 제공이 개시되지 아니한 부분은
			청약철회를 할 수 있습니다.) ※ 고객님의 마음이 바뀌어 교환, 반품을 하실 경우 상품반송 비용은 고객님께서 부담하셔야
			합니다. (색상 교환, 사이즈 교환 등 포함)
		</p>
	</div>

	<div id="tabs-4">
		<div class="review-header">
			<h2>상품평</h2>
			<c:set var="reviewCount" value="0" />
			<c:forEach var="vo" items="${bvo}">
				<c:if test="${vo.bo_type == 2}">
					<c:set var="reviewCount" value="${reviewCount + 1}" />
				</c:if>
			</c:forEach>
			<div class="review-count">
				총
				<c:out value="${reviewCount}" />
				개
			</div>
		</div>

		<div class="review-container">
			<c:set var="hasReview" value="false" />
			<!-- 리뷰 존재 여부를 확인하는 플래그 초기화 -->

			<c:forEach var="board" items="${bvo}">
				<c:if test="${board.bo_type == 2}">
					<div class="review-item">
						<a
							href="?type=boardsDetail&bo_idx=${board.bo_idx}&cPage=1&bo_type=2">

							<p>${board.us_idx}| ${board.bo_write_date}</p>
							<h3>${board.bo_title}</h3> <br />
							<h5>${board.bo_content}</h5>
							<div class="review-content">${board.bo_content}</div>
							<div class="review-images">
								<c:forEach var="image" items="${board_img}">
									<img src="${image.url}" alt="리뷰 이미지">
								</c:forEach>
							</div>
						</a>
					</div>
					<c:set var="hasReview" value="true" />
					<!-- bo_type이 2인 요소가 있으면 플래그를 true로 설정 -->
				</c:if>
			</c:forEach>

			<c:if test="${not hasReview}">
				<!-- 리뷰가 없는 경우 메시지 출력 -->
				<h3>아직 리뷰가 등록되지 않았습니다.</h3>
			</c:if>
		</div>
	</div>
	<div id="tabs-5">
		<h2>상품문의</h2>
		<div class="inquiry-info">
			<p>구매한 상품의 취소/반품은 마이쿠팡 구매내역에서 신청 가능합니다.</p>
			<p>상품문의 및 후기게시판을 통해 취소나 환불, 반품 등은 처리되지 않습니다.</p>
			<p>가격, 판매자, 교환/환불 및 배송 등 해당 상품 자체와 관련 없는 문의는 고객센터 내 1:1 문의하기를
				이용해주세요.</p>
			<p>해당 상품 자체와 관계없는 글, 영업, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출제한, 삭제
				등의 조치가 취해질 수 있습니다.</p>
			<p>공개 게시판이므로 전화번호, 메일 주소 등 고객님의 소중한 개인정보는 절대 남기지 말아주세요.</p>
		</div>
		<button onclick="location.href='문의하기 URL'" class="btn-inquiry">문의하기</button>
		<c:set var="hasquestion" value="false" />
		<!-- 문의 존재 여부를 확인하는 플래그 초기화 -->

		<c:forEach var="board" items="${bvo}">
			<c:if test="${board.bo_type == 1}">
				<div class="question">
					<a
						href="?type=boardsDetail&bo_idx=${board.bo_idx}&bo_type=1&cPage=3">
						<h3>${board.bo_title}</h3>
						<h5>${board.bo_content}</h5>
						<p>${board.bo_write_date}</p>
					</a>
				</div>
				<c:set var="hasquestion" value="true" />
				<!-- bo_type이 1인 요소가 있으면 플래그를 true로 설정 -->
			</c:if>
		</c:forEach>

		<c:if test="${not hasquestion}">
			<!-- 문의가 없는 경우 메시지 출력 -->
			<h3>아직 문의가 등록되지 않았습니다.</h3>
		</c:if>
	</div>




</div>



<%@include file="/jsp/common/footer.jsp"%>


<script>
                    $(function () {
                        $("#tabs").tabs();
                    });
                    function updateTotalPrice() {
                        let price = ${ pvo.pd_price };
                        let quantity = document.getElementById("quantity").value; // 수량 입력 필드에서 값을 가져옵니다.
                        let sale = document.getElementById("sale");
                        let discount = 0;
                        let totalPrice = 0;
                        if (sale == null) {
                            totalPrice = quantity * price;
                        } else {

                            totalPrice = quantity * price;
                            //discount = quantity * price - (price * sale.innerText.substring(0, 2) / 100);
                            discount = totalPrice - (totalPrice * (${ pvo.pd_sale / 100 }));
                            document.getElementById("discount").innerText = discount.toLocaleString() + '원'; // 총 금액을 화면에 표시합니다.
                        }

                        document.getElementById("totalPrice").innerText = totalPrice.toLocaleString() + '원'; // 총 금액을 화면에 표시합니다.

                    }


                    window.onload = updateTotalPrice; // 함수를 직접 할당
                    document.getElementById("quantity").addEventListener("input", updateTotalPrice);

                    function check() {
                        let count = document.getElementById('quantity').value;

                        if (${ sessionScope.user != null }) {

                            // AJAX 요청을 사용하여 장바구니에 상품을 추가하고, 성공 시 페이지를 리다이렉트합니다.
                            $.ajax({
                                url: "?type=cartAdd",
                                type: "GET",
                                data: {
                                    pd_idx: "${pvo.pd_idx}",
                                    pd_cnt: count
                                },
                                success: function () {
                                    if (confirm("장바구니에 담았습니다.계속 이용하시겠습니까?")) {
                                        
                                    } else {

                                        // 장바구니 추가가 성공하면 장바구니 목록 페이지로 이동합니다.
                                        location.href = "?type=cartList";
                                    }
                                },
                                error: function () {
                                    alert("장바구니 추가에 실패했습니다.");
                                }
                            });
                        }else {
                            alert("로그인 먼저 해주세요!");
                            location.href = "?type=login";
                        }
                    }


                </script>