<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/loadingHead.jsp" />

<style type="text/css">
.pointer {
	cursor: pointer;
}

td {
	white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

td a {
	cursor: pointer;
}
</style>

<script type="text/javascript">
$(function() {
	
	initEvents();
	getForecastList();
})

function initEvents() {
	
}

function getForecastList(pageIndex) {
	
	if (pageIndex == undefined || pageIndex == '' || pageIndex == 0) 
		pageIndex = 1;
	
	let pageUnit = $('#pageUnit').val();
	let searchKeyword = $('#searchKeyword').val();
	
	let queryString = '';
	queryString += '?pageIndex=' + pageIndex;
	queryString += '&pageUnit=' + pageUnit;
	queryString += '&searchKeyword=' + searchKeyword;
	
	fetch('/getForecastList.do' + queryString)
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error(response.status + ' 에러');
	})
	.then(data => {
		
		// 내용 구현 시작
		let forecastVos = data.forecastVos;
    	let html = '';
    	
    	$.each(forecastVos, function(index, forecastVo) {
    		html += '<tr>';
    		html += '<td class="checkboL">';
    		html += '<ul>';
    		html += '<li>';
    		html += '<div class="checkboX">';
    		html += '<input name="forecastCheckBox" type="checkbox" value="' + forecastVo.forecastId + '" id="forecastId' + forecastVo.forecastId + '">';
    		html += '<label for="forecastId' + forecastVo.forecastId + '"></label>';
    		html += '</div>';
    		html += '</li>';
    		html += '</ul>';
    		html += '</td>';
    		html += '<td title="' + forecastVo.forecastName + '">' + forecastVo.forecastName + '</td>';
    		html += '<td title="' + forecastVo.forecastInsect + '">' + forecastVo.forecastInsect + '</td>';
    		html += '<td title="' + forecastVo.pngOriFileName + '"><a href="/fileDownload.do?fileName=' + forecastVo.pngFileName + '" download="' + forecastVo.pngOriFileName + '">' + forecastVo.pngOriFileName + '</a></td>';
    		html += '<td title="' + forecastVo.pdfOriFileName + '"><a href="/fileDownload.do?fileName=' + forecastVo.pdfFileName + '" download="' + forecastVo.pdfOriFileName + '">' + forecastVo.pdfOriFileName + '</a></td>';
    		html += '<td title="' + forecastVo.tifOriFileName + '"><a href="/fileDownload.do?fileName=' + forecastVo.tifFileName + '" download="' + forecastVo.tifOriFileName + '">' + forecastVo.tifOriFileName + '</a></td>';
    		html += '<td title="' + forecastVo.jpgOriFileName + '"><a href="/fileDownload.do?fileName=' + forecastVo.jpgFileName + '" download="' + forecastVo.jpgOriFileName + '">' + forecastVo.jpgOriFileName + '</a></td>';
    		html += '<td title="' + forecastVo.programOriFileName + '"><a href="/fileDownload.do?fileName=' + forecastVo.programFileName + '" download="' + forecastVo.programOriFileName + '">' + forecastVo.programOriFileName + '</a></td>';
    		html += '<td title="' + forecastVo.menualOriFileName + '"><a href="/fileDownload.do?fileName=' + forecastVo.menualFileName + '" download="' + forecastVo.menualOriFileName + '">' + forecastVo.menualOriFileName + '</a></td>';
    		html += '</tr>';
    	});
    	
    	$('#listArea').html(html);
    	// 내용 구현 끝
    	
    	// 버튼 구현 시작
    	let paginationInfo = data.paginationInfo;
    	let prev = (paginationInfo.firstPageNoOnPageList == 1 ? 1 : (paginationInfo.currentPageNo - paginationInfo.pageSize < 1 ? 1 : paginationInfo.currentPageNo - paginationInfo.pageSize));
		let next = (paginationInfo.lastPageNoOnPageList == paginationInfo.lastPageNo ? paginationInfo.lastPageNo : (paginationInfo.currentPageNo + paginationInfo.pageSize > paginationInfo.lastPageNo ? paginationInfo.lastPageNo : paginationInfo.currentPageNo + paginationInfo.pageSize));
    	let pagingHtml = '';

    	pagingHtml += '<button type="button" class="btn_page_prev" onclick="getForecastList(' + prev + '); return false;">';
    	pagingHtml += '</button>';
    	
    	for (let i = paginationInfo.firstPageNoOnPageList; i <= paginationInfo.lastPageNoOnPageList; i++) {
    		
			if (i == paginationInfo.currentPageNo) {
			 
				pagingHtml += '<a class="current" title="현재 ' + i + '페이지" onclick="getForecastList(' + i + '); return false;">' + i + '</a> ';
			
			} else {
			 
				pagingHtml += '<a title="' + i + '페이지" onclick="getForecastList(' + i + '); return false;">' + i + '</a> ';
			}
    	}
    	
    	pagingHtml += '<button type="button" class="btn_page_next" onclick="getForecastList(' + next + '); return false;">';
    	pagingHtml += '</button>';

    	$('#pagingWrap').html(pagingHtml);
    	// 버튼 구현 끝
	})
	.catch(error => { 
		
		console.error(error); 
	})
}

