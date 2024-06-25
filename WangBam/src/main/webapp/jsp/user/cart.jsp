<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="/jsp/common/header.jsp"%>


        <table class="table1">
            <thead>
                <tr>
                    <th>선택</th>
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
                    <c:forEach var="vo" items="${cvo}" varStatus="vs">
                    
                                <form action="" method="post">
                        <tr class="item">
                            <td><input type="checkbox" /></td>
                            <td>getImage</td>
                            <td>${vo.pvo.pd_name}</td>
                             <td id="price_${vs.index}">${vo.pvo.pd_price}</td>
                            <td>
                                    <input type="hidden" name="p_num" value="${vo.pvo.pd_idx}" />
                                    <input type="number"  id="cnt" name="count" value="${vo.ca_cnt}" min="1" />
                                    <button type="button" id="countPlus_btn" class="btn" onclick="decrease(this.form)">▽</button>
                                    <button type="button" id="countMinus_btn" class="btn" onclick="increase(this.form)">△</button>
                            </td>
                            
                            <td>${vo.pvo.pd_price * vo.ca_cnt}</td>
                            <td><button type="button" class="btn cancel">삭제</button></td>
                        </tr>
						</form>
					</c:forEach>
                </c:if>

                <c:if test="${cvo == null}">
                    <tr class="no_item">
                        <td colspan="7">
                            <b>장바구니가 비었습니다.</b>
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <div class="btn_div">
            <button class="btn submit">선택상품삭제</button>
            <button class="btn cancel">장바구니비우기</button>
        </div>
        <div>
            <div>상품갯수 : ${vo.ca_cnt}</div>
            <div>합계금액 : $</div>
        </div>
        <br />
        <div class="btn_div">
            <button class="btn submit">선택한 상품 주문</button>
        </div>
   
    <%@include file="/jsp/common/footer.jsp"%>
    <script>
    function increase(form) {
        let cntElement = form.count; // 첫 번째 count 요소를 가져옵니다.
        let currentCount = parseInt(cntElement.value, 10); // 현재 값을 정수로 변환합니다.
        cntElement.value = currentCount + 1; // 값을 증가시킵니다.
    }

    function decrease(form) {
        let cntElement = form.count; // 첫 번째 count 요소를 가져옵니다.
        let currentCount = parseInt(cntElement.value, 10); // 현재 값을 정수로 변환합니다.
        if (currentCount > 1) { // 최소값 1을 유지합니다.
            cntElement.value = currentCount - 1; // 값을 감소시킵니다.
        }
    }	
    
  
</script>

