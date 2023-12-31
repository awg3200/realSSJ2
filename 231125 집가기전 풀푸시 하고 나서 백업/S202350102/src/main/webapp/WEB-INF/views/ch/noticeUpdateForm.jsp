<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/topBar.jsp" %>    
<%@ include file="/WEB-INF/views/header4.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/qBoardDetail.css">
<style type="text/css">
  .custom-hr {
    border: 1px solid #000; /* 기본 테두리 스타일 */
    border-width: 0 0 2px 0; /* 아래쪽 테두리만 두껍게 설정 */
  }
  
  #test{  
    min-height: 200px; /* 최소 높이를 200px로 설정 */
    
  }
</style>
<script type="text/javascript">
	function fileUpdate(){
		var fileInput = document.getElementById('fileInput');
		if(fileInput.style.display == "none"){
			fileInput.style.display = "block";
			fileInput.removeAttribute('disabled');
			$("#imgOroot").hide();
			$("#chgBtn").html("취소");
		} else{
			fileInput.style.display = "none";
			fileInput.setAttribute('disabled', 'true');
			$("#imgOroot").show();
			$("#chgBtn").html("사진 첨부");
		}
	}
	
	function fileDelete(){
		if($("#Img").css("display") != "none"){
			$("#Img").hide();
			$("#imgOroot").hide();
			$("#delBtn").html("취소");
			$("#delStatus").val(1);
		} else{
			$("#Img").show();
			$("#imgOroot").show();
			$("#delBtn").html("파일 삭제");
			$("#delStatus").val(0);
		}
	}
</script>

</head>
<body>
	
	<div class="container">
		<form action="noticeUpdate" method="post" enctype="multipart/form-data">
			<div id="qbd-main" class="qbd-main" style="height: auto;">
				<div class="qbd-mainbody" style="height: auto;">
					<div id="qbd-title" class="qbd-title" style="height: 80px;">
						<div class="qbd-title-content">
							<div class="col-8">						
								<span class="title-text">제목:<input type="text" name="title" value="${noticeConts.title }"></span>
								<input type="hidden" value="${noticeConts.brd_num  }" name="brd_num">
								<input type="hidden" value="${noticeConts.user_num  }" name="user_num">
								<input type="hidden" value="${noticeConts.brd_md}" name="brd_md">
							</div>													
						</div>							
					</div>
					
					<div class="qbd-line">
						<div class="qbd-line-box">
							<span class="qbd-line-box-text">작성자: ${noticeConts.nick }</span>&nbsp;&nbsp;&nbsp;&nbsp;
							<span class="qbd-line-box-text">작성일: <fmt:formatDate value="${noticeConts.reg_date }" pattern="yyyy-MM-dd"/></span>&nbsp;&nbsp;&nbsp;&nbsp;
							<span class="qbd-line-box-text">카테고리: ${noticeConts.category }</span>
						</div>
						<!-- <div class="qbd-line-li"></div> -->
					</div>
					<hr class="custom-hr">
					<div class="container">
		    			<div class="row border" style="height: auto;">
		    				<div class="col-8 p-4 mt-4" >
								<div class="qbd-content">
									<div class="qbd-content text"  id="test">
										<c:if test="${not empty noticeConts.img }">
											<img alt="UpLoad Image" src="${pageContext.request.contextPath}/upload/${noticeConts.img}" id="Img"><p>
											<input type="hidden" name="img" value="${noticeConts.img}">
										</c:if>				
										<span>
											<textarea rows="20" cols="50" name="conts">${noticeConts.conts }</textarea>
										</span>
									</div>						
								</div>						
								<input type="file" name="file1" style="display: none;" id="fileInput" disabled="disabled">
								<c:if test="${not empty noticeConts.img }"><span id="imgOroot">${pageContext.request.contextPath}/upload/${noticeConts.img}</span></c:if><p>
								<button type="button" onclick="fileUpdate()" id="chgBtn">사진 첨부</button>											
								<c:if test="${not empty noticeConts.img }">
									<button type="button" onclick="fileDelete()" id="delBtn">파일 삭제</button>
									<input type="hidden" name="delStatus" id="delStatus" value="0">				
								</c:if>	
							</div>   			
						</div>
					</div>
					<div class="col-4">
						<input type="submit" value="수정" class="btn-danger btn-xxs">									
						<input type="button" value="목록" onclick="location.href='notice?brd_md=${noticeConts.brd_md}'" class="btn-danger btn-xxs">
					</div>	
					<hr class="custom-hr">				
				</div>
			</div>
		</form>
	</div>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>