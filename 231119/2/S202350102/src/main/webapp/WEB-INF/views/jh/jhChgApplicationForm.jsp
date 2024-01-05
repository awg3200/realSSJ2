<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	function ajaxRecommendList(pChg_md){
		$.ajax({
			url: '/recommendCallenge',
			data: {chg_md : pChg_md},
			dataType:'json',
			success:function (recomChgList) {
				 var text;
		          if (recomChgList.length === 0) {
		                // 만약 결과 값이 없을 때의 처리
		                text = '<div class="col text-center">아직 개설된 챌린지가 없습니다.<p>새로운 챌린지를 개설해 주세요! </div>';
		            } else {
		                text = recomList(recomChgList);
		            }

				 $('#recomSlider').html(text);
				    // Flickity 인스턴스 제거
		            var flkty = $('#recomSlider').data('flickity');
		            if (flkty) {
		                flkty.destroy();
		            }
				 initFlickity();
				 
	        }
	    });
	}

	function recomList(recomChgList) {
	    var text = "";
	    for (var i = 0; i < recomChgList.length; i++) {
	        var item = recomChgList[i];
	        var contextPath = $('#contextPath').val();
	        text += '<div class="col px-4" style="max-width: 200px;">';
	        text += '<div class="card">';
	        text += '<img class="card-img-top" id="recomChgThumb' + i + '" style="width: 100%; width:150px; height: 150px; border-radius: 10px;" src="' + contextPath + item.thumb + '" alt="이미지 불러오기에 실패했습니다">';
	        text += '<div class="card-body py-4 px-0 text-center">';															
	        text += '<a class="stretched-link text-body" id="rcomChgUrl' + i + '" href="/chgDetail?chg_id=' + item.chg_id + '" onclick="return confirm(\'페이지를 이동하시면 작성중인 내용이 사라질 수 있습니다. 이동하시겠습니까?\');">';
	        text += '<label class="form-check-label" id="recomChgTitle' + i + '" for="rcomChgUrl">' + item.title + '</label>';
	        text += '</a>';
	        text += '</div>';
	        text += '</div>';
	        text += '</div>';
	    }
	    return text;
	}
	
		// Flickity 초기화 함수
	function initFlickity() {
	
	    // Flickity 초기화 초기화 위해 객체 생성
	    var flkty = new Flickity('#recomSlider', {
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

		
		
		
	function chk(){
		return confirm("챌린지를 신청하시겠습니까?");
		 
	}	
/* 	$(document).ready(function() {
	    // 페이지 로딩 후 초기 설정
	    if ($('#exercise').prop('checked')) {
	        ajaxChallengeList(100);
	    }
	}

	
	function recomList(RecommendationResult) {
	    var text = "";
	    for (var i = 0; i < RecommendationResult.recomChgListSize; i++) {
	        var chg_id = RecommendationResult.recomChgList[i].chg_id;
	        var thumb = RecommendationResult.recomChgList[i].thumb;
	        var title = RecommendationResult.recomChgList[i].title;

	        text += '<div class="col px-4" style="max-width: 200px;">';
	        text += '<div class="card">';

	        // Image
	        text += '<img class="card-img-top" src="' + thumb + '" alt="...">';

	        // Body
	        text += '<div class="card-body py-4 px-0 text-center">';
	        text += '<a class="stretched-link text-body" href="/chgDetail?chg_id=' + chg_id + '">';
	        text += '<label class="form-check-label" for="rcomChgUrl">' + title + '</label>';
	        text += '</a>';
	        text += '</div>';

	        text += '</div>';
	        text += '</div>';
	    }
	    return text;
	} */
				
	   
	 /*     function recomList(RecommendationResult){
	        var text = "";
	         for(var i = 0; i < RecommendationResult.recomChgListSize; i++ ){
	             text +='<div class="col px-4" style="max-width: 150px;">'
	                 + '<div class="card">'
	               + '<div class="card-img">'
	               + '<button class="btn btn-xs w-100 btn-dark card-btn" data-bs-toggle="modal" id="chgDetailBtn" onclick="/chgDetail?chg_id='${RecommendationResult.recomChgList.chg_id}'">'
	               + '<i class="fe fe-eye me-2 mb-1"></i> 챌린지 보러가기'
	                 + '</button>'
	               + '<img id="recommendChgImg" class="card-img-top" src="'${RecommendationResult.thmb}'" alt="">
	               + '</div>'
	                 + '<div class="card-body fw-bold text-center">'
	                 + '<a class="text-body" id="recommendChgTitle" href="/chgDetail?chg_id='${RecommendationResult.recomChgList.chg_id}'">'${RecommendationResult.recomChgList.title}'</a> <br>'
	                 + '</div>'
	                 + '</div>'
	                 + '</div>'
	          }
	          return text;
	       }
	           */   
		
				
				
				
			
</script>
<title>당신만의 챌린지를 신청하세요</title>
</head>
<body>
<button onclick="location.href='/modify'"></button>
 <section class="pt-7 pb-12">
      <div class="container">
        <div class="row">
          <div class="col-12 text-center">

            <!-- Heading -->
            <h3 class="mb-10">챌린지 신청</h3>

          </div>
        </div>
        
        <div class="row">
        <!-- 나중에 진짜 사이드바 만들면 추가하기 -->
         <%@ include file="/WEB-INF/views/jh/side.jsp" %>
         
          <div class="col-12 col-md-9 col-lg-8 offset-lg-1">
			<h5>${user.nick }님이 원하시는 챌린지는?</h5>
			
			
			
			
            <!-- Form -->
            <form action="/chgApplication" onsubmit="return chk()" method="post" enctype="multipart/form-data">
              <input type="hidden" name="user_num" value="${user.user_num}">
              <input type="hidden" name="contextPath" id="contextPath" value="${pageContext.request.contextPath}/upload/">
<%-- 필요한가
			  <input type="hidden" name="userStatus" value="${userStatus}">
 --%>              
 			  <div class="row">
 			  
 			  
                <div class="col-12">
				
                  <!-- 카테고리 -->
                  <div class="form-group">
                  	<label class="form-label" for="accountFirstName">
                     	카테고리
                    </label>
                    
	                <div class="input-group mb-3  d-flex justify-content-between border-1">
                    <c:forEach var="category" items="${category }" varStatus="status">
	                    	<div class="input-group-text border-0">
								<input class="form-check-input" 
								       type="radio" 
								       name="chg_md" 
								       id="category${status.index}"
								       ${status.index == 0 ? 'checked' : ''} 
								       value="${category.md }"  
								       required="required"
								       onclick="ajaxRecommendList(${category.md })">
	                    		<label class="form-check-label" for="category${status.index}">${category.ctn }</label>
	                    	</div>
	              	</c:forEach>

					</div>
                  </div>

                </div>
                
<div class="container">
        <div class="row">
          <div class="col-12">

            <!-- Heading -->
           <span class="mb-10">이런 챌린지는 어떠세요?</span><p>
                     <div class="alert alert-warning">
                     카테고리를  선택하시면 기존에 개설된 챌린지 리스트가 나옵니다!
</div>
            

            <!-- Content -->
            <div class="tab-content">

              <!-- Pane -->
              <div class="tab-pane fade show active" id="topSellersTab">

                <!-- Slider -->
                <div id="recomSlider" class="flickity-buttons-lg flickity-buttons-offset px-lg-12" data-flickity='{"prevNextButtons": true}' >

                    <c:forEach var="recomgList" items="${recomChgList }" varStatus="status">
	                  <!-- Item -->
	                  <div class="col px-4" style="max-width: 200px;">
	                    <div class="card">
	
	                      <!-- Image -->
	                      	<img class="card-img-top" id="recomChgThumb${status.index}" style="width: 100%; width:150px; height: 150px; border-radius: 10px;" src="${pageContext.request.contextPath}/upload/${recomgList.thumb }" alt="이미지  불러오기에 실패했습니다">
	
	                      <!-- Body -->
	                      <div class="card-body py-4 px-0 text-center">
	
	                        <!-- Heading -->
	                        <a class="stretched-link text-body" id="rcomChgUrl${status.index}" href="/chgDetail?chg_id=${recomgList.chg_id }" onclick="return confirm('페이지를 이동하시면 작성중인 내용이 사라질 수 있습니다. 이동하시겠습니까?');">
	                        <label class="form-check-label" id="recomChgTitle${status.index}" for="rcomChgUrl">${recomgList.title }</label>
	                        </a>
	
	                      </div>
	
	                    </div>
	                  </div>
	                </c:forEach>
				</div>
				</div>
			  </div>
			  </div>
			  </div>
			  </div>
				
                <div class="col-12">

                  <!-- 챌린지명 -->
                  <div class="form-group">
                    <label class="form-label" for="title">
                      	챌린지명
                    </label>
                    <input class="form-control form-control-sm" id="title" type="text" name="title" required>
                  </div>

                </div>
                
                
                <div class="col-12">

                  <!-- 챌린지 소개-->
                  <div class="form-group">
                    <label class="form-label" for="chg_conts">
                      	챌린지 소개
                    </label>
                    <textarea class="form-control form-control-sm" rows="5" id="chg_conts" type="text" name="chg_conts" required placeholder="예) 건강을 위해서 우리 다함께 매일 만보를 걷는 챌린지를 해봐요~"></textarea>
                  </div>

                </div>
                
                
				<!-- 종료 날짜를 오늘 이후 날짜로 입력하게 하기 -->
                <div class="col-12">
                  <!--  -->
                  <div class="form-group">
                    <label class="form-label" for="end_date">
                     	종료 날짜
                    </label>
                    <div class="alert alert-warning">
						관리자가 승인하면 그때부터 챌린지가 시작됩니다!<br>
						승인까지 3~5일이 소요되니 이 점 유의하시고 종료 날짜를 선택해 주시길 바랍니다.
					</div>
                    <input class="form-control form-control-sm" name="end_date" id="end_date" type="date" required>
                  </div>

                </div>
                
                
                
                <div class="col-12 col-md-6">

                  <!--  -->
                  <div class="form-group">
                    <label class="form-label" for="chg_capacity">
                      	참여 인원
                    </label>
                    <input type="number" class="form-control" name="chg_capacity" id="chg_capacity" max="50" min="1"  required="required">
                  </div>

                </div>
                <div class="col-12">
                  <!--  -->
                  <div class="form-group">
                    <label class="form-label" for="freq">
                     	인증 빈도
                    </label>
					<select class="form-select" id="freq" name="freq" required="required">
				    <option selected value="" selected disabled hidden>일주일에 인증할 횟수를 선택해 주세요</option>
				    <option value="1">1일</option>
				    <option value="2">2일</option>
				    <option value="3">3일</option>
				    <option value="4">4일</option>
				    <option value="5">5일</option>
				    <option value="6">6일</option>
				    <option value="7">매일</option>
				  	</select>
                  </div>

                </div>
                
                
                <div class="col-12 ">

                  <!-- 챌린지명 -->
                  <div class="form-group">
                    <label class="form-label" for="verificationMethod">
                      	인증 방법
                    </label>
					<input type="text" class="form-control" placeholder="예)하루 만보 걷기 챌린지 : 매일 만보를 걷고 만보가 적힌 만보기 사진을 올려주세요 " id="verificationMethod" name="upload"  required="required">
                  </div>

                </div>
                
                <div class="col-12">

                  <!-- 인증예시 사진 -->
                  <div class="form-group">
                    <label class="form-label" for="sample_img">
                      	인증 예시
                    </label>
					<input type="file" class="form-control" id="sample_img" name="sampleImgFile" required>
                  </div>

                </div>
                
                 <div class="col-12 col-lg-6">

                  <!-- Gender -->
                  <div class="form-group mb-3">

                    <!-- Label -->
                    <label class="form-label">공개 여부</label>
                    <!-- Inputs -->
                    <c:choose>
                    	<c:when test="${user.status_md == 101}">
	                    	<div>
		                      <!-- Male -->
		                      <input class="btn-check" type="radio" name="chg_public" id="public" value="0" checked>
		                      <label class="btn btn-sm btn-outline-border" for="public">공개</label>
		
		                      <!-- Female -->
		                      <input class="btn-check" type="radio" name="chg_public" id="private" value="1">
		                      <label class="btn btn-sm btn-outline-border" for="private">비공개</label>
		
		                    </div>
                    	</c:when>
                    	<c:otherwise>
                    	
	                    	<div>
		                      <!-- Male -->
		                      <input class="btn-check" type="radio" name="chg_public" id="public" disabled>
		                      <label class="btn btn-sm btn-outline-border" for="public">공개</label>
		
		                      <!-- Female -->
		                      <input class="btn-check" type="radio" name="chg_public" id="private" disabled>
		                      <label class="btn btn-sm btn-outline-border" for="private">비공개</label>
		                    </div>
                    	</c:otherwise>
                    </c:choose>
                    

                  </div>

                </div>
                
                
                <div class="col-12 col-md-6">

                  <!-- Password -->
                  <div class="form-group mb-3">
                    <label class="form-label" for="priv_pswd">
                      	비밀번호
                    </label>
                     <c:choose>
                    	<c:when test="${user.status_md == 101}">
							<input type="password" class="form-control" id="priv_pswd" name="priv_pswd" pattern="[0-9]{4}" title="4자리 숫자로 입력하세요."  required="required">
					 	</c:when>
					
                     	<c:otherwise>
							<input type="password" class="form-control" id="priv_pswd" name="priv_pswd"  disabled>
					 	</c:otherwise>
                    </c:choose>
                  </div>

                </div>
				<div class="alert alert-warning">
					멤버십 가입자만 공개/비공개 설정을 할 수 있습니다~!
				</div>
                <div class="col-12">

                  <!-- 썸네일 -->
                  <div class="form-group">
                    <label class="form-label" for="thumb">
                      	썸네일
                    </label>
					<input type="file" class="form-control" id="thumb" name="thumbFile">
                  </div>

                </div>
         
               
                <div class="col-12">

                  <!-- Button -->
                  <button class="btn btn-dark" type="submit" onsubmit="return chk()">Save Changes</button>

                </div>
              </div>
            </form>

          </div>
        </div>
      </div>
    </section>


</body>
</html>