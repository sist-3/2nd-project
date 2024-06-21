<%@page import="mybatis.vo.AddressVO"%>
<%@page import="mybatis.vo.OrderDetailVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제페이지</title>
    <link rel="stylesheet" href="/css/style.css">
</head>

<body>
    <%-- 
        받아야할 정보
        1. 구매할 상세 주문 리스트 => List<order_detail> 
           -> productVO, 수량, 내부 정보 상품 계산 후 가격
     --%>
    <% 
        Object obj = request.getAttribute("odvoList");
        List<OrderDetailVO> odvoList = null;
        if(obj == null) {
            %>
            <script>
                alert("잘못된 접근입니다. \n 메인페이지로 이동합니다.");
            </script>    
            <%
            response.sendRedirect("/");
        } else {
            odvoList = (List<OrderDetailVO>)obj;
        }
    %>
    <div class="buy-con">
        <h1>결제페이지</h1>
        <table class="order-table">
            <thead>
                <tr>
                    <th>이미지</th>
                    <th>상품정보</th>
                    <th>판매가</th>
                    <th>수량</th>
                    <th>적립금</th>
                    <th>배송구분</th>
                    <th>배송비</th>
                    <th>합계</th>
                </tr>
            </thead>
            <tbody>
                <% 
                int totalPrice = 0;
               	for(OrderDetailVO odvo : odvoList) {
               		int price = 0;
               		totalPrice += Integer.parseInt(odvo.getOd_price());
                %>
                <tr>
                    <td><img src="<%=odvo.getPvo().getPd_thumbnail_img()%>"></td>
                    <td><%=odvo.getPvo().getPd_name()%></td>
                    <td><%=Integer.parseInt(odvo.getOd_price()) / Integer.parseInt(odvo.getOd_cnt())%></td>
                    <td><%=odvo.getOd_cnt()%></td>
                    <td>-</td>
                    <td>기본배송</td>
                    <td>착불(수령인)</td>
                    <td><%= odvo.getOd_price() %></td>
                </tr>
                <% } %>
                <tr>
                    <td colspan="8">상품구매금액 <%=totalPrice %>+ 배송비 4000 = 합계 : <%=totalPrice+4000%>원</td>
                </tr>
            </tbody>
        </table>
        <div class="delivery-info">
            <h2>배송 정보</h2>
            <br>
            <form class="form-group">
                <label for="postcode">주소찾기</label>
                <div class="address-group">
                    <input type="text" id="postcode" name="postcode" <c:if test="${avo != null}">value="${avo.getAd_postal_code()}"</c:if> placeholder="우편번호">
                    <button type="button">우편번호</button>
                </div>
                <input type="text" class="address-input" name="address1" <c:if test="${avo != null}">value="${avo.getAd_addr()}"</c:if> placeholder="기본주소"/>
                <input type="text" class="address-input2" name="address2" <c:if test="${avo != null}">value="${avo.getAd_addr_detail()}"</c:if> placeholder="상세주소"/>
                <label for="phone">휴대폰</label>
                <div class="phone-input">
                    <select name="phone1">
                        <option value="010">010</option>
                        <!-- Add more options as needed -->
                    </select>
                    <span>-</span>
                    <input type="text" name="phone2" <c:if test="${avo != null}">value="${avo.getAd_tel().substring(2,6)}"</c:if>>
                    <span>-</span>
                    <input type="text" name="phone3" <c:if test="${avo != null}">value="${avo.getAd_tel().substring(6)}"</c:if>>
                </div>
                <label for="email">이메일</label>
                <input type="email" id="email" name="email">
                <label for="message">배송시요구사항</label>
                <select id="message" name="message">
                    <option value="">배송메모를 선택해주세요</option>
                    <option value="1">문 앞에 놓아주세요</option>
                    <option value="2">부재 시 연락 부탁드려요</option>
                    <option value="3">배송 전 미리 연락해 주세요</option>
                </select>

                <div class="payment">
                    <h2>결제수단</h2>
                    <label><input type="radio" name="payment" value="account"> 무통장 입금</label>
                    <label><input type="radio" name="payment" value="card"> 카드 결제</label>

                </div>
                <div class="total">
                    <p>총 결제금액</p>
                    <p class="total-amount"><%=totalPrice+4000 %> 원</p>
                </div>
                <button type="button" class="final-btn">결제하기</button>
            </form>
        </div>
    </div>
    <script src="/js/ui.js"></script>
</body>

</html>