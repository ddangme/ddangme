<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/customer/community/layout/header.jsp"%>


<div class="card mb-3">
	<div class="card-body">
		<c:forEach var="category" items="${categoryList}">
			<c:if test="${vo.category_no == category.no}">
				<h6 class="card-subtitle text-muted">[${category.name}]</h6>
			</c:if>
		</c:forEach>
		<h5 class="card-title">${vo.title}</h5>
		<h6>
			${vo.name}
			&nbsp;&nbsp;&#124;&nbsp;&nbsp;
			${vo.insert_date}
			&nbsp;&nbsp;&#124;&nbsp;&nbsp;
			<img src="${pageContext.request.contextPath}/resources/common/images/hit.svg">
			&nbsp;${vo.hit}
		</h6>
		<div align="right">
		</div>
	<hr>
	<!--
 	<svg xmlns="http://www.w3.org/2000/svg" class="d-block user-select-none" width="100%" height="200" aria-label="Placeholder: Image cap" focusable="false" role="img" preserveAspectRatio="xMidYMid slice" viewBox="0 0 318 180" style="font-size:1.125rem;text-anchor:middle">
		<rect width="100%" height="100%" fill="#868e96"></rect>
		<text x="50%" y="50%" fill="#dee2e6" dy=".3em">Image cap</text>
	</svg>
	-->
		<c:if test="${login.no == writer.no}">
			<div align="right">
				<a href="javascript:updateCommunity()" class="card-link" style="font-family: 'Poor Story', cursive;">수정</a>
				<a href="javascript:deleteCommunity()" class="card-link" style="font-family: 'Poor Story', cursive;">삭제</a>
			</div>
		</c:if>
		${vo.content}
		<div>
			<c:forEach var="img" items="${imgVo}">
				<img src="${pageContext.request.contextPath}/resources/community/${vo.no}/${img.image}">
			</c:forEach>
		</div>
		<div align="center">
			<button type="button" class="btn btn-danger"><img src="${pageContext.request.contextPath}/resources/common/images/good.svg"></button>
			<button type="button" class="btn btn-info"><img src="${pageContext.request.contextPath}/resources/common/images/bad.svg"></button>
		</div>
	</div>
	<div class="card-footer text-muted">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">Card title</h4>
				<h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
				<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
				<a href="#" class="card-link">Card link</a>
				<a href="#" class="card-link">Another link</a>
			</div>
		</div>
	</div>
</div>


<%@ include file="/WEB-INF/views/customer/layout/footer.jsp"%>

<script type="text/javascript">
function deleteCommunity() {
	if ("${login.no} == ${vo.no}") {
		return location.href="${pageContext.request.contextPath}/community/delete/${vo.no}";
	} else {
		return alert("삭제할 수 없는 게시물 입니다.");
	}
}

function updateCommunity() {
	if ("${login.no} == ${vo.no}") {
		return location.href="${pageContext.request.contextPath}/community/updateForm/${vo.no}";
	} else {
		return alert("수정할 수 없는 게시물 입니다.");
	}
}

</script>