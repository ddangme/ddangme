<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/layout/header.jsp"%>
<div class="row">
	<div class="col-lg-12" align="right">
		<button type="button" id="InsertCategory" class="btn btn-primary">게시판 추가</button>
	</div>
	<div class="col-lg-12 mt-3" id="category-list">
		<table class="table table-hover">
			<thead>
				<tr align="center">
					<th scope="col">게시판</th>
					<th scope="col">링크</th>
					<th scope="col">게시글 수</th>
					<th scope="col">공개 여부</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${categoryList == null}">
					<tr>
						<td align="center" colspan="5">게시판이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="vo" items="${categoryList}">
					<tr onclick="javascript: updateCategory(this);" id="${vo.no}" style="cursor: pointer;">
						<td align="center">${vo.name}</td>
						<td align="center">${vo.link}</td>
						<td align="center">${vo.count}</td>
						<c:choose>
							<c:when test="${vo.status eq 'Y'}">
								<td align="center">공개</td>
							</c:when>
							<c:otherwise>
								<td align="center">비공개</td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<!-- 게시판 추가 -->
<div class="modal" id="showModal" style="margin-top: 150px;">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modal-title">게시판 추가</h5>
			</div>
			<div class="modal-body">
				<input class="form-control" placeholder="게시판 명" id="name">
				<input class="form-control mt-3" placeholder="링크" id="link">
				<fieldset class="form-group mt-3">
					<div class="form-check form-switch">
						<input class="form-check-input" type="checkbox" id="statusCheck" checked>
						<label class="form-check-label" id="statusLabel" for="statusCheck">공개</label>
					</div>
				</fieldset>
			</div>
			<div class="modal-footer">
				<button type="button" id="categoryCheck" class="btn btn-primary">추가</button>
				<button type="button" id="hideModal" class="btn btn-secondary">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 게시판 수정 -->
<div class="modal" id="showUpdateModal" style="margin-top: 150px;">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modal-title">게시판 수정</h5>
			</div>
			<div class="modal-body">
				<input class="form-control" placeholder="게시판 명" id="updateName">
				<input class="form-control mt-3" placeholder="링크" id="updateLink">
				<input type="hidden" id="updateNo">
				<fieldset class="form-group mt-3">
					<div class="form-check form-switch">
						<input class="form-check-input" type="checkbox" id="updateStatusCheck" checked>
						<label class="form-check-label" id="statusLabel" for="updateStatusCheck">공개</label>
					</div>
				</fieldset>
			</div>
			<div class="modal-footer">
				<button type="button" id="delCategory" class="btn btn-warning">삭제</button>
				<button type="button" id="categoryUpdateCheck" class="btn btn-primary">수정</button>
				<button type="button" id="hideModal" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
<script>
// 게시판 추가 버튼 클릭 시 팝업 노출
$("#InsertCategory").click(function(){
	$("#showModal").modal("show");
});

// 게시판 정보 클릭 시 팝업 노출
function updateCategory(e) {
	if ($(e).children().eq(1).text() == "notice") {
		$("#categoryUpdateCheck").attr("hidden", true);
	} else {
		$("#categoryUpdateCheck").attr("hidden", false);
	}
	$("#showUpdateModal").modal("show");
	$("#updateNo").val($(e).attr("id"));
	$("#updateName").val($(e).children().eq(0).text()); // 게시판
	$("#updateLink").val($(e).children().eq(1).text()); // 링크
	if ($(e).children().eq(2).text() != "0" || $(e).children().eq(1).text() == "notice") {
		$("#delCategory").attr("hidden", true);
	} else {
		$("#delCategory").attr("hidden", false);
	}
	if ($(e).children().eq(3).text() === "공개") { // 공개 여부
		$("#updateStatusCheck").prop("checked", true);
		$("#updateStatusLabel").text("공개");
	} else {
		$("#updateStatusCheck").prop("checked", false);
		$("#updateStatusLabel").text("비공개");
	}
}

// 게시판 추가 팝업에서 취소 버튼 클릭 시 팝업 초기화 후 닫기
function resetModal() {
	$("#name").val("");
	$("#link").val("");
	$("#statusCheck").prop("checked", true);
	$("#statusLabel").text("공개");
	$("#showModal").modal("hide");
}

