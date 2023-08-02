<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/bootstrap.min.css">
	<title>WW admin</title>
	<!-- summernote -->
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<script src="/ww/resources/summernote/js/summernote-lite.js"></script>
	<script src="/ww/resources/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="/ww/resources/summernote/css/summernote-lite.css">
	<link rel="stylesheet" href="/ww/resources/summernote/css/font-list.css">
</head>
<body>
<!-- GNB 영역 -->
<nav class="navbar navbar-expand-lg bg-primary" data-bs-theme="dark">
	<div class="container-fluid">
		<a class="navbar-brand" href="#">Welcome Weather admin</a>
		<div class="collapse navbar-collapse" id="navbarColor01">
			<ul class="navbar-nav me-auto">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Community</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/community/category">게시판 관리</a>
						<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/community/list">게시물 관리</a>
						<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/community/notice/list">공지 관리</a>
						<a class="dropdown-item" href="#">댓글 관리</a>
						<a class="dropdown-item" href="#">Something else here</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Separated link</a>
					</div>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">Features</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">Pricing</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">About</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Dropdown</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="#">Action</a>
						<a class="dropdown-item" href="#">Another action</a>
						<a class="dropdown-item" href="#">Something else here</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Separated link</a>
					</div>
				</li>
			</ul>
			<div id="login"></div>
		</div>
	</div>
</nav>
<div class="container" style="margin-top: 75px">
<script type="text/javascript">
const login = document.getElementById("login");
if (localStorage.getItem("login") !== null) {
	login.innerHTML = `
		<button class="btn btn-dark" onclick="logOut()">로그아웃</button>
	`;
} else {
	if (location.href !== "http://localhost:8080/ww/admin") {
	 	alert("로그인 후 이용해주세요.");
		location.href="${pageContext.request.contextPath}/admin";
	}
}

function logOut() {
	if (confirm("로그아웃 하시겠습니까?")) {
		localStorage.removeItem("login");
		alert("로그아웃 되었습니다.");
		location.href="${pageContext.request.contextPath}/admin";
	}
}
</script>