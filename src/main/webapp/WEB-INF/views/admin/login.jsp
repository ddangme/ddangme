<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/layout/header.jsp"%>
<div class="row" style="margin-top: 10%;">
	<div class="col-lg-4"></div>
	<div class="col-lg-4" align="center">
		<form action="${pageContext.request.contextPath}/admin/login" method="post">
				<input type="email" name="id" id="id" class="form-control" placeholder="Enter email">
				<input type="password" name="pw" class="form-control mt-3" placeholder="Password">
				<div align="left" class="mt-3">
					<input class="form-check-input" name="check" type="checkbox" id="flexCheckChecked" checked="">
					<label class="form-check-label" for="flexCheckChecked">
						아이디 기억하기
					</label>
				</div>
				<div class="d-grid">
					<input class="btn btn-primary mt-3" type="button" onclick="loginCheck(this.form)" value="LOGIN">
				</div>
		</form>
	</div>
	<div class="col-lg-4"></div>
</div>
<script>
if (localStorage.getItem("login") !== null) {
	location.href="${pageContext.request.contextPath}/admin/list";
}
if (localStorage.getItem("idCheck") !== null) {
	document.getElementById("id").value = localStorage.getItem("idCheck");
}
function loginCheck(f) {
	if (f.id.value === '') {
		return re_alert("이메일", f.id);
	}
	let regex = new RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
	if (!regex.test(f.id.value)) {
		f.id.focus();
		return alert("이메일 형식으로 입력해주세요.");
	}
	if (f.pw.value === '') {
		return re_alert("비밀번호", f.pw);
	}
	let id = f.id.value;
	let pw = f.pw.value;
	$.ajax({
		url: f.action,
		data: {
			id: id,
			pw: pw
		},
		type: "POST",
		success: function(data) {
			if (data === "") {
				alert("로그인에 실패하였습니다.");
			}
			else {
				if (f.check.checked) {
					localStorage.setItem("idCheck", f.id.value);
				} else {
					localStorage.removeItem("idCheck");
				}
 				localStorage.setItem("login", data);
				location.href="${pageContext.request.contextPath}/admin/list";
			}
		},
		error: function(data) {
			alert("로그인에 실패하였습니다.\n계속될 경우 관리자에게 문의해주세요.");
		}
	});
}
function re_alert(word, e) {
	alert(word + "을(를) 입력해주세요.");
	e.focus();
}
</script>


</div>
</body>
</html>