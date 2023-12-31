<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="header4.jsp" %>
<%@ include file="/WEB-INF/views/topBar.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="shortcut icon" href="./assets/favicon/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="./assets/css/libs.bundle.css" />
    <link rel="stylesheet" href="./assets/css/theme.bundle.css" />
    <link rel="stylesheet" href="https://unpkg.com/flickity@2/dist/flickity.min.css">
    <title>Insert title here</title>
<script src="https://unpkg.com/flickity@2/dist/flickity.pkgd.min.js"></script>
<script src="./js/jquery.js"></script>
<script type="text/javascript">
//Flickity 초기화 함수 - slider활용하기 위한 것
function initFlickity() {

    // Flickity 초기화 초기화 위해 객체 생성
    var flkty = new Flickity('#mySlider', {
        prevNextButtons: true, // 이전 및 다음 버튼 활성화
        draggable: true, // 드래깅 활성화
        // 필요한 경우 더 많은 옵션을 추가할 수 있습니다.
         contain: true ,// 부모 요소에 캐러셀을 포함시킵니다.
         cellAlign: 'left',
         pageDots: false
    });
    
    //리턴값을 줘서 사용(없어도 됨)
    return flkty;
}

function clickLoad(index) {
	
	// Flickity 인스턴스 제거
    var flkty = $('#mySlider').data('flickity');
    if (flkty) {
        flkty.destroy();
    }
    
	
	if(index == 1) {
		// 참여 챌린지
		$.ajax(
				{
					
					url: "myParty",
					dataType:"html",
					success:function(data){
						$("#mySlider").html(data);
						
				        //Flickity 초기화
						initFlickity();
					}
				}		
			);
		
	} else if(index == 2) {
		// 신청한 챌린지
		$.ajax(
				{
					
					url: "myApplychgAjax",
					dataType:"html",
					success:function(data){
						$("#mySlider").html(data);
						
				        //Flickity 초기화
						initFlickity();
					}
				}		
			);
		
	} else if(index == 3) {
		// 찜한 챌린지
		$.ajax(
				{
					url: "/chgPickList",
					dataType:"html",
					success:function(data){
						$("#mySlider").html(data);
						
				        //Flickity 초기화
						initFlickity();
					}
				}		
			);

	} else {
		// 최근 본 챌린지
		// 일단 보류
		
	}
	
}
	
	
	function myContsDelete(brd_md, brd_num){
		var brdMd = brd_md;
		var brdNum = brd_num;
		
		$.ajax({
			url: "myContsDelete",
			type: "POST",
			data: { brd_num: brd_num },
			dataType: "text",
			success: function(data){
				if(parseInt(data)>0){
					$("#body" + brdMd + " #row" + brd_num).remove();
				}
			}
		})
		
	}


	function pageMove(brd_md, currentPage){
		/* alert(brd_md);
		alert(currentPage); */
		var brdMd = brd_md;
		var currentP = currentPage;
		
		$.ajax({
			url : "pageAjax",
			data: {brd_md : brdMd, currentPage : currentP},
			dataType: "json",
			success: function(result){				
				var text = "";
				text = brdText(result);
				$("#body"+result.page.brd_md).html(text);
				$("#body"+result.page.brd_md).css()
			}
		})
	}
	
	function brdText(result){
		var text ="";
		switch(result.page.brd_md){
		/**********************인증***************/
		case 100:
			var num = result.page.total - result.page.start+1;
			for(var i = 0; i< result.reCount; i++){
				text += "<tr id='row"+result.listBdRe[i].brd_num+"'>"
                	+"<td>"+num+"</td>"
                	+"<td><a href='chgDetail?chg_id="+result.listBdRe[i].chg_id+"'>"+result.listBdRe[i].title+"</a></td>"
                	+"<td>"+result.listBdRe[i].nick+"</td>"
                	+"<td>"+new Date(result.listBdRe[i].reg_date).toISOString().slice(0, 10)+"</td>"
                	+"<td>"+result.listBdRe[i].view_cnt+"</td>"
         			+"<td>"+result.listBdRe[i].replyCount+"</td>"
         			+"<td><a href='javascript:void(0);' onclick='myContsDelete("+result.page.brd_md+","+result.listBdRe[i].brd_num+")'>삭제</a></td></tr>";
         		num = num - 1;            
			}
			return text;
			break;
		/**********************후기***************/
		case 101:						
			var num = result.page.total - result.page.start+1;
			for(var i = 0; i< result.reCount; i++){
				text += "<tr id='row"+result.listBdRe[i].brd_num+"'>"
                	+"<td>"+num+"</td>"
                	+"<td><a href='reviewContent?brd_num="+result.listBdRe[i].brd_num+"&chg_id="+result.listBdRe[i].chg_id+"'>"+result.listBdRe[i].title+"</a></td>"
                	+"<td>"+result.listBdRe[i].nick+"</td>"
                	+"<td>"+new Date(result.listBdRe[i].reg_date).toISOString().slice(0, 10)+"</td>"
                	+"<td>"+result.listBdRe[i].replyCount+"</td>"
         			+"<td><a href='javascript:void(0);' onclick='myContsDelete("+result.page.brd_md+","+result.listBdRe[i].brd_num+")'>삭제</a></td></tr>";
         		num = num - 1;            
			}
			return text;
			
			break;
			/**********************쉐어링***************/
		case 102:
			var num = result.page.total - result.page.start+1;
			for(var i = 0; i< result.reCount; i++){
				text += "<tr id='row"+result.listBdRe[i].brd_num+"'>"
                	+"<td>"+num+"</td>"
                	+"<td><a href='detailSharing?brd_num="+result.listBdRe[i].user_num+"&brd_num="+result.listBdRe[i].brd_num+"'>"+result.listBdRe[i].title+"</a></td>"                	
                	+"<td>"+result.listBdRe[i].nick+"</td>"
                	+"<td>"+new Date(result.listBdRe[i].reg_date).toISOString().slice(0, 10)+"</td>"
                	+"<td>"+result.listBdRe[i].view_cnt+"</td>"
         			+"<td>"+result.listBdRe[i].replyCount+"</td>"
         			+"<td><a href='javascript:void(0);' onclick='myContsDelete("+result.page.brd_md+","+result.listBdRe[i].brd_num+")'>삭제</a></td></tr>";
         		num = num - 1;            
			}
			return text;
			break;
			/**********************자유***************/
		case 103:
			var num = result.page.total - result.page.start+1;
			for(var i = 0; i< result.reCount; i++){
				text += "<tr id='row"+result.listBdRe[i].brd_num+"'>"
                	+"<td>"+num+"</td>"
                	+"<td><a href='detailCommunity?brd_num="+result.listBdRe[i].user_num+"&brd_num="+result.listBdRe[i].brd_num+"'>"+result.listBdRe[i].title+"</a></td>"
                	+"<td>"+result.listBdRe[i].nick+"</td>"
                	+"<td>"+new Date(result.listBdRe[i].reg_date).toISOString().slice(0, 10)+"</td>"
                	+"<td>"+result.listBdRe[i].view_cnt+"</td>"
                	+"<td>"+result.listBdRe[i].replyCount+"</td>"
         			+"<td><a href='javascript:void(0);' onclick='myContsDelete("+result.page.brd_md+","+result.listBdRe[i].brd_num+")'>삭제</a></td></tr>";
         			
         		num = num - 1;            
			}
			return text;
			break;
		}
		
		
		
	}
