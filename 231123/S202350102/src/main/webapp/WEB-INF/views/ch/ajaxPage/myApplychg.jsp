<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">

</style>
<title>Insert title here</title>
</head>
<body>
		                  

	<!-- Item2 참여한 챌린지 -->
	<c:forEach items="${mychgList }" var="chg">
		<div class="col px-4" style="max-width: 400px;">
			<div class="card">
			
				<!-- Image -->
				
				
				<!-- Button -->
				<button class="btn btn-xs w-100 btn-dark card-btn">
					<i class="fe me-2 mb-1"></i>챌린지에 도전하세요!
				</button>
				
				
				<a class="text-body" href="chgDetail?chg_id=${chg.chg_id }">
					<c:if test="${chg.thumb != null}">
						<img class="card-img-top" src="${pageContext.request.contextPath}/upload/${chg.thumb}" alt="thumb" style="width: 100%; height: 250px; border-radius: 10px;" >
					</c:if>
					<c:if test="${chg.thumb == null}">
						<img class="card-img-top" src="assets/img/chgDfaultImg.png" alt="chgDfault" style="width: 100%; height: 250px; border-radius: 10px;">
					</c:if>
				</a>
				
				               <!-- Body -->
				<div class="card-body py-4 px-0 text-center">
					
					<a class="text-body fw-bolder text-muted fs-6" href="chgDetail?chg_id=${chg.chg_id }">${chg.title }</a>
					<div class="text-muted"> 
						<fmt:formatDate value="${chg.create_date }" pattern="yyyy-MM-dd"></fmt:formatDate>
						~ 
						<fmt:formatDate value="${chg.end_date }" pattern="yyyy-MM-dd"></fmt:formatDate>
					</div>
					<div class="text-muted">참여인원: ${chg.chlgerCnt}</div>
					<c:if test="${chg.state_md==100 || chg.state_md==104}">
						<form action="myChgUpdate">
							<input type="hidden" name="chg_id" value="${chg.chg_id }">
							<input type="submit" value="수정">
						</form>
					</c:if>
				</div>
			    
			
			</div>
		</div>
	</c:forEach>

			                	         
			                
</body>
</html>