<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header4.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<!--  CSS  -->
<link rel="shortcut icon" href="./assets/favicon/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="./assets/css/libs.bundle.css" />
<link rel="stylesheet" href="./assets/css/theme.bundle.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

 <meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css); 
    	body{
    	font-family: 'Noto Sans KR', sans-serif;} 
			
    </style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
function likePost(brd_num) {
  
	$.ajax({
	    type: 'POST',
	    url: '/board/' + brd_num + '/like', // 좋아요 업데이트를 처리할 서버 엔드포인트
	    data: { brd_num : brd_num }, // 업데이트할 게시물의 ID를 전송
	    success: function (response) {
	        // 성공 시 수행할 작업
	    },
	    error: function (error) {
	        // 오류 발생 시 수행할 작업
	    }
	});
}

//Select 변경 시
function renderTable(data) {
    if (data && data.length > 0) {
        var tableHTML = ''; // 초기화된 테이블 시작
        for (var i = 0; i < data.length; i++) {
            var board = data[i];
             tableHTML += "<div class='col-6 col-md-4' style='padding-left: 8px; padding-right: 8px;'>"+
                "<div class='card mb-7'>"+
                    "<div class='card-img'>"+
                        "<button class='btn btn-xs btn-circle btn-white-primary card-action card-action-end' onclick='likePost("+`${board.brd_num}`+")'>"+
                            "<i class='fe fe-heart'></i>"+
                       " </button>"+
                       "<button class='btn btn-xs w-100 btn-dark card-btn' onclick='location.href=\"detailSharing?user_num=" + board.user_num + "&brd_num=" + board.brd_num + "\"'>" +
                       "<i class='fe fe-eye me-2 mb-1'></i> 자세히 보기" +
                       "</button>" +

                      "<img class='card-img-top' src='/upload/"+board.img+"' alt='...' style='width: 100%; height: 200;'>"+
    					" </div>"+
                   " <div class='card-body fw-bold text-center'>"+
                       " <a class='text-body' href='detailSharing?user_num=`${board.user_num}`&brd_num=`${board.brd_num}`'>"+
                            board.title+
                       " </a><p>"+
                       " <a class='text-primary' href='detailSharing?user_num=`${board.user_num}`&brd_num=`${board.brd_num}`'>"+
                            board.price+"원</a><p>"+
                       " <a class='text-primary'><i class='fas fa-heart me-1'></i>"+
                       		board.like_cnt+"</a>"+
                        						"<i class='fe fe-eye me-1 mb-1' style='margin-left: 30px;'></i>"+
                        	board.view_cnt+
                        						"<i class='fas fa-comment text-secondary me-1' style='margin-left: 20px;'></i>"+
                        	board.replyCount+	"</div>"+"</div>"+"</div>"                    				
    				       
            ;
        }

       
        tableHTML += ''; // 테이블 닫기
        $('#boardtable').html(tableHTML); // boardtable에 새로운 데이터로 업데이트된 테이블 렌더링
    } else {
        $('#boardtable').html('<p>검색 결과가 없습니다.</p>');
    }
}

$("#sortOption").change(function() {
    var sortOption = $("#sortOption").val();

    $.ajax({
        type: "GET",
        url: "loadSortedPosts",
        data: { sort: sortOption },
        dataType: "json",
        success: function(data) {
            console.log("응답 데이터: ", data);
            renderTable(data); // 테이블 렌더링 함수 호출
        },
        error: function(xhr, status, error) {
            console.log("정렬 아작스 호출 실패: " + error);
        }
    });
});
});

    // yr 작성
	// 찜하기 기능
    // ajax 작동 후 찜 갯수 count 되는거 구현해볼까
	function sharingPick(p_index) {
        // alert("sharingPick" + p_index);

        $.ajax({
            url: "/likePro",
            type: "POST",
            data: { brd_num: p_index },
            dataType: 'json',
            success: function (likeResult) {
                if (likeResult.likeProResult > 0) {
                    $("#sharingPick" + p_index).removeClass("btn-white-primary").addClass("btn-primary");
                } else {
                    $("#sharingPick" + p_index).removeClass("btn-primary").addClass("btn-white-primary");
                }

            },
            error: function () {
                alert("찜하기 오류");
            }
        });
    }
	
</script>

