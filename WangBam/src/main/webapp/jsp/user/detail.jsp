<%@page import="mybatis.vo.ProductVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  <style>
  #discount{
  
  color: #e74c3c;
    font-size: 20px;
    margin-bottom: 10px;
    
  
  }
  .product-details p>span{
  font-size: 50px;
  }
  
  #sale{
  font-size: 25px;
  color: red;
  }
  </style>
  
<%@include file="/jsp/common/header.jsp" %>

	
				<div class="top">
					<div class="icons">
						<a href="#" id="home">
							<div id="home_icon">홈화면
							</div>
						</a> > <a href="#">카테고리</a>
					</div>
				</div>
				<div class="product-page">
					<div class="product-image">
						<img src="img/${pvo.pd_thumbnail_img}" alt="Product Image">
					</div>
					<div class="product-details">
						
						<p>
						<span>${pvo.pd_name}</span>
						
						<c:if test="${pvo.pd_sale != null }">
							<p id="sale" >${pvo.pd_sale}% 할인</p>
							
						</c:if>
						</p>
						
						
						<p class="origin">국내산</p>
						<p class="shipping">택배배송</p>
						<p class="shipping-fee">배송비: 4,000원 (50,000원 이상 구매 시 무료)</p>
						<div class="quantity">
							
							<input type="number" id="quantity" name="quantity" value="1"
								min="1">
							
						</div>
								<div>
								정가 : <span id="totalPrice"></span></br>
								<c:if test="${pvo.pd_sale != null }">
								할인금액 : <span id="discount"></span>
								
								</c:if>
								</div></br>
						
						<div class="buttons">
							<button class="buy-now">바로 구매하기</button>
							<button class="add-to-cart" onclick="javascript:location.href='?type=cart&pd_idx=${pvo.pd_idx}&us_idx=${sessionScope.user.us_idx}'">장바구니 담기</button>
							
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
						<p>이 상품의 구매 안내를 확인하세요. 구매 전 반드시 상품 상세 설명을 읽어보시고, 궁금한 점이 있으시면
							언제든지 문의해 주세요.</p>
						<p>상품 주문 후 취소는 24시간 이내에만 가능합니다.</p>
						<p>배송은 결제 완료 후 2~3일 이내에 진행됩니다.</p>
						<p>제품 하자 또는 배송 중 문제 발생 시 무료 교환 또는 환불이 가능합니다.</p>
					</div>
					<div id="tabs-3">
						<p>교환/반품 사절</p>
					</div>
						
					<div id="tabs-4">
						
						<c:set var="hasReview" value="false" /> <!-- 리뷰 존재 여부를 확인하는 플래그 초기화 -->

						<c:forEach var="board" items="${bvo}">
						    <c:if test="${board.bo_type == 2}">
							    <h3>${board.bo_title}</h3>
							 	<h5>${board.bo_content}</h5>
							        <c:set var="hasReview" value="true" /> <!-- bo_type이 2인 요소가 있으면 플래그를 true로 설정 -->
						    </c:if>
						</c:forEach>
						
						<c:if test="${not hasReview}"> <!-- 리뷰가 없는 경우 메시지 출력 -->
						    <h3>아직 리뷰가 등록되지 않았습니다.</h3>
						</c:if>
						
					</div>
					<div id="tabs-5">
					
						<c:set var="hasquestion" value="false" /> <!-- 리뷰 존재 여부를 확인하는 플래그 초기화 -->

						<c:forEach var="board" items="${bvo}">
						    <c:if test="${board.bo_type == 1}">
						    <h3>${board.bo_title}</h3>
						 	<h5>${board.bo_content}</h5>
						        <c:set var="hasquestion" value="true" /> <!-- bo_type이 2인 요소가 있으면 플래그를 true로 설정 -->
						    </c:if>
						</c:forEach>
						
						<c:if test="${not hasquestion}"> <!-- 리뷰가 없는 경우 메시지 출력 -->
						    <h3>아직 리뷰가 등록되지 않았습니다.</h3>
						</c:if>
						
					</div>
					


				</div>
	


<%@include file="/jsp/common/footer.jsp" %>

	
	<script>
	 $( function() {
		    $( "#tabs" ).tabs();
		  } );
	function updateTotalPrice() {
		let price = ${pvo.pd_price};
	    let quantity = document.getElementById("quantity").value; // 수량 입력 필드에서 값을 가져옵니다.
		let sale = document.getElementById("sale");
	   	let discount = 0;
	    let totalPrice = 0;	
	    if(sale == null){
		    totalPrice = quantity * price;	
	    }else{
	    	
	    	totalPrice = quantity * price;
	    	discount = quantity * price-(price*sale.innerText.substring(0,2)/100);
	    document.getElementById("discount").innerText = discount.toLocaleString() + '원'; // 총 금액을 화면에 표시합니다.
	    }

	    document.getElementById("totalPrice").innerText = totalPrice.toLocaleString() + '원'; // 총 금액을 화면에 표시합니다.
	    
	}
	

    window.onload = updateTotalPrice; // 함수를 직접 할당
   // 함수를 직접 할당
    document.getElementById("quantity").addEventListener("input", updateTotalPrice);
    
</script>


