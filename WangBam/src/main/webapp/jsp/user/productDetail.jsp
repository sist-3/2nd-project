<%@page import="mybatis.vo.ProductVO" %>
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
		<style>
			/*탭*/
			.ui-state-default,
			.ui-widget-content .ui-state-default,
			.ui-widget-header .ui-state-default,
			.ui-button,
			html .ui-button.ui-state-disabled:hover,
			html .ui-button.ui-state-disabled:active {
				border: initial !important;
				background: initial !important;
				font-weight: initial !important;
				color: initial !important;
				/*탭버튼 외곽선 */
			}

			.ui-widget-header {
				border: initial !important;
				/* 탭 버튼 위아래 외곽선  */
			}

			.ui-widget.ui-widget-content {
				border: initial !important;
				/* 탭 내용 외곽선 */
			}

			.ui-tabs .ui-tabs-nav {
				margin: 0;
				padding: 0;
				display: flex;
				/* Flexbox를 사용하여 가로로 배치 */
				background-color: white;
				height: 50;
			}

			.ui-tabs .ui-tabs-nav li {
				flex: 1;
				/* 모든 탭이 동일한 너비를 가지도록 설정 */
				list-style: none;
			}

			.ui-tabs .ui-tabs-nav li a {
				position: relative;
				overflow: hidden;
				display: block;
				width: 100%;
				padding: 0.5em 0;
				/* 필요에 따라 조정 */
				text-align: center;
				box-sizing: border-box;
				background-color: #ffffff;
				/* 비활성 탭 배경색 */
				border: 1px solid #c5c5c5;
				/* 비활성 탭 테두리 */
				border-radius: 20px;
				/* 둥근 모서리 */
				margin: 0 5px;
				/* 탭 사이의 간격 */
				color: #333;
				/* 텍스트 색상 */
				text-decoration: none;
				/* 텍스트 밑줄 제거 */
				font-size: large;
				/* 탭 버튼 글자 크기 */
			}

			.ui-tabs .ui-tabs-nav li.ui-tabs-active a {
				background: #fdd835;
				/* 활성 탭 배경색 */
				border: 1px solid #fdd835;
				/* 활성 탭 테두리 */
				color: #333;
				/* 활성 탭 텍스트 색상 */
			}

			.ui-dialog-buttonset>.ui-button:first-child {
				background-color: #8b4d35 !important;
				color: #fff !important;
			}

			.ui-button {
				border: 1px solid #c5c5c5 !important;
				background: #f6f6f6 !important;
				font-weight: normal !important;
				color: #454545 !important;
			}

			/* content 정위치를 위해 css무시 */
			#tabs.ui-widget.ui-widget-content {
				padding: initial !important;
				border-radius: initial !important;
				overflow: initial !important;
				position: initial !important;
			}

			.ui-button:hover {
				border: 1px solid #cccccc !important;
				background: #ededed !important;
				font-weight: normal !important;
				color: #2b2b2b !important;
			}

			/*배경*/
			.main {
				width: 70%;
				padding: 0 20px;
				margin: 30px auto;
				background-color: white;
				box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			}

			/*구매*/
			.product-details {
				align-content: center;
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
				width: 450px;
			}

			#quantity {
				width: 40px;
				height: 23px;
				line-height: 14px !important;
				padding: 0 2px 0 5px;
				border: 1px solid #ccc;
				border-radius: 3px 0 0 3px;
				width: 50px;
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

			.remove_price {
				text-decoration: line-through
			}

			/* 리뷰 */
			.review-section {
				text-align: center;
				display: flex;
				width: 100%;
				height: 200;
				background-color: #FDF9E3;
				align-items: center;
				justify-content: space-around;
			}

			.review-section:nth-child(1) {
				magin-bottom=20px;

			}

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

			.review-item a:hover{
				background-color: #f0f0f0;
				/* 배경색 변경 */
				color: #007bff;
				/* 글자색 변경 */
				border: 1px solid #007bff;
				/* 테두리 색상 변경 */
			}
			.best:hover,.recent:hover, .best-review:hover, .my_question:hover, .all_question:hover{
			font-weight:bold;
			}
			/* 문의사항 */
			.clearFix {
				display: flex;
				justify-content: space-between;
				align-items: center;
			}

			.clearFix:after {
				content: ".";
				display: block;
				clear: both;
				height: 0;
				visibility: hidden;
			}

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

			.btn {
				float: right !important;
				display: inline-block;
				float: right;
				width: 130px;
				height: 50px;
				font-size: 20px !important;
				white-space: nowrap;
				font-weight: bold;
				padding: 8px !important;
			}
			.btn.submit{
			position: absolute;
			right: 30px;
			}

			.question {
				border-bottom: 1px solid #ddd;
				padding: 10px 0;
			}

			.questionItem {
				margin-top: 30px;
				border-top: 2px solid #777;
				border-bottom: 1px solid #ddd;
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

			/*문의사항 답변*/
			.questionMark {
				left: 1em;
				background-color: #777;
			}

			.replyMark {
				left: 1em;
				background-color: #346AFF;
			}

			.questionMark,
			.replyMark {
				top: 20px;
				display: inline-block;
				padding: 4px;
				font-size: 11px;
				letter-spacing: 1px;
				color: #fff;
			}

			/*dialog*/
			.ui-dialog {
				position: fixed;
				top: 50% !important;
				left: 50% !important;
				transform: translate(-50%, -50%) !important;
				margin: 0 !important;
			}

			#tabs-2,
			#tabs-3,
			#tabs-5 {
				padding: 30px;
				line-height: 25px;
				background-color: #f9f9f3db;
				margin-top: 20px;
			}

			.tab-detail {
				padding: 5px 20px;
				margin-top: 20px;
			}
		</style>
		<%@include file="/jsp/common/header.jsp" %>
			<div class="top">
				<div class="icons">
					<a href="?type=index" id="home"></a> > <a href="?type=productList">돌아가기</a>
				</div>
			</div>
			<div class="product-page">
				<div class="product-image">
					<c:if test="${pvo.pd_thumbnail_img eq '' }">
						<img src="https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg"
							width="100%" height="100%">
					</c:if>
					<c:if test="${pvo.pd_thumbnail_img ne ''}">
						<img src="img/${pvo.pd_thumbnail_img}" width="70%" height="70%">
					</c:if>
				</div>
				<div class="product-details">
					<h1>
						[왕밤빵]${pvo.pd_name}
						<c:if test="${pvo.pd_sale != null}">
							<span id="sale" style="color: red;">&nbsp;${pvo.pd_sale}%할인!</span>
						</c:if>
					</h1>
					<table>
						<tr>
							<th>판매가</th>
							<td>
								<c:if test="${pvo.pd_sale != null}">
									<p class="remove_price" id="price">${pvo.pd_price}원</p>&nbsp;
									<p class="price">${pvo.pd_sale_price}원</p>
								</c:if>
								<c:if test="${pvo.pd_sale == null}">
									<p class="price" id="price">${pvo.pd_price}원</p>
								</c:if>
							</td>
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
							<td>4,000원</td>
						</tr>
						<tr>
							<th>수량</th>
							<td><input type="number" id="quantity" name="quantity" value="1" min="1" max="${pvo.pd_cnt}"
									oninput="cntLimit(this)"></td>
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
						<button id="order_Btn" class="buy-now">바로 구매하기</button>
						<button class="add-to-cart" onclick="check()">장바구니 담기</button>
					</div>
				</div>
			</div>
			<div class="tabs-container" style="position: relative;">
				<div id="tabs">
					<ul>
						<li><a href="#tabs-1">상품상세정보</a></li>
						<li><a href="#tabs-2">상품구매안내</a></li>
						<li><a href="#tabs-3">교환/반품</a></li>
						<li><a href="#tabs-4"> <span>상품후기
									<c:set var="reviewCount" value="0" />
									<c:forEach var="vo" items="${bvo}">
										<c:if test="${vo.bo_type == 2}">
											<c:set var="reviewCount" value="${reviewCount + 1}" />
										</c:if>
									</c:forEach> <span class="review-count">(
										<c:out value="${reviewCount}" />&nbsp;)
									</span>
								</span>
							</a></li>
						<li><a href="#tabs-5">상품문의
								<c:set var="questionCount" value="0" />
								<c:forEach var="vo" items="${bvo}">
									<c:if test="${vo.bo_type == 1}">
										<c:set var="questionCount" value="${questionCount + 1}" />
									</c:if>
								</c:forEach> <span class="question-count">(
									<c:out value="${questionCount}" />&nbsp;)
								</span>
							</a></li>
					</ul>
					<div id="tabs-1" style="text-align: center;">
						<c:if test="${pvo.pd_detail_img eq '' }">
							<h3>등록된 상품 상세 이미지가 없습니다.</h3>
						</c:if>
						<c:if test="${pvo.pd_detail_img != null}">
							<img src="${pageContext.request.contextPath}/img/${pvo.pd_detail_img}" width="80%"
								alt="상세 이미지" />
						</c:if>
					</div>
					<div id="tabs-2">
						<h1 style="margin-top: 10px;">상품결제정보</h1>
						<div class="tab-detail">
							고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다. 확인과정에서 도난 카드의 사용이나 타인
							명의의 주문등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다.
							무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다. 주문시
							입력한 입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며 입금되지 않은 주문은
							자동취소 됩니다.
						</div>
						<h1 style="margin-top: 30px;">배송정보</h1>
						<div class="tab-detail">
							배송 방법 : 택배</br> 배송 지역 : 전국지역</br> 배송 비용 : 4,000원 ~ 50,000원</br> 배송 기간 : 3일 ~ 7일</br> 배송
							안내 : - 산간벽지나 도서지방은 별도의 추가금액을 지불하셔야 하는 경우가 있습니다.</br> 고객님께서 주문하신 상품은 입금
							확인후 배송해 드립니다. 다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.
						</div>

					</div>
					<div id="tabs-3">
						<h1 style="margin-top: 10px;">교환 및 반품정보</h1>
						<div class="tab-detail">
							교환 및 반품 주소 -쌍용교육센터</br> 교환 및 반품이 가능한 경우 - 계약내용에 관한 서면을 받은 날부터 7일. 단, 그
							서면을 받은 때보다 재화등의 공급이 늦게 이루어진 경우에는 재화등을 공급받거나 재화등의 공급이 시작된 날부터 7일 이내 -
							공급받으신 상품 및 용역의 내용이 표시.광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날
							부터 3월이내, 그사실을 알게 된 날 또는 알 수 있었던 날부터 30일이내 교환 및 반품이 불가능한 경우 - 이용자에게
							책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는
							청약철회를 할 수 있습니다) - 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우 - 시간의
							경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우 - 복제가 가능한 재화등의 포장을 훼손한 경우 -
							개별 주문 생산되는 재화 등 청약철회시 판매자에게 회복할 수 없는 피해가 예상되어 소비자의 사전 동의를 얻은 경우 -
							디지털 콘텐츠의 제공이 개시된 경우, (다만, 가분적 용역 또는 가분적 디지털콘텐츠로 구성된 계약의 경우 제공이 개시되지
							아니한 부분은 청약철회를 할 수 있습니다.) ※ 고객님의 마음이 바뀌어 교환, 반품을 하실 경우 상품반송 비용은 고객님께서
							부담하셔야 합니다. (색상 교환, 사이즈 교환 등 포함)
						</div>
					</div>
					<div id="tabs-4">
						<c:forEach var="board" items="${bvo}">
							<c:if test="${board.bo_type == 2}">
								<c:set var="reviewCount" value="${reviewCount + 1}" />
								<c:set var="reviewCheck" value="${board.bo_idx}" />
							</c:if>
						</c:forEach>
						<div class="review-header">
							<h1 style="margin-top: 10px;">상품후기</h1>
							<span class="align" style=" margin-right:480px; margin-top: 10px; font-size:15px;">
								<button class="best" onclick="bestList()">베스트순</button>
								<label>|</label>
								<button class="recent" onclick="recentList()">최신순</button>
							</span>
							<p>동일한 상품에 대해 작성된 상품평으로, 판매자는 다를 수 있습니다.</p>
						</div>
						<c:if test="${reviewCheck != null}">
							<div class="review-section">
								<div class="total-score">
									사용자 총 평점
									<div id="starScore" class="star-score" style="margin-top: 10px">
										<c:set var="totalScore" value="0" />
										<c:set var="reviewCount" value="0" />
										<c:forEach var="board" items="${bvo}">
											<c:if test="${board.bo_type == 2}">
												<c:set var="totalScore" value="${totalScore + board.bo_score}" />
												<c:set var="reviewCount" value="${reviewCount + 1}" />
											</c:if>
										</c:forEach>
										<c:set var="averageScore" value="${totalScore / reviewCount}" />
										<c:set var="limit" value="${Math.floor(averageScore)}" />
										<c:forEach begin="1" end="5" varStatus="st">
											<c:choose>
												<c:when test="${st.index <= limit}">
													<div class="icon-star on"></div>
												</c:when>
												<c:otherwise>
													<div class="icon-star"></div>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</div>
									<h2 style="margin-top: 10px">
										<c:out value="${averageScore}" />
										/ 5
									</h2>
								</div>
								<div class="review-count">
									<span style="display: flex; align-items: center;">
										<h2 style="margin: 0;">베스트 리뷰</h2>
										<img src="./img/트로피.png" width="32" style="margin-left: 10px;">
									</span>
									<c:set var="maxHit" value="0" />
									<c:set var="maxHitTitle" value="" />

									<c:forEach var="board" items="${bvo}">
										<c:if test="${board.bo_type == '2'}">
											<c:if test="${board.bo_hit > maxHit}">
												<c:set var="maxHit" value="${board.bo_hit}" />
												<c:set var="maxHitTitle" value="${board.bo_title}" />
												<c:set var="bestreview" value="${board.bo_idx}" />
											</c:if>
										</c:if>
									</c:forEach>
									<br>
									<p style="margin-top: 20px">
										<a class="best-review" href="?type=boardsDetail&bo_idx=${bestreview}&cPage=1&bo_type=2">
											<c:out value="${maxHitTitle}" />
										</a>
									</p>
								</div>
							</div>
						</c:if>

						<div class="review-container">
							<c:set var="hasReview" value="false" />
							<!-- 리뷰 존재 여부를 확인하는 플래그 초기화 -->
							<c:forEach var="board" items="${bvo}">
								<c:if test="${board.bo_type == 2}">
									<div class="review-item" data-board='{"bo_hit": ${board.bo_hit}, "bo_write_date": "${board.bo_write_date}"}'>
										<a href="?type=boardsDetail&bo_idx=${board.bo_idx}&cPage=1&bo_type=2">
											<div id="starScore" class="star-score">
												<c:set var="limit" value="${Math.floor(board.bo_score)}" />
												<c:forEach begin="1" end="5" varStatus="st">
													<c:choose>
														<c:when test="${st.index-1 < limit}">
															<div class="icon-star on"></div>
														</c:when>
														<c:when test="${st.index-1 >= limit}">
															<div class="icon-star"></div>
														</c:when>
													</c:choose>
												</c:forEach>
											</div>
											<c:choose>
											<c:when test="${board.uvo.us_status eq 1}">
											<p>${board.uvo.us_nickname}&nbsp;|&nbsp;${board.bo_write_date}</p>
											</c:when>
											<c:otherwise>
											<p>탈퇴한 회원&nbsp;|&nbsp;${board.bo_write_date}</p>
											</c:otherwise>
											</c:choose>
											<h3>${board.bo_title}</h3> <br />

											<h5>${board.bo_content}</h5>
											<div class="review-images">
												<c:if test="${board.bo_img != null && board.bo_img ne ''}">
													<img src="${pageContext.request.contextPath}/img/${board.bo_img}"
														width="100" />
												</c:if>
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
						<div class="clearFix">
							<span class="align" style="display: flex; align-items: center; font-size:15px;">
							<h1 style="margin-right:10px;">상품문의</h1>
							<button onclick="allQuestion()" class="all_question">전체</button>
                            <label>|</label>
                            <button onclick="myQuestion()" class="my_question">내 글 보기</button>
                            </span>
							<button onclick="questionCheck()" class="btn submit">문의하기</button>
						</div>
						<div class="tab-detail">
							<p>구매한 상품의 취소/반품은 마이쿠팡 구매내역에서 신청 가능합니다.</p>
							<p>상품문의 및 후기게시판을 통해 취소나 환불, 반품 등은 처리되지 않습니다.</p>
							<p>가격, 판매자, 교환/환불 및 배송 등 해당 상품 자체와 관련 없는 문의는 고객센터 내 1:1 문의하기를
								이용해주세요.</p>
							<p>해당 상품 자체와 관계없는 글, 영업, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출제한,
								삭제 등의 조치가 취해질 수 있습니다.</p>
							<p>공개 게시판이므로 전화번호, 메일 주소 등 고객님의 소중한 개인정보는 절대 남기지 말아주세요.</p>
						</div>
						<div class="questionItem">
							<c:set var="hasquestion" value="false" />
							<!-- 문의 존재 여부를 확인하는 플래그 초기화 -->
							<c:forEach var="board" items="${bvo}">
								<c:if test="${board.bo_type == 1}">
									<div class="question" data-user-id="${board.uvo.us_idx}">
										<!--  <a href="?type=boardsDetail&bo_idx=${board.bo_idx}&bo_type=1&cPage=3">-->
										<a href="javascript:if(${sessionScope.user.us_idx == board.uvo.us_idx}){
										location.href='?type=boardsDetail&bo_idx=${board.bo_idx}&bo_type=1&cPage=3'
										}else{
										dialog('dialog-confirm',
													'본인 글만 볼 수 있습니다!',
													{
														'확인': function () {
															$(this).dialog('close');
														}
													}
												);
										};"
										>
											<c:if test="${board.bo_answer eq '0'}">
												<em class="questionMark">미답변</em>
											</c:if>
											<c:if test="${board.bo_answer eq '1'}">
												<em class="replyMark">답변완료</em>
											</c:if>
											<c:if test="${board.uvo.us_status eq '1'}">
												${fn:substring(board.uvo.us_name,0,1)}** | ${board.bo_write_date}
											</c:if>
											<c:if test="${board.uvo.us_name == null}">
												탈퇴한 회원 | ${board.bo_write_date}
											</c:if>

											<h3>${board.bo_title}</h3>
											<h5>${board.bo_content}</h5>
											<div class="question-images">
												<c:if test="${board.bo_img != null && board.bo_img ne ''}">
													<img src="${pageContext.request.contextPath}/img/${board.bo_img}"
														width="100" />
												</c:if>
											</div>
										</a>
									</div>
									<c:set var="hasquestion" value="true" />
									<!-- bo_type이 1인 요소가 있으면 플래그를 true로 설정 -->
								</c:if>
							</c:forEach>
							<c:if test="${not hasquestion}">
								<!-- 문의가 없는 경우 메시지 출력 -->
								<h3 style="margin: 15px 0;">아직 문의가 등록되지 않았습니다.</h3>
							</c:if>
						</div>
					</div>
				</div>
			</div>
			<div id="dialog-confirm" title="알림" class="dialog" style="display: none; white-space: pre-line;">
				<p></p>
			</div>
			<%@include file="/jsp/common/footer.jsp" %>
				<script>
					function dialog(className, msg, callback) {
						$("#" + className + " p").text(msg);
						$("#" + className).dialog({
							resizable: false,
							draggable: false,
							height: "auto",
							width: 400,
							modal: true,
							buttons: callback
						});
					}
					//상품재고 수량 제한
					function cntLimit(input) {
						let max = parseInt(input.max, 10);
						let value = parseInt(input.value, 10);
						if (value > max) {
							dialog("dialog-confirm", "재고보다 많은 수량을 구매할 수 없습니다.", {
								"확인": function () {
									$(this).dialog("close");
									document.updateForm.submit();
								}
							});
							//alert("재고보다 많은 수량은 구매할 수 없습니다.");
							input.value = max;
						}
					}

					$(function () {
						$("#tabs").tabs();
						$("#order_Btn").on('click', function () {
							if (${ sessionScope.user != null }){
							dialog("dialog-confirm", "바로 구매하시겠습니까?", {
								"확인": function () {
									$(this).dialog("close");
									let price = null;

									if (${ pvo.pd_sale != null }) {
								price = $("#discount").text();
							} else {
								price = $("#totalPrice").text();
							}

							price = price.replace(',', '');
							price = price.replace('원', '');

							const data = {
								cnt: $("#quantity").val(),
								price: price
							}
							$.ajax({
								url: '/WangBam/?type=buy',
								type: 'POST',
								contentType: 'application/json',
								data: JSON.stringify(data),
								success: function (response) {
									location.replace("/WangBam/?type=buy");
								},
								error: function (request, status, error) {
								}
							});
						},
						"취소": function() {
							$(this).dialog("close");
						}
					});	
					}else {
						dialog("dialog-confirm",
							"로그인이 필요합니다.\n로그인 페이지로 이동하시겠습니까?\n",
							{
								"확인": function () {
									$(this).dialog("close");
									location.href = "?type=login";
								},
								"취소": function () {
									$(this).dialog("close");
								}
							}
						);
					}
					
				});
			});

					function updateTotalPrice() {
						let priceElement = document.getElementById("price");
						let quantityElement = document.getElementById("quantity");
						let saleElement = document.getElementById("sale");
						let discountElement = document.getElementById("discount");
						let totalPriceElement = document.getElementById("totalPrice");

						if (!priceElement || !quantityElement) {
							return;
						}

						let price = parseInt(priceElement.innerText.replace(/[^0-9]/g, ''), 10);
						let quantity = parseInt(quantityElement.value, 10);
						let totalPrice = quantity * price;
						let discount = 0;

						if (saleElement) {
							let salePercentage = parseInt(saleElement.innerText.replace(/[^0-9]/g, ''), 10);
							discount = totalPrice - (totalPrice * (salePercentage / 100));
							if (discountElement) {
								discountElement.innerText = discount.toLocaleString() + '원';
							}
						}

						if (totalPriceElement) {
							totalPriceElement.innerText = totalPrice.toLocaleString() + '원';
						}
					}

					window.onload = updateTotalPrice; // 함수를 직접 할당
					document.getElementById("quantity").addEventListener("input", updateTotalPrice);

					function check() {
						let count = document.getElementById('quantity').value;

						if (${ sessionScope.user != null }) {
							dialog("dialog-confirm",
								"장바구니에 담으시겠습니까?",
								{
									"확인": function () {
										$(this).dialog("close");
										$.ajax({
											url: "?type=cartAdd",
											type: "GET",
											data: {
												pd_idx: "${pvo.pd_idx}",
												pd_cnt: count
											},
											success: function () {
												dialog("dialog-confirm",
													"장바구니에 담았습니다.\n장바구니로 이동하시겠습니까?\n",
													{
														"확인": function () {
															$(this).dialog("close");
															location.href = "?type=cartList";
														},
														"취소": function () {
															$(this).dialog("close");
														}
													}
												);
											},
											error: function () {
												alert("장바구니 추가에 실패했습니다.");
											}
										});
									},
									"취소": function () {
										$(this).dialog("close");
									}
								}
							);
						}else {
							dialog("dialog-confirm",
								"로그인이 필요합니다.\n로그인 페이지로 이동하시겠습니까?\n",
								{
									"확인": function () {
										$(this).dialog("close");
										location.href = "?type=login";
									},
									"취소": function () {
										$(this).dialog("close");
									}
								}
							);

						}
					}
					function questionCheck() {
						<c:choose>
							<c:when test="${sessionScope.user != null}">
								location.href = "?type=questionWrite&us_idx=${sessionScope.user.us_idx}&pd_idx=${sessionScope.pvo.pd_idx}&ct_idx=${sessionScope.pvo.cvo.ct_idx}";
							</c:when>
							<c:otherwise>
								dialog("dialog-confirm",
								"로그인이 필요합니다.\n로그인 페이지로 이동하시겠습니까?\n",
								{
									"확인": function() {
									$(this).dialog("close");
								location.href = "?type=login";
								    },
								"취소": function() {
									$(this).dialog("close");						         
							        }
								  }
								);
							</c:otherwise>
						</c:choose>
					}
					//베스트 최신순 정렬
					function bestList() {
						sortReviews('best');
					}

					function recentList() {
						sortReviews('recent');
					}

					function sortReviews(type) {
						const reviewItems = document.querySelectorAll('.review-item');
						const reviewsArray = Array.from(reviewItems);

						reviewsArray.sort((a, b) => {
							const aData = JSON.parse(a.getAttribute('data-board'));
							const bData = JSON.parse(b.getAttribute('data-board'));

							if (type === 'best') {
								return bData.bo_hit - aData.bo_hit;
							} else if (type === 'recent') {
								return new Date(bData.bo_write_date) - new Date(aData.bo_write_date);
							}
						});

						const reviewContainer = document.querySelector('.review-container');
						reviewContainer.innerHTML = '';
						reviewsArray.forEach(item => reviewContainer.appendChild(item));
					}
					function allQuestion() {
						const questions = document.querySelectorAll('.question');
						questions.forEach(question => {
							question.style.display = 'block';
						});
					}

					function myQuestion() {
						const userId = '${sessionScope.user.us_idx}';
						const questions = document.querySelectorAll('.question');
						questions.forEach(question => {
							const questionUserId = question.getAttribute('data-user-id');
							if (questionUserId === userId) {
								question.style.display = 'block';
							} else {
								question.style.display = 'none';
							}
						});
					}
				</script>
				</body>

				</html>