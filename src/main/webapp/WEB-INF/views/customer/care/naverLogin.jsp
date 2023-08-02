<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- jstl -->
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/customer/layout/header.jsp"%>
<%@ include file="/WEB-INF/views/customer/layout/footer.jsp"%>

<!-- 네이버 로그인 sdk -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<script type="text/javascript">
// 네이버 로그인 시작
	var naver_id_login = new naver_id_login("Lb3ScB7tikUPFJsakcNZ", "http://localhost:8080/ww/customer/naverLogin");
// 네이버 사용자 프로필 조회
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
function naverSignInCallback() {
	no = naver_id_login.getProfileData('id')
	name = naver_id_login.getProfileData('name');
	email = naver_id_login.getProfileData('email');
	age_group = naver_id_login.getProfileData('age');
	profile = naver_id_login.getProfileData('profile_image');
	gender = naver_id_login.getProfileData('gender');
	window.close(); // 현재 팝업 닫기
	// 기존 화면 페이지 이동
	opener.parent.location.href="${pageContext.request.contextPath}/customer/naverLogin?no=" + no + "&age_group=" + age_group + "&email=" + email + "&gender=" + gender + "&profile=" + profile + "&name=" + name;
}

</script>