<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/customer/layout/header.jsp"%>
<div class="row">
	<!-- LNB 영역 -->
	<div class="col-lg-2">
		<c:if test="${login == null}">
			<div class="alert alert-dismissible alert-secondary">
				<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
				<strong class="text-danger">알림!</strong><p style="font-family: 'Poor Story', cursive;">로그인하면 더 즐거운 커뮤니티 활동을 할 수 있습니다! <a href="${pageContext.request.contextPath}/customer/loginform" class="alert-link">여기</a>를 클릭하면 로그인 페이지로 이동합니다!</p>
			</div>
		</c:if>
		<div class="accordion" id="accordionExample">
			<c:if test="${login != null}">
				<div class="accordion-item">
					<div class="accordion-body">
						<div class="row">
							<div align="center"><img src="${login.profile}" style="width:80px; height: 80px; object-fit: cover; border-radius: 50%;"><br><br></div>
							<div class="col-lg-3" align="center">
								<img src="${pageContext.request.contextPath}/resources/common/images/write.svg">
								0
							</div>
							<div class="col-lg-3" align="center">
								<img src="${pageContext.request.contextPath}/resources/common/images/comment.svg">
								0
							</div>
							<div class="col-lg-3" align="center">
								<img src="${pageContext.request.contextPath}/resources/common/images/good.svg">
								0
							</div>
							<div class="col-lg-3" align="center">
								<img src="${pageContext.request.contextPath}/resources/common/images/bad.svg">
								0
							</div>
						</div>
						<br>
						<div class="row">
							<button onclick="location.href='${pageContext.request.contextPath}/community/writeForm'" class="btn btn-dark" style="font-family: 'Poor Story', cursive;">글쓰기</button>
						</div>
					</div>
				</div>
			</c:if>
			<!-- 유지보수 가능하도록 관리자페이지에서 관리해야함 -->
			<div class="accordion-item">
				<div class="accordion-body">
					<table class="table table-hover" style="font-family: 'Poor Story', cursive;">
						<tbody>
							<tr class="table-light">
								<td style="cursor: pointer;"><a href="${pageContext.request.contextPath}/community/" class="list-group-item list-group-item-action">전체 게시물</a></td>
							</tr>
							<c:forEach var="category" items="${categoryList}">
								<tr class="table-light">
									<td style="cursor: pointer;"><a href="${pageContext.request.contextPath}/community/category/${category.link}" class="list-group-item list-group-item-action">${category.name}</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="col-lg-10">
<script type="text/javascript">
// 등록하기
function writeForm() {
	var url = "${pageContext.request.contextPath}/community/writeForm";
	var param = "";
	sendRequest(url, "", ListResultFn, "POST");
}

function ListResultFn() {
	if (xhr.readyState == 4 & xhr.status == 200) {
		$("#main").load(location.href + " #main");	
	}
}
</script>
	