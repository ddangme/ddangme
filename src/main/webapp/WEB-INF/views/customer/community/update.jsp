<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<!-- summernote -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/summernote/js/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/css/summernote-lite.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/css/font-list.css">
<%@ include file="/WEB-INF/views/customer/community/layout/header.jsp"%>


<form action="${pageContext.request.contextPath }/community/write" method="post" enctype="multipart/form-data" name="write" style="font-family: 'Poor Story', cursive;">
	<div class="row">
		<div class="col-lg-12">
			<h1 style="font-family: 'Poor Story', cursive;">글쓰기</h1><hr>
		</div>
		<div class="col-lg-3">
			<select class="form-select" name="category_no" id="category_no" style="font-family: 'Poor Story', cursive;">
				<option>카테고리를 선택하세요.</option>
				<c:forEach var="category" items="${categoryList}">
					<c:if test="${category.no != 0}">
 						<c:if test="${category.no == vo.category_no}">
							<option value="${category.no}" selected="selected">${category.name}</option>
						</c:if>
						<c:if test="${category.no != vo.category_no}">
							<option value="${category.no}">${category.name}</option>
						</c:if>
					</c:if>
				</c:forEach>
			</select>
		</div>
		<div class="col-lg-9">
			<input value="${vo.title}" class="form-control" name="title" placeholder="제목을 입력해 주세요." id="title" style="font-family: 'Poor Story', cursive;">
		</div>
		<div class="col-lg-12"><br></div>
		<div class="col-lg-12">
			<div class="card border-primary" style="padding:0px 0px;">
				<div class="card-body" style="padding:0px 0px;">
					<textarea id="summernote" name="content">${vo.title}</textarea>
				</div>
			</div>
		</div>
		<div class="col-lg-12"><br></div>
		<c:if test="${vo.show_group == 0}">
			<div class="col-lg-2">
				<div class="form-check">
					
					<input class="form-check-input" type="radio" name="show_group" onclick="javascript:radio(this)" id="showGroup0" value="0" checked="">
					<label class="form-check-label" for="showGroup0">
						전체 공개
					</label>
				</div>
			</div>
			<div class="col-lg-2">
				<div class="form-check">
					<input class="form-check-input" type="radio" name="show_group" onclick="javascript:radio(this)" id="showGroup1" value="1">
					<label class="form-check-label" for="showGroup1">
						회원 공개
					</label>
				</div>
			</div>
		
		</c:if>
		<c:if test="${vo.show_group == 1}">
			<div class="col-lg-2">
				<div class="form-check">
					
					<input class="form-check-input" type="radio" name="show_group" onclick="javascript:radio(this)" id="showGroup0" value="0">
					<label class="form-check-label" for="showGroup0">
						전체 공개
					</label>
				</div>
			</div>
			<div class="col-lg-2">
				<div class="form-check">
					<input class="form-check-input" type="radio" name="show_group" onclick="javascript:radio(this)" id="showGroup1" value="1" checked="checked">
					<label class="form-check-label" for="showGroup1">
						회원 공개
					</label>
				</div>
			</div>
		</c:if>
		<input type="hidden" name="status" id="status" value="0">
		<div class="col-lg-8"><br></div>
		<div class="col-lg-12"><br></div>
		<div class="col-lg-12">
			<input type="hidden" id="main-photo-name">
			<input type="file" class="form-control" name="imageList" id="imageList" onchange="uploadImg(this.files);" accept="image/*" multiple style="font-family: 'Poor Story', cursive;">
		</div>
		<div class="col-lg-12"><br></div>
		<div class="col-lg-12">
			<div class="row" id="before-preview">
				
			</div>
			<div class="row" id="preview"></div>
		</div>
		<div class="col-lg-12"><br></div>
		<div class="col-lg-6">
			<input type="button" class="btn btn-dark" onclick="preInsertCheck(this.form)" value="임시저장">
		</div>
		<div class="col-lg-6" align="right">
			<input type="button" class="btn btn-dark" value="취소">
			<input type="button" class="btn btn-success" onclick="insertCheck(this.form)" value="등록">
		</div>
	</div>


</form>

