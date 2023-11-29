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
		getInsectDetail(${insectNum});
	})
	
	function intEvents() {
		
	}
	
	function getInsectDetail(insectNum) {
		
		fetch('/getInsectByinsectNum.do?insectNum=' + insectNum)
		.then(response => {
			
			if (response.ok) return response.json();
			else throw new Error('네트워크 에러');
		})
		.then(insectVo => {
			
			let insectStatusVos = insectVo.insectStatusVos;
    		let status = '';
    		
    		$.each(insectStatusVos, function(index, insectStatusVo) {
    			
    			status += insectStatusVo.insectStatusName + ', ';
    		})
    		status = status.slice(0, -2);
			
			// 내용 구현 시작
	    	let html = '';
	    	
	    	html += '<li class="inner_02">';
	    	html += '<div class="detail_01">';
	    	html += '<div class="img"><img src="/fileDownload.do?fileName=' + insectVo.savedFileName + '" alt="' + insectVo.korSpecificName + ' 이미지"></div>';
	    	html += '<div class="img_txt_02">';
	    	html += '<p class="point_02">' + insectVo.taxon + '</p>';
	    	html += '<strong>' + insectVo.korSpecificName + '</strong>';
	    	html += '<span>' + insectVo.engSpecificName + '</span>';
	    	html += '<p class="condition"><span>관리현황</span>' + status + '</p>';
	    	html += '</div>';
	    	html += '</div>';
	    	html += '</li>';
	    	html += '<li class="detail_02">';
	    	html += '<p class="pb20">분포정보 : <span>' + insectVo.inflowPath + '</span></p>';
	    	html += '<p>형태정보 : <span>' + insectVo.description + '</span></p>';
	    	html += '</li>';
	    	
	    	$('#detailArea').empty();
	    	$('#detailArea').html(html);
	    	// 내용 구현 끝
		})
		.catch(error => { console.error('fetch에러 => ', error); });
	}
    </script>
</head>

<body>
    <div class="wrap">
		<header class="header sub_hd">
			<jsp:include page="../common/headerDetail.jsp" />
		</header>
         <!-- S:.banner_info -->
         <div class="banner_info">
            <div class="tit_box">
                <p>외래곤충상세</p>
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
                    <li><span>외래곤충정보</span></li>
                    <li class="ro_last"><span>외래곤충상세</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
             <!-- S: .cont-->
             <div class="cont mt80">
                <ul id="detailArea" class="cont_box">
                </ul>
            </div>
            <!-- E: .cont-->
        </div>
        <!-- E: .main-->
        <footer class="foot_02">
			<jsp:include page="../common/footerDetail.jsp" />
        </footer>
    </div>
</body>
</html>