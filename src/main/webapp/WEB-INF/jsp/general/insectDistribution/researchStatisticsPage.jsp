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
$(function() {
	
	intEvents();
})

function intEvents() {
	
}
   </script>
</head>

<body>
    <div class="wrap">
		<header class="header sub_hd">
			<jsp:include page="../common/headerDetail.jsp" />
		</header>
        <!-- S:.banner_info -->
        <div class="banner_info banner_04">
            <div class="tit_box">
                <p>조사통계</p>
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
                    <li><span>외래곤충분포</span></li>
                    <li class="ro_last"><span>조사통계</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .section -->
            <div class="section">
                <!-- S: .chart_tab -->
                <div class="chart_tab mt50">
                    <ul class="chart_box">
                        <li class="move"><a href="#none"><span>지역별</span></a></li><li class="move effect"><a href="#none"><span>곤충별</span></a></li>
                    </ul>
                </div>
                <!-- E: .chart_tab -->
                <!-- S: .title -->
                <div class="title mt20">
                    <p>지역별</p>
                </div>
                <!-- E: .title -->
                <!-- S: .page_A -->
                <div class="page_A mt50">
                    <div class="page_inner02">
                        <select title="최신등록순" class="select_01">
                            <option value="01">최근 3개월</option>
                            <option value="02">최근 6개월</option>
                            <option value="03">최근 1년</option>
                            <option value="04">최근 5년</option>
                            <option value="05">최근 10년</option>
                        </select>
                    </div>
                </div>
                <!-- E: .page_A -->
                <!-- S: .content_01 -->
                <div class="content_01">
                    <div class="cont_box02 mt20">
                        <div>
                            <p>지역</p>
                        </div>
                    </div>
                    <div class="cont_inner mt10"></div>
                    <div><a href="#none" class="down_btn">엑셀파일 다운로드</a></div>
                </div>
                <!-- E: .content_01 -->
            </div>
            <!-- E: .section -->
        </div>
        <!-- E: .main-->
        <footer class="foot_02">
			<jsp:include page="../common/footerDetail.jsp" />
        </footer>
    </div>
</body>
</html>