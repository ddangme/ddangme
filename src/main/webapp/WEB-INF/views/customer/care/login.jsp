<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- jstl -->
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/customer/layout/header.jsp"%>
<div align="center">
	<div class="card border-primary mb-3" style="max-width: 20rem;">
		<!-- 
		<div class="card-header"><h3>로그인</h3></div>
		 -->
		<div class="card-body">
			<div class="row">
				<a href="javascript:loginWithKakao();">
					<img src="${pageContext.request.contextPath}/resources/common/images/KakaoLogin.png" style="cursor: pointer; width:100%; height:auto; padding:12px 38px">
				</a>
				<div id="naver_id_login"></div>
			</div>
				<!-- 
				<label class="col-form-label mt-4" for="inputDefault">Default input</label>
				<input type="text" class="form-control" placeholder="Default input" id="inputDefault">
				<label for="exampleInputPassword1" class="form-label mt-4">Password</label>
				<input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
				-->
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/customer/layout/footer.jsp"%>

<!-- 카카오 로그인 sdk -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/v1/kakao.js"></script>
<!-- 네이버 로그인 sdk -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<script type="text/javascript">
// 네이버 로그인 시작
	var naver_id_login = new naver_id_login("Lb3ScB7tikUPFJsakcNZ", "http://localhost:8080/ww/customer/naverLoginForm");
  	var state = naver_id_login.getUniqState();
  	naver_id_login.setButton("green", 3, 40);
  	naver_id_login.setDomain("https://localhost:8080/ww");
  	naver_id_login.setState(state);
  	naver_id_login.setPopup();
  	naver_id_login.init_naver_id_login();
// 네이버 로그인 끝

  	
// 카카오 로그인 시작
Kakao.init('af396612138dea0fea27a5a396dfe92c'); // 사용하려는 앱의 JavaScript 키 입력
function loginWithKakao() {
	window.Kakao.Auth.login({
		scope:'	profile_nickname, profile_image, account_email, gender, age_range',
		success: function(authObj) {
			window.Kakao.API.request({
				url:'/v2/user/me',
				success: res => {
					const kakao_account = res.kakao_account;
					console.log(kakao_account);
					no = res.id;
					name = kakao_account.profile.nickname;
					console.log(name);
					age_group = kakao_account.age_range;
					email = kakao_account.email;
					gender = kakao_account.gender;
					profile = kakao_account.profile.profile_image_url;
					location.href="${pageContext.request.contextPath}/customer/kakaoLogin?no=" + no + "&age_group=" + age_group + "&email=" + email + "&gender=" + gender + "&profile=" + profile + "&name=" + name;
				}
			});
		}
	});
}
// 카카오 로그인 끝
</script>