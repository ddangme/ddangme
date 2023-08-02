<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- jstl -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Welcome Weather</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/common/images/CleanLogo.png" type="image/x-icon">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/custom.min.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<style>
  		@import url('https://fonts.googleapis.com/css2?family=Poor+Story&display=swap');
	</style>
	<script type="text/javascript">
		function logout() {
			if (confirm("로그아웃 하시겠습니까?")) {
				location.href="${pageContext.request.contextPath}/customer/logout";
			}
		}
	</script>
</head>
<body>

<!-- GNB 영역 시작 -->
<nav class="navbar navbar-expand-lg fixed-top bg-primary" data-bs-theme="dark">
	<div class="container-fluid">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/">
			<img src="${pageContext.request.contextPath}/resources/common/images/CleanLogo.png" id="logo" style="height: 40px">&nbsp;
			Welcome Weather
		</a>
		<div class="collapse navbar-collapse" id="navbarColor01">
			<ul class="navbar-nav me-auto">
				<li class="nav-item">
					<a class="nav-link active" href="${pageContext.request.contextPath}/">Home</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="${pageContext.request.contextPath}/community">Community</a>
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
			<!-- 로그아웃 상태 -->
			<c:if test="${login == null}">
				<input type="button" onclick="location.href='${pageContext.request.contextPath}/customer/loginform'" class="btn btn-primary" style="font-family: 'Poor Story', cursive;" value="로그인">&nbsp;
			</c:if>
			<!-- 로그인 상태 -->
			<c:if test="${login != null}">
				<img src="${login.profile}" style="width: auto; height: 30px; border-radius: 20%">
				<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
					<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
						<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown" style="font-family: 'Poor Story', cursive;">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/customer/myPage">마이페이지</a></li>
							<li><a class="dropdown-item" href="">Activity Log</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item" href="javascript:logout()">로그아웃</a></li>
						</ul>
					</li>
				</ul>
			</c:if>
		</div>
	</div>
</nav>
<!-- GNB 영역 끝 -->
<!-- 본문 영역 시작 -->
<div class="container">
