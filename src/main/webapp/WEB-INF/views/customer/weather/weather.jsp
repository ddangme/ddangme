<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/customer/layout/header.jsp"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=af396612138dea0fea27a5a396dfe92c&libraries=services"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/common/js/httpRequest.js"></script>
<!-- kakao 날씨 -->
<div class="row">
	<div class="col-lg-4" style="font-family: 'Poor Story', cursive;">
		<div class="d-grid gap-2">
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
				<input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked>
				<label class="btn btn-outline-primary" for="btnradio1">현재 위치</label>
				<input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off">
				<label class="btn btn-outline-primary" for="btnradio2">위치 선택</label>
			</div>
			<div class="row" style="display: none" id="address_area">
				<div class="col-lg-4">
					<select id="depth1" class="form-select" style="font-family: 'Poor Story', cursive;">
						<option>시/도</option>
						<c:forEach var="depth" items="${depth1}">
							<option value="${depth}">${depth}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-lg-4">
					<select id="depth2" class="form-select" style="font-family: 'Poor Story', cursive;">
						<option>구/군</option>
					</select>
				</div>
				<div class="col-lg-4">
					<select id="depth3" class="form-select" style="font-family: 'Poor Story', cursive;">
						<option>읍/면/동</option>
					</select>
				</div>
			</div>
			<button class="btn btn-lg btn-primary" type="button" id="current_search">현재 위치 탐색</button>
			<div id="map" style="height: 400px; display: flex; align-items: center; justify-content: center; pointer-events: none;">
				<p class="text-body-tertiary" id="tool">현재 위치 탐색 버튼을 클릭해 주세요!</p>
			</div>
		</div>
	</div>
	<div class="col-lg-8" style="font-family: 'Poor Story', cursive;">
		<div class="card mb-3">
			<h3 class="card-header" id="weather_title">날씨</h3>
			<div class="card-body">
				<h5 class="card-title">Special title treatment</h5>
				<h6 class="card-subtitle text-muted">Support card subtitle</h6>
			</div>
			<!-- <svg xmlns="http://www.w3.org/2000/svg" class="d-block user-select-none" width="100%" height="200" aria-label="Placeholder: Image cap" focusable="false" role="img" preserveAspectRatio="xMidYMid slice" viewBox="0 0 318 180" style="font-size:1.125rem;text-anchor:middle">
				<rect width="100%" height="100%" fill="#868e96"></rect>
				<text x="50%" y="50%" fill="#dee2e6" dy=".3em">Image cap</text>
			</svg> -->
			<div class="card-body">
				<p class="card-text" id="weather_data"></p>
			</div>
			<ul class="list-group list-group-flush">
				<li class="list-group-item">Cras justo odio</li>
				<li class="list-group-item">Dapibus ac facilisis in</li>
				<li class="list-group-item">Vestibulum at eros</li>
			</ul>
			<div class="card-body">
				<a href="#" class="card-link">Card link</a>
				<a href="#" class="card-link">Another link</a>
			</div>
			<div class="card-footer text-muted">
				2 days ago
			</div>
		</div>
		<div id="result">
		
		</div>
	</div>
</div>
<!-- [1] 현재 위치, 오늘 날씨 기준으로 추천할 경우
현재 위치 가져오기 성공하면 지도 노출안하고,
실패하면 지도 노출하여 현재 위치 검색하여 지정하도록 설정

[2] 특정 지역 검색 후 며칠 이내의 날씨로 추천할 경우 -->

<!-- 
[1]. 위치 선택에서 위치 선택 시 아래 카카오 맵의 위치를 변경하도록
[2]. 현재 위치 확인 시 영역이 표시되도록 (읍/면/동 기준으로)

 -->

<!-- 지역 데이터 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/customer/js/map.js"></script>
<script type="text/javascript">

</script>
<%@ include file="/WEB-INF/views/customer/layout/footer.jsp"%>