<%@ include file="/WEB-INF/views/customer/community/layout/footer.jsp"%>


<script type="text/javascript">
// 이전에 등록했던 사진 불러오기
const imageList = "${vo.image}"";

let show_group = "${vo.show_group}";

function radio(r) {
	console.log(r.value);
	show_group = r.value;
}
// 등록하기
function insertCheck(form) {
	document.getElementsByName("show_group")[0].value = show_group;
	form.submit();
}

// 임시저장
function preInsertCheck(form) {
	document.getElementById("status").value = '1';
	form.submit();
}

// 대표이미지(썸네일) 설정
function mainPhoto(element) {
	// 이전에 설정한 대표이미지 삭제
	if (document.getElementById("main-photo") != null) {
		document.getElementById("main-photo").remove();
	}
	// input hidden main-photo-name 변경 -> 이름이 동일한 파일이 있을 경우 결함 발생할 것으로 예상
	// 서버에 파일이 순서대로 갈 경우 number로 체크하면 될 것으로 예상
	document.getElementById("main-photo-name").value = element.alt;
	
	// 대표이미지 아래에 체크 이미지 출력
	var img = document.createElement("img");
	img.src = "${pageContext.request.contextPath}/resources/common/images/check.svg";
	img.id = "main-photo";
	img.style = "align-self: right";
	element.parentElement.appendChild(img);
}

// 이미지 업로드 시 미리보기
function uploadImg(files) {
	var preview = document.getElementById("preview");
	
	// 이미 등록된 미리보기가 있다면 삭제
	while(preview.firstChild) {
		preview.removeChild(preview.firstChild);
	}
	
	let count = 0;
	for (let i = 0; i < files.length; i++) {
		var file = files[i];
		
	    // 이미지 파일인지 확인
		var reader = new FileReader();

	    // 메인 포토를 첫 번째 사진으로 설정 후 안내 문구 노출
  		if (i == 0) {
			document.getElementById("main-photo-name").value = file.name;
			var h6 = document.createElement("h6");
			h6.innerText = "이미지를 클릭하여 대표이미지로 설정할 수 있습니다.";
			preview.appendChild(h6);
  		}
  		
  		reader.onload = (function(file) {
  			return function(event) {
  				var imageUrl = event.target.result;
  				// 이미지 미리보기 엘리먼트 생성
  				count++;
  				if (i == 0) {
  	  				var div = document.createElement("div");
  	  				div.className = "col-lg-2";
  	  				div.innerHTML = `
  	  					<img src="` + imageUrl + `" style="height: auto; width: 150px; cursor: pointer;" onclick="mainPhoto(this)" alt="` + file.name + `">
  	  					<img src="${pageContext.request.contextPath}/resources/common/images/check.svg" id="main-photo" style="width:16px; height:16px">
  	  				`;
  	  				preview.appendChild(div);
  				} else {
  	  				var div = document.createElement("div");
  	  				div.className = "col-lg-2";
  	  				div.innerHTML = `
  	  					<img src="` + imageUrl + `" style="height: auto; width: 150px; cursor: pointer;" onclick="mainPhoto(this)" alt="` + file.name + `">
  	  				`;
  	  				// 이미지 미리보기 엘리먼트 추가
  	  				preview.appendChild(div);
  				}
  				if (count != 0 && count%6 === 0) {
  					div = document.createElement("div");
  					div.className = "col-lg-12";
  					div.innerHTML = `<br>`;
  					preview.appendChild(div);
  				}
  			};
  		})(file);
  		
		// 파일 읽기 실행
		reader.readAsDataURL(file);
	}
}

/* summernote 출력 */
$(document).ready(function() {            
	$.summernote.options.lang = 'ko-KR';	// 툴팁 한글로 노출
	$.summernote.options.airMode = false;
 	$('#summernote').summernote({
 		height: 300,
		toolbar: [
			['fontname', ['fontname']],
			['fontsize', ['fontsize']],
			['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			['color', ['forecolor','color']],
			['para', ['ul', 'ol', 'paragraph']],
			['insert',['picture']]
		],
		fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','프리텐다드','에스코어드림','다이어리체','어비마이센체','돋움체','바탕체'],
		fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
 	});
});
</script>