<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- jstl -->
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/customer/layout/header.jsp"%>
<div id="myTabContent" class="tab-content" style="font-family: 'Poor Story', cursive;" align="center">
	
<ul class="nav nav-tabs" role="tablist">
	<li class="nav-item" role="presentation">
		<a class="nav-link active" data-bs-toggle="tab" href="#home" aria-selected="false" role="tab" tabindex="-1">기본 정보</a>
	</li>
	<li class="nav-item" role="presentation">
		<a class="nav-link" data-bs-toggle="tab" href="#profile" aria-selected="true" role="tab">Profile</a>
	</li>
	<li class="nav-item" role="presentation">
		<a class="nav-link disabled" href="#" aria-selected="false" tabindex="-1" role="tab">Disabled</a>
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
	<div class="tab-pane fade active show" id="home" role="tabpanel" style="max-width: 20rem; margin: 20px 20px">
		<div class="card border-primary mb-3">
			<div class="card-header">기본 정보</div>
				<div class="card-body">
					<div class="form-group" align="left">
						<label class="col-form-label mt-4" for="">이름</label>
						<input class="form-control" id="" style="font-family: 'Poor Story', cursive;" value="${vo.name}">
						<label class="col-form-label mt-4" for="">전화번호</label>
						<input class="form-control" id="" style="font-family: 'Poor Story', cursive;" value="${vo.phone}">
						<label class="col-form-label mt-4" for="">이메일</label>
						<input class="form-control" id="" style="font-family: 'Poor Story', cursive;" value="${vo.email}">
						<label class="col-form-label mt-4" for="">생년월일</label>
						<input type="date" class="form-control" id="" style="font-family: 'Poor Story', cursive;" value="${vo.birth_date}">
						<label class="col-form-label mt-4" for="">성별</label>
						<fieldset class="form-group">
							<div class="row">
								<div class="col-lg-6">
									<div class="form-check">
										<c:if test="${vo.gender == 'F'}">
											<input class="form-check-input" type="radio" name="optionsRadios" id="optionsRadios1" value="option1">
										</c:if>
										<c:if test="${vo.gender == 'M'}">
											<input class="form-check-input" type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
										</c:if>
										<label class="form-check-label" for="optionsRadios1">
											남자
										</label>
									</div>
								</div>
								<div class="col-lg-6">
									<div class="form-check">
										<c:if test="${vo.gender == 'F'}">
											<input class="form-check-input" type="radio" name="optionsRadios" id="optionsRadios2" value="option2" checked>
										</c:if>
										<c:if test="${vo.gender == 'M'}">
											<input class="form-check-input" type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
										</c:if>
										<label class="form-check-label" for="optionsRadios2">
											여자
										</label>
									</div>
								</div>
							</div>
						</fieldset>
						<label class="col-form-label mt-4" for="">프로필 이미지</label>
						<a data-toggle="modal" data-target="#modal"><span class="badge bg-secondary" style="cursor: pointer;">변경</span></a>
						<div class="modal" id="modal">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title">Modal title</h5>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
											<span aria-hidden="true"></span>
										</button>
									</div>
									<div class="modal-body">
										<p>Modal body text goes here.</p>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-primary">Save changes</button>
										<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
									</div>
								</div>
							</div>
						</div>
						<img src="${login.profile}" style="width:100%; height: auto; border-radius: 2%">
						<div class="d-grid gap-2">
							<input class="btn btn-lg btn-primary" type="button" style="margin: 20px 0px 0px 0px" value="변경하기">
						</div>
					</div>
				</div>
		</div>
	</div>
	<div class="tab-pane fade" id="profile" role="tabpanel">
		<p>Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog sartorial PBR leggings next level wes anderson artisan four loko farm-to-table craft beer twee. Qui photo booth letterpress, commodo enim craft beer mlkshk aliquip jean shorts ullamco ad vinyl cillum PBR. Homo nostrud organic, assumenda labore aesthetic magna delectus mollit.</p>
	</div>
	<div class="tab-pane fade" id="dropdown1">
		<p>Etsy mixtape wayfarers, ethical wes anderson tofu before they sold out mcsweeney's organic lomo retro fanny pack lo-fi farm-to-table readymade. Messenger bag gentrify pitchfork tattooed craft beer, iphone skateboard locavore carles etsy salvia banksy hoodie helvetica. DIY synth PBR banksy irony. Leggings gentrify squid 8-bit cred pitchfork.</p>
	</div>
	<div class="tab-pane fade" id="dropdown2">
		<p>Trust fund seitan letterpress, keytar raw denim keffiyeh etsy art party before they sold out master cleanse gluten-free squid scenester freegan cosby sweater. Fanny pack portland seitan DIY, art party locavore wolf cliche high life echo park Austin. Cred vinyl keffiyeh DIY salvia PBR, banh mi before they sold out farm-to-table VHS viral locavore cosby sweater.</p>
	</div>
</div>
	
	
	
<%@ include file="/WEB-INF/views/customer/layout/footer.jsp"%>

<script type="text/javascript">
function test() {
	const modal = document.getElementById("modal");
	alert(modal);
}
</script>