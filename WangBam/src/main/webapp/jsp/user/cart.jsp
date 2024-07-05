<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<%@include file="/jsp/common/header.jsp" %>
			<style>
				.count {
					font-size: large;
				}

				.summary {
					text-align: center;
					font-size: 20px;
					margin-top: 20px;
					background-color: #f9eeb0;
					border-radius: 10px;
					border: 4px solid #8b5228;
					height: 150px;
					display: flex;
					align-items: center;
					justify-content: space-around;
				}
			</style>
			<div class="btn_div" style="display: flex; margin-bottom:10px; ">
			<h2><a href="?type=cartList">장바구니</a></h2>
			<div style="display:flex; gap:5px; position: absolute; right:10px">
				<button id="delete_Btn" class="btn submit">선택상품삭제</button>
				<button id="deleteAll_Btn" class="btn cancel">장바구니비우기</button>
			</div>
			</div>
			<table class="table1">
				<thead>
					<colgroup>
						<col width="130px">
						<col>
						<col width="340px">
						<col width="150px">
						<col width="100px">
						<col width="150px">
						<col width="160px">
					</colgroup>
					<tr>
						<th><input type="checkbox" class="allCheckbox" onclick="allCheck()" checked /> 모두선택</th>
						<th>이미지</th>
						<th>상품명</th>
						<th>가격</th>
						<th>수량</th>
						<th>합계</th>
						<th>삭제</th>
					</tr>
				</thead>

				<tbody>
					<c:if test="${cvo != null}">
						<% int index=0; %>
							<c:forEach var="vo" items="${cvo}">
								<form action="/WangBam/?type=buy" method="get">
									<tr class="item" style="font-size: 16px">
										<td><input type="checkbox" class="checkbox" value="<%= index++ %>" checked />
										</td>
										<c:if test="${vo.pvo.pd_thumbnail_img ne ''}">
											<td><img src="./img/${vo.pvo.pd_thumbnail_img}" width="100"></td>
										</c:if>
										<c:if test="${vo.pvo.pd_thumbnail_img eq ''}">
											<td><img src="https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg"
													width="100"></td>
										</c:if>
										<td>${vo.pvo.pd_name}</td>
										<td class="price">${vo.pvo.pd_price}원</td>
										<td>
											<input type="hidden" name="type" value="cartList" />
											<input type="hidden" name="p_num" value="${vo.pvo.pd_idx}" />
											<input type="hidden" name="c_num" value="${vo.ca_idx}" class="ca_idx" />
											<input type="number" class="count" name="count" value="${vo.ca_cnt}" min="1"
												max="${vo.pvo.pd_cnt}" onchange="handleInputChange(this)" />

										</td>
										<td class="total_price">${vo.pvo.pd_price * vo.ca_cnt}원</td>
										<td>
											<button type="button" class="btn cancel" id="cancel_Btn" onclick="javascript:dialog('dialog-confirm', '삭제하시겠습니까?', {
						            '확인': function() {
						                $(this).dialog('close');
						                location.href='?type=cartDelete&us_idx=${vo.us_idx}&ca_idx=${vo.ca_idx}';
						            },
						            '취소': function() {
						                $(this).dialog('close');
						            }
						        });">삭제</button>
										</td>
									</tr>
								</form>
							</c:forEach>
					</c:if>
					<c:if test="${cvo == null}">
						<tr class="no_item">
							<td colspan="7"><b>장바구니가 비었습니다.</b></td>
						</tr>
					</c:if>
				</tbody>
			</table>

			<div class="summary">
				<div>
					<h4 style="margin-bottom: 30px;">장바구니 상품</h4>
					<div style="display: flex; justify-content: space-around;"><img src="./img/cart.png" width="32"
							height="32">
						<span style="margin-right:20px">${fn:length(cvo)} 개</span>
					</div>
				</div>

				<div>
					<h4 style="margin-bottom: 30px;">합계금액</h4>
					<div style="display: flex; gap:8px; align-items: center;"><img src="./img/dollar.png" width="32"
							height="32">
						<span id="totalSum">0</span>
					</div>
				</div>
			</div>
			<br />
			<div class="btn_div">
				<button id="order_Btn" class="btn submit">선택한 상품 주문</button>
			</div>
			<div id="dialog-confirm" class="dialog" style="display: none">
				<p></p>
			</div>

			<%@include file="/jsp/common/footer.jsp" %>

				<script>
					//수량 입력 유효성 검사 및 최대수량 제한
					function handleInputChange(input) {
						let max = parseInt(input.max);
						let value = parseInt(input.value);
						if (value > max) {
							alert('수량이 많습니다. 최대 수량은 ' + max + '개입니다.');
							input.value = max;
						}
						if (input.value === "" || input.value == 0) {
							input.value = 1;
						}
						calculateTotal(input);
					}
					//개별 상품 금액
					function calculateTotal(countElement) {
						let row = countElement.closest('tr');
						let price = parseInt(row.querySelector('.price').textContent);
						let count = parseInt(countElement.value);
						if (isNaN(count)) {
							count = 1;
						}
						let total = price * count;
						row.querySelector('.total_price').textContent = total + "원";
						calculateTotalSum();
					}
					//총액 계산
					function calculateTotalSum() {
						let totalSum = 0;
						document.querySelectorAll('.total_price').forEach(function (totalElement) {
							totalSum += parseInt(totalElement.textContent);
						});
						document.getElementById('totalSum').textContent = totalSum + "원";
					}

					// 페이지 로드 시 총합 계산
					document.addEventListener("DOMContentLoaded", function () {
						calculateTotalSum();
					});

					$(document).ready(function () {
						//장바구니 리스트 선택 삭제
						$("#delete_Btn").on('click', function () {
							dialog("dialog-confirm", "선택된 상품을 삭제하시겠습니까?", {
								"확인": function () {
									$(this).dialog("close");
									var ca_idx_array = [];
									$(".checkbox:checked").each(function () {
										var $row = $(this).closest('tr');
										var ca_idx = $row.find('.ca_idx').val();
										ca_idx_array.push(ca_idx);
									});
									if (ca_idx_array.length > 0) {
										$.ajax({
											url: '?type=cartselectDelete', // 수정된 서버의 URL
											type: 'POST',
											data: {
												ca_idx_list: ca_idx_array
											},
											traditional: true,
											success: function (response) {
												dialog("dialog-confirm", "선택된 장바구니가 삭제되었습니다.", {
													"확인": function () {
														$(this).dialog("close");
														location.reload(); // 성공 후 페이지 새로고침
													}
												});
											},
											error: function () {

												alert('장바구니 삭제에 실패했습니다.');
											}
										});
									} else {
										alert('삭제할 상품을 선택하세요.');
									}
								},
								"취소": function () {
									$(this).dialog("close");
								}
							});
						});

						//장바구니 모두 비우기
						$("#deleteAll_Btn").on('click', function () {
							dialog("dialog-confirm", "비우시겠습니까?", {
								"확인": function () {
									$(this).dialog("close");
									var ca_idx_Array = [];

									// 모든 class="ca_idx" 요소를 선택하고, 각 요소의 값을 배열에 추가합니다.
									$(".ca_idx").each(function () {
										var ca_idx = $(this).val(); // 각 요소의 값을 가져옵니다.
										ca_idx_Array.push(ca_idx); // 값을 배열에 추가합니다.
									});
									if (ca_idx_Array.length > 0) {
										$.ajax({
											url: '?type=cartallDelete',
											type: 'POST',
											data: {
												ca_idx_list: ca_idx_Array
											},
											traditional: true,
											success: function (response) {
												dialog("dialog-confirm", "장바구니가 비워졌습니다.", {
													"확인": function () {
														$(this).dialog("close");
														location.reload(); // 성공 후 페이지 새로고침
													},
												});
											},
											error: function () {
												dialog("dialog-confirm", "장바구니가 비우는데 실패했습니다.", {
													"확인": function () {
														$(this).dialog("close");
													},
												});
											}
										});
									} else {
										alert('장바구니가 이미 비워져있습니다.');
									}
								},
								"취소": function () {
									$(this).dialog("close");
								}
							});
						});

						//선택한 상품 주문하기
						$("#order_Btn").on('click', function () {
							dialog("dialog-confirm", "주문하시겠습니까?", {
								"확인": function () {
									$(this).dialog("close");
									if ($('.checkbox:checked').length == 0) {
										dialog("dialog-confirm", "상품을 선택해주세요.", {
											"확인": function () {
												$(this).dialog("close");
											}
										});
									} else {
										// 1. 선택한 체크박스에서 인덱스 가져오기
										let selectItem = $(".checkbox:checked")

										let indexArray = [];
										let cntArray = [];
										let totalArray = [];
										let cartIdxArray = [];

										for (let i = 0; i < selectItem.length; i++) {
											let index = selectItem[i].value;
											indexArray.push(index);
											let cnt = $(".count")[index].value;
											cntArray.push(cnt);
											let total = $(".total_price")[index].innerText.slice(0, -1);
											totalArray.push(total);
											let cart = $(".ca_idx")[index].value;
											cartIdxArray.push(cart);
										}

										const data = {
											index: indexArray,
											cnt: cntArray,
											total: totalArray,
											cart: cartIdxArray
										}

										$.ajax({
											url: '/WangBam/?type=buy&buy=cart',
											type: 'POST',
											contentType: 'application/json',
											data: JSON.stringify(data),
											success: function (response) {
												location.replace("/WangBam/?type=buy");
											},
											error: function (request, status, error) {
											}
										});
									}
								},
								"취소": function () {
									$(this).dialog("close");
								}
							});
						});
					});

					//체크박스 기능
					$(".checkbox").on('click', function () {
						let check = false;
						let checkAll = $(".checkbox").prop('checked');
						if (!checkAll) {
							check = false;
						} else {
							for (let i = 0; i < $(".checkbox").length; i++) {
								if ($(".checkbox")[i].checked == false) {
									check = false;
									break;
								} else {
									check = true;
								}
							}
						}
						$(".allCheckbox").prop('checked', check);
					});

					//모두선택
					function allCheck() {
						if ($('.allCheckbox').is(':checked')) { // 선택자와 메서드 사용 수정
							$('.checkbox').prop('checked', true); // 모든 개별 체크박스를 체크 상태로 설정
						} else {
							$('.checkbox').prop('checked', false); // 모든 개별 체크박스를 체크 해제 상태로 설정
						}
					}
					$('input[type="number"]').keydown(function (e) {   // input 태그의 text 타입에 키다운 이벤트라면
						if (e.keyCode === 13) {   // 엔터키 이벤트라면
							e.preventDefault();   // submit을 막아라.
						};
					});

					//dialog
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



				</script>