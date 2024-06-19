<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/jsp/common/header.jsp" %>

  <div>
    <section class="brand-box">
      <h2>브랜드 소개</h2>
      <img src="${pageContext.request.contextPath}/img/logo.png" width="150px" />
      <p>우리 왕밤빵집은 신선한 재료와 정성을 담아 맛있는 빵을 제공합니다. 저희는 최고의 품질과 고객 만족을 위해 최선을 다하고 있습니다.
      </p>

    </section>

    <section class="brand-box">
      <h2 class="brand-title">전국 매장 위치</h2>
      <div id="map" style="width:100%;height:350px;"></div>
    </section>
  </div>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4b2bd8e5311076ad1b804214b8e7ed96"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.49992, 127.0331), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(37.49992, 127.0331); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
// marker.setMap(null);    
</script>


<%@include file="/jsp/common/footer.jsp" %>