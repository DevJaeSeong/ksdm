<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../common/head.jsp" />

   <style type="text/css">
a.current {
	background-color: #f2f2f2;
}

#searchBtn {
	cursor: pointer;
}
</style>

<script type="text/javascript">
$(function() {
	
	initEvents();
	getBoardList();
})

function initEvents() {
	
	$('#searchBtn').on('click', function() { getBoardList(); });
}

function getBoardList(pageIndex) {
	
	if (pageIndex == undefined || pageIndex == '' || pageIndex == 0) pageIndex = 1;
	
	let pageUnit = $('#pageUnitSelect').val();
	let searchKeyword = $('#searchKeyword').val();
	let boardDiv = '${boardDiv}';
	
	let queryString = '';
	queryString += '?pageIndex=' + pageIndex;
	queryString += '&pageUnit=' + pageUnit;
	queryString += '&searchKeyword=' + searchKeyword;
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
    		
    		html += '<tr>';
    		html += '<td class="checkboL">';
    		html += '<ul>';
    		html += '<li>';
    		html += '<div class="checkboX">';
    		html += '<input type="checkbox" value="' + boardVo.boardNum + '" id="checkedBoard' + boardVo.boardNum + '" name="boardCheckBox">';
    		html += '<label for="checkedBoard' + boardVo.boardNum + '"></label>';
    		html += '</div>';
    		html += '</li>';
    		html += '</ul>';
    		html += '</td>';
    		html += '<td>' + boardVo.boardNum + '</td>';
    		html += '<td><a href="/admin/boardDetailPage.do?boardNum=' + boardVo.boardNum + '">' + boardVo.boardSubject + '</a></td>';
    		html += '<td>' + boardVo.regNm + '</td>';
    		html += '<td>' + boardVo.regDate + '</td>';
    		html += '<td>' + boardVo.views + '</td>';
    		html += '<td class="flie_box">';
    		if (boardVo.attachFilenm != null && boardVo.attachFilenm != '')
    			html += '<a><img src="/css/admin/images/file_img.png" alt="첨부파일 이미지"></a>';
    		html += '</td>';
    		html += '</tr>';
    	});
    	
    	$('#boardListArea').empty();
    	$('#boardListArea').html(html);
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
			 
				pagingHtml += '<a class="current" title="현재 ' + i + '페이지" onclick="getBoardList(' + i + '); return false;">' + i + '</a> ';
			
			} else {
			 
				pagingHtml += '<a title="' + i + '페이지" onclick="getBoardList(' + i + '); return false;">' + i + '</a> ';
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

function boardDeleteConfirm() {
	
	if (!confirm('정말로 삭제하시겠습니까?')) return;
	
    let selectedCheckboxes = $('input[name="boardCheckBox"]:checked');
    let boardNums = [];
    
    selectedCheckboxes.each(function() {
    	
      let boardNum = $(this).val();
      boardNums.push(boardNum);
    });
    
	fetch('/admin/boardDeleteConfirm.do', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
			'${_csrf.headerName}': '${_csrf.token}'
		},
		body: JSON.stringify(boardNums)
	})
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error('네트워크 에러');
	})
	.then(data => {
		
		if (data > 0) {
			
			alert('정상적으로 삭제되었습니다.');
			
		} else {
			
			alert('삭제에 실패하였습니다. 잠시후 다시 시도해주세요.');
		}
	})
	.catch(error => { 
		
		console.error('fetch에러 => ', error); 
		alert('삭제에 실패하였습니다. 잠시후 다시 시도해주세요.');
	})
	.finally(() => { getBoardList(); });
}
</script>
</head>

