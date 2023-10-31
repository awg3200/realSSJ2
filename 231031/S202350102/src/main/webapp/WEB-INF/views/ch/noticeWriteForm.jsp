<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ include file="../header.jsp" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeWriteForm공지 및 이벤트 글 작성 </title>
</head>
<body>
	<c:if test="${brd_md == 105 }">공지</c:if>
	<c:if test="${brd_md == 106 }">이벤트</c:if>
	<form action="noticeWrite" method="post">
		<input type="hidden" value="${brd_md }" name="brd_md">
		<table>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" required="required"></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="hidden" name="user_num"  value="${user_num }">${user_num }</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea rows="30" cols="30" name="conts" required="required"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="확인">
				</td>
			</tr>
			
		</table>
		
		
	</form>
</body>
</html>