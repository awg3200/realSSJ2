<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챌린지 관리자 수정</title>
<script type="text/javascript">
	// 페이지 로딩 시 실행되는 함수
    $(document).ready(function () {
        // 비공개 라디오 버튼이 변경될 때의 이벤트 처리
        $('input[name="chg_public"]').change(function () {
            if ($('#private').prop('checked')) {
                // 비공개가 선택되었을 때만 비밀번호 입력란 활성화
                $('#priv_pswd').prop('disabled', false);
            } else {
                // 그 외의 경우에는 비밀번호 입력란 비활성화
                $('#priv_pswd').prop('disabled', true);
            }
        });
    });
	
	
	//DOMContentLoaded : HTML 문서가 완전히 로드되고 파싱되었을 때 발생하는 이벤트
	//					 문서의 모든 요소와 스타일, 스크립트 등이 브라우저에 의해 읽혀지고 해석된 상태
	//아래 함수는  페이지가 완전히 로드되어 브라우저에 표시되는 시점에 , 이미지, 스타일시트, 외부 스크립트 등의 추가 리소스 로딩이 완료되지 않아 DOM 구조를 조작하거나 스크립트를 실행하는 데 사용
    document.addEventListener("DOMContentLoaded", function() {
        var chgFreqValue = "${chg.freq}"; // ${chg.freq}의 값

        var freqSelect = document.getElementById("freq");

        for (var i = 0; i < freqSelect.options.length; i++) {
            if (freqSelect.options[i].value === chgFreqValue) {
                freqSelect.selectedIndex = i;
                break;
            }
        }
    });
    
    
	function validatePswd(input) {
		var inputValue = input.value;
		
		 if (/[^0-9]/.test(inputValue)) {
	            document.getElementById('warningMessage').innerText = '숫자만 입력 가능합니다.';
	        } else {
	            document.getElementById('warningMessage').innerText = '';
	        }
	}
	
	
	/* 인증 예시 이미지 수정버튼 클릭시 발동*/
	function sampleImgUpdate(){
		
		/* 수정 버튼 숨김 */
		$("#sampImgUpBtn").hide();
		
		/* 파일업로드 버튼 안보이게 되어있으면 보여주고 보이면 숨기기 */
		if($("#sample_img").css("display") == "none"){
			$("#sample_img").show();
		} else {
			$("#sample_img").hide();
			
		}
		 
	}
	
	
	/* 썸네일 수정 버튼 클릭시 발동 */
	function thumbUpdate(){
		
		/* 수정 버튼 숨기기 */
		$("#thumbUpdateBtn").hide();
		
		/* 파일업로드버튼 보이면 숨기고 안보이면 보이기 */
		if($("#thumb").css("display") == "none"){
			$("#thumb").show();
		} else {
			$("#thumb").hide();
		}
	}
	
	/* 썸네일 삭제버튼 클릭시 */
	function Deletethumb(){
		/* 썸네일 이미지 안보이게 숨기고 삭제버튼에 취소 적기 취소버튼 누르면 다시 이미지 보이기 */
		if($("#thumbImg").css("display") != "none"){
			$("#thumbImg").hide();
			$("#delBtn").html("취소");
			$("#delStatus").val(1);
		} else{
			$("#thumbImg").show();
			$("#delBtn").html("삭제");
			$("#delStatus").val(0);
		}
	}
	