</head>
<body>
   <section class="pt-7 pb-12">
      <div class="container">
        <div class="row">
          <div class="col-12 text-center">

            <!-- Heading -->
            <h3 class="mb-10">쉐어링 게시판</h3>

          </div>
        </div>
        <div class="row">
          <div class="col-12 col-md-3">

            <!-- Nav -->
            <nav class="mb-10 mb-md-0">
              <div class="list-group list-group-sm list-group-strong list-group-flush-x">
                <a class="list-group-item list-group-item-action dropend-toggle active" href="../sharing">
                  	전체 쉐어링
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle " href="account-wishlist.html">
                 	찜한 쉐어링
                </a>
                <a class="list-group-item list-group-item-action dropend-toggle " href="/mySharing">
                 	내가 쓴 글
                </a>
               <a class="btn w-100 btn-dark mb-2" href="sharingUserDetail" style=" margin-top: 50px;">게시글 작성하기
               </a>
                
              </div>
            </nav>
 			<!-- Nav End -->
          </div>
              
          <div class="col-12 col-md-9 col-lg-8 offset-lg-1">
            <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-between mb-3">
                <!-- 공간을 벌리기 위해 클래스 추가 -->
            </div>
            <div class="d-flex justify-content-end mb-3">
			<select class="form-select form-select-xxs w-auto" id ="sortOption"name="sortOption">
			    <option value="reg_date">최근 게시물</option>
			    <option value="view_cnt">조회수 높은 순</option>
			</select>
			

            </div>
            </div>
  <div class="row" id="boardtable">
    <c:forEach var="board" items="${sharing}">
    
        <div class="col-6 col-md-4" style="padding-left: 8px; padding-right: 8px;">
            <div class="card mb-7">
                <div class="card-img">
    
                    <!-- YR 작성 -->
                    <!-- 쉐어링 찜하기 -->
                    <c:choose>
                        <c:when test="${sessionScope.user_num != null}">
                            <!-- 로그인 한 상태 -->
                            <c:choose>
                                <c:when test="${board.like_cnt > 0}">
                                    <!-- 찜하기 있음 -->
                                    <button type="button"
                                        class="btn btn-xs btn-circle btn-primary card-action card-action-end"
                                        data-toggle="button" onclick="sharingPick(${board.brd_num})"
                                        id="sharingPick${board.brd_num}">
                                        <i class="fe fe-heart"></i>
                                    </button>
                                </c:when>
    
                                <c:otherwise>
                                    <!-- 찜하기 없음 -->
                                    <button type="button"
                                        class="btn btn-xs btn-circle btn-white-primary card-action card-action-end"
                                        data-toggle="button" onclick="sharingPick(${board.brd_num})"
                                        id="sharingPick${board.brd_num}">
                                        <i class="fe fe-heart"></i>
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
    
                        <c:otherwise>
                            <!-- 로그인 안 한 상태 -->
                            <button type="button"
                                class="btn btn-xs btn-circle btn-white-primary card-action card-action-end"
                                data-toggle="button" onclick="location.href='/loginForm'">
                                <i class="fe fe-heart"></i>
                            </button>
                        </c:otherwise>
                    </c:choose>
    
                    <button class="btn btn-xs w-100 btn-dark card-btn"
                        onclick="location.href='detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}'">
                        <i class="fe fe-eye me-2 mb-1"></i> 자세히 보기
                    </button>
    
                    <img class="card-img-top" src="${pageContext.request.contextPath}/upload/${board.img}" alt="..."
                        style="width: 100%; height: 200;">
                </div>
                
                <div class="card-body fw-bold text-center">
                    <a class="text-body" href="detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}">
                        ${board.title}
                    </a>
                    <p>
                        <a class="text-primary" href="detailSharing?user_num=${board.user_num}&brd_num=${board.brd_num}">
                            ${board.price}원</a>
                    <p>
                        <a class="text-primary" id="likeCnt${board.brd_num}">
                            <i class="fas fa-heart me-1"></i> ${board.like_cnt}
                        </a>
                        <i class="fe fe-eye me-1 mb-1" style="margin-left: 20px;"></i> ${board.view_cnt}
                        <i class="fas fa-comment text-secondary me-1" style="margin-left: 20px;"></i>${board.replyCount}
                </div>
    
            </div>
        </div>
    </c:forEach>
</div>


           

          </div>
        </div>
      </div>
      </div>
    </section>
  
  
  
  
  
  
  
  
  
  
  
   
</body>

<%@ include file="footer.jsp" %>
</html>
