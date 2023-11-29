<%@page import="egovframework.ksdmWeb.security.UserDetailVo"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>

	<% Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); %>
	<jsp:include page="../common/head.jsp" />
		
	<script type="text/javascript">
	$(function() {
		
	})
	</script>
	
</head>

<body>
    <div class="wrap">
    
		<jsp:include page="../common/header.jsp" />
		
        <!-- 조사자 정보시작 -->
        <div class="profile_box">
            <div class="profile_inner">
                <div class="profile_img mt20">
                    <img src="../css/user/mobile/images/log_human.png" alt="사용자사진">
                </div>
                <div class="profile_info">
                    <p class="f_03 mt10 mb20"><%= ((UserDetailVo) authentication.getDetails()).getUserName() %>님</p>
                </div>
            </div>
        </div>
        <!-- 조사자 정보끝 -->
        
        <!-- .respon_box 시작  -->
        <div class="respon_box mt30">
            <a href="/user/research/participatedRresearchListPage.do" class="direct_btn c_navy" title="나의 과제내역 바로가기">
                <p class="icon_01">나의 과제내역</p>
                <img src="../css/user/mobile/images/icon_next_img.png" alt="이동 예시아이콘">
            </a>
            <a href="/user/research/researchListPage.do" class="direct_btn c_navy mt10" title="모집중인 내용 바로가기">
                <p class="icon_02">모집중인 내용</p>
                <img src="../css/user/mobile/images/icon_next_img.png" alt="이동 예시아이콘">
            </a>
            <!--  
            <a href="/user/research/forecastImgaeUploadPage.do" class="direct_btn c_navy mt10" title="예측이미지 업로드 바로가기">
                <p class="icon_03">예측이미지 업로드</p>
                <img src="../css/user/mobile/images/icon_next_img.png" alt="이동 예시아이콘">
            </a>
            -->
            <a href="/user/accountInfoPage.do" class="direct_btn c_navy mt10" title="나의 정보 바로가기">
                <p class="icon_04">나의 정보</p>
                <img src="../css/user/mobile/images/icon_next_img.png" alt="이동 예시아이콘">
            </a>
        </div>
        <!-- .respon_box 끝  -->
        
    </div>
</body>
</html>