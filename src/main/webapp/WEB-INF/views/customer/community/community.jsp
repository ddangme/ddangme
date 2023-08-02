<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/customer/community/layout/header.jsp"%>
		<table class="table table-hover" style="font-family: 'Poor Story', cursive;" id="main">
			<thead>
				<tr align="center">
					<th scope="col">제목</th>
					<th scope="col">이름</th>
					<th scope="col">등록일</th>
					<th scope="col">조회수</th>
					<th scope="col">좋아요</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${list == null}">
					<tr>
						<td align="center" colspan="5">게시물이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="vo" items="${list}">
					<tr class="table-light">
						<td><a href="${pageContext.request.contextPath}/community/${vo.no}" class="list-group-item list-group-item-action">${vo.title}</a></td>
						<td align="center">${vo.name}</td>
						<td align="center">${vo.insert_date}</td>
						<td align="center">${vo.hit}</td>
						<td align="center">${vo.good}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<%@ include file="/WEB-INF/views/customer/layout/footer.jsp"%>