</script>    

</head>
<style type="text/css">
@import url(https://fonts.googleapis.com/earlyaccess/notosanskr.css); 
    	body{
    	font-family: 'Noto Sans KR', sans-serif;} 
			
    </style>
<style>
.profile {
  margin: 20px 0;
}

/* Profile sidebar */
.profile-sidebar {
  padding: 20px 0 10px 0;
  background: #fff;
  
}
.profile-userpic {
   text-align: center; /* 추가된 부분 */ 
}
.profile-userpic img {
  float: none;
  margin: 0 auto;
  width: 50%;
  height: 50%;
  -webkit-border-radius: 50% !important;
  -moz-border-radius: 50% !important;
  border-radius: 50% !important;

}

.profile-usertitle {
  text-align: center;
  margin-top: 20px;
}

.profile-usertitle-name {
  color: #5a7391;
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 7px;
}

.profile-usertitle-job {
  text-transform: uppercase;
  color: #5b9bd1;
  font-size: 12px;
  font-weight: 600;
  margin-bottom: 15px;
}


/* Profile Content */
.profile-content {
  padding: 20px;
  background: #fff;
  min-height: 460px;
}




a, button, code, div, img, input, label, li, p, pre, select, span, svg, table, td, textarea, th, ul {
    -webkit-border-radius: 0!important;
    -moz-border-radius: 0!important;
    border-radius: 0!important;
}
.dashboard-stat, .portlet {
    -webkit-border-radius: 4px;
    -moz-border-radius: 4px;
    -ms-border-radius: 4px;
    -o-border-radius: 4px;
}
.portlet {
    margin-top: 0;
    margin-bottom: 25px;
    padding: 0;
    border-radius: 4px;
}
.portlet.bordered {
    border-left: 2px solid #e6e9ec!important;
}
.portlet.light {
    padding: 12px 20px 15px;
    background-color: #fff;
}
.portlet.light.bordered {
    border: 1px solid #e7ecf1!important;
}
.list-separated {
    margin-top: 10px;
    margin-bottom: 15px;
}
.profile-stat {
    padding-bottom: 20px;
    border-bottom: 1px solid #f0f4f7;
}
.profile-stat-title {
    color: #7f90a4;
    font-size: 25px;
    text-align: center;
}
.uppercase {
    text-transform: uppercase!important;
}

.profile-stat-text {
    color: #5b9bd1;
    font-size: 10px;
    font-weight: 600;
    text-align: center;
}
.profile-desc-title {
    color: #7f90a4;
    font-size: 17px;
    font-weight: 600;
}
.profile-desc-text {
    color: #7e8c9e;
    font-size: 14px;
}
.margin-top-20 {
    margin-top: 20px!important;
}
[class*=" fa-"]:not(.fa-stack), [class*=" glyphicon-"], [class*=" icon-"], [class^=fa-]:not(.fa-stack), [class^=glyphicon-], [class^=icon-] {
    display: inline-block;
    line-height: 14px;
    -webkit-font-smoothing: antialiased;
}
.profile-desc-link i {
    width: 22px;
    font-size: 19px;
    color: #abb6c4;
    margin-right: 5px;
}

.flickity-viewport {  
	  height: 400px !important;	  
	}

.flickity-cell {
  width: 50%; /* half-width */
  height: 400px;
  margin-right: 10px;
}

 #recomSlider .flickity-slider{
	width: 100% !important; /* half-width */
}

