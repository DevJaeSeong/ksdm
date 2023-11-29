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
	
	getForecastVo();
})

function getForecastVo() {
	
	let forecastId = '${forecastId}';
	let queryString = '';
	queryString += '?forecastId=' + forecastId;
	
	fetch('/getForecastVo.do' + queryString)
	.then(function(response) {
		
		if (response.ok) return response.json();
		else throw new Error(response.status +' 에러');
	})
	.then(function(forecastVo) {
		
		let programFileAreaHtml = '';
		programFileAreaHtml += '<input type="text" placeholder="' + forecastVo.programOriFileName + '" disabled="disabled">';
		programFileAreaHtml += '<a href="/fileDownload.do?fileName=' + forecastVo.programFileName + '" download="' + forecastVo.programOriFileName + '" class="down_btn_03">다운로드</a>';
		$('#programFileArea').html(programFileAreaHtml);
		
		let menualFileAreaHtml = '';
		menualFileAreaHtml += '<input type="text" placeholder="' + forecastVo.menualOriFileName + '" disabled="disabled">';
		menualFileAreaHtml += '<a href="/fileDownload.do?fileName=' + forecastVo.menualFileName + '" download="' + forecastVo.menualOriFileName + '" class="down_btn_03">다운로드</a>';
		$('#menualFileArea').html(menualFileAreaHtml);
		
		let refFilesAreaHtml = '';
		refFilesAreaHtml += '<li>' + forecastVo.pngOriFileName + '<a href="/fileDownload.do?fileName=' + forecastVo.pngFileName + '" download="' + forecastVo.pngOriFileName + '" class="down_btn02">다운로드</a></li>';
		refFilesAreaHtml += '<li>' + forecastVo.pdfOriFileName + '<a href="/fileDownload.do?fileName=' + forecastVo.pdfFileName + '" download="' + forecastVo.pdfOriFileName + '" class="down_btn02">다운로드</a></li>';
		refFilesAreaHtml += '<li>' + forecastVo.tifOriFileName + '<a href="/fileDownload.do?fileName=' + forecastVo.tifFileName + '" download="' + forecastVo.tifOriFileName + '" class="down_btn02">다운로드</a></li>';
		//refFilesAreaHtml += '<li>' + forecastVo.jpgOriFileName + '<a href="/fileDownload.do?fileName=' + forecastVo.jpgFileName + '" download="' + forecastVo.jpgOriFileName + '" class="down_btn02">다운로드</a></li>';
		
		$('#refFilesArea').html(refFilesAreaHtml);
		
		$('#forecastImg').attr('src', '/fileDownload.do?fileName=' + forecastVo.jpgFileName);
	})
	.catch(function(error) {
		
		alert('선택하신 과제는 등록된 자료가 없습니다.');
		console.error(error);
	})
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
				<p>예상분포</p>
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
                    <li><span>외래산림해충예측</span></li>
                    <li class="ro_last"><span>예상분포</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->

            <!-- S: .section -->
            <div class="section">
                <!-- S: .page_A -->
                <div class="page_A mt50">
                    <div class="page_inner04">
                    	<!--  
                        <select id="taskSelect" onchange="getForecastVo();" title="년도별 과제" class="select_02">
							<c:forEach items="${taskVos}" var="taskVo">
								<option value="${taskVo.taskId}">${taskVo.taskName}</option>
							</c:forEach>
                        </select>
                        -->
                    </div>
                    <div id="menualFileArea" class="input_wrap">
                    </div>
                    <div id="programFileArea" class="input_wrap">
                    </div>
                </div>
                <!-- E: .page_A -->
                <!-- S: .content_01 -->
                <div class="content_01 mt20">
                    <div class="cont_inner">
                        <div class="map_box">
                            <img id="forecastImg" class="map_img" src="" alt="예상분포 지도 이미지">
                        </div>
                    </div>
                    <ul id="refFilesArea" class="mt20 upload_list">
                    </ul>
                    <div style="text-align: right;">
                    	<button type="button" class="btn_type" onclick="location.href='/insectForecastPage.do'">목록</button>
                    </div>
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
	</div>
</body>
</html>