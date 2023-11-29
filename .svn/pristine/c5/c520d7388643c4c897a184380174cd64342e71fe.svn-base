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
		getBoardList();
	})
	
	function intEvents() {
		
		$('#pageUnitSelect').on('change', function() { getBoardList(); });
		$('#sortSelect').on('change', function() { getBoardList(); });
		$('#searchBarBtn').on('click', function() { getBoardList(); });
	}
	
	function getBoardList(pageIndex) {
		
		if (pageIndex == undefined || pageIndex == '' || pageIndex == 0) pageIndex = 1;
		
		let pageUnit = $('#pageUnitSelect').val();
		let searchKeyword = $('#searchKeyword').val();
		let sort = $('#sortSelect').val();
		let boardDiv = '${boardDiv}';
		
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
			
			// 총 개수 화면 시작
			let totalCountHtml = '';
			totalCountHtml += '<span class="total">전체<b>' + paginationInfo.totalRecordCount + '건</b></span>';
			totalCountHtml += '<span>현재페이지 <strong>' + paginationInfo.currentPageNo + '</strong>/<b>' + paginationInfo.lastPageNo + '</b></span>';
			
			$('#totalCountArea').empty();
	    	$('#totalCountArea').html(totalCountHtml);
			// 총 개수 화면 끝
			
			// 내용 구현 시작
			let boardVos = data.boardVos;
	    	let html = '';
	    	
	    	$.each(boardVos, function(index, boardVo) {
	    		
	    		html += '<tr>';
	    		html += '<td>' + boardVo.boardNum + '</td>';
	    		html += '<td class="m_w500"><a href="/boardDetailPage.do?boardNum=' + boardVo.boardNum + '">' + boardVo.boardSubject + '</a></td>';
	    		html += '<td>' + boardVo.regNm + '</td>';
	    		html += '<td>' + boardVo.regDate + '</td>';
	    		html += '<td>' + boardVo.views + '</td>';
	    		html += '<td class="flie_box">';
	    		if (boardVo.attachFilenm != null && boardVo.attachFilenm != '')
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
		        <c:choose>
			        <c:when test="${boardDiv == 1000}">
			        	<p>공지사항</p>
			        </c:when>
			        <c:when test="${boardDiv == 2000}">
			        	<p>보도자료</p>
			        </c:when>
			        <c:when test="${boardDiv == 3000}">
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
				        <c:when test="${boardDiv == 1000}">
				        	<li class="ro_last"><span>공지사항</span></li>
				        </c:when>
				        <c:when test="${boardDiv == 2000}">
				        	<li class="ro_last"><span>보도자료</span></li>
				        </c:when>
				        <c:when test="${boardDiv == 3000}">
				        	<li class="ro_last"><span>자료실</span></li>
				        </c:when>
			        </c:choose>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .search -->
            <section class="search">
                <p class="search_inner txtC">
                    <span class="search_txt"><label>검색어입력</label></span>
                    <span class="inline"><input id="searchKeyword" title="검색어를 입력하세요" class="form_textbox" type="text" value=""></span>
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
                        <col style="width:8%">
                        <col style="width:30%">
                        <col style="width:15%">
                        <col style="width:15%">
                        <col style="width:10%">
                        <col style="width:20%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">NO</th>
                            <th scope="col">제목</th>
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