</script>
</head>
<body>
<section class="py-11">
 <div class="container">
        <div class="row">
          <div class="col-12 text-center">
			
            <!-- Heading -->
            <div class="pt-10 pb-5">
            
            	<h3 class="mb-10">
            	<c:choose>
            		<c:when test="${state_md ==102 }">
		            	진행중 
            		</c:when>
            		<c:when test="${state_md ==103 }">
            			종료
            		</c:when>
            		<c:when test="${state_md ==104 }">
            			반려
            		</c:when>
            		<c:otherwise>
            			신청
            		</c:otherwise>
            	</c:choose>
            	챌린지 수정 관리</h3>
            </div>

          </div>
        </div>
        
        <div class="row">
        <!--사이드바   -->
        <%@ include file="adminSidebar.jsp" %>
        
        <div class="col-10">
        <form action="">
		<table class="table table-bordered table-sm mb-0">
			    <tr>
			      <th scope="row" style="width: 200px;" >챌린지명</th>
			      <td style="width: 350px;">
			      	<input type="text" maxlength="20" class="form-control form-control-sm" id="title" name="title" value="${chg.title }" required>
			      </td>
			      <th rowspan="3" style="width: 200px;">썸네일</th>
				  <td rowspan="3" style="text-align: center; width: 350px;">
					  <c:choose>
					  	<c:when test="${chg.thumb !=null }">
	                      	<img alt="챌린지 썸네일" src="${pageContext.request.contextPath}/upload/${chg.thumb}" id="thumbImg" style="width: 100%; height: 150px; border-radius: 10px;">
	                      	<input type="hidden" name="thumb" value="${chg.thumb}"><p>
	                      	
	                      	<!-- 썸네일 이미지 수정 / 삭제 버튼  -->
		                    <div class="pt-1">
			                    <button  type="button" class="btn btn-xxs btn-info mx-1" id="thumbUpdateBtn" onclick="thumbUpdate()">수정</button>
		    	                <button  type="button" class="btn btn-xxs btn-danger mx-1"  onclick="Deletethumb()" id="delBtn">삭제</button>
		                    </div>
		                    <!-- 썸네일 삭제 유무 -->
		                    <input type="hidden" name="delStatus" value="0" id="delStatus">
		                    <!-- 파일업로드 버튼 -->
							<input type="file" class="form-control" id="thumb" name="thumbFile" style="display: none;">
					  	</c:when>
					  	<c:otherwise>
					  		<!-- 썸네일 없을 경우 기본 이미지 -->
		                  	<img class="card-img-top" src="assets/img/chgDfaultImg.png" alt="userDfault" style="width: 100%; height: 150px; border-radius: 10px;">
					  	</c:otherwise>
					  </c:choose>
				  </td>
			    </tr>
			    <tr>
			      <th scope="row">개설자 아이디 </th>
			      <td>
			      	<input type="hidden" name="user_id" value="${chg.userId }">${chg.userId } 
		      	  </td>
			    </tr>
			      <th scope="row">개설자  닉네임</th>
			      <td>
			      	  <input type="hidden" name="nick" value="${chg.nick }">${chg.nick }
		      	  </td>
			    <tr>
			    </tr>
			    <tr>
			      <th scope="row">개설자 이름</th>
			      <td>
			      	<input type="hidden" name="userName" value="${chg.userName }"> ${chg.userName }
			      </td>
			      <th scope="row">카테고리</th>
			      <td>                    
				      <select class="form-select" style="width: 200px;" id="chg_md" name="chg_md" required>
	                      	<c:forEach var="category" items="${category }" varStatus="status">
	                      		<option  value="${category.md }" ${category.md == chg.chg_md ? 'selected' : ''}>${category.ctn }</option>
	                      	</c:forEach>
	                   </select>
			      </td>
			    </tr>
			    <tr>
			    	<c:if test='${chg.state_md == 104 }'>
				      <th scope="row">반려사유</th>
				      <td colspan="3">
					      <select class="form-select" style="width: 150px;" id="return_md" name="return_md" required>
	                      	<c:forEach var="rtnReason" items="${returnReason }" varStatus="status">
	                      		<option value="${rtnReason.md }"  ${rtnReason.md == chg.return_md ? 'selected' : ''}>${rtnReason.ctn }</option>
	                      	</c:forEach>
		                   </select>
				      </td>
			    	</c:if>
			    </tr>
			    <tr>
			      <th scope="row">참가자수 </th>
			      <td> <input type="hidden" value="${chgrParti }">${chgrParti }
			      <th>참여정원</th>
				  <td>
				      <input type="number" class="form-control form-control-xs" style="width: 200px;" name="chg_capacity" value="${chg.chg_capacity }" required>
				  </td>
			    </tr>
			    <tr>
			      <th scope="row">챌린지 소개</th>
			      <td colspan="3">
			       <textarea class="form-control form-control-zs" rows="5" id="chg_conts" type="text" name="chg_conts" maxlength="100" required >${chg.chg_conts }</textarea>
				  </td>
			    </tr>
			    <tr>
			      <th scope="row">인증방법</th>
			      <td colspan="3"><input type="text" class="form-control form-control-xs" name="upload" value="${chg.upload }" required></td>
			    </tr>
			    
			    <tr>
				    <th scope="row">인증빈도</th>
				    	<td> 
					    	<select class="form-select" id="freq" name="freq" required>
						    <option value="1">1일</option>
						    <option value="2">2일</option>
						    <option value="3">3일</option>
						    <option value="4">4일</option>
						    <option value="5">5일</option>
						    <option value="6">6일</option>
						    <option value="7">매일</option>
				  		</select>
				  		</td>
				      <th rowspan="3">인증 예시</th>
					  <td rowspan="3"  style="text-align: center;">
                      	<img alt="인증 방법" src="${pageContext.request.contextPath}/upload/${chg.sample_img}" style="width: 100%; height: 150px; border-radius: 10px;">
                      	<input type="hidden" value="${chg.sample_img}" name="sample_img">
                      	<div class="pt-2">
	                    <button type="button" class="btn btn-xxs btn-info mx-1" onclick="sampleImgUpdate()" id="sampImgUpBtn">수정</button>                    
	                    </div>
                    	<input type="file" class="form-control" id="sample_img" name="sampleImgFile" style="display: none;">
					  </td>
				</tr>
			    <tr>
			      <th scope="row">공개여부</th>
			      <td>
                   	<div class="text-center">
	                      <input class="btn-check btn-xs" type="radio" name="chg_public" id="public" value="0" ${chg.chg_public == '0' ? 'checked' : ''} >
	                      <label class="btn btn-xs btn-outline-border" for="public">공개</label>
	                      <input class="btn-check btn-xs" type="radio" name="chg_public" id="private" value="1" ${chg.chg_public == '1' ? 'checked' : ''}>
	                      <label class="btn btn-xs btn-outline-border" for="private">비공개</label>
                      	
                    </div>

			      </td>
			    </tr>
			    <tr>
			    
			      <th scope="row">비밀번호</th>
			      <td><input type="text" class="form-control form-control-xs" name="priv_pswd" value="${chg.priv_pswd != 0 ? chg.priv_pswd : ''}" ${chg.priv_pswd == 0 ? 'disabled' : ''} maxlength="4" id="priv_pswd" oninput="validatePswd(this)"></td>
			    </tr>
			    <tr>
			      <th scope="row">챌린지 신청일</th>
			      <td colspan="3"><input class="form-control form-control-xs" name="end_date" id="end_date" type="date" required value="${reg_date }"></td>
			    </tr>
			    <tr>
			      <th scope="row">챌린지 개설일</th>
			      <td colspan="3"><input class="form-control form-control-sm" name="end_date" id="end_date" type="date" required value="${create_date }"></td>
			    </tr>
			    <tr>
			      <th scope="row">챌린지 종료일</th>
			      <td colspan="3"><input class="form-control form-control-sm" name="end_date" id="end_date" type="date" required value="${end_date }"></td>
			    </tr>
		</table>
		<div class="d-flex justify-content-end mt-5">
			<button class="btn btn-sm btn-dark mx-1" onclick="currentPageMove()">목록</button>
			
		
			<!-- 챌린지 진행중, 반려 땐 수정/삭제, 종료엔 삭제 버튼만 활성화  -->
			<c:choose>
				<c:when test="${chg.state_md == 102 || chg.state_md == 104 }">
					<button class="btn btn-sm btn-info mx-1" type="submit" id="chgUpdate"  >수정</button>
					<button class="btn btn-sm btn-dark mx-1" onclick="approvReturnFn(0)" id="chgDelete" >삭제</button>
				</c:when>
				<c:when test="${chg.state_md == 103 }">
					<button class="btn btn-sm btn-dark mx-1" onclick="approvReturnFn(0)" id="chgDelete" >삭제</button>
				</c:when>
			</c:choose>

		</div>	
        </form>
		</div>
		<div class="py-10"></div>	
      </div>
      </div>
      </section>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>