$("#hideModal").click(resetModal);

// 토글 버튼 클릭 시 우측 문구 변경
$("#statusCheck").click(function(){
	if ($('#statusCheck').is(':checked')) {
		return $("#statusLabel").text("공개");
	} else {
		return $("#statusLabel").text("비공개");
	}
});

// 게시판 추가 팝업에서 추가 버튼 클릭 시 동작
$("#categoryCheck").click(function() {
	if ($("#name").val() === "") {
		$("#name").focus();
		return alert("게시판 명을 입력해주세요.");
	}
	if ($("#link").val() === "") {
		$("#link").focus();
		return alert("링크를 입력해주세요.");
	}
	let name = $("#name").val();
	let link = $("#link").val();
	let status = 'Y';
	if (!$("#statusCheck").is(':checked')) {
		status = 'N';
	}
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/community/category/insert",
		data: {
			name: name,
			link: link,
			status: status
		},
		type: "POST",
		success: function(data) {
			if (data == "2") {
				alert("이미 존재하는 게시판 명 혹은 링크가 존재합니다. 변경 후 다시 시도해주세요.");
			} else if (data == "1") {
				alert("게시판 추가에 실패하였습니다.\n계속될 경우 관리자에게 문의해주세요.");
			} else {
				alert(name + " 게시판이 추가되었습니다.");
			}
			$("#category-list").load(location.href + " #category-list");
		},
		error: function(data) {
			$("#category-list").load(location.href + " #category-list");
			alert("게시판 추가에 실패하였습니다.\n계속될 경우 관리자에게 문의해주세요.");
		}
	});
	resetModal();
});

// 게시판 삭제
$("#delCategory").click(function() {
	if (confirm($("#updateName").val() + " 게시판을 삭제하시겠습니까?")) {
		let no = $("#updateNo").val();
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/community/category/delete",
			data: {
				no: no
			},
			type: "POST",
			success: function(data) {
				if (data == "0") {
					alert($("#updateName").val() + " 게시판이 삭제되었습니다.");
					$("#category-list").load(location.href + " #category-list");
				} else if (data == "1") {
					alert("게시판 삭제에 실패하였습니다.\n계속될 경우 관리자에게 문의해주세요.");
				}
			},
			error: function(data) {
					alert("게시판 삭제에 실패하였습니다.\n계속될 경우 관리자에게 문의해주세요.");
			}
		});
		$("#showUpdateModal").modal("hide");
	}
});

// 게시판 수정 팝업에서 수정 버튼 클릭 시 동작
$("#categoryUpdateCheck").click(function() {
	if ($("#updateName").val() === "") {
		$("#updateName").focus();
		return alert("게시판 명을 입력해주세요.");
	}
	if ($("#updateLink").val() === "") {
		$("#updateLink").focus();
		return alert("링크를 입력해주세요.");
	}
	let no = $("#updateNo").val();
	let name = $("#updateName").val();
	let link = $("#updateLink").val();
	let status = 'Y';
	if (!$("#updateStatusCheck").is(':checked')) {
		status = 'N';
	}
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/community/category/update",
		data: {
			no: no,
			name: name,
			link: link,
			status: status
		},
		type: "POST",
		success: function(data) {
			if (data == "2") {
				alert("이미 존재하는 게시판 명 혹은 링크가 존재합니다. 변경 후 다시 시도해주세요.");
			}
			else if (data == "1") {
				alert("게시판 수정에 실패하였습니다.\n계속될 경우 관리자에게 문의해주세요.");
			} else {
				alert(name + " 게시판이 수정되었습니다.");
			}
			$("#category-list").load(location.href + " #category-list");
		},
		error: function(data) {
			$("#category-list").load(location.href + " #category-list");
			alert("게시판 수정에 실패하였습니다.\n계속될 경우 관리자에게 문의해주세요.");
		}
	});
	$("#showUpdateModal").modal("hide");
});
</script>

<%@ include file="/WEB-INF/views/admin/layout/footer.jsp"%>