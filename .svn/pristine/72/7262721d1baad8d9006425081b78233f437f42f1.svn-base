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
a.current {
	background-color: #f2f2f2;
}
</style>
   
<script type="text/javascript">
$(function() {
	
	intEvents();
	getInsectList();
})

function intEvents() {
	
	history.pushState(null, null, '/insectSearchPage.do');
	$('#pageUnitSelect').on('change', function() { getInsectList(); });
	$('#sortSelect').on('change', function() { getInsectList(); });
	$('#searchBarBtn').on('click', function() { getInsectList(); });
}

function getInsectList(pageIndex) {
	
	if (pageIndex == undefined || pageIndex == '' || pageIndex == 0) pageIndex = 1;
	
	let pageUnit = $('#pageUnitSelect').val();
	let searchKeyword = $('#searchKeyWord').val();
	let sort = $('#sortSelect').val();
	
	let queryString = '';
	queryString += '?pageIndex=' + pageIndex;
	queryString += '&pageUnit=' + pageUnit;
	queryString += '&searchKeyword=' + searchKeyword;
	queryString += '&sort=' + sort;
	
	fetch('/getInsectList.do' + queryString)
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error('네트워크 에러');
	})
	.then(data => {
		
		let insectVos = data.insectVos;
		let paginationInfo = data.paginationInfo;
		
		// 총 개수 화면 시작
		let totalCountHtml = '';
		totalCountHtml += '<span class="total">전체<b>' + paginationInfo.totalRecordCount + '건</b></span>';
		totalCountHtml += '<span>현재페이지 <strong>' + paginationInfo.currentPageNo + '</strong>/<b>' + paginationInfo.lastPageNo + '</b></span>';
		
		$('#totalCountArea').empty();
    	$('#totalCountArea').html(totalCountHtml);
		// 총 개수 화면 끝
		
		// 내용 구현 시작
    	let html = '';
    	
    	$.each(insectVos, function(index, insectVo) {
    		
    		let insectStatusVos = insectVo.insectStatusVos;
    		let status = '';
    		
    		$.each(insectStatusVos, function(index, insectStatusVo) {
    			
    			status += insectStatusVo.insectStatusName + ', ';
    		})
    		status = status.slice(0, -2);
    		
    		html += '<li class="inner">';
    		html += '<div>';
    		html += '<div id="insect' + insectVo.insectNum + '" class="img"><img src="/fileDownload.do?fileName=' + insectVo.savedFileName + '" alt="' + insectVo.korSpecificName + ' 이미지"></div>';
    		html += '<div class="img_txt">';
    		html += '<p class="point">' + insectVo.taxon + '</p>';
    		html += '<strong>' + insectVo.korSpecificName + '</strong>';
    		html += '<span>' + insectVo.engSpecificName + '</span>';
    		html += '<p class="condition" title="' + status + '"><span>관리현황</span>' + status + '</p>';
    		html += '<a href="#none" class="cont_btn" onclick="insectDetail(' + insectVo.insectNum + ')"><span>자세히보기</span></a>';
    		html += '</div>';
    		html += '</div>';
    		html += '</li>';
    	});
    	
    	$('#insectList').empty();
    	$('#insectList').html(html);
    	// 내용 구현 끝
    	
    	// 버튼 구현 시작
    	let prev = (paginationInfo.firstPageNoOnPageList == 1 ? 1 : (paginationInfo.currentPageNo - paginationInfo.pageSize < 1 ? 1 : paginationInfo.currentPageNo - paginationInfo.pageSize));
		let next = (paginationInfo.lastPageNoOnPageList == paginationInfo.lastPageNo ? paginationInfo.lastPageNo : (paginationInfo.currentPageNo + paginationInfo.pageSize > paginationInfo.lastPageNo ? paginationInfo.lastPageNo : paginationInfo.currentPageNo + paginationInfo.pageSize));
    	let pagingHtml = '';

    	pagingHtml += '<button type="button" class="btn_page_prev" onclick="getInsectList(' + prev + '); return false;">';
    	pagingHtml += '<img src="/css/general/images/i_l_arrow.png" alt="이전 페이지">';
    	pagingHtml += '</button>';
    	for (let i = paginationInfo.firstPageNoOnPageList; i <= paginationInfo.lastPageNoOnPageList; i++) {
    		
			if (i == paginationInfo.currentPageNo) {
			 
				pagingHtml += '<a class="current" title="현재 ' + i + '페이지" onclick="getInsectList(' + i + '); return false;">' + i + '</a>';
			
			} else {
			 
				pagingHtml += '<a title="' + i + '페이지" onclick="getInsectList(' + i + '); return false;">' + i + '</a>';
			}
    	}
    	pagingHtml += '<button type="button" class="btn_page_next" onclick="getInsectList(' + next + '); return false;">';
    	pagingHtml += '<img src="/css/general/images/i_r_arrow.png" alt="다음 페이지">';
    	pagingHtml += '</button>';

    	$('#pagingBtnArea').empty();
    	$('#pagingBtnArea').html(pagingHtml);
    	// 버튼 구현 끝
	})
	.catch(error => { console.error('fetch에러 => ', error); });
}

function insectDetail(insectNum) { 
	
	location.href='/insectDetailPage.do?insectNum=' + insectNum; 
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
                <p>외래산림해충검색</p>
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
                    <li class="ro_last"><span>외래곤충검색</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .search -->
            <section class="search">
	            <p class="search_inner txtC">
	                <span class="search_txt"><label>검색어입력</label></span>
	                <span class="inline"><input id="searchKeyWord" title="검색어를 입력하세요" class="form_textbox" type="text" value="${searchKeyWord}"></span>
	                <button id="searchBarBtn" class="btn_s"><img src="/css/general/images/search_go.png" alt="검색 이미지"></button>
	            </p>
            </section>
            <!-- S: .search -->
            <!-- S: .page_A -->
            <div class="page_A">
                <div class="page_inner01">
                    <p id="totalCountArea" class="page">
                    </p>
                </div>
                <div class="page_inner02">
                    <select id="pageUnitSelect" title="페이지당항목" class="select_01">
                        <option value="4">4개</option>
                        <option value="8">8개</option>
                        <option value="12">12개</option>
                        <option value="16">16개</option>
                        <option value="20">20개</option>
                    </select>
                    <select id="sortSelect" title="최신등록순" class="select_01">
                        <option value="latestReg">최신등록순</option>
                        <option value="highView">높은검색순</option>
                        <option value="logView">낮은검색순</option>
                    </select>
                </div>
            </div>
            <!-- E: .page_A -->

            <!-- S: .cont-->
            <div class="cont mt20">
                <ul id="insectList" class="cont_box">
                </ul>
            </div>
            <!-- E: .cont-->
            <!-- S : paging_wrap -->
            <div id="pagingBtnArea" class="paging_wrap mt20 mb40">
            </div>
            <!-- E : paging_wrap -->
        </div>
        <!-- E: .main-->
        <footer class="foot_02">
			<jsp:include page="../common/footerDetail.jsp" />
        </footer>
    </div>
</body>
</html>