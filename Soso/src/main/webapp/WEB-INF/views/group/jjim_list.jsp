<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en-us">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width">
    <title>북마크</title>
    <link rel="shortcut icon" type="image/x-icon" href="${path }/resources/images/main/favicon.jpg">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/group/jjimlist.css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
  </head>
<body>
	<jsp:include page="/WEB-INF/views/include/navbar_c.jsp">
		<jsp:param value="home" name="current"/>
	</jsp:include>
	<section>
		<div class="inner-wrap">
			<c:forEach var="tmp" items="${list }">
				<div class="jjim_container">
					<input type="hidden" name="groupNum" value="${tmp.num}" />
					<div id="jjim_item_one">
						<div><img src="${pageContext.request.contextPath}${tmp.img_path}"/></div>
			        	<div class="jjim_subtitle">${tmp.name}</div>
					</div>
					<div id="jjim_item_two">
						<div id="jjim_item_two_header">
							<div>
								<div class="jjim_name">소모임장</div> 
									${tmp.manager_id}
								</div>
							<div>
							<div class="jjim_name">소모임 인원 현황</div> 
								${tmp.now_people } / ${tmp.max_people }
							</div>
						</div>
						<div id="jjim_item_two_body">
							<div class="jjim_name" style="display:block; margin-bottom:10px">소모임 소개 & 규칙</div> 
								<textarea id="group_caption" readonly>${tmp.caption}</textarea>
							</div>
						<div id="jjim_date">
							<div style="margin-right: 30px">
							<div class="jjim_name">소모임 활동 시작일</div> 
								<fmt:parseDate value="${tmp.start_dt}" var="start_dt" pattern="yy-MM-dd"></fmt:parseDate>
								<fmt:formatDate value="${start_dt}" pattern="yy-MM-dd" />
							</div>
							<div>
								<div class="jjim_name">소모임 활동 종료일</div>
								<fmt:parseDate value="${tmp.ended_dt}" var="ended_dt" pattern="yy-MM-dd"></fmt:parseDate>
								<fmt:formatDate value="${ended_dt}" pattern="yy-MM-dd" />
							</div>
						</div>
					</div>
			        <div id="jjim_item_three">
		     			<div id="heart_icon">
							<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="red" class="bi bi-heart-fill" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
							</svg>
						</div>
						<div class="group_deadlined_dt">
							<div id="deadline_content">
								<div class="jjim_name">신청 마감일</div>
								<fmt:parseDate value="${tmp.deadline_dt}" var="deadline_dt" pattern="yy-MM-dd"></fmt:parseDate>
								<fmt:formatDate value="${deadline_dt}" pattern="yy-MM-dd" />
							</div>
						</div>
						<!-- 모임 가입 , 취소, 마감 버튼  -->
						<div class="group_join_btn">
							<c:set var="now" value="<%= new java.util.Date() %>" />
							<c:set var="nowDate"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd" /></c:set>
							<c:choose>
								<c:when test="${tmp.deadline_dt lt nowDate}">
									<!-- 오늘 날짜와 비교해서 신청 마감 버튼으로 변경 -->
									<button type="button" class="disabled" disabled>신청 마감</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="join">
										<a href="${pageContext.request.contextPath}/group/group_joinform?num=${tmp.num }">가입 신청</a>
									</button>
								</c:otherwise>
							</c:choose>
						</div>
			        </div>
				</div>
		   	</c:forEach>
	   	</div>
	</section>
   	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
     	<!-- jQuery 라이브러리를 로드 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	    $(".container").on("click", ".heart", function(e) {
	        var $heart = $(this);
	
	        if ($heart.hasClass("clicked")) {
	            $heart.removeClass("clicked"); // 클래스 제거
	            //하트 비우기
	            $heart.html(`
	   				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
	   				    <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
	   				</svg>
	   			`);
	           
	        } else {
	            $heart.addClass("clicked"); // 클래스 추가
	            //하트 채우기
	            $heart.html(`
    				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
    				    <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
    				</svg>
    			`);
	        }	
	        var num = $heart.siblings('input[name="groupNum"]').val();
	        $.ajax({
	            url: "${pageContext.request.contextPath}/group/jjim",
	            method: "get",
	            data: { "num": num },
	            success: function(data){
	                if (data.isSuccess == true) {
	                    alert("찜 추가되었습니다.");
	                } else {
	                    alert("찜 취소하셨습니다.");
	                }            
	            }
	        });
	    });
	</script>
</body>
</html>