<body>
    <!-- S: .wrap -->
    <div class="wrap">
        <jsp:include page="../common/header_nav.jsp" />
        <!-- S: main -->
        <main id="mainArea">
			<!-- S: .rocate -->
			<div class="rocate">
			    <ul>
			        <li><a href="#none"><img src="/css/admin/images/home.png" alt="home"></a></li>
			        <li><span>관리자페이지</span></li>
			        <li><span>게시판관리</span></li>
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
				<c:choose>
				    <c:when test="${boardDiv == 1000}">
				    	<div class="search_txt"><span>공지사항</span></div>
			        </c:when>
			        <c:when test="${boardDiv == 2000}">
				    	<div class="search_txt"><span>보도자료</span></div>
			        </c:when>
			        <c:when test="${boardDiv == 3000}">
				    	<div class="search_txt"><span>자료실</span></div>
			        </c:when>
				</c:choose>
			    <div class="search_box">
			        <input id="searchKeyword" type="text" title="검색어입력" value="" placeholder="제목">
			        <button id="searchBtn" type="button" class="search_click" title="검색">
			        	<img src="/css/admin/images/search_go.gif" alt="검색 이미지">
			        </button>
			    </div>
			</section>
			<!-- S: .search -->
			<!-- S: main_menu2 -->
			<section class="main_menu2 mt20">
			    <article class="main_project_02" tabindex="0">
			        <!-- S: .table_reset -->
			        <div class="table_reset mt20">
			            <table class="board_date01">
			                <colgroup>
			                    <col style="width:10%;">
			                    <col style="width:10%;">
			                    <col style="width:50%;">
			                    <col style="width:15%;">
			                    <col style="width:20%;">
			                    <col style="width:10%;">
			                    <col style="width:10%;">
			                </colgroup>
			                <thead>
			                    <tr>
			                        <th scope="col">선택</th>
			                        <th scope="col">NO</th>
			                        <th scope="col">제목</th>
			                        <th scope="col">작성자</th>
			                        <th scope="col">등록일</th>
			                        <th scope="col">조회수</th>
			                        <th scope="col">첨부파일</th>
			                    </tr>
			                </thead>
			                <tbody id="boardListArea">
			                </tbody>
			            </table>
			        </div>
			        <!-- E: .table_reset -->
			        <!-- S: .page_A -->
			        <div class="page_A" data-label="페이지당항목">
			            <span>페이지당항목</span>
			            <select id="pageUnitSelect" onchange="getBoardList();" title="페이지당항목" class="select_01">
			                <option value="5">5</option>
			                <option value="10">10</option>
			                <option value="15">15</option>
			                <option value="20">20</option>
			                <option value="25">25</option>
			            </select>
			        </div>
			        <!-- E: .page_A -->
			        <!-- S: .btn_r -->
			        <div class="btn_r">
			        	<c:choose>
				        	<c:when test="${boardDiv == 1000}">
				            	<a href="/admin/boardRegistPage.do?boardDiv=1000" class="btn_list_src mr10" title="글쓰기버튼"><span>글쓰기</span></a>
					        </c:when>
				        	<c:when test="${boardDiv == 2000}">
				            	<a href="/admin/boardRegistPage.do?boardDiv=2000" class="btn_list_src mr10" title="글쓰기버튼"><span>글쓰기</span></a>
					        </c:when>
				        	<c:when test="${boardDiv == 3000}">
				            	<a href="/admin/boardRegistPage.do?boardDiv=3000" class="btn_list_src mr10" title="글쓰기버튼"><span>글쓰기</span></a>
					        </c:when>
			        	</c:choose>
			            <a href="javascript:void(0)" onclick="boardDeleteConfirm();" class="btn_list_src c_red" title="삭제버튼"><span>삭제</span></a>
			        </div>
			        <!-- E: .btn_r -->
			        <!-- S: .paging_wrap -->
			        <div id="pagingBtnArea" class="paging_wrap">
			        </div>
			        <!-- E: .paging_wrap -->
			    </article>
			</section>
			<!-- E: main_menu2 -->		
        </main>
        <!-- E: main -->
    </div>
    <!-- E:.wrap -->
</body>
</html>