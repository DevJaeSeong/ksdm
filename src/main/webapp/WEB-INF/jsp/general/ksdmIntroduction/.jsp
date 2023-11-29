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
    
    <script type="text/javascript">
    </script>
</head>

<body>
    <div class="wrap">
		<header class="header sub_hd">
			<jsp:include page="../common/headerDetail.jsp" />
		</header>
        <!-- S:.banner_info -->
        <div class="banner_info banner_03">
            <div class="tit_box">
                <p>비전 및 목표</p>
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
                    <li><span title="K-SDM소개">K-SDM소개</span></li>
                    <li class="ro_last"><span title="비전 및 목표">비전 및 목표</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .content_01-->
            <div class="content_01 mt70">
                <img src="/css/general/images/vision_img.jpg" alt="">
            </div>
            <!-- E: .content_01-->
        </div>
        <!-- E: .main-->
        <footer class="foot_02">
			<jsp:include page="../common/footerDetail.jsp" />
        </footer>
    </div>
</body>
</html>