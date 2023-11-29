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
    
    #searchKeyword::placeholder {
    	background-color: #fff;
    }
    </style>
    
    <script type="text/javascript">
	$(function() {
		
		intEvents();
		getinsectForecastList();
	})
	
	function intEvents() {
		
		$('#pageUnitSelect').on('change', function() { getinsectForecastList(); });
		$('#sortSelect').on('change', function() { getinsectForecastList(); });
		$('#searchBarBtn').on('click', function() { getinsectForecastList(); });
	}
	
	function keyEvent(e) {
		
		if (e.keyCode == 13) getinsectForecastList();
	}
	
	function getinsectForecastList(pageIndex) {
		
		pageIndex = !pageIndex ? 1 : pageIndex;
		
		let pageUnit = $('#pageUnitSelect').val();
		let searchKeyword = $('#searchKeyword').val();
		let sort = $('#sortSelect').val();
		
		let queryString = '';
		queryString += '?pageIndex=' + pageIndex;
		queryString += '&pageUnit=' + pageUnit;
		queryString += '&searchKeyword=' + searchKeyword;
		queryString += '&sort=' + sort;
		
		fetch('/getinsectForecastList.do' + queryString)
		.then(response => {
			
			if (response.ok) return response.json();
			else throw new Error('네트워크 에러');
		})
		.then(data => {
			
			let paginationInfo = data.paginationInfo;
			
			// 총 개수 화면 시작
			let totalCountHtml = '';
			totalCountHtml += '<span class="total">전체<b>' + paginationInfo.totalRecordCount + '건</b></span>';
			totalCountHtml += '<span>현재페이지 <strong>' + paginationInfo.currentPageNo + '</strong>/<b>' + paginationInfo.lastPageNo + '</b></span>';
			
			$('#totalCountArea').empty();
	    	$('#totalCountArea').html(totalCountHtml);
			// 총 개수 화면 끝
			
			// 내용 구현 시작
			let forecastVos = data.forecastVos;
	    	let html = '';
	    	
	    	$.each(forecastVos, function(index, forecastVo) {
	    		
	    		html += '<tr>';
	    		html += '<td class="m_w500"><a href="/insectForecastDetailPage.do?forecastId=' + forecastVo.forecastId + '">' + forecastVo.forecastName + '</a></td>';
	    		html += '<td>' + forecastVo.forecastInsect + '</td>';
	    		html += '<td>' + forecastVo.regNm + '</td>';
	    		html += '<td>' + forecastVo.regDate + '</td>';
	    		html += '<td>' + forecastVo.views + '</td>';
	    		html += '<td class="flie_box">';
	    		html += '<a><img src="/css/admin/images/file_img.png" alt="첨부파일 이미지"></a>';
	    		html += '</td>';
	    		html += '</tr>';
	    	});
	    	
	    	$('#boardList').empty();
	    	$('#boardList').html(html);
	    	// 내용 구현 끝
	    	
	    	// 버튼 구현 시작
	    	let prev = (paginationInfo.firstPageNoOnPageList == 1 ? 1 : (paginationInfo.currentPageNo - paginationInfo.pageSize < 1 ? 1 : paginationInfo.currentPageNo - paginationInfo.pageSize));
			let next = (paginationInfo.lastPageNoOnPageList == paginationInfo.lastPageNo ? paginationInfo.lastPageNo : (paginationInfo.currentPageNo + paginationInfo.pageSize > paginationInfo.lastPageNo ? paginationInfo.lastPageNo : paginationInfo.currentPageNo + paginationInfo.pageSize));
	    	let pagingHtml = '';

	    	pagingHtml += '<button type="button" class="btn_page_prev" onclick="getBoardList(' + prev + '); return false;">';
	    	pagingHtml += '<img src="/css/general/images/i_l_arrow.png" alt="이전 페이지">';
	    	pagingHtml += '</button>';
	    	for (let i = paginationInfo.firstPageNoOnPageList; i <= paginationInfo.lastPageNoOnPageList; i++) {
	    		
				if (i == paginationInfo.currentPageNo) {
				 
					pagingHtml += '<a class="current" title="현재 ' + i + '페이지" onclick="getBoardList(' + i + '); return false;">' + i + '</a>';
				
				} else {
				 
					pagingHtml += '<a title="' + i + '페이지" onclick="getBoardList(' + i + '); return false;">' + i + '</a>';
				}
	    	}
	    	pagingHtml += '<button type="button" class="btn_page_next" onclick="getBoardList(' + next + '); return false;">';
	    	pagingHtml += '<img src="/css/general/images/i_r_arrow.png" alt="다음 페이지">';
	    	pagingHtml += '</button>';

	    	$('#pagingBtnArea').empty();
	    	$('#pagingBtnArea').html(pagingHtml);
	    	// 버튼 구현 끝
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
        <div class="banner_info banner_02">
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
                    <li><span>예상분포</span></li>
		        	<li class="ro_last"><span>예상분포</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .search -->
            <section class="search">
                <p class="search_inner txtC">
                    <span class="search_txt"><label>검색어입력</label></span>
                    <span class="inline"><input id="searchKeyword" onkeydown="keyEvent(event);" title="검색어를 입력하세요" class="form_textbox" type="text" placeholder="제목 또는 해충명을 입력해주세요."></span>
                    <button id="searchBarBtn" type="button" class="btn_s"><img src="/css/general/images/search_go.png" alt="검색 이미지"></button>
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
                    <select title="페이지당항목" id="pageUnitSelect" class="select_01">
                        <option value="5">5개</option>
                        <option value="10">10개</option>
                        <option value="15">15개</option>
                        <option value="20">20개</option>
                        <option value="25">25개</option>
                    </select>
                    <select id="sortSelect" title="최신등록순" class="select_01">
                        <option value="latestReg">최신등록순</option>
                        <option value="highView">조회수 높은 순</option>
                        <option value="logView">조회수 낮은 순</option>
                    </select>
                </div>
            </div>
            <!-- E: .page_A -->
            <!-- S : table_A -->
            <div class="table_A">
                <table class="contTbl txtC" summary="이 표는 목록입니다.">
                    <colgroup>
                        <col style="width:30%">
                        <col style="width:15%">
                        <col style="width:15%">
                        <col style="width:15%">
                        <col style="width:10%">
                        <col style="width:20%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">제목</th>
                            <th scope="col">해충명</th>
                            <th scope="col">작성자</th>
                            <th scope="col">등록일</th>
                            <th scope="col">조회수</th>
                            <th scope="col">첨부파일</th>
                        </tr>
                    </thead>
                    <tbody id="boardList">
                    </tbody>
                </table>
            </div>
            <!-- E : table_A -->
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