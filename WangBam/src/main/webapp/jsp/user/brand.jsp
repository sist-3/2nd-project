<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/jsp/common/header.jsp" %>

  <div class="brand-main">
    <section class="brand-box">
      <h1>WangBam Bakery</h1>
      <img src="${pageContext.request.contextPath}/img/logo.png" width="150px" />
      <p>WangBam Bakery에 오신 것을 환영합니다. <br>
      저희 빵집은 매일 아침 신선한 재료로 정성껏 구워낸 다양한 종류의 빵을 제공하고 있습니다.<br>
      클래식한 분위기 속에서 갓 구운 크루아상, 바게트, 브리오슈 등 전통적인 유럽 스타일의 빵을 맛보실 수 있습니다. <br>
      따뜻한 커피 한 잔과 함께 여유로운 시간을 즐기세요.
      </p>

    </section>

    <section class="brand-box">
      <h2 class="brand-title">찾아오시는 길</h2>
      <div id="map" style="width:100%;height:350px;"></div>
      <p>
      	Address: 서울특별시 강남구 테헤란로 132(역삼동) <br>
      	대중교통: 역삼역 3번 출구에서 203m
      </p>
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