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
			<button class="btn btn-light" id="search">
				<img src="/ww/resources/common/images/search.svg">
			</button>
		</div>
	</div>
</div>
<div align="right">
	<button class="btn btn-primary mt-2" id="addNotice">공지 등록</button>
</div>
<div id="community-list">
	<table class="table table-hover mt-5" id="table-list">
		<thead>
			<tr align="center">
				<th scope="col">
					<input class="form-check-input" type="checkbox" id="all-check-list">
				</th>
				<th scope="col">게시물 번호</th>
				<th scope="col">제목</th>
				<th scope="col">등록일</th>
				<th scope="col">공개 여부</th>
				<th scope="col">댓글 수</th>
			</tr>
		</thead>
		<tbody id="tbody">
			<c:if test="${noticeList == null}">
				<td align="center" colspan="5">등록된 게시물이 없습니다.</td>
			</c:if>
			<c:forEach var="vo" items="${noticeList}">
				<tr>
					<td align="center">
						<input class="form-check-input" type="checkbox" name="check-list" id="${vo.no}">
					</td>
					<td align="center">${vo.no}</td>
					<td><a style="cursor: pointer;" href="${pageContext.request.contextPath}/admin/community/${vo.no}" class="list-group-item list-group-item-action">${vo.title}</a></td>
					<td align="center">${vo.insert_date}</td>
					<td align="center">
						<c:if test="${vo.status == 'Y'}">
							공개
						</c:if>
						<c:if test="${vo.status == 'N'}">
							비공개
						</c:if>
					</td>
					<td align="center"></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
	<div align="right">
		<button class="btn btn-success" id="alter">수정</button>
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

// 공지 수정

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

// community-list 영역 새로고침
function reload() {
	$("#community-list").load(location.href + " #community-list");
}

// 공지 등록 버튼
$("#addNotice").click(function() {
	location.href="${pageContext.request.contextPath}/admin/community/notice/writeForm";
});
</script>


<%@ include file="/WEB-INF/views/admin/layout/footer.jsp"%>