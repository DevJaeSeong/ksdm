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
	getUserList();
})

function initEvents() {
	
	$('#searchBtn').on('click', function() { getUserList(); });
}

function getUserList(pageIndex) {
	
	if (pageIndex == undefined || pageIndex == '' || pageIndex == 0) pageIndex = 1;
	
	let pageUnit = $('#pageUnitSelect').val();
	let searchKeyword = $('#searchKeyword').val();
	
	let queryString = '';
	queryString += '?pageIndex=' + pageIndex;
	queryString += '&pageUnit=' + pageUnit;
	queryString += '&searchKeyword=' + searchKeyword;
	
	fetch('/admin/getUserList.do' + queryString)
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error('네트워크 에러');
	})
	.then(data => {
		
		let paginationInfo = data.paginationInfo;
		
		// 내용 구현 시작
		let userDetailVos = data.userDetailVos;
    	let html = '';
    	
    	$.each(userDetailVos, function(index, userDetailVo) {
    		
    		html += '<tr>';
    		html += '<td>' + userDetailVo.userName + '</td>';
    		html += '<td><a href="/admin/userDetailPage.do?userId=' + userDetailVo.userId + '">' + userDetailVo.userId + '</a></td>';
    		html += '<td>' + userDetailVo.authorityName + '</td>';
    		html += '<td>' + userDetailVo.regDate + '</td>';
    		html += '<td>' + userDetailVo.userPhone + '</td>';
    		html += '<td>' + userDetailVo.researchAreaName + '</td>';
    		html += '<td>' + userDetailVo.userNote + '</td>';
    		html += '</tr>';
    	});
    	
    	$('#userListArea').empty();
    	$('#userListArea').html(html);
    	// 내용 구현 끝
    	
    	// 버튼 구현 시작
    	let prev = (paginationInfo.firstPageNoOnPageList == 1 ? 1 : (paginationInfo.currentPageNo - paginationInfo.pageSize < 1 ? 1 : paginationInfo.currentPageNo - paginationInfo.pageSize));
		let next = (paginationInfo.lastPageNoOnPageList == paginationInfo.lastPageNo ? paginationInfo.lastPageNo : (paginationInfo.currentPageNo + paginationInfo.pageSize > paginationInfo.lastPageNo ? paginationInfo.lastPageNo : paginationInfo.currentPageNo + paginationInfo.pageSize));
    	let pagingHtml = '';

    	pagingHtml += '<button type="button" class="btn_page_prev" onclick="getUserList(' + prev + '); return false;">';
    	pagingHtml += '<img src="/css/general/images/i_l_arrow.png" alt="이전 페이지">';
    	pagingHtml += '</button>';
    	for (let i = paginationInfo.firstPageNoOnPageList; i <= paginationInfo.lastPageNoOnPageList; i++) {
    		
			if (i == paginationInfo.currentPageNo) {
			 
				pagingHtml += '<a class="current" title="현재 ' + i + '페이지" onclick="getUserList(' + i + '); return false;">' + i + '</a> ';
			
			} else {
			 
				pagingHtml += '<a title="' + i + '페이지" onclick="getUserList(' + i + '); return false;">' + i + '</a> ';
			}
    	}
    	pagingHtml += '<button type="button" class="btn_page_next" onclick="getUserList(' + next + '); return false;">';
    	pagingHtml += '<img src="/css/general/images/i_r_arrow.png" alt="다음 페이지">';
    	pagingHtml += '</button>';

    	$('#pagingBtnArea').empty();
    	$('#pagingBtnArea').html(pagingHtml);
    	// 버튼 구현 끝
	})
	.catch(error => { console.error('fetch에러 => ', error); });
}

function boardDeleteConfirm() {
	
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
	.finally(() => { getUserList(); });
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
                    <li><span>사용자관리</span></li>
                    <li class="ro_last"><span>사용자현황</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .search -->
            <section class="search">
                <div class="search_txt"><span>사용자현황</span></div>
                <div class="search_box">
                    <input id="searchKeyword" type="text" title="검색어입력" value="" placeholder="이름 및 아이디 검색">
                    <button type="button" class="search_click" title="검색"><img src="/css/admin/images/search_go.gif" alt="검색 이미지"></button>
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
                                <col style="width:30%;">
                                <col style="width:30%;">
                                <col style="width:30%;">
                                <col style="width:30%;">
                                <col style="width:30%;">
                                <col style="width:30%;">
                                <col style="width:50%;">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col">이름</th>
                                    <th scope="col">아이디</th>
                                    <th scope="col">구분</th>
                                    <th scope="col">등록일</th>
                                    <th scope="col">연락처</th>
                                    <th scope="col">조사원활동지역</th>
                                    <th scope="col">비고</th>
                                </tr>
                            </thead>
                            <tbody id="userListArea">
                            </tbody>
                        </table>
                    </div>
                    <!-- E: .table_reset -->
                    <!-- S: .page_A -->
                    <div class="page_A" data-label="페이지당항목">
                        <span>페이지당항목</span>
                        <select id="pageUnitSelect" onchange="getUserList();" title="페이지당항목" class="select_01">
                            <option value="5">5</option>
                            <option value="10">10</option>
                            <option value="15">15</option>
                            <option value="20">20</option>
                            <option value="25">25</option>
                        </select>
                    </div>
                    <!-- E: .page_A -->
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