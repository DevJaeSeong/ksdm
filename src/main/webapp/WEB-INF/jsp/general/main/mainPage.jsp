<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<jsp:include page="../common/head.jsp" />
	
    <link rel="stylesheet" href="/css/general/css/meyer_reset2.0.css">
    <link rel="stylesheet" href="/css/general/css/default.css">
    <link rel="stylesheet" href="/css/general/css/font.css">
    <!-- <link rel="stylesheet" href="/css/general/css/slick.css"> -->
    <!-- <link rel="stylesheet" href="/css/general/css/slick-theme.css"> -->
    <link rel="stylesheet" href="/css/general/css/common.css">
    <link rel="stylesheet" href="/css/general/css/main.css">
    <!-- <link rel="stylesheet" href="/css/general/css/content1.css"> -->

    <script src="/css/general/js/3.6.0.js"></script>
    <!-- <script src="/css/general/js/slick.js"></script> -->
    <script src="/css/general/js/common.js"></script>

<style>
/* 이전 CSS 규칙 */
input#searchBar {
    display: inline-block;
    width: calc(100% - 14px);
    height: calc(100% - 4px);
    padding: 0 0 0 10px;
    font-size: 14px;
    text-align: left;
    font-family: 'Noto3';
    border: 2px solid #ffffff;
    border-radius: 24px;
    background-color: transparent;
    color: white;
    position: relative;
}

input#searchBar::placeholder {
  background-color: transparent;
}
</style>

<script type="text/javascript">
   $(function() {
	
   	initEvents();
   	getBoardList();
   	getPressReleaseList();
})

function initEvents() {
	
   	$('#searchBtn').on('click', function() {
   		
   		let searchKeyWord = $('#searchBar').val();
   		location.href = '/insectSearchByKeyword.do?searchKeyWord=' + searchKeyWord;
   	});
}
   
function getBoardList(pageIndex) {
	
	if (pageIndex == undefined || pageIndex == '' || pageIndex == 0) pageIndex = 1;
	
	let pageUnit = 5;
	let searchKeyword = '';
	let sort = 'latestReg';
	let boardDiv = '1000';
	
	let queryString = '';
	queryString += '?pageIndex=' + pageIndex;
	queryString += '&pageUnit=' + pageUnit;
	queryString += '&searchKeyword=' + searchKeyword;
	queryString += '&sort=' + sort;
	queryString += '&boardDiv=' + boardDiv;
	
	fetch('/getBoardList.do' + queryString)
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error('네트워크 에러');
	})
	.then(data => {
		
		let paginationInfo = data.paginationInfo;
		
		// 내용 구현 시작
		let boardVos = data.boardVos;
    	let html = '';
    	
    	$.each(boardVos, function(index, boardVo) {

    		html += '<li><a href="/boardDetailPage.do?boardNum=' + boardVo.boardNum + '" title="' + boardVo.boardSubject + '">' + boardVo.boardSubject + '</a>';
    		html += '<p class="notice_date">' + boardVo.regDate + '</p>';
    		html += '</li>';
    	});
    	
    	$('#boardList').empty();
    	$('#boardList').html(html);
    	// 내용 구현 끝
	})
	.catch(error => { console.error('fetch에러 => ', error); });
}

function getPressReleaseList(pageIndex) {
	
	if (pageIndex == undefined || pageIndex == '' || pageIndex == 0) pageIndex = 1;
	
	let pageUnit = 5;
	let searchKeyword = '';
	let sort = 'latestReg';
	let boardDiv = '2000';
	
	let queryString = '';
	queryString += '?pageIndex=' + pageIndex;
	queryString += '&pageUnit=' + pageUnit;
	queryString += '&searchKeyword=' + searchKeyword;
	queryString += '&sort=' + sort;
	queryString += '&boardDiv=' + boardDiv;
	
	fetch('/getBoardList.do' + queryString)
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error('네트워크 에러');
	})
	.then(data => {
		
		let paginationInfo = data.paginationInfo;
		
		// 내용 구현 시작
		let boardVos = data.boardVos;
    	let html = '';
    	
    	$.each(boardVos, function(index, boardVo) {

    		html += '<li><a href="/boardDetailPage.do?boardNum=' + boardVo.boardNum + '" title="' + boardVo.boardSubject + '">' + boardVo.boardSubject + '</a>';
    		html += '<p class="notice_date">' + boardVo.regDate + '</p>';
    		html += '</li>';
    	});
    	
    	$('#pressReleaseList').empty();
    	$('#pressReleaseList').html(html);
    	// 내용 구현 끝
	})
	.catch(error => { console.error('fetch에러 => ', error); });
}
</script>
</head>

<body>
    <div class="wrap">
        <!-- S: header -->
        <header>
            <jsp:include page="../common/headerDetail.jsp" />
        </header>
        <!-- E: header -->
        <!-- S: .sec1 -->
        <section class="sec1">
            <article>
                <h3>외래산림해충 확산 분석 시스템</h3>
                <h2>K-SDM</h2>
                <div class="sel_search">
                    <input type="hidden" value="">
                    <input type="text" id="searchBar" title="검색어입력" placeholder="예) ‘외래산림해충’ 또는 ‘갈색날개매미충’ " class="inp_base">
                    <button type="button" id="searchBtn" class="search_click" title="검색"></button>
                    <p><a href="#none" title="검색가이드">검색가이드</a></p>
                </div>
            </article>
            <article>
                <div class="fast_menu_title">
                    <p>자주 찾는 서비스</p>
                    <p>원하는 서비스로 바로가기</p>
                </div>
                <div class="fast_menu_icon">
                    <div class="single-item">
                        <a href="/insectSearchPage.do" class="item01" title="외래산림해충"><span>외래산림해충</span></a>
                        <a href="/currentDistributionPage.do" class="item02" title="현재분포"><span>현재분포</span></a>
                        <a href="/insectForecastPage.do" class="item03" title="예상분포"><span>예상분포</span></a>
                    </div>
                </div>
            </article>
        </section>
        <!-- E: .sec1 -->
        <!-- S: .sec2 -->
        <section class="sec2 pt30 pb30">
            <article>
                <div class="notice mr25">
                    <p>
                        <span>공지사항</span>
                        <span class="bar"></span>
                        <a href="/boardListPage.do?boardDiv=1000" title="공지사항 더보기"></a>
                    </p>
                    <ul id="boardList" class="notice_info">
                    </ul>
                </div>
                <div class="notice mr25">
                    <p>
                        <span>보도자료</span>
                        <span class="bar"></span>
                        <a href="/boardListPage.do?boardDiv=2000" title="보도자료 더보기"></a>
                    </p>
                    <ul id="pressReleaseList" class="notice_info">
                    </ul>
                </div>
                <div class="notice h_notice">
                    <p>
                        <span>사용자 메뉴얼</span>
                        <span class="bar02"></span>
                        <!-- <a href="#none" title="보도자료 더보기"></a> -->
                    </p>
                    <div class="notice_info">
                        <p>
                            한국형 외래산림해충 통합관리 시스템관련<br>사용메뉴얼을 확인할 수 있습니다.
                        </p>
                    </div>
                </div>
            </article>
        </section>
        <!-- E: .sec2 -->
        <!-- S: .foot-->
        <footer class="foot">
            <jsp:include page="../common/footerDetail.jsp" />
        </footer>
        <!-- E: .foot-->
    </div>
</body>
</html>