function deleteFiles() {
	
	if(!confirm('정말 삭제하시겠습니까?')) return;
	
	let taskIds = [];
	let checkedBoxes = $('input[name="forecastCheckBox"]:checked');
	
	$.each(checkedBoxes, function(i, checkedBox) {
		
		taskIds.push($(this).val());
	})
	
	let sendData = {
		'taskIds': taskIds
	};
	
	showLoadingOverlay();
	
	fetch('/admin/forecast/deleteFiles.do', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
			'${_csrf.headerName}': '${_csrf.token}'
		},
		body: JSON.stringify(sendData)
	})
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error(response.status + ' 에러');
	})
	.then(data => {
		
		switch (data.result) {
		
			case 'success':
				alert('정상적으로 삭제되었습니다.');
				getForecastList();
				break;
			  
			default:
				alert('삭제에 실패하였습니다. 잠시후 다시 시도해주세요.');
				break;
		}
		
	})
	.catch(error => { 
		
		console.error('fetch에러 => ', error); 
		alert('삭제에 실패하였습니다. 잠시후 다시 시도해주세요.');
	})
	.finally(() => {
		
		hideLoadingOverlay();
	})
}
</script>
</head>

<body>
    <!-- S: .wrap -->
    <div class="wrap">
    	<jsp:include page="../common/header_nav.jsp" />
		<!-- S: main -->
        <main>
            <!-- S: .rocate -->
            <div class="rocate">
                <ul>
                    <li><a href="#none"><img src="/css/admin/images/home.png" alt="home"></a></li>
                    <li><span>관리자페이지</span></li>
                    <li><span>예상분포</span></li>
                    <li class="ro_last"><span>예상분포업로드</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .search -->
            <section class="search">
                <div class="search_txt"><span>예상분포업로드</span></div>
                <div class="search_box">
                    <input id="searchKeyword" type="text" title="검색어입력" value="" placeholder="제목">
                    <button onclick="getForecastList();" type="button" class="search_click" title="검색"><img src="/css/admin/images/search_go.gif"
                            alt="검색 이미지"></button>
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
                                <col style="width:4%;">
                                <col style="width:15%;">
                                <col style="width:10%;">
                                <col style="width:10%;">
                                <col style="width:10%;">
                                <col style="width:10%;">
                                <col style="width:10%;">
                                <col style="width:10%;">
                                <col style="width:10%;">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col">선택</th>
                                    <th scope="col">제목</th>
                                    <th scope="col">해충명</th>
                                    <th scope="col">png</th>
                                    <th scope="col">PDF</th>
                                    <th scope="col">Tif</th>
                                    <th scope="col">JPG</th>
                                    <th scope="col">곤충분포예측프로그램</th>
                                    <th scope="col">곤충분포예측프로그램매뉴얼</th>
                                </tr>
                            </thead>
                            <tbody id="listArea">
                            </tbody>
                        </table>
                    </div>
                    <!-- E: .table_reset -->
                    <!-- S: .page_A -->
                    <div class="page_A" data-label="페이지당항목">
                        <span>페이지당항목</span>
                        <select id="pageUnit" onchange="getForecastList();" title="페이지당항목" class="select_01">
                            <option value="10">10</option>
                            <option value="20">20</option>
                        </select>
                    </div>
                    <!-- E: .page_A -->
                    <!-- S: .btn_r -->
                    <div class="btn_r">
                        <a href="/admin/forecast/forecastUploadRegistPage.do" class="btn_list_src mr10" title="글쓰기버튼"><span>글쓰기</span></a>
                        <a onclick="deleteFiles();" class="btn_list_src c_red pointer" title="삭제버튼"><span>삭제</span></a>
                    </div>
                    <!-- E: .btn_r -->
                    <!-- S: .paging_wrap -->
                    <div id="pagingWrap" class="paging_wrap">
                    </div>
                    <!-- E: .paging_wrap -->
                </article>
            </section>
            <!-- E: main_menu2 -->
        </main>
        <!-- E: main -->    
    </div>
    <!-- E:.wrap -->
    <jsp:include page="../common/loadingBody.jsp" />
</body>
</html>