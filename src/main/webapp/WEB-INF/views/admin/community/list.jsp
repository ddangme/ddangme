<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/layout/header.jsp"%>
<div class="row" align="right">
	<div class="col-lg-2 offset-lg-6">
		<select class="form-select" id="category">
			<option value="-1">-- 게시판 --</option>
			<c:forEach var="category" items="${categoryList}">
				<option value="${category.no}">${category.name}</option>
			</c:forEach>
		</select>
	</div>
	<div class="col-lg-3">
		<input class="form-control" placeholder="검색 키워드를 입력해주세요." id="text">
	</div>
	<div class="col-lg-1">
		<div class="row">
			<button class="btn btn-primary" id="search">검색</button>
		</div>
	</div>
</div>
<div id="community-list">
	<table class="table table-hover mt-5" id="table-list">
		<thead>
			<tr align="center">
				<th scope="col">
					<input class="form-check-input" type="checkbox" id="all-check-list">
				</th>
				<th scope="col">게시물 번호</th>
				<th scope="col">게시판</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">등록일</th>
				<th scope="col">댓글 수</th>
			</tr>
		</thead>
		<tbody id="tbody">
			<c:forEach var="vo" items="${communityList}">
				<tr>
					<td align="center">
						<input class="form-check-input" type="checkbox" name="check-list" id="${vo.no}">
					</td>
					<td align="center">${vo.no}</td>
					<c:forEach var="category" items="${categoryList}">
						<c:if test="${vo.category_no == category.no}">
							<td align="center">${category.name}</td>
						</c:if>
					</c:forEach>
					<td><a style="cursor: pointer;" href="${pageContext.request.contextPath}/admin/community/${vo.no}" class="list-group-item list-group-item-action">${vo.title}</a></td>
					<td align="center">${vo.name}</td>
					<td align="center">${vo.insert_date}</td>
					<td align="center"></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
	<div align="right">
		<button class="btn btn-success" id="delData">게시물 삭제</button>
	</div>
<div class="modal" id="showModal" style="margin-top: 150px;">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">본문 보기</h5>
			</div>
			<div class="modal-body">
				<h6 id="modal-text"></h6>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<script>
// 한 개의 데이터 체크박스 변경
$('input[name="check-list"]').on("click", function() {
	$(this).attr("checked", !$(this).attr("checked"));
});
// 모든 리스트 선택
$("#all-check-list").click(function() {
	// 체크되었을 경우
	if ($(this).is(":checked")) {
		$(".form-check-input").attr("checked", true);
		$(".form-check-input").prop("checked", true);
	} else { // 체크 해제 했을 경우
		$(".form-check-input").attr("checked", false);
		$(".form-check-input").prop("checked", false);
	}
});

// 게시물 삭제
$("#delData").click(function() {
	let list = "";
	$('input[name="check-list"]:checked').each(function() {
		list += $(this).attr("id") + " ";
	});
	if (list === "") {
		return alert("게시물을 선택 후 시도해주세요.");
	}
	if (confirm("게시물을 삭제하시겠습니까?")) {
		$.ajax({
			url: "${pageContext.request.contextPath}/admin/community/delete",
			data: {
				list: list
			},
			type: "POST",
			success: function(data) {
				if (data === "") {
					alert("게시물 삭제에 실패하였습니다.\n계속될 경우 관리자에게 문의해주세요.");
				} else {
					alert("게시물이 삭제되었습니다.");
				}
				reload();
			}, 
			error: function(data) {
				reload();
				alert("게시물 삭제에 실패하였습니다.\n계속될 경우 관리자에게 문의해주세요.");
			}
		});
	}
});
const beforeList = $("#table-list td");
// 검색 동작
$("#search").click(function() {
	
	let updateList = [];
	var category = $("#category option:selected").text();
	console.log(category);
	var content = $("#text").val();
	if (category == "-- 게시판 --" && content === "") {
		return alert("게시판 혹은 검색어를 입력 후 시도해주세요.");
	} else if (category != "-- 게시판 --" && content === "") {
		beforeList.filter(function() {
			if($(this).text().indexOf(category) > -1) {
				updateList.push($(this).parent());
			}
		})
	} else if (category != "-- 게시판 --" && content != "") {
		beforeList.filter(function() {
			if($(this).text().indexOf(category) > -1 && $(this).text().indexOf(content) > -1) {
				updateList.push($(this).parent());
			}
		})
	} else {
		beforeList.filter(function() {
			if($(this).text().indexOf(content) > -1) {
				updateList.push($(this).parent());
			}
		})
	}
	updateList = updateList.filter((value, index, self) => self.indexOf(value) === index);
	$("#tbody").empty();
	for (var i = 0; i < updateList.length; i++) {
		$("#tbody").append(updateList[i]);
	}
	// 검색 시 체크박스 초기화
	$(".form-check-input").prop("checked", false);
});
// 테스트테스트2222222
// community-list 영역 새로고침
function reload() {
	$("#community-list").load(location.href + " #community-list");
}
</script>


<%@ include file="/WEB-INF/views/admin/layout/footer.jsp"%>