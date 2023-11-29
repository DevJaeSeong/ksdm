<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../common/head.jsp" />

<link rel="stylesheet" href="/css/general/css/meyer_reset2.0.css">
<link rel="stylesheet" href="/css/general/css/default.css">
<link rel="stylesheet" href="/css/general/css/font.css">
<link rel="stylesheet" href="/css/general/css/slick.css">
<link rel="stylesheet" href="/css/general/css/slick-theme.css">
<link rel="stylesheet" href="/css/general/css/common.css">
<link rel="stylesheet" href="/css/general/css/main.css">
<link rel="stylesheet" href="/css/general/css/content1.css">

<script src="/css/general/js/3.6.0.js"></script>
<script src="/css/general/js/slick.js"></script>
<script src="/css/general/js/common.js"></script>

<style type="text/css">
#uploadedFileArea {
	min-height: 25px;
	height: 25px;
}
   
#uploadedFile {
	cursor: pointer;
}

#uploadedFile:hover {
	color: #005fb1;
}
</style>
   
<script type="text/javascript">

</script>
</head>

<body>
    <div class="wrap">
		<header class="header sub_hd">
			<jsp:include page="../common/headerDetail.jsp" />
		</header>
        <!-- S:.banner_info -->
        <div class="banner_info banner_02">
            <div class="tit_box">
                <c:choose>
			        <c:when test="${boardVo.boardDiv == 1000}">
		                <p>공지사항</p>
			        </c:when>
			        <c:when test="${boardVo.boardDiv == 2000}">
		                <p>보도자료</p>
			        </c:when>
			        <c:when test="${boardVo.boardDiv == 3000}">
		                <p>자료실</p>
			        </c:when>		        
		        </c:choose>
            </div>
        </div>
        <!-- E:.banner_info -->
        <!-- S: .main-->
        <div class="main">
            <div class="bor100"></div>
            <!-- S: .rocate -->
            <div class="rocate">
                <ul>
                    <li class="bor_l"><a href="#none"></a></li>
                    <li><span>정보마당</span></li>
	                <c:choose>
				        <c:when test="${boardVo.boardDiv == 1000}">
				        	<li class="ro_last"><span>공지사항</span></li>
				        </c:when>
				        <c:when test="${boardVo.boardDiv == 2000}">
				        	<li class="ro_last"><span>보도자료</span></li>
				        </c:when>
				        <c:when test="${boardVo.boardDiv == 3000}">
				        	<li class="ro_last"><span>자료실</span></li>
				        </c:when>		        
			        </c:choose>
                </ul>
            </div>
            <!-- E: .rocate -->
             <!-- S: .container_p -->
            <div class="container_p">
                <div class="container">
                    <article id="boardArea" class="board_view">
                        <p class="title_02">${boardVo.boardSubject}</p>
                        <ul class="info">
                            <li><strong>작성자</strong><span>${boardVo.regNm}</span></li>
                            <li class="date"><strong>등록일</strong><span>${boardVo.regDate}</span></li>
                            <li class="hit"><strong>조회수</strong><span>${boardVo.views}</span></li>
                        </ul>
                        <div class="contents">
                            <p>${boardVo.boardContents}</p>
                        </div>
                       	<c:if test="${not empty boardVo.attachFilenm}">
                       	 	<div id="uploadedFileArea" class="contents">
                        		<a><img src="/css/admin/images/file_img.png" alt="첨부파일 이미지"></a>
			                    <a id="uploadedFile" href="/fileDownload.do?fileName=${boardVo.attachFilenm}" download="${boardVo.attachement}">${boardVo.attachement}</a>
	                        </div>
                       	</c:if>
                    </article>
                    <p class="board_btns">
						<c:choose>
							<c:when test="${boardVo.boardDiv == 1000}">
                       			<button type="button" class="btn_type" onclick="location.href='/boardListPage.do?boardDiv=1000'">목록</button>
					        </c:when>		    
							<c:when test="${boardVo.boardDiv == 2000}">
                       			<button type="button" class="btn_type" onclick="location.href='/boardListPage.do?boardDiv=2000'">목록</button>
					        </c:when>		    
							<c:when test="${boardVo.boardDiv == 3000}">
                       			<button type="button" class="btn_type" onclick="location.href='/boardListPage.do?boardDiv=3000'">목록</button>
					        </c:when>
						</c:choose>
                    </p>
                    <!--  
                    <ul class="prevnext">
                        <li class="prev"><span>이전글</span><a href="#none">10차 조사원 모집공고_01</a></li>
                        <li class="next"><span>다음글</span><a href="#none">10차 조사원 모집공고_03</a></li>
                    </ul>
                    -->
                </div>
            </div>
            <!-- E: .container_p -->
        </div>
        <!-- E: .main-->
        <footer class="foot_02">
			<jsp:include page="../common/footerDetail.jsp" />
        </footer>
    </div>
</body>
</html>