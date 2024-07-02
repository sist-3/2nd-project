<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="/jsp/common/header.jsp"%>
<c:set var="p_ar" value="${requestScope.p_ar}" />
<div class="search-group">
    <h2>상품 리스트</h2>
    <form class="search-bar">
        <select name="productPerBlock" id="productPerBlock">
            <option value="6">6개씩 보기</option>
            <option value="12">12개씩 보기</option>
            <option value="18">18개씩 보기</option>
        </select>
        <select name="ct_idx" id="ct_idx">
            <option>전체</option>
            <c:forEach var="cvo" items="${requestScope.c_list}" varStatus="st">
                <option value="${cvo.ct_idx}">${cvo.ct_name}</option>
            </c:forEach>
        </select>
        <input type="text" id="searchProductName" name="searchValue" placeholder="Search..." />
        <button type="button" class="btn search" id="searchBtn"></button>
    </form>
</div>
<div class="product-list" id="productList">
    <div class="item-list">
        <c:forEach var="product" items="${p_ar}" varStatus="i">
            <div class="item">
                <div class="img-box">
                    <a href="?type=productDetail&pd_idx=${product.pd_idx}"> <img
                        src="${pageContext.request.contextPath}/img/${product.pd_thumbnail_img}"
                        alt="${product.pd_name}">
                    </a>
                </div>
                <p>[왕밤빵 베이커리]${product.pd_name}</p>
                <p>${product.pd_price}만원</p>
            </div>
        </c:forEach>
    </div>
</div>

<div class="pagination" id="pagination">
    <c:set var="paging" value="${requestScope.paging}" />
    <c:choose>
        <c:when test="${paging.startPage >= paging.pagePerBlock }">
            <div>
                <a href="javascript:void(0);" onclick="changePage(${paging.nowPage - paging.pagePerBlock})">&lt;</a>
            </div>
        </c:when>
        <c:when test="${paging.startPage < paging.pagePerBlock }">
            <div class="disable">&lt;</div>
        </c:when>
    </c:choose>
    <c:forEach begin="${paging.startPage }" end="${paging.endPage}"
        varStatus="st">
        <c:choose>
            <c:when test="${paging.nowPage != st.index }">
                <div>
                    <a href="javascript:void(0);" onclick="changePage(${st.index})">${st.index}</a>
                </div>
            </c:when>
            <c:when test="${paging.nowPage == st.index }">
                <div class="on">
                    <a href="javascript:void(0);" onclick="changePage(${st.index})">${st.index}</a>
                </div>
            </c:when>
        </c:choose>
    </c:forEach>
    <c:if test="${paging.endPage < paging.totalPage}">
        <c:if test="${paging.nowPage + paging.pagePerBlock > paging.totalPage }">
            <div>
                <a href="javascript:void(0);" onclick="changePage(${paging.totalPage})">&gt;</a>
            </div>
        </c:if>
        <c:if test="${paging.nowPage + paging.pagePerBlock <= paging.totalPage }">
            <div>
                <a href="javascript:void(0);" onclick="changePage(${paging.nowPage + paging.pagePerBlock})">&gt;</a>
            </div>
        </c:if>
    </c:if>
    <c:if test="${paging.endPage >= paging.totalPage }">
        <div class="disable">&gt;</div>
    </c:if>
</div>

<%@include file="/jsp/common/footer.jsp"%>

<script>
    $(function() {
        $("#searchBtn").on('click', function() {
            loadProductList(1);
        });
    });

    function loadProductList(page) {
        const searchValue = $("#searchProductName").val();
        const productPerBlock = $("#productPerBlock").val();
        const ct_idx = $("#ct_idx").val();
        const param = {
            "type": "productList",
            "searchValue": searchValue,
            "productPerBlock": productPerBlock,
            "ct_idx": ct_idx,
            "cPage": page
        };
        $.ajax({
            url: "?", // 올바른 서블릿 경로를 지정하세요.
            type: "GET",
            data: param,
            dataType: "html"
        }).done(function(res) {
            const newProductList = $(res).find("#productList").html();
            const newPagination = $(res).find("#pagination").html();
            $("#productList").html(newProductList);
            $("#pagination").html(newPagination);
        });
    }

    function changePage(page) {
        loadProductList(page);
    }
</script>
</body>
</html>