</style>

<body>
<div class="container">
	<div class="row profile">
		<div class="col-md-3">
        	<%@ include file="mypageMenu.jsp" %>
        	
		</div>
      	<div class="col-md-9 profile-form">
			<!-- 필수!! -->
		
		 <!-- CATEGORIES -->

		<div class="container">
	        <div class="row">
	        	<div class="col-12">	
	            	<!-- Heading -->
	            	<h5 class="mb-4">챌린지 목록</h5>
	            
		            <!-- Nav -->
		            <div class="nav justify-content-center mb-10">
		            	<a class="nav-link active" href="#my" data-bs-toggle="tab" onclick="clickLoad(1)">참여 챌린지</a>
		            	<a class="nav-link" href="#my" data-bs-toggle="tab"   onclick="clickLoad(2)">신청한 챌린지</a>
		            	<a class="nav-link" href="#my" data-bs-toggle="tab" onclick="clickLoad(3)">찜한 챌린지</a>
		            	<!-- 최근 본 챌린지는 일단 보류. 나중에 시간나면 추가할 예정 -->
		            	<!-- <a class="nav-link" href="#my" data-bs-toggle="tab" onclick="clickLoad(4)">최근 본 챌린지</a> -->
		            </div>	
		            
	            	<!-- Content -->
		            <div class="tab-content">	
		            	<!-- Pane -->
		            	<div class="tab-pane fade show active" id="my">
		            	  <!-- Slider -->
			                <div id="mySlider" class="flickity-buttons-lg flickity-buttons-offset px-lg-6" data-flickity='{"prevNextButtons": true}'>
			                <!--  이 안에서 tab에 해당하는 내용을 ajax로 출력 -->			                  

                  			<!-- Item2 참여한 챌린지 -->
			                  <c:forEach items="${mychgrList }" var="chg">
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
						                <div class="text-muted">참여인원: ${chg.chlgerCnt}
						            	</div>
							            	
				                      </div>
				
				                    </div>
				                  </div>
			                  </c:forEach>

			                	         
			                </div> 
			                <!-- slider -->
		
		            	</div>  
		            	<!-- topSellertsTab -->
		            	
		        	</div> <!-- tab-content -->
				</div> <!-- col-12 -->
			</div> <!-- row -->
		</div> <!-- container -->

	
	
      <div class="container"style="margin-top: 60px;">
        <div class="row">
          <div class="col-12">

            <!-- Heading -->
            <h5 class="mb-4">내가 쓴 글 </h5>
            <!-- Nav -->
            <nav class="nav justify-content-center mb-10">
              <a class="nav-link px-100 active" href="#myCert-list" data-bs-toggle="tab">인증글</a>
              <a class="nav-link px-100 " href="#myReview-list" data-bs-toggle="tab">후기글</a>
              <a class="nav-link px-100 " href="#myCommu-list" data-bs-toggle="tab">자유글</a>
              <a class="nav-link px-100 " href="#myShare-list" data-bs-toggle="tab">쉐어링</a>
            </nav>

            <!-- Content -->
            <div class="tab-content">
            	 <!-------------------------------- 인증글리스트 --------------------------------------->
        		<div class="tab-pane fade show active" id="myCert-list">
					<div id="myCert">				
							<c:choose>
				            	<c:when test="${not empty myCertiList }">
				            		<c:set var="num" value="${myCertiPage.total - myCertiPage.start+1 }"></c:set> 
					                <table class="boardtable">
					                    <thead>
					                        <tr>
					                            <th scope="col" class="th-num">번호</th>
					                            <th scope="col" class="th-title">제목</th>
					                            <th scope="col" class="th-nick">작성자</th>
					                            <th scope="col" class="th-date">등록일</th>
					                            <th scope="col" class="th-view_cnt">조회수</th>
					                            <th  scope="col" class="th-replyCount">댓글수</th>
					                            <th  scope="col" >비고</th>
					                            <th></th>
					                        </tr>
					                    </thead>                 
					                    <tbody id="body${Certi_md }">
					                        <c:forEach items="${myCertiList }" var="myCertiList">
					                            <tr id="row${myCertiList.brd_num}">
					                                <td>${num}</td>
					                                <td><a href="detailCommunity?user_num=${myCertiList.user_num}&brd_num=${myCertiList.brd_num}">${myCertiList.title}</a></td>
					                                <td>${myCertiList.nick}</td>
					                                <td><fmt:formatDate value="${myCertiList.reg_date}" pattern="yyyy-MM-dd"/></td>
					                                <td>${myCertiList.view_cnt}</td>
									         		<td>${myCertiList.replyCount}</td>
									         		<td><a href="javascript:void(0);" onclick="myContsDelete(${Certi_md},${myCertiList.brd_num })">삭제</a></td>
									         		<c:set var="num" value="${num-1}"></c:set> 			       
					                            </tr>
					                        </c:forEach>
					                    </tbody>
					                </table>
					                
									   <div class="page">
										    <c:if test="${myCertiPage.startPage >myCertiPage.pageBlock}">
										        <a href="javascript:void(0);" onclick="pageMove(${Certi_md}, ${myCertiPage.startPage-myCertiPage.pageBlock}">[이전]</a>
										    </c:if>
										    <c:forEach var="i" begin="${myCertiPage.startPage}" end="${myCertiPage.endPage}">					        
										        <a href="javascript:void(0);" onclick="pageMove(${Certi_md}, ${i }); return false;" >[${i}]</a>
										    </c:forEach>
										    <c:if test="${myCertiPage.endPage < myCertiPage.totalPage}">										        
										        <a href="javascript:void(0);" onclick="pageMove(${Certi_md}, ${myCertiPage.startPage+myCommuPage.pageBlock}">[다음]</a>
										    </c:if>
										</div> 
									           	
				            	</c:when> 
				            	
				            	<c:otherwise>
				            		<h3>작성한 글이 없습니다.</h3>
				            	</c:otherwise>
				            	
							</c:choose>			
					</div>	<!-- myCert -->				
				</div>   <!-- myCert-list -->
				<!--------------------------------후기 리스트 --------------------------------------->
				<div class="tab-pane fade" id="myReview-list">
					<div id="myReview">				
						<c:choose>
			            	<c:when test="${not empty myReviewList }">
			            		<c:set var="num" value="${myReviewPage.total - myReviewPage.start+1 }"></c:set> 
				                <table class="table">
				                    <thead>
				                        <tr>
				                            <th scope="col" class="th-num">번호</th>
				                            <th scope="col" class="th-title">제목</th>
				                            <th scope="col" class="th-nick">작성자</th>
				                            <th scope="col" class="th-date">등록일</th>
				                            <th scope="col" class="th-view_cnt">조회수</th>
				                            <th  scope="col" class="th-replyCount">댓글수</th>
				                            <th  scope="col" class="th-replyCount">비고</th>
				                        </tr>
				                    </thead>                 
				                    <tbody id="body${Review_md}">
				                        <c:forEach items="${myReviewList }" var="myReviewList">
				                            <tr id="row${myReviewList.brd_num }">
				                                <td>${num}</td>
				                                <td><a href="reviewContent?brd_num=${myReviewList.brd_num }&chg_id=${myReviewList.chg_id }">${myReviewList.title}</a></td>
				                                <td>${myReviewList.nick}</td>
				                                <td><fmt:formatDate value="${myReviewList.reg_date}" pattern="yyyy-MM-dd"/></td>
				                                <td>${myReviewList.view_cnt}</td>
								         		<td>${myReviewList.replyCount}</td>
								         		<td><a href="javascript:void(0);" onclick="myContsDelete(${Review_md},${myReviewList.brd_num })">삭제</a></td>
								         		<c:set var="num" value="${num-1}"></c:set> 			       
				                            </tr>
				                        </c:forEach>
				                    </tbody>
				                </table>
				                
								<div class="page">
								    <c:if test="${myReviewPage.startPage >myReviewPage.pageBlock}">					        
								        <a href="javascript:void(0);" onclick="pageMove(${Review_md},${myReviewPage.startPage-myReviewPage.pageBlock}); return false;" >[이전]</a>
								    </c:if>
								    <c:forEach var="i" begin="${myReviewPage.startPage}" end="${myReviewPage.endPage}">					    	
								        <a href="javascript:void(0);" onclick="pageMove(${Review_md}, ${i }); return false;" >[${i}]</a>
								    </c:forEach>
								    <c:if test="${myReviewPage.endPage < myReviewPage.totalPage}">					        
								        <a href="javascript:void(0);" onclick="pageMove(${Review_md},${myReviewPage.startPage+myCommuPage.pageBlock}); return false;" >[다음]</a>
								    </c:if>
								</div>            	
			            	</c:when> 
			            	
			            	<c:otherwise>
			            		<h3>작성한 글이 없습니다.</h3>
			            	</c:otherwise>
			            	
						</c:choose>
						
					</div>	<!-- myReview -->
				</div><!-- myReview-list -->
				<!--------------------------------쉐어링 리스트 --------------------------------------->
				<div class="tab-pane fade" id="myShare-list">
					<div id="myShare">					
						<c:choose>
			            	<c:when test="${not empty myShareList }">
			            		<c:set var="num" value="${mySharePage.total - mySharePage.start+1 }"></c:set> 
				                <table class="boardtable">
				                    <thead>
				                        <tr>
				                            <th scope="col" class="th-num">번호</th>
				                            <th scope="col" class="th-title">제목</th>
				                            <th scope="col" class="th-nick">작성자</th>
				                            <th scope="col" class="th-date">등록일</th>
				                            <th scope="col" class="th-view_cnt">조회수</th>
				                            <th  scope="col" class="th-replyCount">댓글수</th>
				                            <th  scope="col" >비고</th>
				                        </tr>
				                    </thead>                 
				                    <tbody id="body${Share_md }">
				                        <c:forEach items="${myShareList }" var="myShareList">
				                            <tr id="row${myShareList.brd_num }">
				                                <td>${num}</td>
				                                <td><a href="detailSharing?user_num=${myShareList.user_num}&brd_num=${myShareList.brd_num}">${myShareList.title}</a></td>
				                                <td>${myShareList.nick}</td>
				                                <td><fmt:formatDate value="${myShareList.reg_date}" pattern="yyyy-MM-dd"/></td>
				                                <td>${myShareList.view_cnt}</td>
								         		<td>${myShareList.replyCount}</td>
								         		<td><a href="javascript:void(0);" onclick="myContsDelete(${Share_md},${myShareList.brd_num })">삭제</a></td>
								         		<c:set var="num" value="${num-1}"></c:set> 			       
				                            </tr>
				                        </c:forEach>
				                    </tbody>
				                </table>
				                
								   <div class="page">
								    <c:if test="${mySharePage.startPage >mySharePage.pageBlock}">
								        <a href="javascript:void(0);" onclick="pageMove(${Share_md},${mySharePage.startPage-mySharePage.pageBlock}); return false;" >[이전]</a>
								    </c:if>
								    <c:forEach var="i" begin="${mySharePage.startPage}" end="${mySharePage.endPage}">
								        <a href="javascript:void(0);" onclick="pageMove(${Share_md}, ${i }); return false;" >[${i}]</a>
								    </c:forEach>
								    <c:if test="${mySharePage.endPage < mySharePage.totalPage}">
								        <a href="javascript:void(0);" onclick="pageMove(${Share_md},${mySharePage.startPage+mySharePage.pageBlock}); return false;" >[다음]</a>
								    </c:if>
								</div>            	
			            	</c:when> 
			            	
			            	<c:otherwise>
			            		<h3>작성한 글이 없습니다.</h3>
			            	</c:otherwise>
			            	
						</c:choose>
						
					</div> <!-- myShare -->
				</div> <!-- myShare-list -->
			  
				<!--------------------------------자유글 리스트 --------------------------------------->
				<div class="tab-pane fade" id="myCommu-list">
					<div id="myCommu">
						
							<c:choose>
				            	<c:when test="${not empty myCommuList }">
				            		<c:set var="num" value="${myCommuPage.total - myCommuPages.start+1 }"></c:set> 
					                <table class="boardtable">
					                    <thead>
					                        <tr>
					                            <th scope="col" class="th-num">번호</th>
					                            <th scope="col" class="th-title">제목</th>
					                            <th scope="col" class="th-nick">작성자</th>
					                            <th scope="col" class="th-date">등록일</th>
					                            <th scope="col" class="th-view_cnt">조회수</th>
					                            <th  scope="col" class="th-replyCount">댓글수</th>
					                            <th></th>
					                        </tr>
					                    </thead>                 
					                    <tbody id="body${commu_bd }">
					                        <c:forEach items="${myCommuList }" var="myCommuList">
					                            <tr>
					                                <td>${num}</td>
					                                <td><a href="detailCommunity?user_num=${myCommuList.user_num}&brd_num=${myCommuList.brd_num}">${myCommuList.title}</a></td>
					                                <td>${myCommuList.nick}</td>
					                                <td><fmt:formatDate value="${myCommuList.reg_date}" pattern="yyyy-MM-dd"/></td>
					                                <td>${myCommuList.view_cnt}</td>
									         		<td>${myCommuList.replyCount}</td>
									         		<td><a href="javascript:void(0);" onclick="myContsDelete(${commu_bd},${myCommuList.brd_num})">삭제</a></td>
									         		<c:set var="num" value="${num-1}"></c:set> 			       
					                            </tr>
					                        </c:forEach>
					                    </tbody>
					                </table>
					                
									   <div class="page">
									    <c:if test="${myCommuPage.startPage >myCommuPage.pageBlock}">					        
									        <a href="javascript:void(0);" onclick="pageMove(${commu_bd},${myCommuPage.startPage-myCommuPage.pageBlock}); return false;" >[이전]</a>
									    </c:if>
									    <c:forEach var="i" begin="${myCommuPage.startPage}" end="${myCommuPage.endPage}">					        
									        <a href="javascript:void(0);" onclick="pageMove(${commu_bd}, ${i }); return false;" >[${i}]</a>
									    </c:forEach>
									    <c:if test="${myCommuPage.endPage < myCommuPage.totalPage}">					        
									        <a href="javascript:void(0);" onclick="pageMove(${commu_bd},${myCommuPage.startPage+myCommuPage.pageBlock}); return false;" >[다음]</a>					        
									    </c:if>
									</div>            	
				            	</c:when> 
				            	
				            	<c:otherwise>
				            		<h3>작성한 글이 없습니다.</h3>
				            	</c:otherwise>
				            	
							</c:choose>  
					</div>
				</div>
				
				  
            </div>     <!-- tab-content -->               
	     </div><!-- col-12 -->	    
	    </div> <!-- row -->
     		</div>
    	</div>	
    </div>
</div>


    <button type="button" class="btn btn-primary" onclick="location.href='/chgCommManagement'">챌린지 카테고리 관리</button><p>
    <button type="button" class="btn btn-primary" onclick="location.href='/myConts'">내가 쓴 글 </button><p>
</body>
<%@ include file="footer.jsp" %>
</html>